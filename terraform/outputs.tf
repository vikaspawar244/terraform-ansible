output "url-elasticsearch" {
  value = "http://${aws_instance.elasticsearch-cluster.0.public_ip}:8080"
}


