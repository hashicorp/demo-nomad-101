# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# PLEASE NOTE: If you copy this file, be sure to replace <YOUR HOSTNAME>
# in the first line and in the "tags" section.
# Your hostname can be attained by running the "identity" command on your node.

# Be sure to replace the other fields such as <YOUR CHOICE> in the tags
# section

job "demo-webapp-<YOUR HOSTNAME>" {
  datacenters = ["dc1"]

  update {
    max_parallel     = 1
    min_healthy_time = "10s"
    healthy_deadline = "20s"
    auto_revert      = true
  }

  group "demo" {
    count = 4
    task "server" {

      env {
        PORT    = "${NOMAD_PORT_http}"
        NODE_IP = "${NOMAD_IP_http}"
      }

      driver = "docker"
      config {
        image = "hashicorp/demo-webapp:v2"
      }

      resources {
        network {
          mbits = 10
          port "http" {}
        }
      }

      service {
        name = "demo-webapp"
        port = "http"

        tags = [
          "<YOUR HOSTNAME>",
          "urlprefix-/<YOUR CHOICE> strip=/<YOURCHOICE>",
        ]

        check {
          type     = "http"
          path     = "/"
          interval = "2s"
          timeout  = "2s"
        }
      }
    }
  }
}
