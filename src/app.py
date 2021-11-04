import re
import ansible_runner
from flask import Flask, request
import os
import sys
import yaml

app = Flask(__name__)


KEYS_DIR = "/keys"
WORK_DIR = "/var/tmp/"
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

    return spec['id']

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

    return spec['id']

@app.route("/key", methods=['GET', 'POST'])
def key():
    if 'ssh' in request.files:
        file = request.files['ssh']
        path = "{}/{}".format(KEYS_DIR, file.filename)

        if not os.path.exists(KEYS_DIR):
            os.makedirs(KEYS_DIR)

        file.save(path)
        os.chmod(path, 0o600)

        return "Successfully uploaded key!"
    
    return "No operation performed."

@app.route("/construct", methods=['GET', 'POST'])
def construct():
    error = None
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

        out, err, rc = ansible_runner.run_command(
            executable_cmd='ansible-playbook',
            cmdline_args=cmd_args,
            input_fd=sys.stdin,
            output_fd=sys.stdout,
            error_fd=sys.stderr,
        )

        CONSTRUCTS[data['id']] = data['setup']

        return "out={}, err={}, rc={}".format(out, err, rc)
    elif request.method == 'GET':
        if 'id' in request.args and request.args['id'] in CONSTRUCTS:
            return {k: v for d in CONSTRUCTS[request.args['id']] for k, v in d.items()}
        else:
            return CONSTRUCTS
