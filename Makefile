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

.PHONY:ansible-inventory
ansible-inventory: terraform
	cp ansible/hosts.sample ansible/hosts
	sed -i -e "s/192.0.2.1/$(bench_ip)/" ansible/hosts
	sed -i -e "s/192.0.2.2/$(webapp1_ip)/" ansible/hosts
	sed -i -e "s/192.0.2.3/$(webapp2_ip)/" ansible/hosts
	sed -i -e "s/192.0.2.4/$(webapp3_ip)/" ansible/hosts

.PHONY:ansible
ansible: ansible-inventory
	cd ansible && ansible-playbook site.yaml -vv

.PHONY:apply-instance
apply-instance: ansible

.PHONY:destroy-instance
destroy-instance:
	cd terraform && terraform destroy
