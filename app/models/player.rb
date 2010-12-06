class Player < ActiveRecord::Base
  has_many :endorsements
  has_many :beverage_endorsements, :through => :endorsements,
           :source => :beverage,
           :conditions => "endorsements.endorseable_type = 'Beverage'"
  has_many :snack_endorsements, :through => :endorsements,
           :source => :snack,
           :conditions => "endorsements.endorseable_type = 'Snack'"
  has_many :fashion_endorsements, :through => :endorsements,
           :source => :fashion,
           :conditions => "endorsements.endorseable_type = 'Fashion'"
end
