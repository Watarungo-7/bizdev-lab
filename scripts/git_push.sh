#!/bin/bash
# Bizdev-Lab: Git自動コミット・Pushスクリプト
# Usage: ./scripts/git_push.sh "コミットメッセージ"

set -e

# デフォルトメッセージ
MESSAGE="${1:-"update: docs updated"}"

# カレントディレクトリがリポジトリルートか確認
if [ ! -d ".git" ]; then
    echo "❌ Error: .git ディレクトリが見つかりません。リポジトリルートで実行してください。"
    exit 1
fi

# 変更をステージング
git add docs/ agents/ CLAUDE.md input.md

# 変更があるか確認
if git diff --cached --quiet; then
    echo "ℹ️  コミットする変更がありません。"
    exit 0
fi

# コミット
git commit -m "$MESSAGE"

# Push
git push origin main

echo "✅ コミット・Push完了: $MESSAGE"
