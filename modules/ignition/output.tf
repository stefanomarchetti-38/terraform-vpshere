
output "ignition_config" {
  value = "${data.ignition_config.ign.*.rendered}"
}