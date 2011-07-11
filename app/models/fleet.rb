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
#  users_count         :integer
#  deleted_at          :time
#

class Fleet < ActiveRecord::Base
  acts_as_random_id
  acts_as_paranoid
  validates_presence_of :title, :scope
  
  has_many :users
  has_many :reports
  
  OPEN = 3
  ALLIANCE = 2
  CORP = 2
  PRIVATE = 1
  
  # scope :open, where(:scope => OPEN) # Unused currently and overrides existing open method
  
  def self.new_from_user(user)
    fleet = new(:display_pilot_count => true, 
                :display_fc_info => true,
                :scope => ALLIANCE,
                :direct_access => true)
    if user
      fleet.title = "#{user.char_name}'s Fleet"
      fleet.fc = user.char_name
      fleet.xo = user.char_name
      fleet.created_by = user.char_name
      fleet.corp_name = user.corp_name
      fleet.alliance_name = user.alliance_name
      if fleet.alliance_name.blank?
        fleet.scope = CORP # use corp instead of alliance
      end
    end
    return fleet
  end
  
  def self.visible(user)
    where("scope = #{OPEN} or (scope = #{ALLIANCE} and alliance_name = ?) or (scope = #{CORP} and corp_name = ?) or created_by = ? or fc = ? or xo = ? or id = ? and deleted = false", 
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
    return true if user.global_admin?
    return false if self.deleted?
    return true if self.direct_access
    return false if user.nil?
    return true if user.fleet == self
    return true if self.admin?(user)
    case self.scope
    when OPEN
      return true
    when ALLIANCE
      return self.alliance_name == user.alliance_name
    when CORP
      return self.corp_name == user.corp_name
    end
  end
  
  def purge_users
    users = self.users.abandoned
    users.map(&:leave_fleet)
    return users
  end
  
  scope :empty, lambda {
    #select("fleets.*,count(users.id)").
    #joins("LEFT JOIN users ON fleets.id = users.fleet_id").
    #group("fleets.id,fleet.title, fleet.created_at, fleet.updated_at, fleet.scope, fleet.display_pilot_count, fleet.display_fc_info, fleet.fc, fleet.xo, fleet.created_by, fleet.corp_name, fleet.alliance_name, fleet.direct_access").
    #having("count(users.id)=0")
    #select("fleets.*, (select count(users.id) from users where fleets.id = users.fleet_id) as user_count").
    #having("user_count=0")
    where("users_count=0")
  }
  
  def self.purge
    Fleet.empty.map(&:delete)
  end
  
end

