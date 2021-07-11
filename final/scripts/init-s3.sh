aws s3api create-bucket --bucket dadamenko-lohika-bucket --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
aws s3api put-bucket-versioning --bucket dadamenko-lohika-bucket --versioning-configuration Status=Enabled
aws s3 cp calc-0.0.2-SNAPSHOT.jar s3://dadamenko-lohika-bucket/calc-0.0.2-SNAPSHOT.jar
aws s3 cp persist3-0.0.1-SNAPSHOT.jar s3://dadamenko-lohika-bucket/persist3-0.0.1-SNAPSHOT.jar
