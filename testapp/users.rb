
require_relative 'user'

class Userslist
  DEPS = [0, 1, 2]
  @@last_user = nil

  def self.this_id()
    @@last_user.id
  end
  def self.this_name()
    @@last_user.name
  end
  def self.this_depno()
    @@last_user.depno
  end
  def self.this_dep()
    dtos(@@last_user.depno)
  end
  def self.this_pass()
    @@last_user.path
  end
  def self.access(id)
    u = User.find_by id: id
    @@last_user = u
    u != nil
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
  def self.add(id, name, depno, pass)
    begin
      user = User.new(id, name, depno, pass)
      user.save
      access(id)
      true
    rescue
      false
    end
  end

  def self.list_depno()
    DEPS
  end
  def self.dtos(d)
    case d
    when 0
      "ITセキュリティ事業本部"
    when 1
      "総務部"
    else
      "その他"
    end
  end
end
