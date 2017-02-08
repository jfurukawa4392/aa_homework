CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,

  FOREIGN KEY (subject_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Bo', 'Katsarov'),
  ('Jesse', 'F');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ("How do you build database?", "What about SQL?", (SELECT id FROM users WHERE fname = 'Bo'));

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Bo'), (SELECT id FROM questions));

INSERT INTO
  replies(subject_id, user_id, body)
VALUES
  ((SELECT id FROM questions), (SELECT id FROM users WHERE fname = 'Jesse'), 'Great question');

INSERT INTO
  question_likes(question_id, user_id)
VALUES
  ((SELECT id FROM questions), (SELECT id FROM users WHERE fname = 'Bo'));
