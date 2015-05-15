# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  album_type :string           not null
#  band_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  ALBUM_TYPE = %w(live studio)

  validates :title, :album_type, :band_id, presence: true
  validates :album_type, inclusion: ALBUM_TYPE

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
