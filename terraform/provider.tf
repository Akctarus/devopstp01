HOLA

terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "4.1.0"
    }
  }
}

provider "heroku" {
  email = var.heroku_email
  api_key = var.heroku_api_key
}

resource "heroku_app" "app_production" {
  name = "devops-tp01-prod"
  region = "eu"
}

resource "heroku_addon" "db_production" {
  app = heroku_app.app_production.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_app" "app_staging" {
  name = "devops-tp01-staging"
  region = "eu"
}

resource "heroku_addon" "db_staging" {
  app = heroku_app.app_staging.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_app" "app_qanda" {
  name = "devops-tp01-qanda"
  region = "eu"
}

resource "heroku_addon" "db_qanda" {
  app = heroku_app.app_qanda.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_pipeline" "pipeline" {
  name = "devops-tp01"
}

resource "heroku_pipeline_coupling" "coupling_qanda" {
  app      = heroku_app.app_qanda.name
  pipeline = heroku_pipeline.pipeline.id
  stage    = "development"
}

resource "heroku_pipeline_coupling" "coupling_staging" {
  app      = heroku_app.app_staging.name
  pipeline = heroku_pipeline.pipeline.id
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "coupling_production" {
  app      = heroku_app.app_production.name
  pipeline = heroku_pipeline.pipeline.id
  stage    = "production"
}


