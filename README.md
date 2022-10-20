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

Create terraform.tfvars and adjust

```
cp terraform.tfvars.example terraform.tfvars
```

## Deploy

```
terraform init
terraform plan
terraform apply
```

## Example

```
Outputs:

f5xc_namespace = {
  "namespace" = {
    "id" = "0d28e702-b401-4f23-8851-f1ca2087ba09"
      "name" = "marcel-ns"
  }
}
f5xc_virtual_site = {
  "virtual-site" = {
    "id" = "a6bc66b0-70fd-49a2-8551-91a222ea59eb"
      "name" = "marcel-vsite"
      "site_type" = "CUSTOMER_EDGE"
  }
}
vk8s = {
  "vk8s" = {
    "id" = "4374512f-4c15-4f8b-8fd4-f16240816634"
      "name" = "marcel-vk8s"
  }
}
```

## Varia

### Start with empty folder

```
git init
git submodule add https://github.com/cklewar/f5-xc-modules modules
```
