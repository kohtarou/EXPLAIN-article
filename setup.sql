-- 環境: PostgreSQL 17 (Docker)
-- 1. テーブル作成
CREATE TABLE users_expert (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255),
    category_id INT,
    score INT,
    pref_code INT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 2. データ生成 (100万行)
-- score: 1~100の一様乱数 (score=50 は約1% = 1万行)
INSERT INTO users_expert (email, category_id, score, pref_code, created_at)
SELECT 
    'user_' || i || '@example.com',
    floor(random() * 10 + 1)::int,   -- 1-10
    floor(random() * 100 + 1)::int,  -- 1-100
    floor(random() * 47 + 1)::int,   -- 1-47
    NOW() - (random() * interval '365 days')
FROM generate_series(1, 1000000) AS s(i);

-- 3. 統計情報の更新
ANALYZE users_expert;
