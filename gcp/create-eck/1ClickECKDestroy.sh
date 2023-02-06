#!/bin/bash

export KUBE_CONFIG_PATH=~/.kube/config
set -e

echo "1ClickECKDestroy.sh Copying variable files"
cp -f ../variables.tf .
cp -f ../terraform.tfvars .
cp -f ../variables.tf ./create-operator/variables.tf
cp -f ../terraform.tfvars ./create-operator/variables.tfvars

terraform init

echo "1ClickECKDestroy.sh Terraform Destroy"
echo "1ClickECKDestroy.sh Destroying License"
(cd ./license; ./1ClickAddLicenseDestroy.sh)
echo "1ClickECKDestroy.sh finished Destroying License"

echo "1ClickECKDestroy.sh Destroying ES Pods"
terraform destroy -auto-approve
echo "1ClickECKDestroy.sh finished Destroying ES Pods"

echo "1ClickECKDestroy.sh Destroying Operator"
(cd ./create-operator; ./1ClickECKOperatorDestroy.sh)
echo "1ClickECKDestroy.sh finished Destroying Operator"