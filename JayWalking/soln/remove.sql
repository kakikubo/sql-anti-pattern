-- 解決策の利点⑥: 要素の追加・削除が 1 本の INSERT / DELETE で完結する。
-- アンチパターン（anti/remove.py）のようにアプリ側で文字列を分解・再結合する必要はない。
-- 追加: (製品 456, アカウント 34) の組を 1 行足すだけ。
INSERT INTO
  Contacts (product_id, account_id)
VALUES
  (456, 34);

-- 削除: 対象の組を主キーで特定して 1 行消すだけ。
DELETE FROM Contacts
WHERE
  product_id = 456
  AND account_id = 34;
