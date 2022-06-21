<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| <a name="provider_libvirt"></a> [libvirt](#provider\_libvirt) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

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
| <a name="input_arch"></a> [arch](#input\_arch) | Arch to use | `string` | `"x86_64"` | no |
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | Github repo to add the runner to | `string` | `"rancher/elemental-toolkit"` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | PAT token to use. This is used to auto obtain runner tokens. Use a short lived token (7 days) as its no necessary after the bootstrap | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory for each server | `number` | `4096` | no |
| <a name="input_pool_dir"></a> [pool\_dir](#input\_pool\_dir) | Pool dir to store the VM data | `string` | `"/data/"` | no |
| <a name="input_qemu_uri"></a> [qemu\_uri](#input\_qemu\_uri) | Qemu url | `string` | `"qemu:///system"` | no |
| <a name="input_runner_version"></a> [runner\_version](#input\_runner\_version) | github runner version to use | `string` | `"2.293.0"` | no |
| <a name="input_servers"></a> [servers](#input\_servers) | Number of servers to deploy | `number` | `1` | no |
| <a name="input_vcpu"></a> [vcpu](#input\_vcpu) | Cpus for each server | `number` | `4` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ips"></a> [ips](#output\_ips) | n/a |
<!-- END_TF_DOCS -->