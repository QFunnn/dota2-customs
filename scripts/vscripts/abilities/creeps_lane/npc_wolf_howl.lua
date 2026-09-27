--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wolf_howl_buff", "abilities/creeps_lane/npc_wolf_howl", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wolf_howl", "abilities/creeps_lane/npc_wolf_howl", LUA_MODIFIER_MOTION_NONE)

npc_wolf_howl = class({})

function npc_wolf_howl:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_lycan/lycan_howl_cast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_lone_druid/lone_druid_battle_cry_overhead.vpcf", context)
end

function npc_wolf_howl:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.speed = self:GetLevelSpecialValueFor("speed", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

function npc_wolf_howl:GetChannelTime()
	return self.duration
end

function npc_wolf_howl:OnSpellStart()
	self.caster:AddNewModifier(self.caster, self, "modifier_wolf_howl", {})
end

function npc_wolf_howl:OnChannelFinish(bInterrupted)
	self.caster:RemoveModifierByName("modifier_wolf_howl")
end

modifier_wolf_howl = class(mod_hidden)
function modifier_wolf_howl:IsAura()
	return true
end
function modifier_wolf_howl:GetAuraDuration()
	return 0.1
end
function modifier_wolf_howl:GetAuraRadius()
	return self.ability.radius
end
function modifier_wolf_howl:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_wolf_howl:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_wolf_howl:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self:StartIntervalThink(2)
	self:OnIntervalThink()
end

function modifier_wolf_howl:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not self.parent:IsAlive() then
		return
	end

	self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.4)
	self.parent:EmitSound("Hero_Lycan.Howl")

	Timers:CreateTimer(0.4, function()
		if not IsValid(self.parent) or not self.parent:IsAlive() then
			return
		end

		local particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lycan/lycan_howl_cast.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			particle,
			1,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_mouth",
			self.parent:GetOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle)
	end)
end

function modifier_wolf_howl:GetModifierAura()
	return "modifier_wolf_howl_buff"
end

modifier_wolf_howl_buff = class(mod_visible)
function modifier_wolf_howl_buff:GetTexture()
	return "lycan_howl"
end
function modifier_wolf_howl_buff:GetEffectName()
	return "particles/units/heroes/hero_lone_druid/lone_druid_battle_cry_overhead.vpcf"
end
function modifier_wolf_howl_buff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_wolf_howl_buff:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.damage = self.ability.damage
	self.speed = self.ability.speed
end

function modifier_wolf_howl_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end

function modifier_wolf_howl_buff:GetModifierBaseDamageOutgoing_Percentage()
	return self.damage
end

function modifier_wolf_howl_buff:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end

function modifier_wolf_howl_buff:OnTooltip()
	return self.damage
end

function modifier_wolf_howl_buff:OnTooltip2()
	return self.speed
end