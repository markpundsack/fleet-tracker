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
#  direct_access       :boolean
#

class Fleet < ActiveRecord::Base
  acts_as_random_id
  validates_presence_of :title, :scope
  
  has_many :users
  has_many :reports
  
  scope :open, where(:scope => '3')
  
  def self.new_from_user(user)
    fleet = new(:display_pilot_count => true, 
                :display_fc_info => true,
                :scope => 2,
                :direct_access => true) #alliance
    if user
      fleet.title = "#{user.char_name}'s Fleet"
      fleet.fc = user.char_name
      fleet.xo = user.char_name
      fleet.created_by = user.char_name
      fleet.corp_name = user.corp_name
      fleet.alliance_name = user.alliance_name
      if fleet.alliance_name.blank?
        fleet.scope = 1 # use corp instead of alliance
      end
    end
    return fleet
  end
  
  def self.visible(user)
    where("scope = 3 or (scope = 2 and alliance_name = ?) or (scope = 1 and corp_name = ?) or created_by = ? or fc = ? or xo = ? or id = ?", 
          user.alliance_name, user.corp_name, user.char_name, user.char_name, user.char_name, user.fleet_id)
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
    map = ["Private", "Corp", "Alliance", "Anyone"]
    return map[scope]
  end
  
  def new_reports?(after = 0)
    self.reports.where("updated_at > ?", Time.at(after.to_i + 1)).count > 0
  end
  
  def user_changes_since?(after = 0)
    self.users.where("changed_at > ?", Time.at(after.to_i + 1)).count > 0
  end
  
  def admin?(user)
    return false if user.nil?
    return true if user.global_admin?
    case user.char_name
    when self.fc, self.xo, self.created_by
      return true
    else
      return false
    end
  end
  
  def access_by?(user)
    return false if user.nil?
    return true if self.direct_access
    return true if user.fleet == self
    return true if self.admin?(user)
    case self.scope
    when 3
      return true
    when 2
      return self.alliance_name == user.alliance_name
    when 1
      return self.corp_name == user.corp_name
    end
  end
  
  def purge_users
    users = self.users.where(['updated_at < ?', 10.minutes.ago])
    users.map(&:leave_fleet)
    return users
  end
  
  def self.purge
    # The slow way
    fleets = Fleet.all
    fleets.each do |fleet|
      if fleet.users.is_empty?
        fleet.delete
      end
    end
  end
  
end
