bench_ip = $(shell cat terraform/terraform.tfstate | jq .outputs.bench_public_ip.value | tr -d '"')
webapp1_ip = $(shell cat terraform/terraform.tfstate | jq .outputs.webapp1_public_ip.value | tr -d '"')
webapp2_ip = $(shell cat terraform/terraform.tfstate | jq .outputs.webapp2_public_ip.value | tr -d '"')
webapp3_ip = $(shell cat terraform/terraform.tfstate | jq .outputs.webapp3_public_ip.value | tr -d '"')

.PHONY:go-fmt
go-fmt: 
	gofmt -l -w .

.PHONY:terraform-fmt
terraform-fmt:
	terraform fmt -recursive

.PHONY:fmt
fmt: go-fmt terraform-fmt

.PHONY:terraform
terraform:
	cd terraform && terraform apply -auto-approve

.PHONY:terraform-destroy
terraform-destroy:
	cd terraform && terraform destroy -auto-approve

ansible/hosts_tmp:
	cp ansible/hosts.sample ansible/hosts_tmp
	sed -i -e "s/192.0.2.1/$(bench_ip)/" ansible/hosts_tmp
	sed -i -e "s/192.0.2.2/$(webapp1_ip)/" ansible/hosts_tmp
	sed -i -e "s/192.0.2.3/$(webapp2_ip)/" ansible/hosts_tmp
	sed -i -e "s/192.0.2.4/$(webapp3_ip)/" ansible/hosts_tmp

ansible/hosts: ansible/hosts_tmp
	cp ansible/hosts_tmp ansible/hosts
	rm ansible/hosts_tmp

.PHONY:ansible
ansible: ansible/hosts
	cd ansible && ansible-playbook site.yaml -vv --ssh-extra-args '-o ControlMaster=auto -o ControlPersist=300s -o ForwardAgent=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

