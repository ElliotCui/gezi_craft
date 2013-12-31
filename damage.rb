class Damage
  S = {
    Hero::ATTACK_TYPES_COMMON => {
      Hero::ARMOR_MEDIUM => 1.5,
      Hero::ARMOR_HEAVY => 1.0,
      Hero::ARMOR_UNARMORED => 1.0,
    },
    Hero::ATTACK_TYPES_MAGIC => {
      Hero::ARMOR_MEDIUM => 1.0,
      Hero::ARMOR_HEAVY => 1.5,
      Hero::ARMOR_UNARMORED => 1.0,
    },
    Hero::ATTACK_TYPES_PIERCING => {
      Hero::ARMOR_MEDIUM => 0.8,
      Hero::ARMOR_HEAVY => 1.0,
      Hero::ARMOR_UNARMORED => 1.4,
    }
  }

  def self.compute attack_type, attack_value, armor_type, armor_value
    (attack_value * S[attack_type][armor_type] - armor_value).to_f.round
  end
end