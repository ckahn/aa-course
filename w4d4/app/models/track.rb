# == Schema Information
#
# Table name: tracks
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  bonus_track :boolean          not null
#  album_id    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Track < ActiveRecord::Base
  validates :name, :album_id, presence: true
  validates :bonus_track, inclusion: { in: [true, false] }
  belongs_to :album
  has_one :band, through: :album
end
