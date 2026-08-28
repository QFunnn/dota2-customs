--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

str_for_kill = class(base_game_perk)

function str_for_kill:__OnCreated()
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

function str_for_kill:DeclareFunctions()
	return { MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, MODIFIER_EVENT_ON_HERO_KILLED }
end

function str_for_kill:OnHeroKilled(keys)
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

function str_for_kill:GetModifierBonusStats_Strength()
	return self.per_kill * self:GetStackCount()
end