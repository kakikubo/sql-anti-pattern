-- 書籍「SQL アンチパターン」全体で使用するバグ管理システムのベーススキーマ。
-- 各章のサンプルはこのスキーマを前提に、テーブルの追加・変更を行っていく。
-- ユーザー（開発者・報告者）を表すマスタ。バグの報告者・担当者・検証者として参照される。
CREATE TABLE Accounts (
  account_id SERIAL PRIMARY KEY,
  account_name VARCHAR(20),
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  email VARCHAR(100),
  password_hash CHAR(64),
  portrait_image BLOB,
  hourly_rate NUMERIC(9, 2)
);

-- バグの状態（NEW / IN PROGRESS / FIXED など）を列挙する参照テーブル。
CREATE TABLE BugStatus (status VARCHAR(20) PRIMARY KEY);

-- バグ本体。報告者・担当者・検証者は Accounts を、状態は BugStatus を外部キーで参照する。
CREATE TABLE Bugs (
  bug_id SERIAL PRIMARY KEY,
  date_reported DATE NOT NULL DEFAULT(CURRENT_DATE),
  summary VARCHAR(80),
  description VARCHAR(1000),
  resolution VARCHAR(1000),
  reported_by BIGINT UNSIGNED NOT NULL,
  assigned_to BIGINT UNSIGNED,
  verified_by BIGINT UNSIGNED,
  status VARCHAR(20) NOT NULL DEFAULT 'NEW',
  priority VARCHAR(20),
  hours NUMERIC(9, 2),
  FOREIGN KEY (reported_by) REFERENCES Accounts (account_id),
  FOREIGN KEY (assigned_to) REFERENCES Accounts (account_id),
  FOREIGN KEY (verified_by) REFERENCES Accounts (account_id),
  FOREIGN KEY (status) REFERENCES BugStatus (status)
);

-- バグへのコメント。1 バグに対して複数コメントがぶら下がる（1 対多）。
CREATE TABLE Comments (
  comment_id SERIAL PRIMARY KEY,
  bug_id BIGINT UNSIGNED NOT NULL,
  author BIGINT UNSIGNED NOT NULL,
  comment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  comment TEXT NOT NULL,
  FOREIGN KEY (bug_id) REFERENCES Bugs (bug_id),
  FOREIGN KEY (author) REFERENCES Accounts (account_id)
);

-- バグに添付するスクリーンショット。(bug_id, image_id) の複合主キーでバグごとに採番する。
CREATE TABLE Screenshots (
  bug_id BIGINT UNSIGNED NOT NULL,
  image_id BIGINT UNSIGNED NOT NULL,
  screenshot_image BLOB,
  caption VARCHAR(100),
  PRIMARY KEY (bug_id, image_id),
  FOREIGN KEY (bug_id) REFERENCES Bugs (bug_id)
);

-- 製品マスタ。どのバグがどの製品に紐づくかを BugsProducts で表現する。
CREATE TABLE Products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(50)
);

-- バグと製品の多対多を解決する交差テーブル（1 バグが複数製品に影響し得る）。
CREATE TABLE BugsProducts (
  bug_id BIGINT UNSIGNED NOT NULL,
  product_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (bug_id, product_id),
  FOREIGN KEY (bug_id) REFERENCES Bugs (bug_id),
  FOREIGN KEY (product_id) REFERENCES Products (product_id)
);
