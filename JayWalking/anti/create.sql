-- アンチパターン「Jaywalking（信号無視）」: 交差テーブルを作る代わりに、
-- 複数の値（担当アカウントの一覧）を 1 列にカンマ区切り文字列として押し込む。
-- 本来は多対多だが、それをスカラー 1 列で表現しようとするのが誤り。
CREATE TABLE Products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(1000),
  -- カンマ区切りのリスト。VARCHAR なので個々の値が整数である保証も、
  -- Accounts に実在する保証もない。下記 FOREIGN KEY は文字列全体を
  -- 1 つの account_id として扱うため、実質的に機能しない。
  account_id VARCHAR(100),
  FOREIGN KEY (account_id) REFERENCES Accounts (account_id)
);

-- 製品 1 行に対し、担当アカウント 12 と 34 を "12,34" という 1 つの文字列で保持する。
INSERT INTO
  Products (product_id, product_name, account_id)
VALUES
  (DEFAULT, 'Visual TurboBuilder', '12,34');
