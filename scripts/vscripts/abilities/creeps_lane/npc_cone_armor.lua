--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_cone_armor", "abilities/creeps_lane/npc_cone_armor", LUA_MODIFIER_MOTION_NONE)

npc_cone_armor = class({})

function npc_cone_armor:Precache(context)
	PrecacheResource("particle", "particles/items3_fx/star_emblem_friend_shield.vpcf", context)
end

function npc_cone_armor:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.armor = self:GetLevelSpecialValueFor("armor", 1)
	self.speed = self:GetLevelSpecialValueFor("speed", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

function npc_cone_armor:OnSpellStart()
	self.caster:EmitSound("UI.Generic_shield")
	self.caster:AddNewModifier(self.caster, self, "modifier_cone_armor", { duration = self.duration })
end

modifier_cone_armor = class(mod_visible)
function modifier_cone_armor:IsPurgable()
	return true
end
function modifier_cone_armor:GetTexture()
	return "pangolier_shield_crash"
end
function modifier_cone_armor:GetEffectName()
	return "particles/items3_fx/star_emblem_friend_shield.vpcf"
end
function modifier_cone_armor:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_cone_armor:OnCreated()
	self.ability = self:GetAbility()

	self.armor = -self.ability.armor
	self.speed = self.ability.speed
end

function modifier_cone_armor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_cone_armor:GetModifierIncomingDamage_Percentage()
	return self.armor
end

function modifier_cone_armor:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end