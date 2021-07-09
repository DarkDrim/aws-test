## Run

```bash
cd scripts
./init-s3.sh

terraform init
terraform validate
terraform apply

docker build -t client .
docker run --rm -it client bash
```

Run into public subnet:
calc-0.0.1-SNAPSHOT.jar

Run into private subnet:
persist3-0.0.1-SNAPSHOT.jar
set environment variable RDS_HOST with correct RDS address

On your local machine, you need to have java 8.
On your local machine execute:
java -cp calc-client-1.0-SNAPSHOT-jar-with-dependencies.jar CalcClient <ELB’s DNS name>
```bash
docker build -t client .
docker run --rm -it client bash
java -cp calc-client-1.0-SNAPSHOT-jar-with-dependencies.jar CalcClient <ELB’s DNS name>
```
