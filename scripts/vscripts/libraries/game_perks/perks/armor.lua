--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

armor = class(base_game_perk)

function armor:DeclareFunctions()
	if self:GetParent():IsClone() then
		return
	end
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function armor:GetModifierPhysicalArmorBonus()
	return self:CalculateValueByLevel(self.flat, self.level_step, self.per_level)
end