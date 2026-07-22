-- アンチパターンの弊害③: 格納できる件数が列の長さに縛られる。
-- account_id は VARCHAR(100) なので、詰め込める ID の個数は文字列長で頭打ちになる。
-- 短い ID を並べれば多く入るが、それでも桁数次第で上限に達する。
UPDATE Products
SET
  account_id = '10,14,18,22,26,30,34,38,42,46'
WHERE
  product_id = 123;

-- ID が長くなると同じ VARCHAR(100) でも格納できる件数は一気に減る。
UPDATE Products
SET
  account_id = '101418,222630,343842,467790'
WHERE
  product_id = 123;
