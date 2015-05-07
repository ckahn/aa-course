# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text             not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results_n_plus_one
    results = {}
    answer_choices.each do |ac|
      results[ac.text] = ac.responses.count
    end
    results
  end

  def results_with_includes
    answer_choices = self.answer_choices.includes(:responses)

    answer_choice_counts = {}
    answer_choices.each do |ac|
      answer_choice_counts[ac.text] = ac.responses.count
    end
    answer_choice_counts
  end

  def results
    result_arr = Question.find_by_sql([<<-SQL, self.id]).to_a
      SELECT
        ac.text, COUNT(*) ac_counts
      FROM
        answer_choices AS ac
      LEFT OUTER JOIN
        responses AS r ON ac.id = r.answer_choice_id
      WHERE
        ac.question_id = ?
      GROUP BY
        ac.id
    SQL
    answer = {}
    result_arr.each do |result|
      answer[result.text] = result.ac_counts
    end

    answer
  end

  def ar_results
    my_results_arr = self
    .answer_choices
    .select("answer_choices.text, COUNT(*) AS ac_count")
    .joins("LEFT OUTER JOIN responses AS r ON
            answer_choices.id = r.answer_choice_id")
    .where("answer_choices.question_id = ?", self.id)
    .group("answer_choices.id")

    my_results_arr

    answer = {}
    my_results_arr.each do |result|
      answer[result.text] = result.ac_count
    end

    answer
  end
end



































# stuff
