# sql-anti-pattern

『SQL アンチパターン』の写経リポジトリです。書籍のサンプルスキーマを MySQL 上に構築し、章ごとに SQL を試せるようにしています。

## 必要なもの

- Docker / Docker Compose
- Node.js（SQL フォーマッタと git フック用）
- make

## セットアップ

```bash
make setup   # 依存パッケージのインストールと git フックの設定
make up      # MySQL の起動
```

`make up` は起動完了（healthcheck が通るまで）待機します。完了したらテーブルが作られていることを確認できます。

```bash
make tables
```

```
Tables_in_bugs
Accounts
BugStatus
Bugs
BugsProducts
Comments
Products
Screenshots
```

## make タスク

| タスク | 内容 |
|---|---|
| `make help` | タスク一覧を表示（引数なしで実行した場合も同じ） |
| `make setup` | 依存パッケージのインストールと git フックの設定 |
| `make up` | MySQL を起動する（起動完了まで待機） |
| `make down` | MySQL を停止する（データは残す） |
| `make clean` | MySQL を停止しデータを破棄する |
| `make reset` | データを破棄して `setup.sql` から作り直す |
| `make db` | MySQL に接続する |
| `make tables` | テーブル一覧を表示する |
| `make logs` | MySQL のログを追う |
| `make fmt` | すべての `*.sql` をフォーマットする |

## データベース

| 項目 | 値 |
|---|---|
| イメージ | `mysql:8.4` |
| ホスト / ポート | `127.0.0.1:13306` |
| データベース | `bugs` |
| ユーザ / パスワード | `root` / `root` |

ポートを 13306 にしているのは、ローカルに MySQL が入っている場合の衝突を避けるためです。GUI クライアントから繋ぐ場合もこのポートを使ってください。

スキーマは `Introduction/setup.sql` で定義しています。このファイルは `/docker-entrypoint-initdb.d/` にマウントされ、**初回起動時にのみ**実行されます。

> **`setup.sql` を編集したときは `make reset` が必要です。**
> `docker-entrypoint-initdb.d` はデータディレクトリが空のときしか実行されないため、`make down` → `make up` では変更が反映されません。

## SQL のフォーマット

[sql-formatter](https://github.com/sql-formatter-org/sql-formatter) で整形しています。設定は `.sql-formatter.json`（MySQL 方言・2スペースインデント・キーワードは大文字）が単一の定義元です。

適用のタイミングは3つあります。

- **コミット時** — lefthook の pre-commit フックが、ステージされた `*.sql` を整形して再ステージします。`make setup` を実行していれば自動で有効になります。
- **保存時（Zed）** — `.zed/settings.json` でフォーマット・オン・セーブを設定済みです。[SQL 拡張](https://github.com/zed-extensions/sql)をインストールしてください。
- **手動** — `make fmt`
