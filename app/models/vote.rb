# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  votable_id   :integer
#  votable_type :string
#  value        :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Vote < ActiveRecord::Base
  validates :value, inclusion: [1, -1]
  validates :votable_id, :votable_type, :value, presence: true

  belongs_to :votable, polymorphic: true
end
