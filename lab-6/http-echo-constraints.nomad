# PLEASE NOTE: If you copy this file, be sure to replace <YOUR HOSTNAME>
# in the first line and in the "tags" section.
# Your hostname can be attained by running the "identity" command on your node.

job "http-echo-<YOUR HOSTNAME>" {
  datacenters = ["dc1"]

  constraint {
	  attribute = "${attr.kernel.name}"
	  value     = "linux"
  }

  group "echo" {
    count = 5 
    task "server" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo:latest"
        args  = [
          "-listen", ":${NOMAD_PORT_http}",
          "-text", "Welcome to the http-echo service. You are on ${NOMAD_IP_http}",
        ]
      }

      resources {
				memory = 300
        network {
          mbits = 10
          port "http" {}
        }
      }

      service {
        name = "http-echo"
        port = "http"

        tags = [
          "<YOUR HOSTNAME>",
          "urlprefix-/http-echo",
        ]

        check {
          type     = "http"
          path     = "/health"
          interval = "2s"
          timeout  = "2s"
        }
      }
    }
  }
}
