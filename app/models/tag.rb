
# == Schema Information
#
# Table name: tags
#
#  id          :integer         not null, primary key
#  text        :string(255)     not null
#  usage_count :integer         default(0), not null
#  favorite    :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

class Tag < ActiveRecord::Base
  validates_presence_of :text
  
  has_many :users
  
end
