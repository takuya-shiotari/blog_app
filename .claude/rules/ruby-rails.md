---
description: Ruby/Rails コーディング規約。app/配下のソース編集時に適用。
globs: ["app/**/*.rb", "config/**/*.rb", "lib/**/*.rb", "db/**/*.rb"]
---

# Ruby/Rails コーディング規約

## スタイル
- `rubocop-rails-omakase` に準拠する。個別の except/disable は `.rubocop.yml` に理由を添えて追記する場合のみ許可。
- 変更後は必ず `bin/rubocop` を実行し、offense ゼロを確認する。

## 配置規約
- 横断的関心事は `app/controllers/concerns/` または `app/models/concerns/` に置く。
- ジョブは `app/jobs/`、メーラーは `app/mailers/` に置く（既存の Rails 標準配置から逸脱しない）。
- フロントエンドは Importmap 前提（`app/javascript/controllers/`）。バンドラー導入（webpacker, esbuild等）は明示的な指示なく追加しない。

## DB / マイグレーション
- 本アプリは SQLite かつ primary/cache/queue/cable の4DB構成（`config/database.yml`）。マイグレーションを追加する際は対象DBに応じた `db/*_migrate` ディレクトリを誤らないこと。
- スキーマ変更は必ずマイグレーションファイル経由で行い、`db/schema.rb` を手動編集しない。
