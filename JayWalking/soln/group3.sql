-- 解決策の利点③: 集計結果をそのまま ORDER BY / LIMIT に渡せる。
-- ここでは担当アカウント数が最も多い製品を 1 件だけ取り出そうとしている。
SELECT
  product_id,
  COUNT(*),
  AS accounts_per_product
FROM
  Contacts
GROUP BY
  product_id
ORDER BY
  accounts_per_product DESC
LIMIT
  1;
