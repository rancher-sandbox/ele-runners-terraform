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
| pool\_dir | Pool dir to store the VM data | `string` | `"/data/"` | no |
| qemu\_uri | Qemu url | `string` | `"qemu:///system"` | no |
| runner\_version | github runner version to use | `string` | `"2.293.0"` | no |
| servers | Number of servers to deploy | `number` | `1` | no |
| vcpu | Cpus for each server | `number` | `4` | no |

## Outputs

| Name | Description |
|------|-------------|
| ips | Pair of nodename:IP of created VMs |
<!-- END_TF_DOCS -->