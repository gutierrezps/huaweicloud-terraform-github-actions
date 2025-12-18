# Huawei Cloud Terraform with GitHub Actions

This repository contains Terraform files to deploy a minimal Huawei Cloud
infrastructure (one VPC) using GitHub Actions.

## Prerequisites

- Huawei Cloud Account
- AK/SK of an IAM User with programmatic access and permission to deploy the
  resources you use
- Huawei Cloud OBS bucket to store the remote state file (the IAM user must
  have read-write permission to the bucket)

## Configure GitHub secrets and variables

In your GitHub repository:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. Add the following repository variables:

    | Variable Name            | Description                                    |
    | ------------------------ | ---------------------------------------------- |
    | `HWC_ACCESS_KEY`         | Huawei Cloud Access Key (AK)                   |
    | `HWC_OBS_BUCKET_NAME`    | OBS bucket name to store the remote state file |

3. Add the following repository secret:

    | Secret Name              | Description                         |
    | ------------------------ | ----------------------------------- |
    | `HWC_SECRET_KEY`         | Huawei Cloud Secret Access Key (SK) |

## Deployment flow

Whenever code is pushed to the `main` branch, GitHub Actions will:

1. Initialize Terraform
2. Check code formatting
3. Validate configuration
4. Generate a plan

![Terraform plan generated after code is pushed to the main branch](./img/terraform-plan.png)

After reviewing the plan, if you agree with it, you need to manually run the
workflow in order to provision the infrastructure in Huawei Cloud:

1. Go to **Actions** tab;
2. Select **Terraform Huawei Cloud** action;
3. Click on **Run workflow** on the right side;
4. Under **Approve Terraform Apply?**, select **apply** and click **Run workflow**;
5. Infrastructure changes will be applied automatically.

![Running Worflow manually in Actions tab](./img/run-workflow.png)

![Infrastructure changes being applied automatically by GitHub Actions](./img/terraform-apply.png)

## Destroy infrastructure

If you wish to destroy the infrastructure through GitHub Actions, manually run
the **Terraform Destroy (Huawei Cloud)** workflow. Select the **skip** option
when running the workflow to preview what will be done, and then if you agree
with the plan, select the **apply** option when running the workflow again.
