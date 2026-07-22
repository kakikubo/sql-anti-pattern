-- アンチパターンの弊害①: 値の妥当性を検証できない。
-- account_id が VARCHAR のため、整数以外の 'banana' すら挿入できてしまう。
-- 正しく交差テーブル + 整数の外部キーにしていれば、この INSERT はエラーで弾かれる。
INSERT INTO
  Products (product_id, product_name, account_id)
VALUES
  (DEFAULT, 'Visual TurboBuilder', '12,34,banana');
