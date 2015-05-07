class Response < ActiveRecord::Base
  validates :answerer_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :answerer_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )


  def sibling_responses
    question.responses.where("responses.id != ? OR ? IS NULL",
                             self.id, self.id)
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.where("answerer_id = ?", self.answerer_id).count > 0
      puts "hey"
      errors[:base] << "Already answered question"
    end
  end

  def author_cannot_respond_to_own_poll
    if answer_choice.question.poll.author.id == self.answerer_id
      errors[:base] << "You can't answer your own poll"
    end
  end
end
