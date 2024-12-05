# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  comment    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  paper_id   :integer
#  user_id    :integer
#
class Bookmark < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :paper, required: true, class_name: "Paper", foreign_key: "paper_id"
end
