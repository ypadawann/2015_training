
require_relative 'department'
require_relative 'user'

class Userslist
  def self.get_ids()
    User.pluck(:num)
  end
  def self.get_names()
    User.pluck(:name)
  end
  def self.clear()
    User.destroy_all
    true
  end
  def self.include?(id)
    get_ids.include?(id.to_i)
  end
  def self.add(id, name)
    if include?(id)
      false
    else
      user = User.new(:num => id, :name => name)
      user.save
      true
    end
  end
end
