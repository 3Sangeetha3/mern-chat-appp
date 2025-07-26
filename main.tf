provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "chat_app" {
  ami           = "ami-0d03cb826412c6b0f" # Amazon Linux 2 AMI for ap-south-1
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              # Update and install necessary packages
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo yum install -y git

              # Install Docker Compose
              sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose

              # Clone the repository
              cd /home/ec2-user
              git clone https://github.com/3Sangeetha3/mern-chat-appp.git
              cd mern-chat-appp
              
              # Create .env file from variables passed into the template
              cat > .env << EOL
                MONGODB_URI=mongodb://mongodb:27017/chatapp
                JWT_SECRET=${var.jwt_secret}
                GOOGLE_AI_API_KEY=${var.google_ai_api_key}
                CLOUDINARY_CLOUD_NAME=${var.cloudinary_cloud_name}
                CLOUDINARY_API_KEY=${var.cloudinary_api_key}
                CLOUDINARY_API_SECRET=${var.cloudinary_api_secret}
                EMAIL_FROM=${var.email_from}
                EMAIL_PASS=${var.email_pass}
                FRONTEND_URL=http://localhost:3000
                EOL

              # Start the application using Docker Compose
              /usr/local/bin/docker-compose up -d
            EOF

  tags = {
    Name = "MernChatAppEC2"
  }

  vpc_security_group_ids = [aws_security_group.allow_chat_traffic.id]
}

resource "aws_security_group" "allow_chat_traffic" {
  name_prefix = "allow-chat-traffic-"

  # Ingress for Frontend
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress for Backend
  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress for all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance."
  value       = aws_instance.chat_app.public_ip
}

output "application_url" {
  description = "URL to access the chat application frontend."
  value       = "http://${aws_instance.chat_app.public_ip}:3000"
}
