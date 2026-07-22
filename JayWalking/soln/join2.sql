-- 解決策の利点⑤: 逆方向「製品 123 を担当するアカウント」も同じ交差テーブルから引ける。
-- 交差テーブルは両方向の問い合わせを対称に扱える。
SELECT
  a.*
FROM
  Accounts AS a
  JOIN Contacts AS c ON (a.account_id = c.account_id)
WHERE
  c.product_id = 123;
