# Setup and execute a suite of Phoronix-Test-Suite benchmarks and upload results to Openbenchmarking.org:

### curl --request POST --data @benchmark-example.json https://{operator-host-address}:{port}/v1/construct
------------
`> cat benchmark-example.json`
```json
{
    "id": "benchmark_example_construct",
    "setup": [
        {
            "type": "benchmark",
            "url": "0x0i.phoronix",
            "properties": {
                "install_type": "archive",
                "archive_url": "https://github.com/phoronix-test-suite/phoronix-test-suite/releases/download/v10.6.1/phoronix-test-suite-10.6.1.tar.gz",
                "inspect_system": false,
                "default_run_asynchronous": true,
                "default_autopilot": true,
                "user_configs": [
                    {
                        "user": "example-user",
                        "config": {
                            "BatchMode": {
                                "SaveResults": true
                            }
                        },
                        "test_runs": [
                            {
                                "name": "pts/compress-gzip",
                                "runtime_config": {
                                    "test_results_name": "test-compress-gzip-results"
                                }
                            },
                            {
                                "name": "pts/python",
                                "runtime_config": {
                                    "test_results_name": "test-python-results"
                                }
                            }
                        ]
                    }
                ]
            }
        }
    ],
    "inventory": [
        {
            "name": "example-node",
            "address": "localhost",
            "user": "example-user",
            "roles": ["benchmark"]
        }
    ]
}
```
