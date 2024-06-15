# Deploying an Azure Architecture using Terraform

We are creating public access so users can securely connect to virtual machines. We are Using Terraform to deploy the Azure resources in our environment.

![architecture](/azure_terraform_arch.png)

## Setting up

A few steps are needed to run this project on your machine or deploy the same resources on Azure.

### 1. Getting your secrets using Azure CLI

For this setup, it is necessary to have Azure CLI installed. Follow this documentation to install it on your environment: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

On your terminal, run the following command to authenticate on Azure:
```bash
  az login
```
After login, the CLI will prompt you to select what tenant you want to use, ensure you select the right tenant, and confirm using this command:
```bash
  az account show
```
the command will output a JSON, and you can see the subscription_id and tenant_id keys, in the second line: `homeTenantID:<your-tenant-id>`and third line: `id: <your-subscription-id>`  

Now, need the `client_id` and `client_secret`. Just create an RBAC to get these secrets, using the following commands:

```bash
export MSYS_NO_PATHCONV=1
```
Change the `service_principal_name` to what you want and your `subscription_id`.
```bash
az ad sp create-for-rbac --name <service_principal_name> --role Contributor --scopes /subscriptions/<subscription_id>
```
The command will output `appId` as your `client_id` and the `passoword` as your `client_secret`

For secure platforms, if you want to put these secrets in a public repository, DON`T put them in your providers.tf, once you are using it to test, put it in a private repository. Put your secrets on a Vault solution or in your environment variable.

