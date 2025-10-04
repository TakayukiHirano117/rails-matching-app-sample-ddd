

# 概要



・これは誰が使うシステムなのか？
  恋人が欲しい男女

## 起動コマンド
docker compose -f docker-compose.dev.yml up

## テストコマンド
docker compose -e RAILS_ENV=test exec web bundle exec rspec

## Rubocop
docker compose -e RAILS_ENV=development exec web bundle exec rubocop -a

