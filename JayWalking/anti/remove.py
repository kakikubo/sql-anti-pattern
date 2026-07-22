"""アンチパターンの弊害⑦: 要素の削除を SQL 単体で行えない。

カンマ区切りリストから特定の account_id を 1 件消すだけなのに、
「SELECT で現在値を取得 → アプリ側で split して該当要素を除去 → join し直して UPDATE」
というアプリケーションとの往復が必要になる。交差テーブルなら 1 本の DELETE で済む。
"""

import mysql.connector

cnx = mysql.connector.connect(user='scott', database='test')
cursor = cnx.cursor()

product_id_to_search = 2
value_to_remove = '34'

# 対象製品の現在のカンマ区切りリストを取り出す
query = "SELECT product_id, account_id FROM Products WHERE product_id = %s"
cursor.execute(query, (product_id_to_search,))
for (row) in cursor:
    (product_id, account_ids) = row
    # 文字列をアプリ側で分解し、目的の値を取り除いて組み立て直す
    account_id_list = account_ids.split(",")
    account_id_list.remove(value_to_remove)
    account_ids = ",".join(account_id_list)
    # 作り直した文字列で列を丸ごと上書きする
    query = "UPDATE Products SET account_id = %s WHERE product_id = %s"
    cursor.execute(query, (account_ids, product_id,))

cnx.commit()
