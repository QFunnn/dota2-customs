--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


modifier_waveupgrade = class(mod_hidden)
function modifier_waveupgrade:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.host_team = self.parent.host_team
	self.any_team_damage = self.parent.any_team_damage
	self.cannot_miss = self.parent.mkb == 1
	self.amp = table.amp
	self.speed = table.speed
	self.pure = table.pure

	if not self.host_team then
		return
	end

	for i = 0, math.max(self.parent:GetAbilityCount(), 4) - 1 do
		local ability = self.parent:GetAbilityByIndex(i)
		if ability then
			ability:SetLevel(1)
		end
	end

	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end

function modifier_waveupgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
end

function modifier_waveupgrade:CheckState()
	if not self.cannot_miss then
		return
	end
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

function modifier_waveupgrade:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_waveupgrade:GetModifierSpellAmplify_Percentage()
	if not IsServer() then
		return
	end
	return self.amp
end

function modifier_waveupgrade:NoDamage(attacker)
	if not IsServer() then
		return
	end
	if not attacker then
		return 0
	end
	if (attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 2000 then
		return 1
	end
	if self.any_team_damage then
		return 0
	end
	if not self.host_team then
		return 0
	end
	if attacker:GetTeamNumber() == self.host_team then
		return 0
	end
	return 1
end

function modifier_waveupgrade:GetAbsoluteNoDamagePhysical(params)
	return self:NoDamage(params.attacker)
end

function modifier_waveupgrade:GetAbsoluteNoDamageMagical(params)
	return self:NoDamage(params.attacker)
end

function modifier_waveupgrade:GetAbsoluteNoDamagePure(params)
	return self:NoDamage(params.attacker)
end

function modifier_waveupgrade:GetModifierIncomingDamage_Percentage(params)
	if params.damage_type ~= DAMAGE_TYPE_PURE then
		return
	end
	return self.pure
end

function modifier_waveupgrade:GetModifierTotalDamageOutgoing_Percentage(params)
	if params.attacker ~= self.parent then
		return
	end
	if not params.target then
		return
	end
	if not params.target:IsBuilding() then
		return
	end
	return -65
end

function modifier_waveupgrade:AddCustomTransmitterData()
	return {
		speed = self.speed,
	}
end

function modifier_waveupgrade:HandleCustomTransmitterData(data)
	self.speed = data.speed
end