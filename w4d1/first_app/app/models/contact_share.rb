# == Schema Information
#
# Table name: contact_shares
#
#  id         :integer          not null, primary key
#  contact_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :contact_id }

  belongs_to :contact

  belongs_to :user

  has_many :comments, as: :commentable
end
