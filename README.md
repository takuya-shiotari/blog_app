# blog_app

Rails 8 の omakase 標準構成で構築するブログアプリケーション。

## Ruby バージョン

Ruby 4.0.6（`.ruby-version` 参照）

## セットアップ

```bash
bin/setup --skip-server
```

`bundle install`、DB準備（`db:prepare`）、git pre-commit フックの有効化（`core.hooksPath`）、ログ/tmpのクリアを行う冪等スクリプト。`--skip-server` を外すと開発サーバー（`bin/dev`）まで起動する。

## システム依存関係

- SQLite3
- Node.js は不要（フロントエンドは Importmap、バンドラーなし）

## データベース

SQLite3。`storage/` 配下に primary / cache（Solid Cache）/ queue（Solid Queue）/ cable（Solid Cable）の4DBを持つ（`config/database.yml`）。

```bash
bin/rails db:prepare   # 作成 + マイグレーション
bin/rails db:seed      # シード投入
```

## テストの実行

Minitest（`test/`）。

```bash
bin/rails test              # ユニット/統合テスト
bin/rails test test/models/xxx_test.rb   # 特定ファイルのみ
```

## Lint / セキュリティ監査

```bash
bin/rubocop                              # RuboCop（omakase スタイル）
bin/brakeman --no-pager                  # 静的セキュリティ解析
bin/bundler-audit                        # gem 脆弱性監査
bin/importmap audit                      # JS 依存の脆弱性監査
```

## Verify（自己検証コマンド）

```bash
scripts/verify.sh   # 高速ループ: bin/rubocop && bin/rails test
bin/ci               # フルゲート: Setup → Lint → Security×3 → Test → Seed replant
```

`git commit` 時は `.githooks/pre-commit`（`bin/setup` が `core.hooksPath` を設定）により `scripts/verify.sh` の成功が強制される。

## サービス

- ジョブキュー: Solid Queue（`config/recurring.yml` に定期ジョブ定義）
- キャッシュ: Solid Cache
- WebSocket: Solid Cable

いずれも追加のミドルウェア（Redis等）は不要で、SQLite上で動作する。

## デプロイ

Kamal（`config/deploy.yml`, `.kamal/`）。

```bash
bin/kamal deploy
```

## Claude Code ハーネス

このリポジトリは Claude Code での自律的な開発運用向けに設定されている。詳細は [`CLAUDE.md`](./CLAUDE.md) および `.claude/rules/` を参照。
