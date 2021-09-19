{
    "Job": {
        "Affinities": null,
        "AllAtOnce": false,
        "Constraints": null,
        "ConsulNamespace": "",
        "ConsulToken": "",
        "CreateIndex": 35,
        "Datacenters": [
            "cwdc-os-1"
        ],
        "Dispatched": false,
        "ID": "waypoint-runner",
        "JobModifyIndex": 35,
        "Meta": null,
        "Migrate": null,
        "ModifyIndex": 46,
        "Multiregion": null,
        "Name": "waypoint-runner",
        "Namespace": "default",
        "NomadTokenID": "",
        "ParameterizedJob": null,
        "ParentID": "",
        "Payload": null,
        "Periodic": null,
        "Priority": 50,
        "Region": "global",
        "Reschedule": null,
        "Spreads": null,
        "Stable": true,
        "Status": "running",
        "StatusDescription": "",
        "Stop": false,
        "SubmitTime": 1632027289176029416,
        "TaskGroups": [
            {
                "Affinities": null,
                "Constraints": null,
                "Consul": {
                    "Namespace": ""
                },
                "Count": 1,
                "EphemeralDisk": {
                    "Migrate": false,
                    "SizeMB": 300,
                    "Sticky": false
                },
                "Meta": null,
                "Migrate": {
                    "HealthCheck": "checks",
                    "HealthyDeadline": 300000000000,
                    "MaxParallel": 1,
                    "MinHealthyTime": 10000000000
                },
                "Name": "waypoint-runner",
                "Networks": [
                    {
                        "CIDR": "",
                        "DNS": null,
                        "Device": "",
                        "DynamicPorts": null,
                        "IP": "",
                        "MBits": 0,
                        "Mode": "host",
                        "ReservedPorts": null
                    }
                ],
                "ReschedulePolicy": {
                    "Attempts": 0,
                    "Delay": 30000000000,
                    "DelayFunction": "exponential",
                    "Interval": 0,
                    "MaxDelay": 3600000000000,
                    "Unlimited": true
                },
                "RestartPolicy": {
                    "Attempts": 2,
                    "Delay": 15000000000,
                    "Interval": 1800000000000,
                    "Mode": "fail"
                },
                "Scaling": null,
                "Services": null,
                "ShutdownDelay": null,
                "Spreads": null,
                "StopAfterClientDisconnect": null,
                "Tasks": [
                    {
                        "Affinities": null,
                        "Artifacts": null,
                        "Config": {
                            "image": "hashicorp/waypoint:latest",
                            "args": [
                                "runner",
                                "agent",
                                "-vvv"
                            ],
                            "auth_soft_fail": false
                        },
                        "Constraints": null,
                        "DispatchPayload": null,
                        "Driver": "docker",
                        "Env": {
                            "WAYPOINT_SERVER_ADDR": "192.168.121.243:20704",
                            "WAYPOINT_SERVER_TLS": "true",
                            "WAYPOINT_SERVER_TLS_SKIP_VERIFY": "true",
                            "WAYPOINT_SERVER_TOKEN": "3K4wQUdH1dfHybG3HmdE6qfFAV2Hc4ntz7tHAnrHdUc5SyQNp97oTCLbDsaVxH7iJH3RjgonWNY2J8SBVrSoFhxFJGrN6dbqN5gUBEbdTcNd9guPiHzKrFM8AEAM1REbs7CeDskRfmFNe2Pz"
                        },
                        "KillSignal": "",
                        "KillTimeout": 5000000000,
                        "Kind": "",
                        "Leader": false,
                        "Lifecycle": null,
                        "LogConfig": {
                            "MaxFileSizeMB": 10,
                            "MaxFiles": 10
                        },
                        "Meta": null,
                        "Name": "runner",
                        "Resources": {
                            "CPU": 200,
                            "Cores": 0,
                            "Devices": null,
                            "DiskMB": 0,
                            "IOPS": 0,
                            "MemoryMB": 600,
                            "MemoryMaxMB": 0,
                            "Networks": null
                        },
                        "RestartPolicy": {
                            "Attempts": 2,
                            "Delay": 15000000000,
                            "Interval": 1800000000000,
                            "Mode": "fail"
                        },
                        "ScalingPolicies": null,
                        "Services": null,
                        "ShutdownDelay": 0,
                        "Templates": null,
                        "User": "",
                        "Vault": null,
                        "VolumeMounts": null
                    }
                ],
                "Update": {
                    "AutoPromote": false,
                    "AutoRevert": false,
                    "Canary": 0,
                    "HealthCheck": "checks",
                    "HealthyDeadline": 300000000000,
                    "MaxParallel": 1,
                    "MinHealthyTime": 10000000000,
                    "ProgressDeadline": 600000000000,
                    "Stagger": 30000000000
                },
                "Volumes": null
            }
        ],
        "Type": "service",
        "Update": {
            "AutoPromote": false,
            "AutoRevert": false,
            "Canary": 0,
            "HealthCheck": "",
            "HealthyDeadline": 0,
            "MaxParallel": 1,
            "MinHealthyTime": 0,
            "ProgressDeadline": 0,
            "Stagger": 30000000000
        },
        "VaultNamespace": "",
        "VaultToken": "",
        "Version": 0
    }
}