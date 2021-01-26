class Task < ApplicationRecord
  validates:name,presence: true
  enum status: { 未着手:1, 着手中:2, 完了:3 }
  scope :deadline_sort, -> { order(deadline: :desc) }
  scope :created_sort, -> { order(created_at: :desc) }
  scope :name_sarch, -> params_sarch{ where('name LIKE(?)', "%#{params_sarch}%") }
  scope :status_sarch, -> params_status{ where(status:params_status) }
  enum priority:  { 高:1, 中:2, 低:3 }
  scope :priority_sort, -> { order(priority: :asc)}
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels
  scope :label_sarch, -> params_label_id { joins(:labels).where(labels: { id: params_label_id }) }
end
