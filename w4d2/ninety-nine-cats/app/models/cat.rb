# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  validates :birth_date, :name, :color, presence: true
  validates :color, inclusion: { in: %w(brown red grey white) }
  validates :sex, inclusion: { in: %w(M F) }

  has_many :cat_rental_requests, dependent: :destroy


  def age
    cat_age = Date.today.year - birth_date.year
    cat_age -= 1 if Date.today < birth_date + cat_age.years
    cat_age
  end


end
