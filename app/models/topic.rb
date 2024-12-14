# == Schema Information
#
# Table name: topics
#
#  id                :bigint           not null, primary key
#  papertopics_count :integer
#  topic             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#
class Topic < ApplicationRecord
  belongs_to :user
  has_many  :papertopics, class_name: "Papertopic", foreign_key: "topic_id", dependent: :destroy
  has_many :papers, through: :papertopics

  validates :topic, presence: true 
  validates :user_id, presence: true
end
