--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

mp_regen = class(base_game_perk)

function mp_regen:DeclareFunctions()
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT }
end
function mp_regen:GetModifierConstantManaRegen()
	return self:CalculateValueByLevel(self.flat, self.level_step, self.per_level)
end