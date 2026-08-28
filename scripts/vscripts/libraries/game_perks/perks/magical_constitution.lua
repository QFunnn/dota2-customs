--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

magical_constitution = class(base_game_perk)

function magical_constitution:__OnCreated()
	self.convert_pct = self.convert_pct or 0
	self:StartIntervalThink(1)
end

function magical_constitution:OnIntervalThink()
	if not self or self:IsNull() then
		return
	end
	if not self.parent or self.parent:IsNull() then
		return
	end

	self.convert_pct = (self.mana_to_hp or 0) / 100

	if not IsServer() then
		return
	end
	self.parent:CalculateStatBonus(true)
end

function magical_constitution:OnDestroy()
	self:StartIntervalThink(-1)
end

function magical_constitution:DeclareFunctions()
	return { MODIFIER_PROPERTY_HEALTH_BONUS }
end

function magical_constitution:GetModifierHealthBonus()
	return (self.parent and (not self.parent:IsNull()) and self.parent:GetMaxMana() or 0) * self.convert_pct
end