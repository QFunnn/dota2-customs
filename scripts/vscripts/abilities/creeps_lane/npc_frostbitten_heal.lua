--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_frostbitten_heal", "abilities/creeps_lane/npc_frostbitten_heal", LUA_MODIFIER_MOTION_NONE)

npc_frostbitten_heal = class({})

function npc_frostbitten_heal:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_buff.vpcf", context)
end

function npc_frostbitten_heal:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.heal = self:GetLevelSpecialValueFor("heal", 1)
end

function npc_frostbitten_heal:OnSpellStart()
	self:GetCursorTarget():AddNewModifier(self.caster, self, "modifier_frostbitten_heal", { duration = self.duration })
end

modifier_frostbitten_heal = class(mod_visible)
function modifier_frostbitten_heal:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
end

function modifier_frostbitten_heal:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.heal = self.ability.heal

	if not IsServer() then
		return
	end
	self.parent:EmitSound("Creep.Wyvern_heal")
	self.parent:GenericParticle(
		"particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_buff.vpcf",
		self,
		false,
		{ 1, 2 }
	)
end

function modifier_frostbitten_heal:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	}
end

function modifier_frostbitten_heal:GetModifierHealthRegenPercentage()
	return self.heal
end

function modifier_frostbitten_heal:GetAbsoluteNoDamagePhysical()
	return 1
end