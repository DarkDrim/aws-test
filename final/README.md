## Run

```bash
cd scripts
./init-s3.sh

terraform init
terraform validate
terraform apply
```

To find sensitive outputs use:
```bash
terraform output rds_host
terraform output rds_username
```

Add SNS subscription (email) using AWS console.

Run into public subnets:
```bash
sudo su
cd /
java -jar calc-0.0.2-SNAPSHOT.jar
```

Run into private subnet:
```bash
sudo su
cd /
# set environment variable RDS_HOST with correct RDS address
RDS_HOST=<rds_host> java -jar persist3-0.0.1-SNAPSHOT.jar
```

On your local machine, you need to have java 8.
On your local machine execute:
java -cp calc-client-1.0-SNAPSHOT-jar-with-dependencies.jar CalcClient <ELB’s DNS name>
```bash
docker build -t client .
docker run --rm -it client bash

$> java -cp calc-client-1.0-SNAPSHOT-jar-with-dependencies.jar CalcClient <ELB’s DNS name>
```

Scan items from dynamodb:
SSH to public instance

```bash
aws dynamodb scan --table-name edu-lohika-training-aws-dynamodb
```

Connect to RSD:
SSH to private instance from public

User rootuser
Pwd rootuser
Table LOGS

Get DB instances
```bash
aws rds describe-db-instances --filters "Name=engine,Values=postgres" --query "*[].[DBInstanceIdentifier,Endpoint.Address,Endpoint.Port,MasterUsername]"
```

Response example
```text
[
    [
        "lohikadb",
        "lohikadb.cfs4xvpnoisn.us-west-2.rds.amazonaws.com",
        5432,
        "rootuser"
    ]
]
```

Connect
```bash
psql -h lohikadb.cfs4xvpnoisn.us-west-2.rds.amazonaws.com -U rootuser EduLohikaTrainingAwsRds --password
# pwd: rootuser
```

Query:
```sql
SELECT * FROM LOGS;
```
