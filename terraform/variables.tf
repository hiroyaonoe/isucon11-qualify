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

locals {
  init_instance_script = file("${path.module}/init_instance.sh")
}

variable "my_home_ip" {
  description = "自宅のIPアドレス"
  type        = string
}
