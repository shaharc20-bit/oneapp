# Terraform - builder EC2

Provisions the `builder` EC2 instance used to build and run the app and Jenkins.

## Implemented
- EC2 `builder` (t3.large - Docker + Jenkins + k3s, Ubuntu 24.04, 30GB gp3) in a public subnet of the selected VPC
- VPC: `vpc_id` variable (default `vpc-0a318c6ec12295c3c`, empty = default VPC of the account)
- Subnet: picked automatically from public subnets in AZs that support the instance type
- SSH key pair generated with `tls_private_key`, private key saved locally as `builder_key.pem` (0600), public key uploaded as an AWS key pair
- Security group: 22 (SSH), 5001 (Flask), 8080 (Jenkins) (+ optional `extra_tcp_ports`, NodePort range) open only to the IP of the machine running terraform + `allowed_cidrs` (e.g. home IP), all outbound allowed
- IAM role + instance profile with read-only `ec2:Describe*` / `elasticloadbalancing:DescribeLoadBalancers`, so the app reads AWS without access keys (IMDSv2, hop limit 3 for containers)
- Docker + Docker Compose installed automatically with `remote-exec` (bonus). Manual option: `scripts/install_docker.sh`
- Outputs: public IP/DNS, instance id, security group id, key name, private key path, ssh command, app/jenkins URLs

## Run
```bash
cd aws/terraform
cp terraform.tfvars.example terraform.tfvars   # set region + your home IP
terraform init
terraform plan
terraform apply
terraform output
ssh -i builder_key.pem ubuntu@$(terraform output -raw public_ip)
docker --version && docker compose version
```

Destroy when done: `terraform destroy`

## Notes
- Running from AWS CloudShell: `export TF_DATA_DIR=/tmp/tfdata` before `terraform init` (the AWS provider is ~750MB and CloudShell home is limited to 1GB).
- `tls_private_key` keeps the key in the state file, so the state is local and git-ignored together with `*.pem`.
- If your IP changes, run `terraform apply` again to update the security group.
