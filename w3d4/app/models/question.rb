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

  belongs_to(
    :poll, 
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many :responses, through: :answer_choices, source: :responses

  def results
    # N+1 Query
    # choices_for_question = self.answer_choices

    choices_and_counts = {}
    # choices_for_question.each do |choice|
    #   choices_and_counts[choice.text] = choice.responses.count
    # end

    # prefetch solution, 2 queries
    # choices_for_question = self.answer_choices.includes(:responses)
    # choices_for_question.each do |choice|
    #   choices_and_counts[choice.text] = choice.responses.length
    # end

    choices = self.answer_choices
      .select('answer_choices.*, COUNT(responses.id) AS response_count')
      .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
      .where('answer_choices.question_id = ?', self.id)
      .group('answer_choices.id')

    choices.each { |choice| choices_and_counts[choice.text] = choice.response_count } 

    choices_and_counts
  end
end
