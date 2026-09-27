--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_feral_passive", "abilities/creeps_lane/npc_wolf_feral", LUA_MODIFIER_MOTION_NONE)

npc_wolf_feral = class({})

function npc_wolf_feral:GetIntrinsicModifierName()
	return "modifier_feral_passive"
end

modifier_feral_passive = class(mod_hidden)
function modifier_feral_passive:IsHidden()
	return self:GetStackCount() == 0
end
function modifier_feral_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.speed = self.ability:GetSpecialValueFor("speed")
	self.ability.armor = self.ability:GetSpecialValueFor("armor")
	self.ability.magic = self.ability:GetSpecialValueFor("magic")

	if not IsServer() then
		return
	end
	self.parent:AddDeathEvent(self, true)
end

function modifier_feral_passive:DeathEvent(params)
	if not IsServer() then
		return
	end
	if params.unit:GetTeamNumber() ~= self.parent:GetTeamNumber() then
		return
	end
	if
		params.unit:GetUnitName() == "npc_psi_blades_crystal"
		or params.unit:GetUnitName() == "npc_psi_blades_crystal_mini"
	then
		return
	end
	if (params.unit:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 1500 then
		return
	end

	self:IncrementStackCount()
end

function modifier_feral_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end

function modifier_feral_passive:GetModifierAttackSpeedBonus_Constant()
	return self.ability.speed * self:GetStackCount()
end

function modifier_feral_passive:GetModifierPhysicalArmorBonus()
	return self.ability.armor * self:GetStackCount()
end

function modifier_feral_passive:GetModifierMagicalResistanceBonus()
	return self.ability.magic * self:GetStackCount()
end

function modifier_feral_passive:GetModifierModelScale()
	return 10 * self:GetStackCount()
end

function modifier_feral_passive:OnTooltip()
	return self.ability.magic * self:GetStackCount()
end

function modifier_feral_passive:OnTooltip2()
	return self.ability.armor * self:GetStackCount()
end