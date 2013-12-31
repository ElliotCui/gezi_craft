# coding: utf-8
class Zhangjian < Programmer
  def initialize
    @name = "张健"
    @skill_name = "长跑"
    @skill_description = "跑得快"
    super
    @speed += 2
  end

  record
end