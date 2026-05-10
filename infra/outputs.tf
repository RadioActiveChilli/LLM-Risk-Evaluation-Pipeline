output "eval_runner_container_id" {
  description = "ID of the eval-runner container"
  value       = docker_container.eval_runner.id
}

output "network_name" {
  description = "Name of the Docker network"
  value       = docker_network.eval_net.name
}
