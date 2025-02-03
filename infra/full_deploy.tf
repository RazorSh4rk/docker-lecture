# Configure the provider
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Create a namespace for the application
resource "kubernetes_namespace" "example" {
  metadata {
    name = "fullstack"
  }
}

# Create a deployment for the Redis service
resource "kubernetes_deployment" "redis" {
  metadata {
    name      = "redis"
    namespace = kubernetes_namespace.example.metadata[0].name
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "redis"
      }
    }

    template {
      metadata {
        labels = {
          app = "redis"
        }
      }
      
      spec {
        container {
          image = "redis"
          name  = "redis"

          port {
            container_port = 6379
          }
        }
      }
    }
  }
}

# Create a service for the Redis deployment
resource "kubernetes_service" "redis" {
  metadata {
    name      = "redis"
    namespace = kubernetes_namespace.example.metadata[0].name
  }
  spec {
    selector = {
      app = "redis"
    }

    port {
      port        = 6379
      target_port = 6379
    }

    type = "ClusterIP"
  }
}

# Create a deployment for the backend service
resource "kubernetes_deployment" "backend" {
  metadata {
    name      = "backend"
    namespace = kubernetes_namespace.example.metadata[0].name
  }
  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          image = "razorsh4rk00/docker-tutorial-backend"
          name  = "backend"

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

# Create a service for the backend deployment
resource "kubernetes_service" "backend" {
  metadata {
    name      = "backend"
    namespace = kubernetes_namespace.example.metadata[0].name
  }
  spec {
    selector = {
      app = "backend"
    }

    port {
      port        = 3000
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}

# Create a deployment for the frontend service
resource "kubernetes_deployment" "frontend" {
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.example.metadata[0].name
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          image = "razorsh4rk00/docker-tutorial-frontend"
          name  = "frontend"

          port {
            container_port = 5173
          }
        }
      }
    }
  }
}

# Create a service for the frontend deployment
resource "kubernetes_service" "frontend" {
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.example.metadata[0].name
  }
  spec {
    selector = {
      app = "frontend"
    }

    port {
      port        = 5173
      target_port = 5173
    }

    type = "LoadBalancer"
  }
}
