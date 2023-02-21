# Create elastic beanstalk application
resource "aws_elastic_beanstalk_application" "elasticapp" {
  name = var.elasticapp
}
 
# Create elastic beanstalk Environment
resource "aws_elastic_beanstalk_environment" "beanstalkappenv" {
  name                = var.beanstalkappenv
  application         = aws_elastic_beanstalk_application.elasticapp.name
  solution_stack_name = var.solution_stack_name
  tier                = var.tier
 
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     =  "True"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.public_subnets)
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.autoscaling_min
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.autoscaling_max
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.keypair
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "ENV1"
    value     = "VALUE1"
  }

}


/*
 name        = "gitea-app"
 description = "Gitea Application"
 }

 resource "aws_elastic_beanstalk_environment" "gitea" {
   name = "gitea-env"
   solution_stack_name = "64bit Amazon Linux 2 v3.6.4 running Go 1"
   application = aws_elastic_beanstalk_application.gitea.name
   setting {
     namespace = "aws:autoscaling:launchconfiguration"
     name = "InstanceType"
     value = "t3.micro"
   }
 }
 /*
  resource "aws_s3_bucket" "gitea" {
    bucket = "gitea-bucket"
  }
  /*
   resource "aws_db_instance" "maria_db" {
     instance_class = "db.t2.micro"
     engine = "MariaDB"
     allocated_storage = 20
     storage_type = "gp2"
     db_subnet_group_name = "default"
     vpc_security_group_ids = [aws_security_group.gitea.id]
     identifier = "gitea-db"
     username = "gitea-user"
     password = "gitea-password"
   }

   resource "aws_security_group" "gitea" {
     name = "gitea-sg"
     ingress {
       from_port = 3306
       to_port = 3306
       protocol = "tcp"
       security_groups = [aws_security_group.beanstalk.id]
     }
   }*/
  /*
   resource "aws_security_group" "beanstalk" {
     name = "beanstalk-sg"
     ingress {
       from_port = 80
       to_port = 80
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
     }
   }
   */
  #resource "aws_efs_file_system" "gitea" {
  #  creation_token = "gitea"
  #}

  /*
   resource "aws_efs_mount_target" "gitea" {
     file_system_id = aws_efs_file_system.gitea.id
     subnet_id = [aws_subnet.private.id]
   }

   resource "aws_subnet" "gitea" {
     vpc_id            = aws_vpc.foo.id
     availability_zone = "us-west-2a"
     cidr_block        = "10.0.1.0/24"
   }
   */
