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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____wearable_aura_effect = require("shared.wearable_aura_effect")
local getWearableAuraChildParticlePaths = ____wearable_aura_effect.getWearableAuraChildParticlePaths
local getWearableAuraOwnerParticlePath = ____wearable_aura_effect.getWearableAuraOwnerParticlePath
local WEARABLE_AURA_RADIUS = 600
local WEARABLE_AURA_DURATION = 0.1
--- 通用饰品光环父 modifier：只负责原生 Aura 的目标筛选与生命周期。
local BaseWearableAuraModifier = __TS__Class()
BaseWearableAuraModifier.name = "BaseWearableAuraModifier"
__TS__ClassExtends(BaseWearableAuraModifier, BaseModifier_CS)
function BaseWearableAuraModifier.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local particleId = ParticleManager:CreateParticle(self:getOwnerParticlePath(), PATTACH_ABSORIGIN_FOLLOW, parent)
	for ____, ____value in ipairs(self:getOwnerParticleControlPoints()) do
		local controlPoint = ____value[1]
		local attachType = ____value[2]
		ParticleManager:SetParticleControlEnt(
			particleId,
			controlPoint,
			parent,
			attachType,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			true
		)
	end
	self.ownerParticleId = particleId
	print(
		(
			(
				(
					(
						(("[WearableAura] 主特效已创建 modifier=" .. self:GetName()) .. " hero=")
						.. parent:GetUnitName()
					) .. " entity="
				) .. tostring(parent:entindex())
			) .. " particleId="
		) .. tostring(particleId)
	)
end
function BaseWearableAuraModifier.prototype.OnDestroy(self)
	if IsServer() then
		print(
			(("[DEBUG-aura-7f1c] 父Modifier销毁 modifier=" .. self:GetName()) .. " hero=")
				.. tostring(self:GetParent():entindex())
		)
	end
	if not IsServer() or self.ownerParticleId == nil then
		return
	end
	ParticleManager:DestroyParticle(self.ownerParticleId, false)
	ParticleManager:ReleaseParticleIndex(self.ownerParticleId)
	self.ownerParticleId = nil
end
function BaseWearableAuraModifier.prototype.IsAura(self)
	return IsValidAlive(nil, self:GetParent())
end
function BaseWearableAuraModifier.prototype.IsHidden(self)
	return true
end
function BaseWearableAuraModifier.prototype.IsPurgable(self)
	return false
end
function BaseWearableAuraModifier.prototype.RemoveOnDeath(self)
	return false
end
function BaseWearableAuraModifier.prototype.GetModifierAura(self)
	return self:getAuraEffectModifierName()
end
function BaseWearableAuraModifier.prototype.GetAuraRadius(self)
	return WEARABLE_AURA_RADIUS
end
function BaseWearableAuraModifier.prototype.GetAuraDuration(self)
	return WEARABLE_AURA_DURATION
end
function BaseWearableAuraModifier.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function BaseWearableAuraModifier.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HERO
end
function BaseWearableAuraModifier.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function BaseWearableAuraModifier.prototype.GetAuraEntityReject(self, target)
	return not IsValidAlive(nil, target) or not target:IsHero()
