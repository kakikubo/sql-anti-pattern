-- 目的（objective）: 本来やりたいのは「製品に担当アカウントを紐づける」こと。
-- ここでは account_id を整数 1 列 + 外部キーで表現しており、型の妥当性や参照整合性は守れる。
-- ただしこのモデルでは 1 製品に 1 アカウントしか持てない。
-- 「複数アカウントを担当させたい」という要求に応えようとして、
-- カンマ区切り文字列に走ってしまう（＝アンチパターン）のがこの章の出発点。
-- 正しい解決は soln/ の交差テーブル。
CREATE TABLE Products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(1000),
  account_id BIGINT UNSIGNED,
  FOREIGN KEY (account_id) REFERENCES Accounts (account_id)
);

INSERT INTO
  Products (product_id, product_name, account_id)
VALUES
  (DEFAULT, 'Visual TurboBuilder', 12);
