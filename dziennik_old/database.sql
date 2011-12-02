CREATE TABLE bells (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  school_id INTEGER UNSIGNED NULL,
  start_time TIME NULL,
  end_time TIME NULL,
  PRIMARY KEY(id)
);

CREATE TABLE classes (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NULL,
  yearbook INTEGER UNSIGNED NULL,
  school_id INTEGER UNSIGNED NULL,
  teacher_id INTEGER UNSIGNED NULL,
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
  teacher_id INTEGER UNSIGNED NULL,
  class_id INTEGER UNSIGNED NULL,
  name VARCHAR(255) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE marks (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  student_id INTEGER UNSIGNED NULL,
  class_id INTEGER UNSIGNED NULL,
  subject_id TINYINT UNSIGNED NULL,
  description_id INTEGER UNSIGNED NULL,
  mark TINYINT UNSIGNED NULL,
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
    mail VARCHAR(255) NULL,
    school_id INTEGER UNSIGNED NULL,
    class_id INTEGER UNSIGNED NULL,
    teacher_id INTEGER UNSIGNED NULL,
    student BOOLEAN NOT NULL DEFAULT 0,
    teacher BOOLEAN NOT NULL DEFAULT 0,
    admin BOOLEAN NOT NULL DEFAULT 0,
    superadmin BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

INSERT INTO users (username, password, superadmin) VALUES ('superadmin', 'f1bab0da1e3744bc9c22d63be1af16f5e4f76fc4', '1');
INSERT INTO users (username, password, admin) VALUES ('admin', 'f1bab0da1e3744bc9c22d63be1af16f5e4f76fc4', '1');
INSERT INTO users (username, password, teacher, first_name, last_name, class_id) VALUES ('teacher', 'f1bab0da1e3744bc9c22d63be1af16f5e4f76fc4', '1', 'Karolina', 'Olczak', '1');
INSERT INTO users (username, password, student, first_name, last_name, class_id, teacher_id) VALUES ('student', 'f1bab0da1e3744bc9c22d63be1af16f5e4f76fc4', '1', 'Jakub', 'Gorzelak', '1', '3');
INSERT INTO users (username, password, student, first_name, last_name, class_id, teacher_id) VALUES ('student2', 'f1bab0da1e3744bc9c22d63be1af16f5e4f76fc4', '1', 'Arkadiusz', 'Dudek', '1', '3');


INSERT INTO subjects (school_id, teacher_id, class_id, name) VALUES ('1', '3', '1', 'Matematyka');
INSERT INTO descriptions (subject_id, description) VALUES ('1', 'Sprawdzian Planimetria');
