--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

bonus_hp_pct = class(base_game_perk)

function bonus_hp_pct:__OnCreated()
	self.flat_bonus_hp = 0
	self.bonus_hp_pct = self.bonus_hp / 100
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end

function bonus_hp_pct:OnIntervalThink()
	local max_health = self.parent:GetMaxHealth()

	if max_health ~= self.prev_max_health then
		self.flat_bonus_hp = self.bonus_hp_pct * (max_health - (self.prev_flat_bonus_hp or 0))
		self.prev_max_health = max_health
		self.prev_flat_bonus_hp = self.flat_bonus_hp

		self.parent:CalculateStatBonus(true)
	end
end

function bonus_hp_pct:DeclareFunctions()
	return { MODIFIER_PROPERTY_HEALTH_BONUS }
end
function bonus_hp_pct:GetModifierHealthBonus()
	return self.flat_bonus_hp
end