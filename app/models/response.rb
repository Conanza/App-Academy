# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer          not null
#  respondent_id    :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :respondent_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_poll_author

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :respondent_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question

  # pull all responses for a question for 2 cases:
  # 1. if current response isn't saved yet, self.id will be null
  #    thus, pull everything self.question.responses returns
  #  OR 
  # 2. if curr response is saved,
  #    then find all responses where responses.id is not same as self.id
  def sibling_responses
    self.question.responses
      .where('? IS NULL OR responses.id != ?', self.id, self.id)
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(respondent_id: self.respondent_id)
      errors[:respondent_id] << "has already answered this question"
    end
  end

  def respondent_is_not_poll_author
    poll_author = self.question.poll.author_id

    if poll_author == self.respondent_id
      errors[:respondent_id] << "cannot be the poll's author"
    end
  end
end
