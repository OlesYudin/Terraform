# Init build Application
resource "null_resource" "init_build_container" {
  provisioner "local-exec" {
    command     = "sh docker.sh"
    working_dir = var.working_dir
    # Environment variables for script
    environment = {
      region      = var.region
      registry_id = data.aws_ecr_repository.ecr_repository.registry_id
      app_name    = var.app_name
      image_tag   = var.image_tag
    }
  }
}
