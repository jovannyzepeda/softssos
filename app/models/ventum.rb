class Ventum < ActiveRecord::Base
	belongs_to :user
	has_many :detail
end
