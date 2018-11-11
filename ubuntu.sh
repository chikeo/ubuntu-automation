#!/usr/bin/env bash

echo "------------------------------------------------------"
echo "Welcome to Ubuntu 16.04 Provisioning and Configuration"
echo "------------------------------------------------------"

ROOT_DIR=$PWD
export ANSIBLE_HOST_KEY_CHECKING=False

terraform_apply() {
cd $ROOT_DIR/terraform
terraform init
terraform fmt
terraform validate
echo "yes" | terraform apply


ansible_configure() {
echo "Waiting for 300 seconds to allow for the EC2 machine to be fully provisioned and to come online"
sleep 300
ansible-playbook -i $ROOT_DIR/ansible/hosts $ROOT_DIR/ansible/main.yml -e 'ansible_python_interpreter=/usr/bin/python3'
}

while true; do
    read -p "Do you wish to proceed with the server configuration? " yn
    case $yn in
        [Yy]* ) ansible_configure; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

}

terraform_destroy() {
cd $ROOT_DIR/terraform
terraform init
terraform fmt
terraform validate
echo "yes" | terraform destroy
}

# Setting up the resources for maintaining and locking the terraform remote state
echo "Setting up the resources for maintaining and locking the terraform remote state"
cd terraform/remote-state/
terraform init && terraform fmt && terraform validate 
echo "yes" | terraform apply -var-file="starter-vars.tfvars"
cd ../../

while true; do
    read -p "Do you wish to proceed with the server provisioning? " yn
    case $yn in
        [Yy]* ) terraform_apply; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to proceed with terraform destroy? " yn
    case $yn in
        [Yy]* ) terraform_destroy; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
