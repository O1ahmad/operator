import ansible_runner
import ast
from flask import Flask, request
import json
import os
import sys
import yaml

app = Flask(__name__)


KEYS_DIR = "/keys"
WORK_DIR = "/var/tmp"
ROLES_DIR = os.environ.get("ROLES_DIR", "{}/roles".format(WORK_DIR))

CONSTRUCTS = {}

def generate_setup(spec):
    with open("{dir}/{id}.yaml".format(dir=WORK_DIR, id=spec['id']), 'w') as f:
        for role in spec['setup']:
            d = [{
                "name": "Deploy {role} roles".format(role=role['type']),
                "hosts": role['type'],
                "roles" : [{
                    "role": "{dir}/{url}".format(dir=ROLES_DIR, url=role['url']),
                    "vars": role['properties']
                }]
            }]
            yaml.dump(d, f, default_flow_style=False)

    return { 'message': "{id} setup completed successfully.".format(id=spec['id']) }

def generate_inventory(spec):
    with open("{dir}/inventory-{id}.yaml".format(dir=WORK_DIR, id=spec['id']), 'w') as f:
        i = {"all": {
            "hosts": {},
            "children": {}
        }}
        for host in spec['inventory']:
            i['all']['hosts'][host['name']] = {
                "ansible_host": host['address'],
                "ansible_user": host['user']
            }
            for role in host['roles']:
                if not i['all']['children'].get(role):
                    i['all']['children'][role] = { "hosts": { host['name']: {}} }
                else:
                    i['all']['children'][role]['hosts'][host['name']] = {}
            yaml.dump(i, f, default_flow_style=False)

    return { 'message': "{id} inventory generation completed successfully.".format(id=spec['id']) }

def load_construct_file(cid):
    data = {}
    with open("{dir}/{id}.yaml".format(dir=WORK_DIR, id=cid)) as file:
        data = yaml.safe_load(file)

    return data

def update_constructs_datastore(construct):
    CONSTRUCTS[construct['id']] = construct['setup']

@app.route("/v1/key", methods=['POST'])
def key():
    if 'ssh' in request.files:
        file = request.files['ssh']
        path = "{}/{}".format(KEYS_DIR, file.filename)

        if not os.path.exists(KEYS_DIR):
            os.makedirs(KEYS_DIR)

        file.save(path)
        os.chmod(path, 0o600)

        return { 'message': "SSH key, {key}, successfully uploaded.".format(key=file.filename) }
    
    return { 'message': "No SSH key was provided for upload." }

@app.route("/v1/view/<cid>", methods=['GET'])
def view(cid):
    if request.method == 'GET':
        cmd_args = [
            '--inventory',
            "{dir}/inventory-{id}.yaml".format(dir=WORK_DIR, id=cid),
            '--module-name',
            'setup'
        ]

        if 'ssh_key' in request.args and os.path.exists("{}/{}".format(KEYS_DIR, request.args['ssh_key'])):
            cmd_args.extend(["--private-key", "{}/{}".format(KEYS_DIR, request.args['ssh_key'])])
        else:
            cmd_args.append("--ask-pass")
        if 'target' in request.args:
            cmd_args.append(request.args['target'])
        else:
            cmd_args.append('all')
        if 'hosts' in request.args:
            cmd_args.extend(['--limit', request.args['hosts']])
        if 'filter' in request.args:
            cmd_args.extend(['-a', "filter='{}'".format(request.args['filter'])])

        out, err, rc = ansible_runner.run_command(
            executable_cmd='ansible',
            cmdline_args=cmd_args,
            input_fd=sys.stdin
        )
        if rc == 0:
            trim_start = out.find('{')
            out = out[trim_start:]+'}'
            return {
                'id': cid,
                'message': "{id} successfully viewed.".format(id=cid),
                'view': json.loads(out.replace("\n", "").replace(" ", "")),
            }
        else:
            return {
                'id': cid,
                'message': err,
                'rc': rc
            }

@app.route("/v1/run/<cid>", methods=['POST'])
def run(cid):
    if request.method == 'POST':
        if not request.get_json(silent=True) and 'run_args' not in request.get_json(force=True):
            return {
                'id': cid,
                'message': 'Specification of command "run_args" is required within request data - None provided.',
                'result': ''
            }
        
        data = request.get_json(force=True)
        cmd_args = [
            '--inventory',
            "{dir}/inventory-{id}.yaml".format(dir=WORK_DIR, id=cid),
            '--args',
            data['run_args']
        ]
        if 'ssh_key' in request.args and os.path.exists("{}/{}".format(KEYS_DIR, request.args['ssh_key'])):
            cmd_args.extend(["--private-key", "{}/{}".format(KEYS_DIR, request.args['ssh_key'])])
        else:
            cmd_args.append("--ask-pass")
        if 'target' in request.args:
            cmd_args.append(request.args['target'])
        else:
            cmd_args.append('all')
        if 'hosts' in request.args:
            cmd_args.extend(['--limit', request.args['hosts']])
        if 'module' in request.args:
            cmd_args.extend(['--module-name', request.args['module']])

        out, err, rc = ansible_runner.run_command(
            executable_cmd='ansible',
            cmdline_args=cmd_args,
            input_fd=sys.stdin
        )
        trim_start = out.find('>>')
        out = out[trim_start+2:]
        if rc == 0:
            return {
                'id': cid,
                'message': "{cmd} sucessfully executed.".format(cmd=data['run_args']),
                # compress/cleanse output for simpler downstream parsing
                'result': out.strip().replace("  ", "")
            }
        else:
            return {
                'id': cid,
                'message': rc,
                'result': err
            }

@app.route("/v1/construct", methods=['GET', 'POST'])
def construct():
    if request.method == 'POST':
        data = request.get_json(force=True)
        generate_inventory(data)
        generate_setup(data)

        cmd_args = [
            '{dir}/{id}.yaml'.format(dir=WORK_DIR, id=data['id']),
            '-i',
            '{dir}/inventory-{id}.yaml'.format(dir=WORK_DIR, id=data['id']),
            '-v'
        ]

        if 'ssh_key' in request.args and os.path.exists("/{}/{}".format(KEYS_DIR, request.args['ssh_key'])):
            cmd_args.extend(["--private-key", "/{}/{}".format(KEYS_DIR, request.args['ssh_key'])])
        else:
            cmd_args.append("--ask-pass")

        _, err, rc = ansible_runner.run_command(
            executable_cmd='ansible-playbook',
            cmdline_args=cmd_args,
            input_fd=sys.stdin,
            output_fd=sys.stdout,
            error_fd=sys.stderr,
        )
        if rc == 0:
            update_constructs_datastore(data)
            return {
                'id': data['id'],
                'message': "{id}, successfully constructed.".format(id=data['id']),
                'construct': load_construct_file(data['id']),
            }
        else:
            return {
                'id': data['id'],
                'message': err,
                'rc': rc
            }
    elif request.method == 'GET':
        if 'id' in request.args and request.args['id'] in CONSTRUCTS:
            return {
                'id': request.args['id'],
                'message': "{id} successfully retrieved.".format(id=request.args['id']),
                'construct': load_construct_file(request.args['id'])
            }
        elif 'id' in request.args and request.args['id'] not in CONSTRUCTS:
            return {
                'id': request.args['id'],
                'message': "Retrieval failed - construct does not exist.".format(id=request.args['id'])
            }
        else:
            ret = {
                'message': "Constructs successfully retrieved",
                'constructs': []
            }
            for k in CONSTRUCTS.keys():
                ret['constructs'].append({ k: load_construct_file(k) })

            return ret
