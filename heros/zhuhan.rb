# coding: utf-8
class Zhuhan < Designer
  def initialize
    @name = "朱晗"
    @skill_name = "找BUG"
    @skill_description = "对对方某个工程师造成45点伤害"
    super
  end

  def skill player
    opponent = player.opponent
    hero = opponent.heros.values.select{ |h| h.is_a? Programmer }.sample
    unless hero
      return "对面没有工程师"
    end
    self.skill_used = true
    opponent.bleed(hero, 45)

    "【朱晗】找到一个#{hero.name}的bug，#{hero.name}吐血45点！"
  end

  record
end