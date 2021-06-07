echo 'Hey!' > test.txt
aws s3api create-bucket --bucket dadamenko-test-bucket --region us-east-2 --create-bucket-configuration LocationConstraint=us-east-2
aws s3api put-bucket-versioning --bucket dadamenko-test-bucket --versioning-configuration Status=Enabled
aws s3 cp test.txt s3://dadamenko-test-bucket/test.txt

