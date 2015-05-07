# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :answerer_id,
    primary_key: :id
  )

  def questions_per_poll
    result = User.find_by_sql([<<-SQL])
      SELECT
        polls.*, COUNT(*) AS poll_count
      FROM
        questions
      JOIN
        polls ON questions.poll_id = polls.id
      JOIN
        users ON polls.author_id = users.id
      GROUP BY
        polls.id
    SQL
    result
  end

=begin

SELECT
  polls.*, COUNT(*)
FROM
  questions
JOIN
  polls ON questions.poll_id = polls.id
JOIN
  users ON polls.author_id = users.id
GROUP BY
  polls.id

=end

end
