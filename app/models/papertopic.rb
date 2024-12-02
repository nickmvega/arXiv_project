# == Schema Information
#
# Table name: papertopics
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  paper_id   :integer
#  topic_id   :integer
#
class Papertopic < ApplicationRecord
  belongs_to :paper, required: true, class_name: "Paper", foreign_key: "paper_id", counter_cache: true
  belongs_to :topic, required: true, class_name: "Topic", foreign_key: "topic_id", counter_cache: true
end
