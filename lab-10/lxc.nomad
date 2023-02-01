# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# PLEASE NOTE: If you copy this file, be sure to replace <YOUR HOSTNAME>
# Your hostname can be attained by running the "identity" command on your node.

job "example-lxc-<YOUR HOSTNAME>" {
  datacenters = ["dc1"]
  type        = "service"

  # Example constraints (Be sure to replace the values with your own)


  # constraint {
  #   attribute = "${node.unique.name}"
  #   operator  = "="
  #   value     = "nomad-training-bear"
  # }
  # 
  # constraint {
  #   attribute = "${attr.unique.hostname}"
  #   operator  = "="
  #   value     = "nomad-training-bear.node.consul"
  # }
  # 
  # constraint {
  #   attribute = "${attr.unique.platform.aws.local-ipv4}"
  #   operator  = "="
  #   value     = "10.1.1.225"
  # }

  group "example" {
    task "example" {
      driver = "lxc"

      config {
        log_level = "trace"
        verbosity = "verbose"
        template  = "/usr/share/lxc/templates/lxc-busybox"
      }

      resources {
        cpu    = 500
        memory = 256
      }
    }
  }
}
