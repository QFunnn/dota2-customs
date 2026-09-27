--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


modifier_waveupgrade_boss = class(mod_hidden)
function modifier_waveupgrade_boss:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.wave = table.wave
	self.pure = 0
	self.speed = 0

	local health = 1800
	local damage = 80
	local gold = 250
	local exp = 250
	local magic = 35
	local armor = 5

	if self.wave ~= 1 then
		health = 60000
		damage = 450
		gold = 1000
		exp = 3000
		magic = -90
		armor = 12
		self.pure = 65
		self.speed = 130
	end

	if self.parent.host_team then
		local ids = dota1x6:FindPlayers(self.parent.host_team)
		if ids and #ids == 2 then
			health = health * creeps_team_health
			damage = damage * creeps_team_damage
		end
	end

	health = math.floor(health)

	self.parent:SetBaseMaxHealth(health)
	self.parent:SetMaxHealth(health)
	self.parent:SetHealth(health)
	self.parent:SetBaseDamageMin(damage)
	self.parent:SetBaseDamageMax(damage)
	self.parent:SetMinimumGoldBounty(gold)
	self.parent:SetMaximumGoldBounty(gold)
	self.parent:SetDeathXP(exp)
	self.parent:SetBaseMagicalResistanceValue(magic)
	self.parent:SetPhysicalArmorBaseValue(armor)

	self:SetStackCount(self.wave)
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end

function modifier_waveupgrade_boss:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
end

function modifier_waveupgrade_boss:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_waveupgrade_boss:NoDamage(attacker)
	if not IsServer() then
		return
	end
	if not attacker then
		return 0
	end
	if (attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 2000 then
		return 1
	end
	return 0
end

function modifier_waveupgrade_boss:GetAbsoluteNoDamagePhysical(params)
	return self:NoDamage(params.attacker)
end

function modifier_waveupgrade_boss:GetAbsoluteNoDamageMagical(params)
	return self:NoDamage(params.attacker)
end

function modifier_waveupgrade_boss:GetAbsoluteNoDamagePure(params)
	return self:NoDamage(params.attacker)
end

function modifier_waveupgrade_boss:GetModifierIncomingDamage_Percentage(params)
	if params.attacker and params.attacker:IsBuilding() then
		return -40
	end
	if params.damage_type ~= DAMAGE_TYPE_PURE then
		return
	end
	return self.pure
end

function modifier_waveupgrade_boss:GetModifierTotalDamageOutgoing_Percentage(params)
	if params.attacker ~= self.parent then
		return
	end
	if not params.target then
		return
	end
	if not params.target:IsBuilding() then
		return
	end
	return self.wave == 1 and 150 or -20
end

function modifier_waveupgrade_boss:AddCustomTransmitterData()
	return {
		speed = self.speed,
	}
end

function modifier_waveupgrade_boss:HandleCustomTransmitterData(data)
	self.speed = data.speed
end