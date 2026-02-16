class Task < ApplicationRecord
  validates :title, presence: true
  validates :importance, :urgency, :effort,
            numericality: { only_integer: true, in: 1..5 },
            allow_nil: true

  scope :incomplete, -> { where(completed_at: nil) }
  scope :complete,   -> { where.not(completed_at: nil) }

  scope :unscored, -> { where("importance IS NULL OR urgency IS NULL OR effort IS NULL") }
  scope :scored,   -> { where("importance IS NOT NULL AND urgency IS NOT NULL AND effort IS NOT NULL") }

  def scored?
    importance.present? && urgency.present? && effort.present?
  end

  def bucket
    return :complete if completed_at.present?
    return :unscored unless scored?
    return :quick_wins if effort <= 2
    return :later if importance <= 3 && urgency <= 3
    :active_projects
  end
end
