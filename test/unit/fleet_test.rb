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

require 'test_helper'

class FleetTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end



