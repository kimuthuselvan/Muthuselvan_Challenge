#! /bin/bash
###
EC2HOSTNAME="`cat /etc/hostname`"

SOURCE_PATH="/home/ec2-user/Muthuselvan_Challenge-master/infra/terraform/aws/middleware"
EC2HOSTNAME="`cat $SOURCE_PATH/host_dns.txt`"

sudo yum install -y httpd mod_ssl

sudo sed -i "s/EC2HOSTNAME/$EC2HOSTNAME/g" $SOURCE_PATH/ssl.conf
sudo sed -i "s/EC2HOSTNAME/$EC2HOSTNAME/g" $SOURCE_PATH/non-ssl.conf

sudo mkdir -p /etc/ssl/private
sudo cp -f $SOURCE_PATH/ssl.crt /etc/ssl/certs/ssl.crt
sudo cp -f $SOURCE_PATH/ssl.key /etc/ssl/private/ssl.key
sudo cp -f $SOURCE_PATH/ssl.conf /etc//httpd/conf.d/ssl.conf
sudo cp -f $SOURCE_PATH/non-ssl.conf /etc//httpd/conf.d/non-ssl.conf

sudo systemctl enable httpd.service
sudo systemctl restart httpd.service

rm -rf /home/ec2-user/Muthuselvan_Challenge-master
rm -rf /home/ec2-user/master.zip

