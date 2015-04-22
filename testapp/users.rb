
require_relative 'user'

class Userslist
  def self.get_ids
    User.pluck(:num)
  end
  def self.get_names
    User.pluck(:name)
  end
  def self.clear
    User.destroy_all
    true
  end
  def self.include?(id) # おかしい
    get_ids.include?(id.to_s)
  end
  def self.add(id, name)
    @ncols1 = get_ids.length
    user = User.new(:num => id, :name => name)
    user.save
    @ncols2 = get_ids.length
    @ncol1 != @ncol2
  end
end
