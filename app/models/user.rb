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
#

class User < ActiveRecord::Base
  validates_presence_of :char_name, :corp_name
  
  belongs_to :fleet
  
  def in_fleet?(fleet)
    fleet_id == fleet.id
  end
  
  def join_fleet(fleet)
    fleet = fleet
  end
  
  def leave_fleet
    self.fleet = nil
    save
  end
  
  def self.new_from_env(env)
    if !env["HTTP_EVE_CHARNAME"].blank?
      user = User.find_or_initialize_by_char_name(env["HTTP_EVE_CHARNAME"])
      # set everything just in case member has changed corp, etc.
      user.corp_name = env["HTTP_EVE_CORPNAME"]
      user.alliance_name = env["HTTP_EVE_ALLIANCENAME"]
      user.region_name = env["HTTP_EVE_REGIONNAME"]
      user.constellation_name = env["HTTP_EVE_CONSTELLATIONNAME"]
      user.solar_system_name = env["HTTP_EVE_SOLARSYSTEMNAME"]
      user.station_name = env["HTTP_EVE_STATIONNAME"]
      user.updated_at = Time.now # To force an update
      user.save
    end
    return user
  end
  
end

