# ubuntu-automation
Demonstration of the automated provisioning and configuration of an Ubuntu Server

Prerequisites
-----------

1 : AWS CLI installed in your local control machine or server. Pre-configured with your AWS Access key, Secret key, region, and data format (i.e. json)

2 : Terraform installed in your local control machine or server.

3 : Ansible installed in your local control machine or server.

4 : Availability of an ssh key pair or the creation of one using ssh-keygen.

Working
------

(1) AWS CLI installation takes care of

		Setting up the AWS ACCESS KEY ID and the AWS SECRET KEY. The default AWS region and data format (i.e. json) is also setup in the AWS CLI.
		--------------------------------------------------------------------------------

		On a recent Ubuntu control/local machine, this command will install the AWS CLI.

		sudo apt install aws-cli
		OR
		sudo apt-get install aws-cli

(2) Terraform installation takes care of
		Provisioning an Ubuntu 16.04 server AWS environment

		Setting up the firewall to only allow ingress on the ssh port in AWS security group
		-----------------------------------------------------------------------------------

		Download from the terraform website, extract, and add to the system's PATH.


(3) Ansible takes care of

		Configuration to allow login over ssh, 

		Configuration to secure the server by disabling password-based login

		Configuration to only to allow password-less (certificate) based login
		
		Configuration to display the MOTD including the text "Hello Assurity DevOps”.
		-----------------------------------------------------------------------------

		On a recent Ubuntu control/local machine, this command will install Ansible.

		sudo apt install ansible
		OR
		sudo apt-get install ansible

(4) Availability of an ssh key pair or the creation of one using ssh-keygen

		Creating SSH keys on Ubuntu

		Before generating a new SSH key pair, first check for existing SSH keys on your Ubuntu client machine. You can do that by running the following command:

		ls -l ~/.ssh/id_*.pub


		If the command above prints something like No such file or directory or no matches found it means that you don’t have SSH keys on your client machine and you can proceed with the next step and generate SSH key pair.

		If there are existing keys, you can either use those and skip the next step or backup up the old keys and generate new ones.

		Generate a new 4096 bits SSH key pair with your email address as a comment by typing:

			ssh-keygen -t rsa -b 4096 -C "your_email@domain.com"


Steps to execute
----------------

git clone https://github.com/chikeo/ubuntu-automation.git

cd ubuntu-automation/

# Remember to replace the email placeholder with your email as a comment and to reference the keys appropriately
# Move the key pair one level above this application's root folder for it to work with the application without any changes

ssh-keygen -t rsa -b 4096 -C "your_email@domain.com"

./ubuntu.sh

