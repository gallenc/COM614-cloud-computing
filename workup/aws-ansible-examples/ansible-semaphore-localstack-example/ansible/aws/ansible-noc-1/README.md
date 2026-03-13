




# based on example here

https://github.com/1homas/Ansible_AWS_EC2_Instance

# Ansible AWS EC2 Instance Playbook

Deploy an AWS EC2 instance of a Linux VM.  You may complete everything below within the [AWS Free Tier](https://aws.amazon.com/free).  If you have never deployed an AWS EC2 instance, you should first read [Deploy an EC2 Instance from the AWS Console](Deploy_EC2_Instance_from_AWS_Console.md) to understand the process and the virtual private cloud (VPC) components involved.


## Quick Start

1. Clone this repository:  

    ```bash
    git clone https://github.com/1homas/Ansible_AWS_EC2_Instance
    ```

1. Create your Python environment and install Ansible:  

    ```bash
    pip install --upgrade pip
    pip install pipenv
    pipenv install --python 3.9
    pipenv install ansible boto boto3 botocore
    pipenv shell
    ```

    If you have any problems installing Python or Ansible, see [Installing Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

1. Export your AWS Access & Secret keys into your terminal environment:  

    ```bash
    export AWS_REGION='us-west-1'
    export AWS_ACCESS_KEY='AKIAIOSF/EXAMPLE+KEY'
    export AWS_SECRET_KEY='wJalrXUtnFEMI/K7MDENG/bPxRfi/EXAMPLE+KEY'
    ```

1. Run the Ansible playbook:  

    ```bash
    ansible-playbook playbook.yaml
    ```

1. SSH to your new running instance:  

    > ⚠ Replace the `{hostname}` with the dynamically assigned public IP address!

    ```bash
    ssh -i ./AWS_EC2_Instance_Test.private_key.pem ec2-user@{hostname}
    ```

1. When you're done, you may terminate and remove the instances:

    ```bash
    ansible-playbook terminate.yaml
    ```





## Create an AWS Identity and Access Management (IAM) User

In order to programmatically interact with resources in your AWS account - using REST APIs with Ansible - you must configure an Identity and Access Management (IAM) User with an API Key.  If you have already done this, you may skip it.

1. In AWS, select **Services > Security, Identity, & Compliance > [IAM](https://console.aws.amazon.com/iam/home)**
1. In the left panel, select **Access management > Users**
1. Click on the **Add Users** button
    1. Username: *your_iam_username* (example: `aws-api`)
    1. Access type: ✅ Programmatic access
       This generates an **access key ID** and **secret access key** for the AWS API, CLI, SDK, and other development tools. 
    1. Click **Next: Permissions**
    1. Create a new group named **APIs** or something similar if you don't have one already then click **Next: Tags**
    1. You may add tags as key-value pairs or skip it and click **Next: Review**
    1. Review your settings then click **Create User**
2. Copy your **Access Key ID**, and **Secret Access Key** into dot-file named with the **IAM API Username** in your home directory (`~/.keys/aws-api.keys`) :

    ```bash
    export AWS_REGION='us-west-1'
    export AWS_ACCESS_KEY='AKIAIOSF/EXAMPLE+KEY'
    export AWS_SECRET_KEY='wJalrXUtnFEMI/K7MDENG/bPxRfi/EXAMPLE+KEY'
    ```

    > 🛑 These credentials allow *anyone* to provision unlimited AWS resources and have them conveniently billed to your account - be careful about where you store them!

    > 💡 You may want to encrypt your keys file with Ansible Vault

3. Once you have saved your credentials, click **Close**





## Using AWS Credentials with Ansible

Every Ansible AWS task requires [authentication for programmatic access](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) using your access keys. This must be done in *every* task of your playbook.

To keep your AWS credentials safe - and keep your playbooks shorter and simpler! - the [Ansible AWS Guide](https://docs.ansible.com/ansible/latest/scenario_guides/guide_aws.html) explains how you may use shell environment variables to do the same thing.  

In your terminal session with Ansible, load the `AWS_*` environment variables from the `~/.keys/aws-api.keys` you created with the command
```bash
source ~/.keys/aws-api.keys
```

The `amazon.aws.*` and `community.aws.*` modules will implicitly use the environment variables for programmatic access, eliminating 2-3 lines from *every* AWS-related task in your playbooks!  This is the method used in this repository's playbooks.  

```yaml
  - name: Create SSH Key Pair
    amazon.aws.ec2_key:
      # region: "{{ region }}"
      # aws_access_key: "{{ aws_access_key }}"
      # aws_secret_key: "{{ aws_secret_key }}"
      name: my_public_key
      state: present
    register: create_key
```

If you would rather explicitly include the `region` and `aws_*` keys, you may put them in an Ansible `vars` YAML file that you include in your playbook for variable substitution.  If you do this, be careful about accidentally publishing your unencrypted AWS keys in a public repository or shared directory. To secure your keys, it is recommended that you use [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) or other strong encryption mechanism to keep your credentials secure.





## Resources

- [Installing Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) for all platforms
- [amazon.aws](https://docs.ansible.com/ansible/latest/collections/amazon/aws/) Ansible collection documentation
- [community.aws](https://docs.ansible.com/ansible/latest/collections/community/aws/) Ansible collection documentation
- - [AWS re:Invent 2019: AWS Networking Fundamentals (NET201-R2)](https://www.youtube.com/watch?v=gj4CD73Wmns) provides an excellent overview of the networking elements that are automatically created when using the [Launch Instance wizard](https://console.aws.amazon.com/ec2/home#LaunchInstanceWizard)
- [Best practices for managing AWS access keys](https://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html)





## License

This repository is licensed under the [MIT License](https://choosealicense.com/licenses/mit/).




