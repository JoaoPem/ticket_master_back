class Ticket < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :requester, class_name: "User", foreign_key: "requester_id"
  belongs_to :assigned_user, class_name: "User", optional: true

  validates :title, :description, :status, presence: true
  validates :priority, inclusion: { in: [ 0, 1, 2 ] }

  belongs_to :sector
  validates :sector, presence: true, unless: -> { assigned_user.present? }

  private

  def assign_sector_if_needed
    if assigned_user.present?
      self.sector = assigned_user.sector
    end
  end

  def set_status
    if assigned_user.present?
      self.status = "atribuído"
    else
      self.status = "new"
    end
  end
end
