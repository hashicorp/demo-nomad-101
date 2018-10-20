job "project-nomad-training-ant" {
  datacenters = ["dc1"]

  group "project" {
    count = 1
    task "server" {
      driver = "exec"

      config {
        command = "local/project"
      }

      artifact {
        source      = "https://s3-us-west-2.amazonaws.com/hashicorp-education/demo-binaries/project"
        destination = "local/project"
        mode        = "file"
      }

      resources {
        cpu    = 200
        memory = 256
        network {
          port "web" {}
        }
      }

      service {
        name = "project"
        port = "web"

        tags = [
          "urlprefix-/testing strip=/testing"
        ]

        check {
          type     = "tcp"
          interval = "2s"
          timeout  = "2s"
        }
      }
    }
  }
}
