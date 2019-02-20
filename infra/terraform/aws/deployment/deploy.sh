#! /bin/bash
###
AWS_HOST=`cat ../ec2-instance/host_ip.txt`
AWS_SSH_KEY="../ec2-instance/aws_ssh_key"
GIT_ZIP_PKG="https://github.com/kimuthuselvan/Muthuselvan_Challenge/archive/master.zip"

ssh -i $AWS_SSH_KEY ec2-user@$AWS_HOST "wget -q $GIT_ZIP_PKG"
ssh -i $AWS_SSH_KEY ec2-user@$AWS_HOST "unzip master.zip >/dev/null"

SOURCE_PATH="/home/ec2-user/Muthuselvan_Challenge-master/src"

ssh -i $AWS_SSH_KEY ec2-user@$AWS_HOST "sudo cp -f $SOURCE_PATH/index.html /var/www/html/index.html"

ssh -i $AWS_SSH_KEY ec2-user@$AWS_HOST "sudo systemctl restart httpd.service"

rm -rf /home/ec2-user/Muthuselvan_Challenge-master
rm -rf /home/ec2-user/master.zip


