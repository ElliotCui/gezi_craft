# coding: utf-8
class Wangran < OO
  def initialize
    @name = "王然"
    @skill_name = "开会啦"
    @skill_description = "all不能攻击"
    super
  end

  record
end

class Tianfang < Programmer
  def initialize
    @name = "天放"
    @skill_name = "开会啦"
    @skill_description = "all不能攻击"
    super
  end

  record
end