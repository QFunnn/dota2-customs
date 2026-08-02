--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

summon_power = class(base_game_perk)

function summon_power:__OnCreated()
	if not IsServer() then
		return
	end

	self.summon_damage_pct = self.summon_damage / 100
	self.summon_health_pct = self.summon_health / 100

	self.parent.ApplySummonPower = function(_, unit)
		self:ApplySummonPower(unit)
	end
end

function summon_power:ApplySummonPower(unit)
	if not IsServer() then
		return
	end
	if not IsValidEntity(unit) then
		return
	end

	unit:AddNewModifier(self.parent, nil, "modifier_summon_power_buff", {
		duration = -1,
		summon_health = self.summon_health_pct,
		summon_damage = self.summon_damage_pct,
	})
end

modifier_summon_power_buff = class({})

function modifier_summon_power_buff:IsHidden()
	return true
end
function modifier_summon_power_buff:IsPurgable()
	return false
end
function modifier_summon_power_buff:IsPurgeException()
	return false
end
function modifier_summon_power_buff:RemoveOnDeath()
	return false
end

function modifier_summon_power_buff:OnCreated(kv)
	self.parent = self:GetParent()

	if not IsServer() then
		return
	end

	-- Need a delay to apply all bonuses from ability config / talents / etc.
	Timers:CreateTimer(0.1, function()
		-- Cache values to prevent re-dominate creeps with multiplicative bonuses
		if not self.parent._base_health or not self.parent._base_damage then
			self.parent._base_health = self.parent:GetMaxHealth()
			--self.parent._base_damage = self.parent:GetAverageTrueAttackDamage(self.parent) - return damage with green bonus damage
			self.parent._base_damage = math.floor((self.parent:GetBaseDamageMin() + self.parent:GetBaseDamageMax()) / 2)
		end

		local h_mod, d_mod, a_mod = unpack(SummonsRegistry:GetSummonMultipliers(self.parent:GetUnitName()))
		local base_max_health = self.parent:GetBaseMaxHealth()
		local hp_multiplier, damage_multiplier = kv.summon_health, kv.summon_damage

		if self.parent:HasModifier("modifier_chen_zealot_buff") then
			local chen_talent_fix = base_max_health / self.parent._base_health
			hp_multiplier = hp_multiplier * chen_talent_fix
			damage_multiplier = damage_multiplier * chen_talent_fix
		end

		local health_bonus = self.parent._base_health * hp_multiplier * (h_mod or 1)
		local new_base_health = base_max_health + health_bonus

		local new_health = self.parent._base_health + health_bonus
		local new_damage = self.parent._base_damage + self.parent._base_damage * damage_multiplier * (d_mod or 1)

		self.parent:SetBaseMaxHealth(new_base_health)
		self.parent:SetMaxHealth(new_health)
		self.parent:SetHealth(new_health)

		self.parent:SetBaseDamageMin(new_damage)
		self.parent:SetBaseDamageMax(new_damage)

		self.parent:CalculateGenericBonuses()
	end)
end