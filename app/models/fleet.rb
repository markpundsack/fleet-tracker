class Fleet < ActiveRecord::Base
  validates_presence_of :title, :scope
  
  has_many :users
end
