CREATE TABLE bells (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  school_id INTEGER UNSIGNED NULL,
  start_time TIME NULL,
  end_time TIME NULL,
  PRIMARY KEY(id)
);

CREATE TABLE classes (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INTEGER UNSIGNED NULL,
  name VARCHAR(255) NULL,
  school_id INTEGER UNSIGNED NULL,
  yearbook INTEGER UNSIGNED NULL,
  PRIMARY KEY(id)
);

CREATE TABLE descriptions (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  description VARCHAR(255) NULL,
  subject_id TINYINT UNSIGNED NULL,
  PRIMARY KEY(id)
);

CREATE TABLE subjects (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  school_id INTEGER UNSIGNED NULL,
  class_id INTEGER UNSIGNED NULL,
  name VARCHAR(255) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE marks (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INTEGER UNSIGNED NULL,
  class_id INTEGER UNSIGNED NULL,
  subject_id TINYINT UNSIGNED NULL,
  mark TINYINT UNSIGNED NULL,
  description_id INTEGER UNSIGNED NULL,
  PRIMARY KEY(id)
);

CREATE TABLE notes (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INTEGER UNSIGNED NULL,
  class_id INTEGER UNSIGNED NULL,
  description TEXT NULL,
  teacher_id INTEGER UNSIGNED NULL,
  PRIMARY KEY(id)
);

CREATE TABLE presences (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INTEGER UNSIGNED NULL,
  class_id INTEGER UNSIGNED NULL,
  data_2 INTEGER UNSIGNED NULL,
  lesson_id INTEGER UNSIGNED NULL,
  justification BOOL NULL,
  escape_2 BOOL NULL,
  exemption BOOL NULL,
  teacher_exemption BOOL NULL,
  PRIMARY KEY(id)
);

CREATE TABLE schools (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NULL,
  adress VARCHAR(255) NOT NULL,
  user_id INTEGER UNSIGNED NULL,
  PRIMARY KEY(id)
);

CREATE TABLE teachers (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  subject_id INTEGER UNSIGNED NULL,
  first_name VARCHAR(255) NULL,
  last_name VARCHAR(255) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE time_tables (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  class_id INTEGER UNSIGNED NULL,
  lesson_1 INTEGER UNSIGNED NULL,
  lesson_2 INTEGER UNSIGNED NULL,
  lesson_3 INTEGER UNSIGNED NULL,
  lesson_4 INTEGER UNSIGNED NULL,
  lesson_5 INTEGER UNSIGNED NULL,
  lesson_6 INTEGER UNSIGNED NULL,
  lesson_7 INTEGER UNSIGNED NULL,
  lesson_8 INTEGER UNSIGNED NULL,
  lesson_9 INTEGER UNSIGNED NULL,
  lesson_10 INTEGER UNSIGNED NULL,
  lesson_11 INTEGER UNSIGNED NULL,
  week_day INTEGER UNSIGNED NULL,
  PRIMARY KEY(id)
);

CREATE TABLE users (
    id integer UNSIGNED NOT NULL AUTO_INCREMENT,
    username char(50),
    password char(40),
    first_name varchar(32),
    last_name varchar(32),
    account_type VARCHAR(255) NULL,
    mail VARCHAR(255) NULL,
    class_id INTEGER UNSIGNED NULL,
    school_id INTEGER UNSIGNED NULL,
    PRIMARY KEY (id)
);


/* Test user
   login: test
   password: test */

INSERT INTO users (username, password) VALUES ('test', '098f6bcd4621d373cade4e832627b4f6');

/* Test admin
   login: test_admin
   password: test_admin */

INSERT INTO users (username, password, account_type) VALUES ('test_admin', '01b114342d7fc811669eb24dbe609cc4', 'admin');

/* Test teacher
   login: test_teacher
   password: test_teacher */

INSERT INTO users (username, password, account_type) VALUES ('test_teacher', '62397d32e4fa81fb1d753736aa714caf', 'teacher');
INSERT INTO subjects (school_id, class_id, name) VALUES ('1', '1', 'Matematyka');
INSERT INTO marks (user_id, class_id, subject_id, mark, description_id) VALUES ('1', '1', '1', '5', '1');
