# == Schema Information
#
# Table name: papers
#
#  id                :bigint           not null, primary key
#  arxiv_identifier  :string
#  author            :string
#  papertopics_count :integer
#  text              :string
#  title             :string
#  url               :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#
class Paper < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id", counter_cache: true
  has_many  :papertopics, class_name: "Papertopic", foreign_key: "paper_id", dependent: :destroy

  mount_uploader :text, TextUploader
end
