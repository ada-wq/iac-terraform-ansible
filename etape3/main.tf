provider "aws" {
  region = "us-east-1"
}


resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAtmFHVxl3z6DAdGtss5gOlNjNuDGoIqH9FqrbUMfGzA4vNjwA5PFR5/J1r6eVijQdRrcFHJeZ4gkKm5tSHWxW1pPFlHuyplkBGTmH1tZwIuVEZTtRDtLJl6wDs0JQ0mdA5gAk5gHzTYwkwNo1YfW8fVmj16lt5u63wT8T8cTjZDs9XpqcoqA78u4fEqWr3n2sVkMw6OYlV1k= adam@host"
}


resource "aws_instance" "docker_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # AMI Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name
  security_groups = ["default"]

  tags = {
    Name = "DockerInstance"
  }


  output "instance_ip" {
    value = aws_instance.docker_instance.public_ip
  }
}
