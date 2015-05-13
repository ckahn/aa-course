# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate :no_overlapping_approved_requests
  after_initialize :ensure_pending_status

  belongs_to :cat

  def approve!
    raise "not pending" unless status == "PENDING"
    CatRentalRequest.transaction do
      self.update(status: "APPROVED")
      overlapping_pending_requests.each { |request| request.deny! }
    end
  end

  def deny!
    self.update(status: "DENIED")
  end

  def overlapping_requests
    requests = self.cat.cat_rental_requests
    overlapping_requests = []
    requests.each do |request|
      next if self.id == request.id

      max_start = [request.start_date, self.start_date].max
      min_end = [request.end_date, self.end_date].min

      overlapping_requests << request if max_start <= min_end
    end

    overlapping_requests
  end

  def overlapping_pending_requests
    overlapping_requests.select { |request| request.status == "PENDING" }
  end

  def no_overlapping_approved_requests
    if self.status == "APPROVED"
      if overlapping_requests.any? { |request| request.status == "APPROVED" }
        errors[:overlap] << "can't overlap approved request"
      end
    end
  end

  protected

  def ensure_pending_status
    self.status ||= "PENDING"
  end

end
