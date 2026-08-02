--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

agi_for_kill = class(base_game_perk)

function agi_for_kill:__OnCreated()
	if IsClient() then
		return
	end

	if not self.parent:IsRealHero() and not self.parent:IsClone() then
		local hero = PlayerResource:GetSelectedHeroEntity(self.parent:GetPlayerOwnerID())

		if IsValidEntity(hero) then
			self:SetStackCount(hero:GetModifierStackCount(self:GetName(), hero))
		end
	end
end

function agi_for_kill:DeclareFunctions()
	return { MODIFIER_PROPERTY_STATS_AGILITY_BONUS, MODIFIER_EVENT_ON_HERO_KILLED }
end

function agi_for_kill:OnHeroKilled(keys)
	if not IsServer() then
		return
	end
	local killerID = keys.attacker:GetPlayerOwnerID()
	if self:GetStackCount() >= self.stack_limit then
		return
	end

	if killerID and killerID == self.parent:GetPlayerOwnerID() and keys.target:GetTeam() ~= self.parent:GetTeam() then
		self:IncrementStackCount()
		self.parent:CalculateStatBonus(false)
	end
end

function agi_for_kill:GetModifierBonusStats_Agility()
	return self.per_kill * self:GetStackCount()
end