--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@class modifier_undying_tombstone_zombie:CDOTA_Modifier_Lua
modifier_undying_tombstone_zombie = class({})

function modifier_undying_tombstone_zombie:IsHidden() return true end
function modifier_undying_tombstone_zombie:IsPurgable() return false end

function modifier_undying_tombstone_zombie:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_AVOID_DAMAGE,
		MODIFIER_PROPERTY_DISABLE_HEALING,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_undying_tombstone_zombie:OnCreated(kv)
	self.parent = self:GetParent()

	self.deathstrike = self.parent:FindAbilityByName("undying_tombstone_zombie_deathstrike")
	self.health_threshold = self.deathstrike:GetSpecialValueFor("health_threshold_pct")
	self.bonus_move_speed = self.deathstrike:GetSpecialValueFor("bonus_move_speed")
	self.bonus_attack_speed = self.deathstrike:GetSpecialValueFor("bonus_attack_speed")

	self:StartIntervalThink(0.2)

	if IsClient() then return end

	self.parent.tombstone_stacks = {}
	self.parent.timed_tombstone_stacks = {}
end

function modifier_undying_tombstone_zombie:OnDestroy()
	if IsServer() then

		if self.parent:IsAlive() then
			self.parent:ForceKill(false)
		end

		Timers:CreateTimer(4, function()
			if IsValidEntity(self.parent) then
				self.parent:RemoveSelf()
			end
		end)
	end
end

function modifier_undying_tombstone_zombie:OnIntervalThink()
	self.deathlust_activated = IsValidEntity(self.target) and self.target:GetHealthPercent() < self.health_threshold

	if IsClient() then return end

	if not IsValidEntity(self.target) or not self.target:IsAlive() or self.target:IsInvisible() then
		self.parent:ForceKill(false)
	end
end

function modifier_undying_tombstone_zombie:GetUpgradeStacks()
	return math.floor((self.parent:GetHealth() - 2) / 2)
end

function modifier_undying_tombstone_zombie:GetModifierAttackSpeedBonus_Constant()
	local speed_bonus = self:GetUpgradeStacks() * 100

	if self.deathlust_activated then
		speed_bonus = speed_bonus + self.bonus_attack_speed
	end

	return speed_bonus
end

function modifier_undying_tombstone_zombie:GetModifierMoveSpeedBonus_Percentage()
	if self.deathlust_activated then
		return self.bonus_move_speed
	end
end

function modifier_undying_tombstone_zombie:GetModifierModelScale()
	return self:GetUpgradeStacks() * 10
end

function modifier_undying_tombstone_zombie:GetModifierAvoidDamage(params)

	if params.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then 
		return 1
	end

	local damage = params.attacker:IsRealHero() and 2 or 1

	-- Spend stacks evenly by each tomb
	for i = 1, damage do
		local max_stacks_source
		local max_stacks = 0

		for source, stacks in pairs(self.parent.tombstone_stacks) do
			if stacks > max_stacks then
				max_stacks_source = source
				max_stacks = stacks
			end
		end

		if not max_stacks_source then break end
		self:SpendStack(max_stacks_source, 1)
	end

	self:RecalcHealth(params.attacker)

	return 1
end

function modifier_undying_tombstone_zombie:AddStack(source)
	self.parent.tombstone_stacks[source] = (self.parent.tombstone_stacks[source] or 0) + 2
	self:RecalcHealth()

	-- Shard stacks have 15 sec duration
	if source:IsRealHero() then
		local timer = Timers:CreateTimer(15, function()
			if not self:IsNull() then
				self:SpendStack(source, 2)
			end
		end)

		table.insert(self.parent.timed_tombstone_stacks, timer)
	end
end

function modifier_undying_tombstone_zombie:SpendStack(source, count)
	local stacks = self.parent.tombstone_stacks
	stacks[source] = stacks[source] - count

	-- Remove shard stack timer if stack was removed
	if source:IsRealHero() then
		if stacks[source] <= 0 then
			stacks[source] = nil

			for _, timer in pairs(self.parent.timed_tombstone_stacks) do
				Timers:RemoveTimer(timer)
			end
			self.parent.timed_tombstone_stacks = {}

		elseif stacks[source] % 2 == 0 then
			Timers:RemoveTimer(table.remove(self.parent.timed_tombstone_stacks, 1))
		end
	end

	self:RecalcHealth()
end

function modifier_undying_tombstone_zombie:RemoveStacks(source)
	self.parent.tombstone_stacks[source] = nil
	self:RecalcHealth()
end

function modifier_undying_tombstone_zombie:RecalcHealth(attacker)
	local hp = 0
	
	for _, stacks in pairs(self.parent.tombstone_stacks) do
		hp = hp + stacks
	end

	if hp > 0 then
		if hp > self.parent:GetMaxHealth() then
			self.parent:SetBaseMaxHealth(hp)
			self.parent:SetMaxHealth(hp)
		end

		self.parent:SetHealth(hp)
	elseif attacker then
		self.parent:Kill(nil, attacker)
	else
		self.parent:ForceKill(false)
	end
end

function modifier_undying_tombstone_zombie:GetDisableHealing()
	return 1
end