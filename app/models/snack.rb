class Snack < ActiveRecord::Base
  has_many :endorsements, :as => :endorseable
  has_many :players, :through => :endorsements
  def get_all_for_select
    logger.debug "===> Smodel 0"
    @snacks = Snack.find(:all, :order => "name ASC",
               :select => "name, name").map { |b|
                           [b.name, b.name]}
               #:select => "id, name").map { |b|
               #            [b.name, b.name]}
  end
end
