-- 回避策: 分割関数が無い環境で、連番テーブル（Numbers）を使ってカンマ区切り列を行に展開する。
-- JOIN 条件の「LENGTH - REPLACE 後の LENGTH」で要素数を求め、1〜要素数の連番 n を掛け合わせる。
-- SUBSTRING_INDEX を二重に使い、n 番目の区切りまでを取り出してから最後の要素だけを切り出すことで、
-- 各行に n 番目の account_id を取り出している。
-- ※ あらかじめ連番を並べた Numbers(n) テーブルが必要。根本解決は交差テーブル化（soln/）。
SELECT
  p.product_id,
  p.product_name,
  SUBSTRING_INDEX(SUBSTRING_INDEX(p.account_id, ',', n.n), ',', -1) AS account_id
FROM
  Products AS p
  JOIN Numbers AS n ON n.n <= LENGTH(p.account_id) - LENGTH(
    REPLACE
      (p.account_id, ',', '')
  );
