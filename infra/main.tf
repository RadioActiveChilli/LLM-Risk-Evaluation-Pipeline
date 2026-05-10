terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# ── Network ──────────────────────────────────────────────────────────────────

resource "docker_network" "eval_net" {
  name   = "eval-net"
  driver = "bridge"
}

# ── Data volume ───────────────────────────────────────────────────────────────

resource "docker_volume" "eval_data" {
  name = "eval-data"
}

# ── eval-runner image (built from local Dockerfile) ───────────────────────────

resource "docker_image" "eval_runner" {
  name = "eval-runner:latest"
  build {
    context    = ".."
    dockerfile = "../docker/Dockerfile"
  }
  keep_locally = true
}

# ── eval-runner container ─────────────────────────────────────────────────────

resource "docker_container" "eval_runner" {
  name  = "eval-runner"
  image = docker_image.eval_runner.image_id

  env = [
    "SUBJECT_MODEL=${var.subject_model}",
    "SUBJECT_MODEL_PATH=${var.subject_model_path}",
    "JUDGE_MODEL=${var.judge_model}",
    "JUDGE_MODEL_PATH=${var.judge_model_path}",
  ]

  # Bind-mount the host data directory so results are written back to the host
  volumes {
    host_path      = "${var.project_root}/data"
    container_path = "/app/data"
  }

  # Mount model files read-only at the same absolute path so .env paths resolve
  volumes {
    host_path      = var.models_dir
    container_path = var.models_dir
    read_only      = true
  }

  networks_advanced {
    name = docker_network.eval_net.name
  }

  restart = "no"
}
