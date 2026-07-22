-- 回避策: 連番テーブルを持てない場合に、インラインの UNION で連番(1〜4…)を生成して行展開する。
-- 仕組みは int-table.sql と同じ（SUBSTRING_INDEX 二重適用で n 番目の要素を取り出す）だが、
-- 別テーブルを用意せずサブクエリ内の SELECT ... UNION で連番を作っている点が違う。
-- 生成した連番の上限（ここでは 4）を超える件数のリストは取りこぼすため、要素数に応じて拡張が必要。
-- 根本解決は交差テーブル化（soln/）。
SELECT
  p.product_id,
  p.product_name,
  SUBSTRING_INDEX(SUBSTRING_INDEX(p.account_id, ',', n.n), ',', -1) AS account_id
FROM
  Products AS p
  JOIN (
    SELECT
      1 AS n
    UNION
    SELECT
      2
    UNION
    SELECT
      3
    UNION
    SELECT
      4 -- 以下同様
  ) AS n ON n.n <= LENGTH(p.account_id) - LENGTH(
    REPLACE
      (p.account_id, ',', '')
  );
