require 'singleton'
require 'sqlite3'
require_relative 'question_database'
require_relative 'user'

class QuestionLike
  def self.all
    question_likes = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    question_likes.map { |question_like| QuestionLike.new(question_like) }
  end

  def self.find_by_id(id)
    options =
      QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          question_likes
        WHERE
          question_likes.id = ?;
      SQL
    QuestionLike.new(options.first)
  end

  def self.liked_questions_for_user_id(user_id)
    questions =
      QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
          q.*
        FROM
          questions q
        INNER JOIN
          question_likes ql ON (q.id = ql.question_id)
        WHERE
          ql.user_id = ?
      SQL
    questions.map { |question| Question.new(question)}
  end

  def self.likers_for_question_id(question_id)
    users =
      QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT DISTINCT
          users.fname, users.lname, users.id
        FROM
          questions
        INNER JOIN
          question_likes ON questions.id = question_likes.question_id
        INNER JOIN
          users ON question_likes.user_id = users.id
        WHERE
          questions.id = ?;

        --
        -- SELECT
        --   users.*
        -- FROM
        --   question_likes ql
        -- JOIN
        --   users u
        -- ON
        --   ql.user_id = u.id
        -- WHERE
        --   ql.question_id = ?
        --
      SQL
    users.map { |user| User.new(user) }
  end

  def self.most_liked_questions(n)
    questions =
      QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT
          q.*
        FROM
          question_likes ql
        INNER JOIN
          questions q ON ql.question_id = q.id
        GROUP BY
          q.id
        ORDER BY
          COUNT(*) DESC
        LIMIT
          ?
      SQL
    questions.map { |question| Question.new(question) }
  end

  def self.num_likes_for_question_id(question_id)
    count =
      QuestionsDatabase.instance.get_first_row(<<-SQL, question_id)
        SELECT DISTINCT
          COUNT(*)
        FROM
          questions
        INNER JOIN
          question_likes ON questions.id = question_likes.question_id
        WHERE
          questions.id = ?
      SQL
    count.values.first
  end

  attr_accessor :id, :user_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def create
    raise 'already saved like!' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_id, user_id, body)
      INSERT INTO
        question_likes (user_id, question_id)
      VALUES
        (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end
end
