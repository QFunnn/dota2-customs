--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

hp_regen = class(base_game_perk)

function hp_regen:DeclareFunctions()
	return { MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
end
function hp_regen:GetModifierConstantHealthRegen()
	return self:CalculateValueByLevel(self.flat, self.level_step, self.per_level)
end