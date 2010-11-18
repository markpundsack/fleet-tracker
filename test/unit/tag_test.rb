require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: tags
#
#  id          :integer         not null, primary key
#  text        :string(255)     not null
#  usage_count :integer         default(0), not null
#  favorite    :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

