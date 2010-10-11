# == Schema Information
#
# Table name: reports
#
#  id                :integer         not null, primary key
#  char_name         :string(255)
#  solar_system_name :string(255)
#  reds              :integer
#  neutrals          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  fleet_id          :integer
#

class Report < ActiveRecord::Base
  validates_presence_of :char_name, :solar_system_name
    
  belongs_to :fleet
  
  default_scope :order => 'updated_at DESC'

  def reds?
    return false if reds.nil?
    reds > 0
  end
  
  def neutrals?
    return false if neutrals.nil?
    neutrals > 0
  end
  
  def clear?
    !reds? && !neutrals?
  end
end

