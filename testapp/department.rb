class Department
  DEPS = [:ITsec, :Eco, :Others]

  def self.to_string(dep)
    case dep
    when :ITsec
      "ITセキュリティ事業本部"
    when :ECO
      "エコプロダクト事業本部"
    else
      "その他"
    end
  end
  def list_dep()
    DEPS.each { |d| to_string(d) }
  end
end
