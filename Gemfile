source "https://rubygems.org"

gem "rails", "~> 8.0.3"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Infra / background
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Performance
gem "bootsnap", require: false

# Deploy
gem "kamal", require: false
gem "thruster", require: false

# gem "jbuilder"
# gem "image_processing", "~> 1.2"
# gem "rack-cors"

group :development, :test do
  # Debugging
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "pry", "~> 0.14.2"
  gem "pry-byebug"

  # Segurança e estilo
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false

  # Configuração e utilidades
  gem "dotenv-rails"
  gem "awesome_print"

  # Auth
  gem "jwt"
  gem "bcrypt", "~> 3.1.7"
  gem "pundit"

  # Serializers
  gem "active_model_serializers", "~> 0.10.12"

  # Testes principais
  gem "rspec-rails", "~> 6.0.3"
  gem "rswag-specs", "~> 2.9"
  gem "rswag-api"

  # Factories e dados falsos
  gem "factory_bot_rails"
  gem "faker"
end

group :test do
  # Matchers para validações e associações
  gem "shoulda-matchers", "~> 5.3"

  # Banco limpo entre testes
  gem "database_cleaner-active_record"

  # Cobertura
  gem "simplecov", require: false

  # Testes de integração com APIs externas
  gem "vcr"
  gem "webmock"
end
