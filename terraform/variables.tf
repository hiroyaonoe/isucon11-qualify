variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}

variable "isucon11q_ami" {
  description = "https://github.com/matsuu/aws-isucon"
  type        = string
  default     = "ami-01730fadc0a1d1e1c"
}

variable "git_branch_name" {
  description = "checkoutするブランチ名"
  type        = string
  default     = "master"
}

data "template_file" "init_instance_script" {
  template = file("${path.module}/init_instance.tpl")
  vars = {
    git_branch_name = var.git_branch_name
  }
}

variable "allow_ssh_cidr" {
  description = "sshを許可するIPアドレス"
  type        = string
}
