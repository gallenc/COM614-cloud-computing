# Ansible AWS EC2 Management

An Ansible project to **create** and **terminate** AWS EC2 instances.

---

## Prerequisites

- Python 3.8+
- Ansible 2.12+
- `boto3` and `botocore` Python packages
- AWS credentials configured

### Install dependencies

```bash
pip install ansible boto3 botocore
ansible-galaxy collection install amazon.aws
```

### AWS credentials

Export credentials or use a profile:

```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

Or configure `~/.aws/credentials` via `aws configure`.

---

## Project Structure

```
ansible-ec2/
├── README.md
├── ansible.cfg                    # Ansible configuration
├── requirements.yml               # Galaxy collection dependencies
├── inventory/
│   └── hosts.ini                  # Static inventory (localhost for AWS API calls)
├── group_vars/
│   └── all.yml                    # Shared variables
├── playbooks/
│   ├── create_instances.yml       # Playbook: create EC2 instances
│   └── terminate_instances.yml    # Playbook: terminate EC2 instances
└── roles/
    ├── ec2_create/
    │   ├── defaults/main.yml      # Default variables
    │   ├── vars/main.yml          # Role variables
    │   └── tasks/main.yml         # Create tasks
    └── ec2_terminate/
        ├── defaults/main.yml      # Default variables
        ├── vars/main.yml          # Role variables
        └── tasks/main.yml         # Terminate tasks
```

---

## Usage

### Create EC2 Instances

```bash
# Using defaults
ansible-playbook playbooks/create_instances.yml

# Override variables at runtime
ansible-playbook playbooks/create_instances.yml \
  -e "instance_count=3" \
  -e "instance_type=t3.medium" \
  -e "ec2_region=us-west-2"
```

### Terminate EC2 Instances

```bash
# Terminate by tag (recommended)
ansible-playbook playbooks/terminate_instances.yml

# Terminate specific instance IDs
ansible-playbook playbooks/terminate_instances.yml \
  -e "instance_ids=['i-0abc123','i-0def456']"

# Terminate by different tag value
ansible-playbook playbooks/terminate_instances.yml \
  -e "ec2_env=staging"
```

---

## Variables Reference

| Variable | Default | Description |
|---|---|---|
| `ec2_region` | `us-east-1` | AWS region |
| `instance_type` | `t3.micro` | EC2 instance type |
| `instance_count` | `1` | Number of instances to create |
| `ami_id` | `ami-0c02fb55956c7d316` | Amazon Machine Image ID |
| `key_name` | `my-keypair` | SSH key pair name |
| `ec2_env` | `dev` | Environment tag (used for targeting) |
| `instance_name` | `ansible-managed` | Name tag for instances |
| `vpc_subnet_id` | `""` | VPC subnet (empty = default VPC) |
| `security_group_ids` | `[]` | List of security group IDs |
| `assign_public_ip` | `true` | Assign a public IP |
| `instance_ids` | `[]` | Specific instance IDs to terminate |

---

## Tags

The project uses Ansible tags for selective execution:

```bash
# Only run instance creation steps
ansible-playbook playbooks/create_instances.yml --tags create

# Only display instance info after creation
ansible-playbook playbooks/create_instances.yml --tags info
```
