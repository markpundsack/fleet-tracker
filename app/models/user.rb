# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  char_name          :string(255)
#  corp_name          :string(255)
#  alliance_name      :string(255)
#  station_name       :string(255)
#  solar_system_name  :string(255)
#  constellation_name :string(255)
#  region_name        :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  fleet_id           :integer
#  changed_at         :datetime
#

class User < ActiveRecord::Base
  validates_presence_of :char_name, :corp_name
  
  before_save :check_for_changes
  
  belongs_to :fleet

  default_scope :order => 'char_name'
  
  def in_fleet?(fleet)
    fleet_id == fleet.id
  end
  
  def join_fleet(fleet)
    self.fleet = fleet
    save
  end
  
  def leave_fleet
    self.fleet = nil
    save
  end

  def set_from_env(env)
    # set everything just in case member has changed corp, etc.
    self.corp_name = env["HTTP_EVE_CORPNAME"]
    self.alliance_name = env["HTTP_EVE_ALLIANCENAME"]
    self.region_name = env["HTTP_EVE_REGIONNAME"]
    self.constellation_name = env["HTTP_EVE_CONSTELLATIONNAME"]
    self.solar_system_name = env["HTTP_EVE_SOLARSYSTEMNAME"]
    self.station_name = env["HTTP_EVE_STATIONNAME"]
  end
  
  def self.find_or_initialize_from_env(env)
    if !env["HTTP_EVE_CHARNAME"].blank?
      user = User.find_or_initialize_by_char_name(env["HTTP_EVE_CHARNAME"])
    end
  end
  
  def self.new_or_update_from_env(env)
    if !env["HTTP_EVE_CHARNAME"].blank?
      user = User.find_or_initialize_by_char_name(env["HTTP_EVE_CHARNAME"])
      user.set_from_env(env)
    end
    return user
  end
  
  def self.new_or_update_from_env_and_save(env)
    if !env["HTTP_EVE_CHARNAME"].blank?
      user = User.find_or_initialize_by_char_name(env["HTTP_EVE_CHARNAME"])
      user.set_from_env(env)
      user.updated_at = Time.now # To force an update
      user.save
      Logger.new(STDOUT).info('updated user')
    end
    return user
  end
  
  def stale?
    updated_at < 1.minute.ago
  end
  
  def abandoned?
    updated_at < 10.minutes.ago
  end
  
  def check_for_changes
    self.changed_at = Time.now if self.solar_system_name_changed?
  end
  
  def global_admin?
    return true if (GlobalAdmin.find_by_char_name(self.char_name))
  end
  
  def self.purge
    users = Users.where(['updated_at < ?', 10.minutes.ago])
    users.map(&:leave_fleet)
    return users
  end
  
end
