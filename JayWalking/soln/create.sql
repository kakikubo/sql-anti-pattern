-- 解決策（solution）: 製品とアカウントの多対多を交差テーブルで表現する。
-- 1 行 = 1 つの (製品, アカウント) の組。カンマ区切り文字列をやめることで、
-- 各 ID は整数 + 外部キーで検証され、追加・削除・集計・結合がすべて素直な SQL で書ける。
CREATE TABLE Contacts (
  product_id BIGINT UNSIGNED NOT NULL,
  account_id BIGINT UNSIGNED NOT NULL,
  -- 同じ組の重複を主キーで防ぐ
  PRIMARY KEY (product_id, account_id),
  FOREIGN KEY (product_id) REFERENCES Products (product_id),
  FOREIGN KEY (account_id) REFERENCES Accounts (account_id)
);

-- 1 製品に複数アカウント、1 アカウントが複数製品を担当する関係を、行の集合で表す。
INSERT INTO
  Contacts (product_id, account_id)
VALUES
  (123, 12),
  (123, 34),
  (345, 23),
  (567, 12),
  (567, 34);
