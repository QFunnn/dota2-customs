--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


modifier_rule_only_cone = class(mod_hidden)
function modifier_rule_only_cone:RemoveOnDeath()
	return false
end
function modifier_rule_only_cone:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()

	local banned = {
		["npc_muerta_ursa"] = true,
		["npc_muerta_satyr"] = true,
		["npc_muerta_centaur"] = true,
		["npc_muerta_ogre"] = true,
		["npc_dota_neutral_warpine_raider"] = true,
	}

	if banned[self.parent:GetUnitName()] then
		self:Destroy()
		return
	end

	for i = 0, 10 do
		local ability = self.parent:GetAbilityByIndex(i)
		if ability then
			self.parent:RemoveAbility(ability:GetName())
		end
	end

	self.parent:AddAbility("neutral_cone_armor")

	self.parent:SetBaseMaxHealth(1400)
	self.parent:SetMaxHealth(1400)
	self.parent:SetHealth(self.parent:GetMaxHealth())
	self.parent:SetPhysicalArmorBaseValue(4)
	self.parent:SetBaseMagicalResistanceValue(25)
	self.parent:SetBaseDamageMax(70)
	self.parent:SetBaseDamageMin(70)
	self.parent:SetMaximumGoldBounty(63 * 0.8)
	self.parent:SetMinimumGoldBounty(63 * 0.8)
	self.parent:SetBaseMoveSpeed(310)
	self.parent:SetDeathXP(150 * 0.7)
	self.parent:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
	BluePoints[self.parent:GetUnitName()] = 11
end

function modifier_rule_only_cone:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BASE_OVERRIDE,
	}
end

function modifier_rule_only_cone:GetModifierAttackRangeOverride()
	return 128
end

function modifier_rule_only_cone:GetModifierModelChange()
	return "models/creeps/pine_cone/pine_cone.vmdl"
end