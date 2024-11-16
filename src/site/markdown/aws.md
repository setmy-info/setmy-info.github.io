# AWS

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```shell

aws configure sso --profile profilex
# SSO start URL [https://oursuperconpany.awsapps.com/start]:
# SSO Region [eu-central-1]:
# Select account from CLI menu

aws configure list-profiles

aws s3 ls --profile profilex

# TODO : is this correct to set profilex as default? Is it working?
aws configure sso --profile profilex

# Probably default profile should be in config ~/.aws/config
aws sso login

# Or
AWS_DEFAULT_PROFILE=profilex
aws sso login

aws sts get-caller-identity

aws s3 cp s3://oursuperbucker/ ~/uploads/temp/s3 --recursive --include "*.jpgGiven"

#aws configure sso --profile abc-test
aws configure --profile abc-test
#(x, x, x)
aws s3 ls --profile abc-test
aws eks update-kubeconfig --name k8s-training --region eu-central-1 --profile abc-test
aws eks list-clusters --region eu-central-1 --profile abc-test

```

### Adding profile

Can think as hierarchy:

* Profile
    * Accounts
        * Roles

Example config file **~/.aws/config**:

```
[profile SuperConpantyProfileA-Developers]
sso_start_url = https://supercompanyname.awsapps.com/start
sso_region = eu-central-1
sso_account_id = 259760735148
sso_role_name = Developers
[profile SuperConpantyProfileA-AdministratorAccess]
sso_start_url = https://supercompanyname.awsapps.com/start
sso_region = eu-central-1
sso_account_id = 259760735148
sso_role_name = AdministratorAccess
[default]
sso_start_url = https://supercompanyname.awsapps.com/start
sso_region = eu-central-1
region = eu-central-1
sso_account_id = 259760735148
sso_role_name = Developers
```

## See also

[xxxx](http://yyyyy)
