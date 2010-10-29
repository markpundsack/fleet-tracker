# == Schema Information
#
# Table name: global_admins
#
#  id         :integer         not null, primary key
#  char_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class GlobalAdmin < ActiveRecord::Base
  validates_presence_of :char_name
end
