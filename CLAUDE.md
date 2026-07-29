# blog_app

## 目的
Rails 8 の omakase 標準構成で構築するブログアプリケーション。現時点ではフレームワークの scaffold のみで、アプリ固有のモデル/コントローラはまだ実装されていない。

## アーキテクチャ概要
- `app/` — 標準 MVC（`controllers/`, `models/`, `views/`, `helpers/`, `jobs/`, `mailers/`）。`app/controllers/concerns`, `app/models/concerns` を横断的関心事に使う。
- `app/javascript/` — Importmap（バンドラーなし）。
- `config/` — `database.yml` は SQLite（primary / cache / queue / cable の4DB構成）。`recurring.yml` は Solid Queue の定期ジョブ設定。
- `db/` — `cable_schema.rb` / `cache_schema.rb` / `queue_schema.rb` はそれぞれ Solid Cable / Solid Cache / Solid Queue 用スキーマ。
- `.kamal/` — Kamal によるデプロイ設定（`secrets` は読み取り禁止）。

## 技術スタック
- 言語: Ruby 4.0.6
- フレームワーク: Rails 8（rubocop-rails-omakase 準拠）
- DB: SQLite3（storage/ 配下、Solid Queue/Cache/Cable 込み）
- テスト: Minitest（Capybara + Selenium は導入済みだが system test 未整備）
- Lint: RuboCop（omakase スタイル、`.rubocop.yml`）
- セキュリティ監査: Brakeman / bundler-audit / importmap audit
- デプロイ: Kamal

## 必須ルール

### やること
- コード変更後は必ず `scripts/verify.sh` を実行し、成功を確認する
- PR/マージ前には `bin/ci`（フルゲート）を通す
- 初回セットアップやDB未初期化時は `bin/setup --skip-server` を実行する
- 既存のコーディング規約（`.claude/rules/`）に従う
- モデル・コントローラ等アプリ固有コードが増えたら `.claude/rules/` を実態に合わせて更新する

### やらないこと（最重要）
- テストなしで実装を完了したと報告しない
- `bin/rails db:reset` / `db:drop` など破壊的な DB 操作を明示的指示なく実行しない
- `config/master.key`, `config/credentials.yml.enc`, `.kamal/secrets` の内容を読み取り・出力・コミットしない
- `bin/kamal deploy` など本番デプロイ操作を明示的指示なく実行しない
- `--force` `--no-verify` `-rf` フラグの使用（明示的な指示がない限り）
- 未使用の抽象化・将来の要件に備えた設計の追加

## Verify（自己検証ループ）

高速ループ（アプリコード変更時）:
```bash
scripts/verify.sh   # bin/rubocop && bin/rails test
```

マージ前フルゲート（Setup → Lint → Security×3 → Test → Seed replant）:
```bash
bin/ci
```

いずれも終了コード 0 が成功、非0が失敗。

`git commit` は `.githooks/pre-commit`（`core.hooksPath` で有効化、`bin/setup` が自動設定）により `scripts/verify.sh` の成功が強制される。フックを迂回する `git commit --no-verify` は明示的な指示がない限り使用しない。

## コンテキスト管理
- ルール詳細: `.claude/rules/`
- 個人設定: `.claude/settings.local.json`（.gitignore対象、未作成の場合は必要に応じて作成）
