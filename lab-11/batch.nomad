# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# PLEASE NOTE: If you copy this file, be sure to replace <YOUR HOSTNAME>
# Your hostname can be attained by running the "identity" command on your node.

job "example-<YOUR HOSTNAME>" {
  datacenters = ["dc1"]
  type = "batch"

  group "batch-jobs" {
    count = 1

# Be sure to make this constraint unique to your node
    constraint {
      attribute = "${attr.unique.hostname}"
      value     = "nomad-training-ant.node.consul"
    }
    task "payload" {
      driver = "raw_exec"
      config {
        command = "/bin/bash"
        args    = ["-c", "echo $(date) >> /tmp/payload.txt"]
      }
    }
  }
}
