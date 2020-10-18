Ansible Role: AWS CloudWatch Agent
=========
This Ansible role installs and configures AWS CloudWatch Agent on AWS EC2 instances
and on-premise servers.

Requirements
------------
* An AWS EC2 instance or an on-premise Linux server
* If using AWS EC2 instance, the instance must have an IAM role attached that has policies to run AWS CloudWatch Agent. Consider using the AWS provided policy - CloudWatchAgentServerPolicy.
* If using on-premise server, configure /root/.aws/credentials and /root/.aws/config.
* Create the file `aws-cw-config.json` in a path where Ansible can find it. Within this file, save your AWS CloudWatchAgent configuration in JSON format.

Role Variables
--------------

| Variable | Default Value | Description | Required? |
|----------|---------------|---------|-----------|
| aws_cloudwatch_agent_username |  | The administrative user that should be the owner of the downloaded files. Typically same as remote_user. On Ubuntu it maybe `ubuntu` and CentOS it may be `centos` and on Amazon Linux it may be `ec2-user`. The role guesses the username based on OS if not set explicitly. | No |
| aws_cloudwatch_agent_download_directory | | The location where the AWS CloudWatch Agent software has to be downloaded to. The role guesses the location based on OS if not set explicitly. | No |
| aws_cloudwatch_agent_download_url | | The URL from which Amazon CloudWatchAgent must be downloaded. This is automatically set by the role. But you can override it. | No |
| aws_cloudwatch_agent_mode | ec2 | The AWS CloudWatch Agent mode. Can be one of `ec2`, `onPremise` and `auto` | No |

Example JSON file: aws-cw-config.json
-------------
```json

{
	"metrics": {
		"append_dimensions": {
			"AutoScalingGroupName": "${aws:AutoScalingGroupName}",
			"ImageId": "${aws:ImageId}",
			"InstanceId": "${aws:InstanceId}",
			"InstanceType": "${aws:InstanceType}"
		},
		"metrics_collected": {
			"cpu": {
				"measurement": [
					"cpu_usage_idle",
					"cpu_usage_iowait",
					"cpu_usage_user",
					"cpu_usage_system"
				],
				"metrics_collection_interval": 300,
				"resources": [
					"*"
				],
				"totalcpu": false
			},
			"disk": {
				"measurement": [
					"used_percent",
					"inodes_free"
				],
				"metrics_collection_interval": 300,
				"resources": [
					"*"
				]
			},
			"diskio": {
				"measurement": [
					"io_time"
				],
				"metrics_collection_interval": 300,
				"resources": [
					"*"
				]
			},
			"mem": {
				"measurement": [
					"mem_used_percent"
				],
				"metrics_collection_interval": 300
			},
			"swap": {
				"measurement": [
					"swap_used_percent"
				],
				"metrics_collection_interval": 300
			}
		}
	}
}

```

Example JSON for onPremise server:
```json
{
        "metrics": {
                "namespace": "my_custom_namespace",
                "metrics_collected": {
                        "cpu": {
                                "measurement": [
                                        "cpu_usage_idle",
                                        "cpu_usage_iowait",
                                        "cpu_usage_user",
                                        "cpu_usage_system"
                                ],
                                "metrics_collection_interval": 360,
                                "resources": [
                                        "*"
                                ],
                                "totalcpu": false
                        },
                        "disk": {
                                "measurement": [
                                        "used_percent",
                                        "inodes_free"
                                ],
                                "metrics_collection_interval": 360,
                                "resources": [
                                        "*"
                                ]
                        },
                        "diskio": {
                                "measurement": [
                                        "io_time"
                                ],
                                "metrics_collection_interval": 360,
                                "resources": [
                                        "*"
                                ]
                        },
                        "mem": {
                                "measurement": [
                                        "mem_used_percent"
                                ],
                                "metrics_collection_interval": 360
                        },
                        "swap": {
                                "measurement": [
                                        "swap_used_percent"
                                ],
                                "metrics_collection_interval": 360
                        }
                }
        }
}
```

Example /root/.aws/credentials for on-premise server:
```
[AmazonCloudWatchAgent]
aws_access_key_id = youaccesskeyid
aws_secret_access_key = yoursecretkey

```
Example /root/.aws/config for on-premise server:
```
[AmazonCloudWatchAgent]
region = us-east-1
```

For the list of metrics, see [AWS CloudWatchAgent Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/metrics-collected-by-CloudWatch-agent.html)

Example Playbook
----------------

```yml
    - hosts: cloudwatch-servers
      roles:
         - role: Gavika.aws-cloudwatch-agent
```


Continuous Integration
-----------------------
This Github project uses TravisCI for continuous integration. AWS secrets are
used in the Travis environment file. Therefore, CI builds are not available for
pull requests. However, you can run molecule tests locally.

License
-------

BSD

Author Information
------------------

Sudheer Satyanarayana
* Blog: https://www.techchorus.net
* Twitter: https://www.twitter.com/bngsudheer


Gavika
* https://www.gavika.com
