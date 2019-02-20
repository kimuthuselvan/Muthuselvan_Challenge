#! /bin/bash
###============================================================================
### Script name: ec2-instance.sh
### Script type: Bash shell
### Description: This script will help to create
###              1) Key pair(s)
###              2) Security group(s)
###              3) EC2 instance(s)
### Author: Muthuselvan I. Kangeya (kimuthuselvan@gmail.com)
### Version: 1.0                Release: 1.0                   Date: 2019-02-19
###============================================================================
export PATH=/opt/terraform:$PATH

#echo -e "Please provide the path for SSH key: \c"
#read SSH_KEY_PATH

#file $SSH_KEY_PATH/* |grep "PEM RSA private key"


case $1 in
setup)
terraform init
[ $? -ne 0 ] && exit 1
echo -e "\n"
terraform plan
[ $? -ne 0 ] && exit 1
echo -e "\n"
terraform apply
[ $? -ne 0 ] && exit 1
echo -e "\n"
terraform output mscontest_public_ip >host_ip.txt
terraform output mscontest_public_dns >host_dns.txt
;;
destroy)
terraform destroy
echo -e "\n"
rm -f host_ip.txt
rm -f host_dns.txt
find ../ -name "*tfstate*" -exec rm -f {} \;
;;
*)
echo -e "\n"
echo -e "Usage: $0 <setup | destroy>"
echo -e "\n"
;;
esac

###============================================================================
### End
###============================================================================
