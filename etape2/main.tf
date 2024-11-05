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
    host_path      = "${path.module}/config/nginx.conf"
    container_path = "/etc/nginx/conf.d/default.conf"
  }
}

resource "docker_container" "script" {
  name  = "script"
  image = docker_image.php_fpm.latest
  networks_advanced {
    name = docker_network.app_network.name
  }
  volumes {
    host_path      = "${path.module}/src"
    container_path = "/app"
  }
}

resource "docker_container" "data" {
  name  = "data"
  image = docker_image.mariadb.latest
  env = [
    "MYSQL_ROOT_PASSWORD=rootpassword",
    "MYSQL_DATABASE=testdb",
    "MYSQL_USER=user",
    "MYSQL_PASSWORD=password"
  ]
  networks_advanced {
    name = docker_network.app_network.name
  }
  ports {
    internal = 3306
    external = 3306
  }
  volumes {
    host_path      = "${path.module}/db_data"
    container_path = "/var/lib/mysql"
  }
}
