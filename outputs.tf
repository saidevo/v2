output "url" {
  value = "http://${aws_instance.instance.public_ip}/oxer-html"
}