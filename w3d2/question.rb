require 'singleton'
require 'sqlite3'
require_relative 'question_database'
require_relative 'question_follow'
require_relative 'question_like'

class Question
  def self.all
    questions = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    questions.map { |question| Question.new(question) }
  end

  def self.find_by_author_id(user_id)
    options =
      QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
          *
        FROM
          questions
        WHERE
          user_id = ?;
      SQL
    options.map { |question| Question.new(question) }
  end

  def self.find_by_id(id)
    options =
      QuestionsDatabase.instance.get_first_row(<<-SQL, id)
        SELECT
          *
        FROM
          questions
        WHERE
          questions.id = ?;
      SQL
    Question.new(options)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_question(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  attr_accessor :id, :title, :body, :user_id

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    options =
      QuestionsDatabase.instance.get_first_row(<<-SQL, user_id)
        SELECT
          *
        FROM
          users
        WHERE
          id = ?;
      SQL
    User.new(options)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_quesetion_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  private
  
  def create
    raise 'already saved question!' unless self.id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, title, body, user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end
end
