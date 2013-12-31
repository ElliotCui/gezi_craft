# coding: utf-8
class Xiangdan < Programmer
  def initialize
    @name = "祥旦"
    @skill_name = "晚餐界毒瘤"
    @skill_description = "我想尝尝你这个好吃吗！（如果对面英雄中存在俊伟，则俊伟承受效果，否则随机。）"
    super
  end

  def skill player
    opponent = player.opponent
    heros = opponent.heros.values

    hero = heros.find { |h| h.is_a?(Junwei) }
    notice = "【祥旦】明抢#{hero.name}晚餐，导致#{hero.name}永久失去 5点攻击和3点防御力。" if hero

    unless hero
      hero = heros.sample
      notice = "由于【祥旦】没有找到俊伟，改偷吃#{hero.name}晚餐，导致#{hero.name}永久失去 5点攻击和3点防御力。"
    end

    hero.attack_value -= 5
    hero.armor_value -= 3

    self.skill_used = true
    notice
  end

  record
end