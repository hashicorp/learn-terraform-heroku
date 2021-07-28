provider "heroku" {}

resource "heroku_app" "example" {
  name   = "learn-terraform-heroku"
  region = "us"
}

resource "heroku_addon" "postgres" {
  app  = heroku_app.example.id
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_build" "example" {
  app = heroku_app.example.id

  source {
    path = "./app"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Launch the app's web process by scaling-up
resource "heroku_formation" "example" {
  app        = heroku_app.example.id
  type       = "web"
  quantity   = 2
  size       = "Standard-1x"
  depends_on = [heroku_build.example]
}

resource "heroku_addon" "logging" {
  app  = heroku_app.example.id
  plan = "papertrail:choklad"
}
