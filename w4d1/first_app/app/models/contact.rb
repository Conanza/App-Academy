# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validates :name, uniqueness: { scope: :email }

  belongs_to :owner, class_name: "User", foreign_key: :user_id

  has_many :contact_shares, dependent: :destroy

  has_many(
    :shared_users,
    through: :contact_shares,
    source: :user
  )

  has_many :comments, as: :commentable
  
end
