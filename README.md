# f5xc-vk8s-lab

Build namespace, virtual site and virtual kubernetes cluster and download kubeconfig using f5-xc-modules for Terraform.

## Requirements

Provide F5 XC API credentials via environment variables:

```
export VOLT_API_P12_FILE=/cert/<tenant>.console.ves.volterra.io.api-creds.p12
export VOLTERRA_TOKEN=<token>
export VOLT_API_URL=https://playground.console.volterra.io/api
#export VOLT_API_CA_CERT=<only required for non production use>
```


## Start with empty folder

```
git init
git submodule add https://github.com/cklewar/f5-xc-modules modules
```
