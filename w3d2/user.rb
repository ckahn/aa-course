require 'singleton'
require 'sqlite3'
require_relative 'question_database'
require_relative 'question_follow'
require_relative 'question_like'

class User

  def self.all
    users = QuestionsDatabase.instance.execute('SELECT * FROM users')
    users.map { |user| User.new(user) }
  end

  def self.find_by_id(id)
    options =
      QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          users
        WHERE
          id = ?;
      SQL
    User.new(options.first)
  end

  def self.find_by_name(fname, lname)
    options =
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT
          *
        FROM
          users
        WHERE
          fname = ? AND lname = ?
      SQL
    User.new(options.first)
  end

  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id =  options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def average_karma
    karma =
      QuestionsDatabase.instance.get_first_row(<<-SQL, @id)
        SELECT
          CAST(COUNT(ql.user_id) AS FLOAT), COUNT(DISTINCT(q.id))
        FROM
          questions q
        LEFT OUTER JOIN
          question_likes ql ON q.id = ql.question_id
        WHERE
          q.user_id = ?
      SQL
    karma.values.first / karma.values.last
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def create
    raise "already persisted" if persisted?

    QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def save
    persisted? ? update : create
  end

  private

  def persisted?
    !@id.nil?
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end
end
