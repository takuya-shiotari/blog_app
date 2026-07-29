---
description: セキュリティ規約。config/, .kamal/ 配下、秘密情報を扱う操作時に適用。
globs: ["config/**/*", ".kamal/**/*"]
---

# セキュリティ規約

## 秘密情報
- `config/master.key`, `.kamal/secrets` の内容を読み取り・出力・ログ・コミットしない。`.claude/settings.json` の `deny` で `Read` を禁止済み。
- `config/credentials.yml.enc` は暗号化済みのため読み取り自体は無害だが、復号（`bin/rails credentials:show` / `credentials:edit`）は明示的な指示がない限り実行しない。

## セキュリティ監査
- Brakeman（`bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error`）、bundler-audit（`bin/bundler-audit`）、importmap audit（`bin/importmap audit`）は `bin/ci` の一部として必須。これらを無効化・スキップする変更は行わない。
- 新しい gem や JS 依存を追加した場合は、追加後に `bin/bundler-audit` または `bin/importmap audit` を実行して脆弱性がないことを確認する。

## デプロイ
- `bin/kamal deploy` 等の本番デプロイ操作は明示的な指示がない限り実行しない（`.claude/settings.json` で deny 済み）。
