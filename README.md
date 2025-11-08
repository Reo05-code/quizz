# Quiz App

Ruby on Rails（API モード）+ React（TypeScript + Vite）+ Docker で構成されたクイズアプリケーションです。

## 📋 技術スタック

### バックエンド（API）
- **Ruby**: 3.2.2
- **Rails**: 7.0.7.2（APIモード）
- **データベース**: PostgreSQL 15
- **コードチェック**: RuboCop
- **テスト**: RSpec（任意）

### フロントエンド
- **TypeScript**: 5.0.2
- **React**: 18.2.0
- **ビルドツール**: Vite 4.5.0
- **ルーティング**: React Router
- **HTTP通信**: Axios
- **UI**: Tailwind CSS
- **コードチェック**: ESLint
- **コード整形**: Prettier

### 開発環境
- **Docker**: コンテナ環境
- **Docker Compose**: マルチコンテナ管理

## 📁 ディレクトリ構造

```
quiz/
├── backend/                 # Rails APIサーバー
│   ├── app/
│   │   ├── controllers/    # コントローラー
│   │   └── models/         # モデル
│   ├── config/             # Rails設定
│   ├── db/                 # データベース関連
│   ├── spec/               # テストファイル
│   ├── Dockerfile          # バックエンド用Dockerイメージ
│   ├── Gemfile             # Ruby依存関係
│   └── .rubocop.yml        # RuboCop設定
│
├── frontend/               # React + Viteアプリ
│   ├── src/
│   │   ├── pages/         # ページコンポーネント
│   │   ├── lib/           # ユーティリティ
│   │   ├── App.tsx        # メインアプリ
│   │   └── main.tsx       # エントリーポイント
│   ├── public/            # 静的ファイル
│   ├── Dockerfile         # フロントエンド用Dockerイメージ
│   ├── package.json       # npm依存関係
│   ├── vite.config.ts     # Vite設定
│   ├── tsconfig.json      # TypeScript設定
│   ├── tailwind.config.js # Tailwind CSS設定
│   ├── .eslintrc.cjs      # ESLint設定
│   └── .prettierrc        # Prettier設定
│
└── docker-compose.yml      # Docker Compose設定
```

## 🚀 セットアップ手順


### 1. リポジトリのクローン（またはプロジェクトの準備）

```bash
cd /home/ataik/B/quiz
```

### 2. 環境変数の設定

#### バックエンド
```bash
cd backend
cp .env.example .env
# 必要に応じて .env を編集
cd ..
```

#### フロントエンド
```bash
cd frontend
cp .env.example .env
# 必要に応じて .env を編集
cd ..
```

### 3. Dockerコンテナの起動

```bash
# すべてのサービスをビルドして起動
docker-compose up --build

# バックグラウンドで起動する場合
docker-compose up -d --build
```

### 4. データベースのセットアップ

初回起動時に、別のターミナルで以下を実行：

```bash
# データベースの作成
docker-compose exec backend rails db:create

# マイグレーションの実行
docker-compose exec backend rails db:migrate

# シードデータの投入（任意）
docker-compose exec backend rails db:seed
```

### 5. アクセス確認

- **フロントエンド**: http://localhost:5173
- **バックエンドAPI**: http://localhost:3000
- **データベース**: localhost:5432

## 🛠️ 開発コマンド

### Docker関連

```bash
# コンテナの起動
docker-compose up

# コンテナの停止
docker-compose down

# コンテナの再ビルド
docker-compose up --build

# ログの確認
docker-compose logs -f [service_name]

# コンテナ内でコマンド実行
docker-compose exec [service_name] [command]
```

### バックエンド（Rails）

```bash
# Railsコンソール
docker-compose exec backend rails console

# マイグレーション生成
docker-compose exec backend rails generate migration [MigrationName]

# RuboCopでコードチェック
docker-compose exec backend rubocop

# RuboCopで自動修正
docker-compose exec backend rubocop -A

# RSpecテスト実行（セットアップ後）
docker-compose exec backend rspec
```

### フロントエンド（React）

```bash
# npm パッケージのインストール
docker-compose exec frontend npm install [package_name]

# ESLintでコードチェック
docker-compose exec frontend npm run lint

# ESLintで自動修正
docker-compose exec frontend npm run lint:fix

# Prettierでコード整形
docker-compose exec frontend npm run format

# TypeScript型チェック
docker-compose exec frontend npm run type-check

# プロダクションビルド
docker-compose exec frontend npm run build
```

## 📝 開発ワークフロー

1. **新機能の開発**
   - バックエンド: `backend/app/controllers` や `backend/app/models` にコードを追加
   - フロントエンド: `frontend/src` 配下にコンポーネントやページを追加

2. **コード品質チェック**
   - バックエンド: RuboCop でチェック
   - フロントエンド: ESLint + Prettier でチェック

3. **テストの実行**
   - バックエンド: RSpec でテスト（セットアップが必要）
   - フロントエンド: 必要に応じてJestなどを追加

## 🔧 トラブルシューティング

### ポートが既に使用されている場合

`docker-compose.yml` の `ports` セクションを編集してポート番号を変更してください。

### データベース接続エラー

```bash
# データベースコンテナの再起動
docker-compose restart db

# データベースの再作成
docker-compose exec backend rails db:drop db:create db:migrate
```

### node_modules のエラー

```bash
# node_modules を削除して再インストール
docker-compose down
docker-compose up --build
```

## 📚 参考リンク

- [Ruby on Rails Guides](https://guides.rubyonrails.org/)
- [React Documentation](https://react.dev/)
- [Vite Documentation](https://vitejs.dev/)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Docker Documentation](https://docs.docker.com/)

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。

---

Happy Coding! 🎉
