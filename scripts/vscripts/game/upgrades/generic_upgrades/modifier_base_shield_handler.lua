--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_base_shield_handler = modifier_base_shield_handler or class(modifier_base_generic_upgrade)



function modifier_base_shield_handler:IsHidden() return false end
function modifier_base_shield_handler:DestroyOnExpire() return false end


function modifier_base_shield_handler:OnCreated()
	self.parent = self:GetParent()

	self.shield_capacity = self:CalculateBonusPerUpgrade("shield_capacity")

	self.combat_cd = self:GetUpgradeValueFor("fixed_combat_cd")
	self.tickrate = self:GetUpgradeValueFor("fixed_tickrate")
	self.regeneration_rate = self:GetUpgradeValueFor("fixed_regeneration_rate") * self.tickrate / 100

	self.current_cd = 0

	self.current_shield = self.shield_capacity

	if IsServer() then
		self:SetHasCustomTransmitterData(true)
		self:StartIntervalThink(self.tickrate)
		self:OnIntervalThink()
	end
end


function modifier_base_shield_handler:OnRefresh()
	local at_max_capacity = math.abs(self.current_shield - self.shield_capacity) < 1
	local new_capacity = self:CalculateBonusPerUpgrade("shield_capacity")
	self.shield_capacity = new_capacity

	if not IsServer() then return end

	-- if capacity was extended while we are (near) max shield, extend current as well
	-- near because one of them may become float from damage taken
	if at_max_capacity then
		self.current_shield = new_capacity

		self:SendBuffRefreshToClients()
	end
end


function modifier_base_shield_handler:OnIntervalThink()
	if not IsValidEntity(self.parent) then return end

	if self.parent:HasModifier("modifier_fountain_rejuvenation_effect_lua") and self.current_shield < self.shield_capacity then
		return self:ResetShields()
	end

	if self.current_cd <= 0 and self.current_shield < self.shield_capacity then
		local regenerated_shield = self.regeneration_rate * self.shield_capacity
		self.current_shield = math.min(self.current_shield + regenerated_shield, self.shield_capacity)
		self:SendBuffRefreshToClients()
	end

	self.current_cd = math.max(self.current_cd - self.tickrate, 0)
end


function modifier_base_shield_handler:ResetShields()
	local capacity = self:CalculateBonusPerUpgrade("shield_capacity")
	self.shield_capacity = capacity
	self.current_shield = capacity
	self.current_cd = 0
	self:SetDuration(0, false)
	self:SendBuffRefreshToClients()
end


function modifier_base_shield_handler:HandleShieldDamage(event)
	if not IsServer() then
		if event.report_max then return self.shield_capacity end
		return self.current_shield
	end
	if event.damage <= 0.5 then return end

	if self.current_shield >= event.damage then
		self.current_shield = self.current_shield - event.damage
		-- how bad is this? unsure! wouldn't want to do that in chc for example, but ot3 is much slower
		-- better to do it with stack counts if possible, here stack count is used for upgrade level already
		self:SetDuration(self.combat_cd, false)
		self.current_cd = self.combat_cd
		self:SendBuffRefreshToClients()
		return -event.damage
	else
		self:SetDuration(self.combat_cd, false)
		self.current_cd = self.combat_cd
		self.current_shield = 0
		self:SendBuffRefreshToClients()
		return -self.current_shield
	end
end


function modifier_base_shield_handler:AddCustomTransmitterData()
	return {
		current_shield = self.current_shield
	}
end


function modifier_base_shield_handler:HandleCustomTransmitterData(data)
	self.current_shield = data.current_shield
end