# Huawei Cloud Terraform with GitHub Actions

🌐 **Language**: **English** | [Português](./README.pt.md)

<!-- markdownlint-disable MD033 -->
<a href="https://www.huaweicloud.com/intl/en-us" target="_blank">
  <img src="https://console-static.huaweicloud.com/static/authui/20210202115135/public/custom/images/logo-en.svg"
    alt="Huawei Cloud" width="450px" height="102px">
</a>

This repository contains [Terraform][terraform] files to deploy a minimal
[Huawei Cloud][hwc] infrastructure (one [VPC][vpc]) using
[GitHub Actions][actions].

- [Huawei Cloud Terraform with GitHub Actions](#huawei-cloud-terraform-with-github-actions)
  - [Prerequisites](#prerequisites)
  - [Configure GitHub secrets and variables](#configure-github-secrets-and-variables)
  - [Deployment flow](#deployment-flow)
  - [Destroying the infrastructure](#destroying-the-infrastructure)
  - [Further reading](#further-reading)

## Prerequisites

- [Huawei Cloud account][hwc-account];
- [Access Keys (AK/SK)][aksk] of an [IAM User with programmatic access][iam-prog]
  and permission to deploy the resources you use;
- [Huawei Cloud OBS][obs] bucket to store the state file remotely (the IAM user
  must have [read-write permissions to the bucket][bucket-policy]).

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

![GitHub repository variables](./img/github-repository-variables.png)

## Deployment flow

Whenever code is pushed to the `main` branch, GitHub Actions will:

1. Initialize Terraform (`terraform init`)
2. Check code formatting (`terraform fmt -check`)
3. Validate configuration (`terraform validate`)
4. Generate a plan (`terraform plan`)

![Terraform plan generated after code is pushed to the main branch](./img/terraform-plan.png)

After reviewing the plan, if you agree with it, you need to manually run the
workflow in order to provision the infrastructure in Huawei Cloud:

1. Go to **Actions** tab;
2. Select **Terraform Apply** action;
3. Click on **Run workflow** on the right side;
4. Under **Approve Terraform Apply?**, select **apply** and click
   **Run workflow**;
5. Infrastructure changes will be applied automatically.

![Running "Terraform Apply" worflow manually in Actions tab](./img/run-workflow.png)

![Infrastructure changes being applied automatically by GitHub Actions](./img/terraform-apply.png)

## Destroying the infrastructure

If you wish to destroy the infrastructure through GitHub Actions, manually run
the **Terraform Destroy** workflow. Select the **skip** option when running the
workflow to preview what will be done, and then if you agree with the plan,
select the **apply** option when manually running the workflow again.

![Infrastructure destroyed automatically by GitHub Actions](./img/terraform-destroy.png)

## Further reading

- Huawei Cloud Terraform Boilerplate: <https://github.com/huaweicloud-latam/terraform-boilerplate>
- Huawei Cloud Terraform provider documentation: <https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs>
- Remote state configuration: <https://github.com/huaweicloud-latam/terraform-boilerplate/blob/main/doc/remote_state.md>

[terraform]: <https://developer.hashicorp.com/terraform/docs>
[hwc]: <https://www.huaweicloud.com/intl/en-us>
[actions]: <https://docs.github.com/en/actions>
[hwc-account]: <https://support.huaweicloud.com/intl/en-us/usermanual-account/account_id_001.html>
[aksk]: <https://support.huaweicloud.com/intl/en-us/usermanual-ca/ca_05_0003.html>
[iam-prog]: <https://support.huaweicloud.com/intl/en-us/usermanual-iam5/iam_01_1150.html>
[obs]: <https://support.huaweicloud.com/intl/en-us/obs/index.html>
[bucket-policy]: <https://support.huaweicloud.com/intl/en-us/usermanual-obs/obs_03_0142.html>
[vpc]: <https://support.huaweicloud.com/intl/en-us/vpc/index.html>