end
--- 通用饰品光环子效果基类：维持三段原生纹章粒子并提供属性入口。
local BaseWearableAuraEffectModifier = __TS__Class()
BaseWearableAuraEffectModifier.name = "BaseWearableAuraEffectModifier"
__TS__ClassExtends(BaseWearableAuraEffectModifier, BaseModifier_CS)
function BaseWearableAuraEffectModifier.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.particleIds = {}
end
function BaseWearableAuraEffectModifier.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local isAuraOwner = caster ~= nil and caster:entindex() == parent:entindex()
	print(
		(
			(
				(
					(
						(("[DEBUG-aura-7f1c] 子Modifier创建 modifier=" .. self:GetName()) .. " hero=")
						.. tostring(parent:entindex())
					) .. " caster="
				) .. tostring(caster and caster:entindex() or -1)
			) .. " owner="
		) .. (isAuraOwner and "1" or "0")
	)
	if isAuraOwner then
		return
	end
	for ____, particlePath in ipairs(self:getParticlePaths()) do
		local particleId = ParticleManager:CreateParticle(particlePath, PATTACH_ABSORIGIN_FOLLOW, parent)
		local ____self_particleIds_2 = self.particleIds
		____self_particleIds_2[#____self_particleIds_2 + 1] = particleId
	end
end
function BaseWearableAuraEffectModifier.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	for ____, particleId in ipairs(self.particleIds) do
		ParticleManager:DestroyParticle(particleId, false)
		ParticleManager:ReleaseParticleIndex(particleId)
	end
	self.particleIds = {}
end
function BaseWearableAuraEffectModifier.prototype.IsDebuff(self)
	return false
end
function BaseWearableAuraEffectModifier.prototype.IsPurgable(self)
	return false
end
____exports.modifier_wearable_aura_1 = __TS__Class()
local modifier_wearable_aura_1 = ____exports.modifier_wearable_aura_1
modifier_wearable_aura_1.name = "modifier_wearable_aura_1"
__TS__ClassExtends(modifier_wearable_aura_1, BaseWearableAuraModifier)
function modifier_wearable_aura_1.prototype.getAuraEffectModifierName(self)
	return ____exports.modifier_wearable_aura_1_effect.name
end
function modifier_wearable_aura_1.prototype.getOwnerParticlePath(self)
	return getWearableAuraOwnerParticlePath(nil, "item_U001")
end
function modifier_wearable_aura_1.prototype.getOwnerParticleControlPoints(self)
	return { { 0, PATTACH_ABSORIGIN_FOLLOW }, { 2, PATTACH_ABSORIGIN_FOLLOW } }
end
modifier_wearable_aura_1 =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_wearable_aura_1") }, modifier_wearable_aura_1)
____exports.modifier_wearable_aura_1 = modifier_wearable_aura_1
____exports.modifier_wearable_aura_1_effect = __TS__Class()
local modifier_wearable_aura_1_effect = ____exports.modifier_wearable_aura_1_effect
modifier_wearable_aura_1_effect.name = "modifier_wearable_aura_1_effect"
__TS__ClassExtends(modifier_wearable_aura_1_effect, BaseWearableAuraEffectModifier)
function modifier_wearable_aura_1_effect.GetLocalizationCN(self)
	return { name = "沉没回蓝光环", description = "每秒恢复 1%% 最大魔法值。" }
end
function modifier_wearable_aura_1_effect.prototype.GetTexture(self)
	return "crystal_maiden_brilliance_aura"
end
function modifier_wearable_aura_1_effect.prototype.getParticlePaths(self)
	return getWearableAuraChildParticlePaths(nil, "item_U001")
end
function modifier_wearable_aura_1_effect.prototype.GetAttributeBonus(self)
	return { mana_regen_pct = 1 }
end
modifier_wearable_aura_1_effect =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_wearable_aura_1_effect") }, modifier_wearable_aura_1_effect)
____exports.modifier_wearable_aura_1_effect = modifier_wearable_aura_1_effect
____exports.modifier_wearable_aura_2 = __TS__Class()
local modifier_wearable_aura_2 = ____exports.modifier_wearable_aura_2
modifier_wearable_aura_2.name = "modifier_wearable_aura_2"
__TS__ClassExtends(modifier_wearable_aura_2, BaseWearableAuraModifier)
function modifier_wearable_aura_2.prototype.getAuraEffectModifierName(self)
	return ____exports.modifier_wearable_aura_2_effect.name
end
function modifier_wearable_aura_2.prototype.getOwnerParticlePath(self)
	return getWearableAuraOwnerParticlePath(nil, "item_U002")
end
function modifier_wearable_aura_2.prototype.getOwnerParticleControlPoints(self)
	return { { 0, PATTACH_ABSORIGIN_FOLLOW }, { 2, PATTACH_ABSORIGIN_FOLLOW }, { 6, PATTACH_ABSORIGIN_FOLLOW } }
end
modifier_wearable_aura_2 =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_wearable_aura_2") }, modifier_wearable_aura_2)
____exports.modifier_wearable_aura_2 = modifier_wearable_aura_2
____exports.modifier_wearable_aura_2_effect = __TS__Class()
local modifier_wearable_aura_2_effect = ____exports.modifier_wearable_aura_2_effect
modifier_wearable_aura_2_effect.name = "modifier_wearable_aura_2_effect"
__TS__ClassExtends(modifier_wearable_aura_2_effect, BaseWearableAuraEffectModifier)
function modifier_wearable_aura_2_effect.GetLocalizationCN(self)
	return { name = "神圣护甲光环", description = "护甲提高 5%%。" }
end
function modifier_wearable_aura_2_effect.prototype.GetTexture(self)
	return "dragon_knight_dragon_blood"
end
function modifier_wearable_aura_2_effect.prototype.getParticlePaths(self)
	return getWearableAuraChildParticlePaths(nil, "item_U002")
end
function modifier_wearable_aura_2_effect.prototype.GetAttributeBonus(self)
	return { base_armor_pct = 5 }
end
modifier_wearable_aura_2_effect =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_wearable_aura_2_effect") }, modifier_wearable_aura_2_effect)
____exports.modifier_wearable_aura_2_effect = modifier_wearable_aura_2_effect
____exports.modifier_wearable_aura_3 = __TS__Class()
local modifier_wearable_aura_3 = ____exports.modifier_wearable_aura_3
modifier_wearable_aura_3.name = "modifier_wearable_aura_3"
__TS__ClassExtends(modifier_wearable_aura_3, BaseWearableAuraModifier)
function modifier_wearable_aura_3.prototype.getAuraEffectModifierName(self)
	return ____exports.modifier_wearable_aura_3_effect.name
end
function modifier_wearable_aura_3.prototype.getOwnerParticlePath(self)
	return getWearableAuraOwnerParticlePath(nil, "item_U003")
end
function modifier_wearable_aura_3.prototype.getOwnerParticleControlPoints(self)
	return { { 0, PATTACH_ABSORIGIN_FOLLOW }, { 2, PATTACH_ABSORIGIN_FOLLOW }, { 3, PATTACH_ABSORIGIN_FOLLOW } }
end
modifier_wearable_aura_3 =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_wearable_aura_3") }, modifier_wearable_aura_3)
____exports.modifier_wearable_aura_3 = modifier_wearable_aura_3
____exports.modifier_wearable_aura_3_effect = __TS__Class()
local modifier_wearable_aura_3_effect = ____exports.modifier_wearable_aura_3_effect
modifier_wearable_aura_3_effect.name = "modifier_wearable_aura_3_effect"
__TS__ClassExtends(modifier_wearable_aura_3_effect, BaseWearableAuraEffectModifier)
function modifier_wearable_aura_3_effect.GetLocalizationCN(self)
	return { name = "蔓生暴击光环", description = "全域暴击提高 3%%。" }
end
function modifier_wearable_aura_3_effect.prototype.GetTexture(self)
	return "phantom_assassin_coup_de_grace"
end
function modifier_wearable_aura_3_effect.prototype.getParticlePaths(self)
	return getWearableAuraChildParticlePaths(nil, "item_U003")
end
function modifier_wearable_aura_3_effect.prototype.GetAttributeBonus(self)
	return { omni_crit_chance_pct = 3 }
end
modifier_wearable_aura_3_effect =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_wearable_aura_3_effect") }, modifier_wearable_aura_3_effect)
____exports.modifier_wearable_aura_3_effect = modifier_wearable_aura_3_effect
____exports.modifier_wearable_aura_4 = __TS__Class()
local modifier_wearable_aura_4 = ____exports.modifier_wearable_aura_4
modifier_wearable_aura_4.name = "modifier_wearable_aura_4"
__TS__ClassExtends(modifier_wearable_aura_4, BaseWearableAuraModifier)
function modifier_wearable_aura_4.prototype.getAuraEffectModifierName(self)
	return ____exports.modifier_wearable_aura_4_effect.name
end
function modifier_wearable_aura_4.prototype.getOwnerParticlePath(self)
	return getWearableAuraOwnerParticlePath(nil, "item_U004")
end
function modifier_wearable_aura_4.prototype.getOwnerParticleControlPoints(self)
	return { { 0, PATTACH_ABSORIGIN_FOLLOW }, { 2, PATTACH_ABSORIGIN_FOLLOW }, { 3, PATTACH_ABSORIGIN_FOLLOW } }
end
modifier_wearable_aura_4 =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_wearable_aura_4") }, modifier_wearable_aura_4)
____exports.modifier_wearable_aura_4 = modifier_wearable_aura_4
____exports.modifier_wearable_aura_4_effect = __TS__Class()
local modifier_wearable_aura_4_effect = ____exports.modifier_wearable_aura_4_effect
modifier_wearable_aura_4_effect.name = "modifier_wearable_aura_4_effect"
__TS__ClassExtends(modifier_wearable_aura_4_effect, BaseWearableAuraEffectModifier)
function modifier_wearable_aura_4_effect.GetLocalizationCN(self)
	return { name = "晶阶吸血光环", description = "全域吸血提高 3%%。" }
end
function modifier_wearable_aura_4_effect.prototype.GetTexture(self)
	return "life_stealer_feast"
end
function modifier_wearable_aura_4_effect.prototype.getParticlePaths(self)
	return getWearableAuraChildParticlePaths(nil, "item_U004")
end
function modifier_wearable_aura_4_effect.prototype.GetAttributeBonus(self)
	return { omni_lifesteal_pct = 3 }
end
modifier_wearable_aura_4_effect =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_wearable_aura_4_effect") }, modifier_wearable_aura_4_effect)
____exports.modifier_wearable_aura_4_effect = modifier_wearable_aura_4_effect
return ____exports