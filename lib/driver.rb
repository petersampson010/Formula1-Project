class Driver < ActiveRecord::Base

  belongs_to :constructor
  has_many :finishing_positions
  has_many :races, through: :finishing_positions

  def name
    "#{first_name} #{second_name}"
  end

  def increase_skill(skill_points)
    self.skill_factor += skill_points
  end

  def self.reset_drivers_to_teams
    Driver.all.each do |d|
      if d.id > 16
      elsif d.id.even?
        new_id = d.id / 2
        new_constructor = Constructor.find_by(id: new_id)
        new_constructor.drivers << d
      else
        new_id = ((d.id / 2.0).to_f + 0.5).to_i
        new_constructor = Constructor.find_by(id: new_id)
        new_constructor.drivers << d
      end
    end
  end
end