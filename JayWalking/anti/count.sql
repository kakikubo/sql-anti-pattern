-- アンチパターンの弊害②: 集計が難しい。
-- 製品ごとの担当アカウント数を数えたいだけなのに COUNT が使えず、
-- 「元の長さ」から「カンマを消した長さ」を引いて消えたカンマの個数を求め、
-- +1 することで要素数を逆算するという回りくどい文字列トリックが必要になる。
SELECT
  product_id,
  LENGTH(account_id) - LENGTH(
    REPLACE
      (account_id, ',', '')
  ) + 1 AS contracts.per_product
FROM
  Products;
