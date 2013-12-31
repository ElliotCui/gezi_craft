# # coding: utf-8
class QiuHan < Programmer
  def initialize
    @name = "邱晗"
    @skill_name = "大胃王"
    @skill_description = "关键时刻，吃个包子，生命+60"
    super
  end

  def skill player
    self.current_health += 60
    if self.current_health > self.health
      self.current_health = self.health
    end
    self.skill_used = true
    "邱晗使用大胃王技能，吞下一个大包子，生命恢复60点，我胡汉三又回来了！"
  end
  record
end