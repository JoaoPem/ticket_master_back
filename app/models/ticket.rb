class Ticket < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :requester, class_name: "User", foreign_key: "requester_id"
  belongs_to :assigned_user, class_name: "User", optional: true
  belongs_to :department

  validates :department, presence: true

  validates :title, :description, :creator_id, :requester_id, presence: true
  validates :deadline_date, presence: true


  enum :status, [ :new_found, :assigned, :pending, :closed, :completed ]
  validates :status, presence: true

  enum :priority, [ :very_low, :low, :medium, :high, :very_high ]
  validates :priority, presence: true

  before_create :assign_department_if_assigned_user_present, :set_status

  private

  def assign_department_if_assigned_user_present
    if assigned_user.present?
      self.department = assigned_user.department
    end
  end

  def set_status
    self.status = assigned_user.present? ? :assigned : :new_found
  end
end
