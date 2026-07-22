-- 解決策の利点②: 集計軸を変えるのも GROUP BY のキーを差し替えるだけ。
-- ここでは account_id でまとめ、アカウントごとに担当製品が何件あるかを数えている。
SELECT
  product_id,
  COUNT(*) AS products_per_account
FROM
  Contacts
GROUP BY
  account_id;
