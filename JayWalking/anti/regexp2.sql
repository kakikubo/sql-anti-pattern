-- アンチパターンの弊害⑤: テーブル結合が正規表現頼みになる。
-- Products.account_id（カンマ区切り文字列）と Accounts.account_id を突き合わせるため、
-- 結合条件で単語境界の正規表現を使わざるを得ない。
-- 通常の等価結合と違いインデックスが使えず、非常に遅い。
SELECT
  *
FROM
  Products AS p
  JOIN Accounts AS a ON p.account_id REGEXP '\\b' || a.account_id || '\\b'
WHERE
  p.product_id ~ 123;
