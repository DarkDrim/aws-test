#!/bin/bash -xe
yum -y install java-1.8.0-openjdk
yum -y install postgresql
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
aws s3 cp s3://dadamenko-lohika-bucket . --recursive
