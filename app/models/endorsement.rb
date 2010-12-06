class Endorsement < ActiveRecord::Base
  belongs_to :player
  belongs_to :endorseable, :polymorphic => true
  belongs_to :beverage, :class_name => "Beverage",
                        :foreign_key => "endorseable_id"
  belongs_to :snack, :class_name => "Snack",
                        :foreign_key => "endorseable_id"
  belongs_to :fashion, :class_name => "Fashion",
                        :foreign_key => "endorseable_id"
end
