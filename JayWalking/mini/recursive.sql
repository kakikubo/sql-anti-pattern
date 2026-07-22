-- 回避策: 再帰 CTE でカンマ区切り列を 1 要素ずつ行に展開する（連番テーブル不要）。
-- 初回(アンカー)で先頭要素を account_id、残りを remainder として切り出し、
-- 再帰側で remainder の先頭要素を繰り返し取り出していく。
-- remainder が空になった時点で（WHERE LENGTH(remainder) > 0）再帰が止まる。
-- 連番の上限を決め打ちする int-union.sql と違い、要素数に依らず全件展開できる。
-- 根本解決は交差テーブル化（soln/）。
WITH RECURSIVE
  cte AS (
    SELECT
      product_id,
      product_name,
      SUBSTRING_INDEX(account_id, ',', 1) AS account_id,
      SUBSTRING(
        account_id,
        LENGTH(SUBSTRING_INDEX(account_id, ',', 1)) + 2
      ) AS remainder
    FROM
      Products
    UNION ALL
    SELECT
      product_id,
      product_name,
      SUBSTRING_INDEX(remainder, ',', 1),
      SUBSTRING(
        remainder,
        LENGTH(SUBSTRING_INDEX(remainder, ',', 1)) + 2
      )
    FROM
      cte
    WHERE
      LENGTH(remainder) > 0
  )
SELECT
  product_id,
  product_name,
  account_id
FROM
  cte;
