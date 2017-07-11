#! /bin/bash -ev

if [[ $# -lt 2 || $1 == "help" ]]
then
    echo "./$( basename $0 ) <user> <env>"
    echo "where <env> is one of"
    echo "   dev"
    echo "   prod"
    echo "   staging"
    exit 1
fi

TF_USER=$1
TF_ENV=$2
echo "deploying $TF_ENV"

# Init
terraform init -backend-config=environments/$TF_ENV-backend.tfvars

# Plan
terraform plan -var-file=environments/$TF_ENV.tfvars

# Apply
terraform apply -var-file=environments/$TF_ENV.tfvars

# Push
terraform push -name=$TF_USER/multiple-envs-$TF_ENV -var-file=environments/$TF_ENV.tfvars
