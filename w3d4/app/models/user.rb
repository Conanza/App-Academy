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
    foreign_key: :respondent_id,
    primary_key: :id
  )

  def completed_polls
    Poll.find_by_sql(<<-SQL, self.id)
      SELECT
        polls.*
      FROM
        polls
      JOIN
        questions ON polls.id = questions.poll_id
      JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN (
        SELECT 
          *
        FROM
          responses
        WHERE
          responses.respondent_id = ?
      ) AS user_responses ON user_responses.answer_choice_id = answer_choices.id
      GROUP BY 
        polls.id 
      HAVING
        COUNT(DISTINCT questions.id) = COUNT(user_responses.id)
    SQL
  end
end
