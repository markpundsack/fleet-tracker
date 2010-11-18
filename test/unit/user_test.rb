require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end



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
#  tag_id             :integer
#

