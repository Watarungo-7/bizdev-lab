# 🔬 Bizdev-Lab

AIエージェントチーム（最大9体）による事業仮説検証システム。  
事業概要を入力するだけで、自動的にGo/No-Go判断まで実施します。

## 🏗️ アーキテクチャ

```
Phase 1: 仮説検証（6エージェント）
  ①仮説設計 → ②市場調査 / ③顧客検証 / ④財務モデル / ⑤リスク分析 → ⑥Go/No-Go判定

Phase 2: 実行計画（3エージェント、Go判定+承認後）
  ⑦事業責任者 → ⑧マーケ責任者 / ⑨営業責任者
```

## 🚀 セットアップ

### 1. リポジトリの作成

```bash
# GitHubで新規リポジトリ "bizdev-lab" を作成後:
git clone https://github.com/[YOUR_USERNAME]/bizdev-lab.git
cd bizdev-lab
```

### 2. プロジェクトファイルの配置

このリポジトリの全ファイルをクローンしたディレクトリにコピーします。

```bash
git add .
git commit -m "init: Bizdev-Lab セットアップ"
git push origin main
```

### 3. Claude Codeの準備

Claude Codeがインストール済みであることを確認：

```bash
claude --version
```

未インストールの場合：
```bash
npm install -g @anthropic-ai/claude-code
```

Web検索ツールが利用可能であることを確認。

## 📝 使い方

### Step 1: 事業概要を記入

`input.md` をエディタで開き、事業概要を記入します。

```bash
# CursorやVSCodeで開く
cursor input.md
# または
code input.md
```

### Step 2: Claude Codeを起動

```bash
cd bizdev-lab
claude
```

### Step 3: Phase 1 実行（仮説検証）

`docs/templates/master_prompt.md` の「Phase 1 起動プロンプト」をコピーして、Claude Codeに貼り付けます。

確認が入ったら `Yes` で進めます。

完了すると `docs/` 配下に以下が生成されます：
- `01_hypothesis.md` - 仮説設計書
- `02_market_research.md` - 市場・競合調査
- `03_customer_validation.md` - 顧客検証
- `04_financial_model.md` - 財務モデル（+ .csv）
- `05_risk_analysis.md` - リスク分析
- `06_go_nogo_verdict.md` - **Go/No-Go判定**

### Step 4: 判定結果の確認

`docs/06_go_nogo_verdict.md` を確認し、判定結果を確認します。

- 🟢 **Go** → Phase 2 に進む
- 🟡 **Conditional Go** → 条件を確認して判断
- 🔴 **No-Go** → 撤退 or ピボット検討

### Step 5: Phase 2 実行（Go判定の場合）

`docs/templates/master_prompt.md` の「Phase 2 起動プロンプト」をコピーして、Claude Codeに貼り付けます。

完了すると追加で以下が生成されます：
- `07_business_roadmap.md` - 事業ロードマップ
- `08_marketing_plan.md` - マーケティング計画
- `09_sales_plan.md` - 営業・セールス計画

### Step 6: Gitにコミット

```bash
./scripts/git_push.sh "feat: [事業名] 仮説検証完了"
```

## 📂 ディレクトリ構成

```
bizdev-lab/
├── CLAUDE.md                          # プロジェクト指示書
├── README.md                          # このファイル
├── input.md                           # 事業概要入力シート
├── agents/                            # エージェント個別プロンプト
│   ├── 01_hypothesis_architect.md
│   ├── 02_market_intelligence.md
│   ├── 03_customer_validator.md
│   ├── 04_financial_modeler.md
│   ├── 05_risk_analyst.md
│   ├── 06_integration_judge.md
│   ├── 07_business_lead.md
│   ├── 08_marketing_lead.md
│   └── 09_sales_lead.md
├── docs/                              # エージェント出力先
│   └── templates/
│       └── master_prompt.md           # 起動用プロンプト
└── scripts/
    └── git_push.sh                    # Git自動コミットスクリプト
```

## ⚙️ カスタマイズ

### エージェントの追加・変更

`agents/` 配下のMarkdownファイルを編集すれば、各エージェントの振る舞いを変更できます。新しいエージェントを追加する場合は、同じフォーマットでファイルを作成し、マスタープロンプトに追加してください。

### スコアリング基準の変更

`agents/06_integration_judge.md` 内のスコアリングテーブルを編集すれば、Go/No-Go判定の基準をカスタマイズできます。

### 出力フォーマットの変更

各エージェントファイル内の「出力フォーマット」セクションを編集すれば、レポートの構成を変更できます。

## 💡 Tips

- **input.md は詳しく書くほど精度が上がる**。最低でも「事業概要」「解決したい課題」「ターゲット顧客」は記入してください
- **Phase 1の途中でYes/Noを聞かれたら基本Yes**で進めてOK
- **結果に納得いかない場合**、追加プロンプトで「②の市場調査をもっと深掘りして」等の指示が可能
- **複数事業を検証する場合**、`input.md` を書き換えて再実行するだけでOK。過去の結果はGitに残ります

## 📋 前提条件

- Claude Code インストール済み（`npm install -g @anthropic-ai/claude-code`）
- Git セットアップ済み
- Web検索ツール利用可能
- 実行体制: ユーザー1人 + AI（スモールスタート前提）
