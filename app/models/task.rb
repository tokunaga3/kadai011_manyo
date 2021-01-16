class Task < ApplicationRecord
  validates:name,presence: true
  enum status: { 未着手:1, 着手中:2, 完了:3 }
  scope :deadline_sort, -> { order(deadline: :desc) }
  scope :created_sort, -> { order(created_at: :desc) }
  scope :name_sarch, -> params_sarch{ where('name LIKE(?)', "%#{params_sarch}%") }
  scope :status_sarch, -> params_status{ where(status:params_status) }
end
