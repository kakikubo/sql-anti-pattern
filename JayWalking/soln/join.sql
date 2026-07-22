-- 解決策の利点④: 「アカウント 34 が担当する製品」を通常の等価結合で取得できる。
-- アンチパターンの anti/regexp.sql（正規表現照合）と違い、
-- インデックスを利用でき高速かつ堅牢。
SELECT
  p.*
FROM
  Products AS p
  JOIN Contacts AS c ON (p.product_id = c.product_id)
WHERE
  c.account_id = 34;
