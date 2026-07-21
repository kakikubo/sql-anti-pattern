.DEFAULT_GOAL := help

COMPOSE := docker compose
MYSQL_USER := root
MYSQL_PASSWORD := root
MYSQL_DATABASE := bugs

.PHONY: help
help: ## このヘルプを表示する
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## 依存パッケージをインストールし git フックを設定する
	npm install

.PHONY: up
up: ## MySQL を起動する（起動完了まで待機）
	$(COMPOSE) up -d --wait

.PHONY: down
down: ## MySQL を停止する（データは残す）
	$(COMPOSE) down

.PHONY: clean
clean: ## MySQL を停止しデータを破棄する
	$(COMPOSE) down -v

.PHONY: reset
reset: ## データを破棄して setup.sql から作り直す
	$(MAKE) clean
	$(MAKE) up

.PHONY: db
db: ## MySQL に接続する
	$(COMPOSE) exec mysql mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DATABASE)

.PHONY: tables
tables: ## テーブル一覧を表示する
	@$(COMPOSE) exec -T mysql mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DATABASE) -e 'SHOW TABLES;'

.PHONY: logs
logs: ## MySQL のログを追う
	$(COMPOSE) logs -f mysql

.PHONY: fmt
fmt: ## すべての *.sql をフォーマットする
	find . -name '*.sql' -not -path './node_modules/*' -exec node_modules/.bin/sql-formatter --fix {} \;
