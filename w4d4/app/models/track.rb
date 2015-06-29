# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  song       :string           not null
#  lyrics     :text
#  track_type :string           not null
#  album_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  TRACK_TYPE = %w(bonus regular)

  validates :song, :track_type, :album_id, presence: true
  validates :track_type, inclusion: TRACK_TYPE

  belongs_to :album
  has_one :band, through: :album
  has_many :band_albums, through: :band, source: :albums
end
