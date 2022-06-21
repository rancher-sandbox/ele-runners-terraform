# Terraform teplates for kvm github runners


## How to use

 - clone the repo
 - create your own NAME.tfvars with your variables override (see [docs](https://www.terraform.io/language/values/variables#variable-definitions-tfvars-files))
 - `terraform init`
 - `terraform plan -var-file=NAME.tfvars` to see the plan
 - `terraform apply -var-file=NAME.tfvars` to update the infra (if needed)


This plan will create a number of VMs and connect them to github in order to server as CI runners.
Should work for both x86 and aarch64 as long as the config is set properly (see `arch` input below)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| libvirt | ~>0.6 |
| template | ~>2.2 |

## Providers

| Name | Version |
|------|---------|
| libvirt | 0.6.14 |
| template | 2.2.0 |

## Resources

| Name | Type |
|------|------|
| [libvirt_cloudinit_disk.commoninit](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/cloudinit_disk) | resource |
| [libvirt_domain.github_runner](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/domain) | resource |
| [libvirt_network.runner_network](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/network) | resource |
| [libvirt_pool.runners](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/pool) | resource |
| [libvirt_volume.jeos](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume) | resource |
| [libvirt_volume.volume](https://registry.terraform.io/providers/dmacvicar/libvirt/latest/docs/resources/volume) | resource |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| github\_token | PAT token to use. This is used to auto obtain runner tokens. Use a short lived token (7 days) as its no necessary after the bootstrap | `string` | n/a | yes |
| arch | Arch to use | `string` | `"x86_64"` | no |
| github\_repo | Github repo to add the runner to | `string` | `"rancher/elemental-toolkit"` | no |
| memory | Memory for each server | `number` | `4096` | no |
| pool\_dir | Pool dir to store the VM data | `string` | `"/data/vm"` | no |
| qemu\_uri | Qemu url | `string` | `"qemu:///system"` | no |
| runner\_version | github runner version to use | `string` | `"2.293.0"` | no |
| servers | Number of servers to deploy | `number` | `1` | no |
| vcpu | Cpus for each server | `number` | `4` | no |

## Outputs

| Name | Description |
|------|-------------|
| ips | Pair of nodename:IP of created VMs |
<!-- END_TF_DOCS -->