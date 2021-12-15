.PHONY:go-fmt
go-fmt: 
	gofmt -l -w .

.PHONY:terraform-fmt
terraform-fmt:
	terraform fmt -recursive

.PHONY:fmt
fmt: go-fmt terraform-fmt

