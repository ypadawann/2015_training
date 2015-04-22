
require_relative 'department'
require_relative 'user'

class Userslist
  @@last_id = 0
  @@last_name = ""

  def self.access(id)
    u = User.find_by id: id
    @@last_id = u.id
    @@last_name = u.name
    u.name
  end
  def self.get_ids()
    User.pluck(:id)
  end
  def self.get_names()
    User.pluck(:name)
  end
  def self.clear()
    User.destroy_all
    true
  end
  def self.include?(id)
    get_ids.include?(id)
  end
  def self.add(id, name)
    if include?(id)
      false
    else
      user = User.new(:id => id, :name => name)
      user.save
      access(id)
      true
    end
  end
end
