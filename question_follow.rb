require 'singleton'
require 'sqlite3'
require_relative 'user'
require_relative 'question'

class QuestionFollow
  def self.all
    question_follows = QuestionsDatabase.instance.execute('SELECT * FROM question_follows')
    question_follows.map { |question_follow| QuestionFollow.new(question_follow) }
  end

  def self.find_by_id(id)
    options =
      QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          question_follows
        WHERE
          id = ?;
      SQL
    QuestionFollow.new(options.first)
  end

  def self.most_followed_questions(n)
    questions =
      QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT
          questions.id, questions.title, questions.body, questions.user_id
        FROM
          question_follows
        INNER JOIN
          questions ON (question_follows.question_id = questions.id)
        GROUP BY
          questions.id
        ORDER BY
          COUNT(*) DESC
        LIMIT
          ?
      SQL
    questions.map { |question| Question.new(question) }
  end

  attr_accessor :id, :user_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def create
    raise 'already followed!' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, user_id, question_id)
      INSERT INTO
        question_follows (user_id, question_id)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.followers_for_question_id(question_id)
    options =
      QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          users.id, users.fname, users.lname
        FROM
          users
        INNER JOIN
          question_follows ON question_follows.user_id = users.id
        WHERE
          question_follows.question_id = ?
      SQL
    options.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        users
      INNER JOIN
        question_follows ON question_follows.user_id = users.id
      INNER JOIN
        questions ON questions.id = question_follows.question_id
      WHERE
        users.id = ?
    SQL
    options.map { |question| Question.new(question) }
  end
end
