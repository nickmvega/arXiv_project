# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  papers_count           :integer
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :papers, class_name: "Paper", foreign_key: "user_id", dependent: :destroy
  has_many  :bookmarks, class_name: "Bookmark", foreign_key: "user_id", dependent: :destroy
  has_many :papertopics, through: :papers
  has_many :topics, class_name: "Topic", foreign_key: "user_id", dependent: :destroy 

end
