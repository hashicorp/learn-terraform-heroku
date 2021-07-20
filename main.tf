terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.6.0"
    }
  }

  required_version = ">= 0.14"
}

provider "heroku" {}

resource "heroku_app" "this" {
  name   = "learn-terraform-heroku"
  region = "us"
}

resource "heroku_addon" "postgres" {
  app  = heroku_app.this.id
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_build" "this" {
  app = heroku_app.this.id

  source {
    path = "./app"
  }
}

# Launch the app's web process by scaling-up
resource "heroku_formation" "this" {
  app        = heroku_app.this.id
  type       = "web"
  quantity   = 1
  size       = "Standard-1x"
  depends_on = [heroku_build.this]
}