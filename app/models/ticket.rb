class Ticket < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :requester, class_name: "User", foreign_key: "requester_id"
  belongs_to :assigned_user, class_name: "User", optional: true

  validates :title, :description, :status, presence: true
  validates :priority, inclusion: { in: [ 0, 1, 2 ] }

  belongs_to :sector
  validates :sector, presence: true, unless: -> { assigned_user.present? }

  enum status: { novo: 0, atribuido: 1, pendente: 2, encerrado: 3, concluido: 4 }

  before_create :assign_sector_if_needed, :set_status

  private

  def assign_sector_if_needed
    if assigned_user.present?
      self.sector = assigned_user.sector
    end
  end

  def set_status
    self.status = assigned_user.present? ? :atribuido : :novo
  end
end
