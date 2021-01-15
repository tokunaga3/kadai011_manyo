class Task < ApplicationRecord
  validates:name,presence: true
  enum status: { 未着手:1, 着手中:2, 完了:3 }
end
