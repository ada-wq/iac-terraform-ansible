terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"  # Assurez-vous que la version est spécifiée
    }
  }
}

provider "docker" {}

# Réseau Docker
resource "docker_network" "app_network" {
  name = "app_network"
}

# Conteneur HTTP avec NGINX
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "http" {
  name  = "http"
  image = docker_image.nginx.latest
  ports {
    internal = 80
    external = 8080
  }
  networks_advanced {
    name = docker_network.app_network.name
  }
  volumes {
    host_path      = "C:/Users/Mahamat Adam/OneDrive/Documents/Cours 2023-2024/S2/devops/iac/IaC/docker-tp2/etape1/config/nginx.conf"
    container_path = "/etc/nginx/conf.d/default.conf"
  }
}

# Conteneur SCRIPT avec PHP-FPM
resource "docker_image" "php_fpm" {
  name = "php:fpm"
}

resource "docker_container" "script" {
  name  = "script"
  image = docker_image.php_fpm.latest
  networks_advanced {
    name = docker_network.app_network.name
  }
  volumes {
    host_path      = "C:/Users/Mahamat Adam/OneDrive/Documents/Cours 2023-2024/S2/devops/iac/IaC/docker-tp2/etape1/src"
    container_path = "/app"
  }
}
