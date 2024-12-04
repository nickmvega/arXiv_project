# == Schema Information
#
# Table name: topics
#
#  id                :bigint           not null, primary key
#  papertopics_count :integer
#  topic             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Topic < ApplicationRecord
  has_many  :papertopics, class_name: "Papertopic", foreign_key: "topic_id", dependent: :destroy
  has_many :papers, through: :papertopics
end
