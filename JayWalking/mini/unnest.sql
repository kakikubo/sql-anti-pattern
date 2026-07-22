-- 回避策: PostgreSQL でカンマ区切り列を行に展開する。
-- string_to_array で "12,34" を配列にし、unnest で配列要素を行へ展開、
-- CROSS JOIN で各製品行に紐づけている。
-- STRING_SPLIT（SQL Server）と同じ発想の PostgreSQL 版。根本解決は交差テーブル化（soln/）。
SELECT
  *
FROM
  Products
  CROSS JOIN unnest (string_to_array (account_id, ',')) AS a;
