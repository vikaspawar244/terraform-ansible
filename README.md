# terraform-ansible
Elasticsearch cluster setup using Terrafrom and Ansible tool.

## Notes and requirements
 - The playbook was built and tested on Ubuntu 16.04 VMs, for Elasticsearch versions 6.x 
 - You will need Ansible installed and running
 - In the terminal on the machine hosting Ansible, clone this repo.
 - Cd into the directory, 
 - cd terraform-ansible/
  More Info: 
   Terraform has four essential commands that allow us to deal with an end-to-end workflow:
        terraform init
	terraform plan
	terraform apply
	terraform destroy
 - For running terraform script Prepare your profile key, make sure you have already created your AWS account (AWS Access Key ID & AWS Secret Access Key)
 - For running terraform scripts you need changes few aws resources like as vpc_id,subnet_id & security_groups.
(Please check the output directory for clear picture)

   

