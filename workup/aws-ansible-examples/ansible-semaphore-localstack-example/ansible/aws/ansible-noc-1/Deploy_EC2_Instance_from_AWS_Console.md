# Deploy an EC2 Instance from the AWS Console

Sometimes it is good to deploy something the old-fashioned way using the [AWS Console](https://console.aws.amazon.com) in order to compare it with the new, automated way using Ansible or other programmatic methods. This will help you to understand the basics of AWS VPC networking if you are new to AWS. It will also explain what the [AWS Launch Instance wizard](https://console.aws.amazon.com/ec2/home#LaunchInstanceWizard) is doing automatically behind the scenes for you that you must do *manually* with APIs.





## Amazon Web Services (AWS) Account

Obviously, if you do not have an AWS account, you will need one! Register for a *free* account and 1 year of free tier services: <https://aws.amazon.com/free>. You may complete everything below using only free tier services.





## Create a Key Pair

Your example AWS instance(s) will have a public IP address so anyone can - and will - eventually find it and try to login and use it. For this reason, AWS does not allow the use of normal passwords. Instead, they use a private/public cryptographic key pair which is *much* stronger than a password.

1. Login to the [Amazon Web Services (AWS) Console](https://console.aws.amazon.com) as a root user (not IAM user) of your account
2. Verify or choose your **Region** in the drop-down menu next to your account name
3. Open the **Services** menu and choose **Compute > EC2**
4. Choose **Network & Security > Key Pairs** from the left menu
5. Click **Create Key Pair**, fill in the attributes below, and click **Create Key Pair**
    - Name: `aws_ssh_key`
    - Key pair type: **RSA**
    - Private key file format: **.pem**
6. When prompted, save the `aws_ssh_key.pem` private key file to your home directory in a folder named `.ssh` (`~/.ssh/aws_ssh_key.pem`)
7. If you are using macOS, Linux, or WSL, change the file permissions so it cannot be viewed by others or accidentally overwritten or deleted by you:

    ```bash
    chmod 400 ~/.ssh/aws_ssh_key.pem
    ```

    > 🛑 Do not lose this private key file! You will not be able to login to your AWS EC2 instances configured with the corresponding public key!

When you create instances in AWS, you may choose to put the matching public key into your VMs to authorize your SSH login. To use your key with AWS EC2 instances, you will connect using SSH and authenticate with the `-i` *identity file* option which is your `aws_ssh_key.pem` private key :

```bash
ssh -i ~/.ssh/aws_ssh_key.pem ubuntu@{hostname | IP}
```





## Launch an Instance

You may quickly deploy a Linux VM with these easy steps.

1. Login to the [AWS Console](https://console.aws.amazon.com)
2. Verify or choose your **Region** in the drop-down menu next to your account name
3. Open the **Services** menu and choose **Compute > EC2**
4. Click on **Launch Instances**
5. Find the **Ubuntu Server 20.04 LTS (HVM), SSD Volume Type** - or whichever Free Tier Eligible AMI you prefer and click the **Select** button for it
6. Choose the default `t2.micro` instance type and click **Review and Launch**
7. You can see that AWS will create a default Security Group (launch-wizard-*n*) to allow you to connect to the instance using SSH on `TCP/22` from anywhere in the world (`0.0.0.0/0`). This will be fine for this example - you do not need to change anything.
8. Click on **Launch**
9.  Choose or create your SSH key pair, acknowledge that you have the private key file, then click **Launch Instances**

    > 🛑 Do not proceed without a key pair and do not choose a public key without a matching private key file in your possession!





## Connect to the Instance

1. Click on the **View Instances** button then click on your **Instance ID**. You may click on the **⟳** refresh button until you see the Instance State is **Running**.
2. Click **Connect** to see the `ssh` command for your instance:

    ```bash
    ssh -i "~/.ssh/aws_ssh_key.pem" ubuntu@{hostname | IP}
    ```

    > ⚠ Note: you may need to fix the path to your private key (`*.pem`) file if it is not in the current directory

You may also use the public IP address to connect :

```bash
ssh -i ~/.ssh/aws_ssh_key.pem ubuntu@{hostname | IP}
```





## Review AWS Instance Defaults

Now that you have deployed a basic instance, it is good to understand that there are a few things that AWS provisioned automatically for you. It is important to understand the required virtual infrastructure surrounding this instance if you need to create it manually or with automation.

In the AWS Console, go to **Services > Compute > EC2** then select **Instances** from the left menu. You should inspect the individual resources below in the console to view their configuration details and dependencies between each other.

- **VPC** : You have a default VPC in every region. Every default VPC has a private address space of `172.31.0.0/16` but you may configure additional [RFC1918](https://datatracker.ietf.org/doc/html/rfc1918) ranges
- **Subnet** : the private IPv4 subnet (`172.31.0.0/20`) is *within* the default VPC's `172.31.0.0/16` CIDR block. This private subnet covers a single Availability Zone (`us-west-1a`)
- **Private IPv4 Address** : the instance got it's address dynamically from the private subnet
- **Public IPv4 Address** : the public IPv4 address is on a network interface which you used to connect with SSH
- **Internet Gateway** : provides the public address(es) and performs network address translation (NAT) between the public and private addresses
- **Route Table** : has 2 routes for where the traffic should flow:
  | Destination   | Target       |
  |---------------|--------------|
  | 172.31.0.0/16 | local        |
  | 0.0.0.0/0     | igw-faea089d |
- **Network ACL** : configured to Allow All traffic by default
- **Security Group** : 
  - you *must* assign a security group to each EC2 instance
  - AWS assigned the default launch-wizard-*n* security group to operate as a stateful firewall for the instance
    - it allows Inbound connections on TCP/22 from anywhere (`0.0.0.0/0`) and
    - it allows Outbound connections on All ports with All protocols to anywhere (`0.0.0.0/0`)
  - if you want to add additional ports and protocols or limit the traffic sources and destinations, you will need to create your own Security Group(s)

Hopefully you now have a better understanding of the many elements that need to be considered when putting a VM instance into a VPC.  You will need to create all of these manually when using programmatic methods with REST or Ansible.





## Terminate the Instance

When you are done playing with your instance it is important to *Terminate* it or you will continue to incur charges against your account.

1. In the AWS Console, go to **Services > Compute > EC2** then select **Instances** from the left menu. 
2. Check the box next to your instance then choose **Instance State > Terminate instance**
3. You should see the Instance State change to *Shutting Down* then eventually *Terminated*





