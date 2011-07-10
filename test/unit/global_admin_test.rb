# == Schema Information
#
# Table name: global_admins
#
#  id         :integer         not null, primary key
#  char_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class GlobalAdminTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

