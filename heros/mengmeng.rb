# coding: utf-8
class Mengmeng < OO
  def initialize
    @name = "蒙蒙"
    @skill_name = "可以点餐啦"
    @skill_description = "除祥旦外 ，所有人自己加血"
    super
  end

  def skill player
    player.heros.each do |id, hero|
      hero.add_current_health(14)
    end
    self.skill_used = true
    "蒙蒙摊开一桌子菜，player#{player.position}的英雄们吃的很嗨皮，各加了14点血。"
  end
  record
end