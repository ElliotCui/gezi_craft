# coding: utf-8
class Danni < OO
  def initialize
    @name = "丹妮"
    @skill_name = "我有一个想法"
    @skill_description = "随机使对面某个英雄损血30点。"
    super
  end

  def skill player
    opponent = player.opponent

    hero = opponent.random_hero
    opponent.bleed(hero, 30)
    self.skill_used = true
    "丹妮使用技能，用一个不可思议的想法恶心了#{hero.name}，减少30点血!"
  end

  record
end