#! /bin/bash
###

AWS_HOST_IP=`cat ../ec2-instance/host_ip.txt`
AWS_HOST_DNS=`cat ../ec2-instance/host_dns.txt`
AWS_SSH_KEY="../ec2-instance/aws_ssh_key"
GIT_ZIP_PKG="https://github.com/kimuthuselvan/Muthuselvan_Challenge/archive/master.zip"


ssh -i $AWS_SSH_KEY ec2-user@$AWS_HOST_IP "wget -q $GIT_ZIP_PKG"
ssh -i $AWS_SSH_KEY ec2-user@$AWS_HOST_IP "unzip master.zip >/dev/null"

SOURCE_PATH="/home/ec2-user/Muthuselvan_Challenge-master/infra/terraform/aws/middleware"
scp -i $AWS_SSH_KEY ../ec2-instance/host_dns.txt ec2-user@$AWS_HOST_IP:$SOURCE_PATH/ 
ssh -i $AWS_SSH_KEY ec2-user@$AWS_HOST_IP "/bin/sh $SOURCE_PATH/deploy.sh"

