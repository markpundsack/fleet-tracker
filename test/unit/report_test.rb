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

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

