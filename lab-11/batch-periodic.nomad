job "example-<YOUR HOSTNAME>" {
  datacenters = ["dc1"]
  type = "batch"
  periodic {
    cron  = "* * * * *"
  }
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
