# PLEASE NOTE: If you copy this file, be sure to replace <YOUR HOSTNAME>
# in the first line and in the "tags" section.
# Your hostname can be attained by running the "identity" command on your node.

# Be sure to replace the other fields such as <YOUR CHOICE> and
# <YOUR SERVICE NAME>

job "<YOUR HOSTNAME>" {
  datacenters = ["dc1"]

  group "echo" {
    count = 1

    task "server" {
      driver = "docker"

      config {
        image = "nginx"

        port_map {
          http = 80
        }

        volumes = [
          "local:/usr/share/nginx/html",
        ]
      }

      template {
        data = <<EOF
      <pre>
	node_dc:          {{ env "node.datacenter" }}
	node_cores:       {{ env "attr.cpu.numcores" }}
        # Add as many runtime environment variables as you like
      </pre>
      EOF

        destination = "local/index.html"
      }

      resources {
        network {
          mbits = 10
          port  "http"{}
        }
      }

      service {
        name = "<YOUR SERVICE NAME>"
        port = "http"

        tags = [
          "<YOUR HOSTNAME>",
          "urlprefix-/<YOUR CHOICE> strip=/<YOUR CHOICE>",
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
