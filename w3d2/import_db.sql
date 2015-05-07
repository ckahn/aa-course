DROP TABLE users;
DROP TABLE questions;
DROP TABLE question_follows;
DROP TABLE replies;
DROP TABLE question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  user_id INTEGER REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  question_id INTEGER NOT NULL REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  parent_id INTEGER REFERENCES replies(id),
  user_id INTEGER NOT NULL REFERENCES users(id),
  body VARCHAR(255) NOT NULL
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  question_id INTEGER NOT NULL REFERENCES questions(id)
);

.headers on
.mode column

INSERT INTO
  users (fname,  lname)
VALUES
  ('Chris', 'Kahn'),
  ('Bob', 'Bob'),
  ('Jim', 'Jim'),
  ('Carl', 'Kim');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Job?', 'Will I get a job?', (SELECT id FROM users WHERE fname = 'Chris')),
  ('Rain?', 'Will it rain money?', (SELECT id FROM users WHERE fname = 'Carl')),
  ('Bob?', 'Are you bob?', (SELECT id FROM users WHERE fname = 'Chris'));


INSERT INTO
  question_follows(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Carl'),
  (SELECT id FROM questions WHERE title = 'Job?')),

  ((SELECT id FROM users WHERE fname = 'Chris'),
  (SELECT id FROM questions WHERE title = 'Rain?'));

INSERT INTO
  replies(question_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Job?'),
   (SELECT id FROM users WHERE fname = 'Carl'),
    'No, you will not get a job.');

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Job?'),
   1,
   (SELECT id FROM users WHERE fname = 'Chris'),
    'Yes, yes I will.');

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Carl'),
   (SELECT id FROM questions WHERE title = 'Job?')),
  ((SELECT id FROM users WHERE fname = 'Bob'),
   (SELECT id FROM questions WHERE title = 'Job?')),
  ((SELECT id FROM users WHERE fname = 'Jim'),
   (SELECT id FROM questions WHERE title = 'Job?')),
  ((SELECT id FROM users WHERE fname = 'Chris'),
   (SELECT id FROM questions WHERE title = 'Rain?'));
