# coding: utf-8
class Dongdong < Programmer
  def initialize
    @name = "东东"
    @skill_name = "不差钱"
    @skill_description = "对方血量最少的敌人减血35"
    super
  end

  def skill player
    opponent = player.opponent
    hero = nil
    health = 1000

    opponent.heros.each do |id, h|
      if h.current_health < health
        hero = h
        health = h.current_health
      end
    end

    opponent.bleed(hero, 35)
    self.skill_used = true
    "【东东】使用技能不差钱，将百元大钞票打在【#{hero.name}】脸上，伤血35。霸气侧漏啊！"
  end

  record
end