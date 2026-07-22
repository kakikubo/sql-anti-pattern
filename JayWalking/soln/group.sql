-- 解決策の利点①: 製品ごとの担当アカウント数を、素直な COUNT + GROUP BY で数えられる。
-- （アンチパターンの anti/count.sql の文字列トリックと比較すると一目瞭然）
SELECT
  product_id,
  COUNT(*) AS accounts_per_product
FROM
  Contacts
GROUP BY
  product_id;
