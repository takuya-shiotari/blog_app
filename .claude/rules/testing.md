---
description: テスト規約。test/配下の編集・テスト追加時に適用。
globs: ["test/**/*.rb"]
---

# テスト規約

## フレームワーク
- Minitest 標準構成（`test/controllers`, `test/models`, `test/mailers`, `test/integration`）。RSpecへの移行や併用は明示的な指示なく行わない。
- fixtures（`test/fixtures/`）でテストデータを用意する。テストごとにDBへ直接データを投入するのではなく、既存の fixtures パターンに合わせる。

## System test
- Capybara + Selenium は Gemfile に導入済みだが `test/system/` はまだ存在しない。追加する場合は `bin/rails generate system_test` 等 Rails 標準の生成方法を使う。
- `bin/ci` では system test はデフォルトで無効化されている（`config/ci.rb` 内でコメントアウト）。system test を追加した場合は `config/ci.rb` の該当行を有効化するかどうかをユーザーに確認する。

## 実行方法
- 通常のユニット/統合テスト: `bin/rails test`
- 特定ファイルのみ: `bin/rails test test/models/xxx_test.rb`
- テスト用DBの再構築が必要な場合: `env RAILS_ENV=test bin/rails db:seed:replant`（`bin/ci`の最終ステップと同一）
