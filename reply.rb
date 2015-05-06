require 'singleton'
require 'sqlite3'
require_relative 'question_database'

class Reply
  def self.all
    replies = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_user_id(user_id)
    options =
      QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
          *
        FROM
          replies
        WHERE
          user_id = ?;
      SQL
    options.map { |reply| Reply.new(reply) }
  end

  def self.find_by_id(id)
    options =
      QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          replies
        WHERE
          replies.id = ?;
      SQL
    return if options.empty?
    Reply.new(options.first)
  end

  def self.find_by_question_id(question_id)
    options =
      QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          *
        FROM
          replies
        WHERE
          question_id = ?;
      SQL
    options.map { |reply| Reply.new(reply) }
  end

  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def author
    User.find_by_id(@user_id)
  end

  def child_replies
    options =
      QuestionsDatabase.instance.execute(<<-SQL, @id)
        SELECT
          *
        FROM
          replies
        WHERE
          parent_id = ?;
      SQL
    options.map { |reply| Reply.new(reply) }
  end

  def create
    raise 'already saved reply!' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_id, user_id, body)
      INSERT INTO
        replies (question_id, parent_id, user_id, body)
      VALUES
        (?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def question
    Question.find_by_id(@question_id)
  end
end
