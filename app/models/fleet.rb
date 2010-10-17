# == Schema Information
#
# Table name: fleets
#
#  id                  :integer         not null, primary key
#  title               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  scope               :integer
#  display_pilot_count :boolean
#  display_fc_info     :boolean
#  fc                  :string(255)
#  xo                  :string(255)
#  created_by          :string(255)
#  corp_name           :string(255)
#  alliance_name       :string(255)
#

class Fleet < ActiveRecord::Base
  validates_presence_of :title, :scope
  
  has_many :users
  has_many :reports
  
  scope :open, where(:scope => '3')
  
  def self.new_from_user(user)
    fleet = new(:display_pilot_count => true, 
                :display_fc_info => true,
                :scope => 2) #alliance
    if user
      fleet.title = "#{user.char_name}'s Fleet"
      fleet.fc = user.char_name
      fleet.xo = user.char_name
      fleet.created_by = user.char_name
      fleet.corp_name = user.corp_name
      fleet.alliance_name = user.alliance_name
    end
    return fleet
  end
  
  def self.visible(user)
    where("scope = 3 or (scope = 2 and alliance_name = '#{user.alliance_name}') or (scope = 1 and corp_name = '#{user.corp_name}')")
  end  

  def summarize
    # Calculate summmary
    system = {}
    users.each do |user|
      if system[user.solar_system_name].nil?
        system[user.solar_system_name] = [user]
      else
        system[user.solar_system_name] << user
      end
    end
    # Sort based on number of pilots in each system
    sorted_systems = system.sort {|a,b| a[1].count <=> b[1].count}
    sorted_systems.reverse!
    return sorted_systems
  end
  
  def scope_to_s
    map = ["Private", "Corp", "Alliance", "Open"]
    return map[scope]
  end
  
  def new_reports?(after = 0)
    self.reports.where("updated_at > ?", Time.at(after.to_i + 1)).count > 0
  end
  
  def user_changes_since?(after = 0)
    self.users.where("changed_at > ?", Time.at(after.to_i + 1)).count > 0
  end

end

