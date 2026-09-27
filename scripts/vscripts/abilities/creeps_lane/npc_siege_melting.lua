--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_siege_melting", "abilities/creeps_lane/npc_siege_melting", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_siege_armor", "abilities/creeps_lane/npc_siege_melting", LUA_MODIFIER_MOTION_NONE)

npc_siege_melting = class({})

function npc_siege_melting:Precache(context)
	PrecacheResource("particle", "particles/general/generic_armor_reduction.vpcf", context)
end

function npc_siege_melting:GetIntrinsicModifierName()
	return "modifier_siege_melting"
end

modifier_siege_melting = class(mod_hidden)
function modifier_siege_melting:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.armor = self.ability:GetSpecialValueFor("armor")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.max = self.ability:GetSpecialValueFor("max")

	if not IsServer() then
		return
	end
	self.parent:AddAttackEvent_out(self, true)
end

function modifier_siege_melting:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end

	params.target:EmitSound("Item_Desolator.Target")
	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_siege_armor",
		{ duration = self.ability.duration }
	)
end

modifier_siege_armor = class(mod_visible)
function modifier_siege_armor:GetEffectName()
	return "particles/general/generic_armor_reduction.vpcf"
end
function modifier_siege_armor:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_siege_armor:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.armor = -self.ability.armor
	self.max = self.ability.max

	if not IsServer() then
		return
	end
	self.parent:EmitSound("Item.StarEmblem.Enemy")
	self:OnRefresh()
end

function modifier_siege_armor:OnRefresh()
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end
	self:IncrementStackCount()
end

function modifier_siege_armor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_siege_armor:GetModifierPhysicalArmorBonus()
	return self.armor * self:GetStackCount()
end

function modifier_siege_armor:OnTooltip()
	return self.armor * self:GetStackCount()
end