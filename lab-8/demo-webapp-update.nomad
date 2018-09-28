# PLEASE NOTE: If you copy this file, be sure to replace <YOUR HOSTNAME>
# in the first line and in the "tags" section.
# Your hostname can be attained by running the "identity" command on your node.

job "demo-webapp-<YOUR HOSTNAME>" {
  datacenters = ["dc1"]

  update {
    max_parallel     = 1
    min_healthy_time = "10s"
    healthy_deadline = "20s"
    auto_revert      = true
  }

  group "echo" {
    count = 4
    task "server" {
      driver = "docker"

      config {
        image = "hashicorp/demo-webapp:v2"
	  port_map = {
	    http = 80
	  }
      }

      resources {
        network {
          mbits = 10
          port "http" {}
        }
      }

      service {
        name = ""
        port = "http"

        tags = [
          "<YOUR HOSTNAME>-demo-webapp",
          "urlprefix-/",
        ]

        check {
          type     = "http"
          path     = "/index.html"
          interval = "2s"
          timeout  = "2s"
        }
      }
    }
  }
}
