-- 回避策（アンチパターンを一時的に扱わざるを得ない場合）: カンマ区切り列を行に展開する。
-- SQL Server 2016 以降の STRING_SPLIT を CROSS APPLY で各行に適用し、
-- "12,34" を 1 値 1 行（value 列）へ分解して他テーブルのように扱えるようにしている。
-- あくまで既存データへの対処であり、根本解決は交差テーブル化（soln/）である点に注意。
SELECT
  product_id,
  product_name,
  value
FROM
  Products CROSS APPLY STRING_SPLIT (account_id, ',');
