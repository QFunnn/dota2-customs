--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local AURA_RADIUS = 1200
local BONUS_ATTACK_SPEED = 50
local BONUS_MOVESPEED_PCT = 50
local SPEED_PARTICLE = "particles/tt/speed_01.vpcf"
local AURA_MASTER_RANGE = 125
local AURA_CLIENT_RANGE = 75
--- 迅捷图腾 - 光环：1200 范围内友方单位获得 +50 攻击速度、+35% 移速
____exports.totem_swift = __TS__Class()
local totem_swift = ____exports.totem_swift
totem_swift.name = "totem_swift"
__TS__ClassExtends(totem_swift, MonsterAbility_CS)
function totem_swift.prototype.Precache(self, context)
	PrecacheResource("particle", SPEED_PARTICLE, context)
end
function totem_swift.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function totem_swift.prototype.GetIntrinsicModifierName(self)
	return "modifier_totem_swift_aura"
end
totem_swift = __TS__DecorateLegacy({ registerAbility(nil) }, totem_swift)
____exports.totem_swift = totem_swift
--- 光环提供者
____exports.modifier_totem_swift_aura = __TS__Class()
local modifier_totem_swift_aura = ____exports.modifier_totem_swift_aura
modifier_totem_swift_aura.name = "modifier_totem_swift_aura"
__TS__ClassExtends(modifier_totem_swift_aura, BaseModifier_CS)
function modifier_totem_swift_aura.prototype.GetModifierAura(self)
	return "modifier_totem_swift_effect"
end
function modifier_totem_swift_aura.prototype.GetAuraRadius(self)
	return AURA_RADIUS
end
function modifier_totem_swift_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_totem_swift_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_totem_swift_aura.prototype.GetAuraEntityReject(self, unit)
	return unit == self:GetParent()
end
function modifier_totem_swift_aura.prototype.IsAura(self)
	return true
end
function modifier_totem_swift_aura.prototype.IsHidden(self)
	return true
end
function modifier_totem_swift_aura.prototype.IsPurgable(self)
	return false
end
function modifier_totem_swift_aura.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:SetAngles(0, 270, 0)
	parent:EmitSound("Hero_Bloodseeker.Thirst.Cast")
	self._pfx = ParticleManager:CreateParticle(SPEED_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(self._pfx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self._pfx, 1, Vector(AURA_MASTER_RANGE, 0, 0))
end
function modifier_totem_swift_aura.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._pfx ~= nil then
		ParticleManager:DestroyParticle(self._pfx, false)
		ParticleManager:ReleaseParticleIndex(self._pfx)
	end
end
modifier_totem_swift_aura =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_totem_swift_aura") }, modifier_totem_swift_aura)
____exports.modifier_totem_swift_aura = modifier_totem_swift_aura
--- 光环效果 buff：+30 攻击速度、+30 移速
____exports.modifier_totem_swift_effect = __TS__Class()
local modifier_totem_swift_effect = ____exports.modifier_totem_swift_effect
modifier_totem_swift_effect.name = "modifier_totem_swift_effect"
__TS__ClassExtends(modifier_totem_swift_effect, BaseModifier_CS)
function modifier_totem_swift_effect.prototype.IsHidden(self)
	return false
end
function modifier_totem_swift_effect.prototype.IsPurgable(self)
	return true
end
function modifier_totem_swift_effect.prototype.IsDebuff(self)
	return false
end
function modifier_totem_swift_effect.prototype.GetTexture(self)
	return "bloodseeker_bloodrage"
end
function modifier_totem_swift_effect.prototype.GetAttributeBonus(self)
	return { attack_speed = BONUS_ATTACK_SPEED, bonus_movespeed_pct = BONUS_MOVESPEED_PCT }
end
function modifier_totem_swift_effect.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self._pfx = ParticleManager:CreateParticle(SPEED_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(self._pfx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self._pfx, 1, Vector(AURA_CLIENT_RANGE, 0, 0))
end
function modifier_totem_swift_effect.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._pfx ~= nil then
		ParticleManager:DestroyParticle(self._pfx, false)
		ParticleManager:ReleaseParticleIndex(self._pfx)
	end
end
modifier_totem_swift_effect =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_totem_swift_effect") }, modifier_totem_swift_effect)
____exports.modifier_totem_swift_effect = modifier_totem_swift_effect
return ____exports