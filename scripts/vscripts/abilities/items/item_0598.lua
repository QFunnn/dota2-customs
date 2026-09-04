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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local LINK_CUSTOM_TAG = "item_0598_link"
____exports.item_0598 = __TS__Class()
local item_0598 = ____exports.item_0598
item_0598.name = "item_0598"
__TS__ClassExtends(item_0598, BaseItem_CS)
function item_0598.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0598_mutex.name
end
function item_0598.prototype.GetCastRange(self)
	return math.max(0, self:GetSpecialValueFor("ability_cast_range"))
end
function item_0598.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not IsValidAlive(nil, caster) or not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == caster:GetTeamNumber() then
		return
	end
	local ability_link_duration = math.max(0.5, self:GetSpecialValueFor("ability_link_duration"))
	target:AddNewModifier(caster, self, ____exports.modifier_item_0598_link.name, { duration = ability_link_duration })
	caster:AddNewModifier(caster, self, ____exports.modifier_item_0598_self.name, {
		duration = ability_link_duration,
		link_target_ent = target:entindex(),
	})
	caster:EmitSound("Hero_Grimstroke.SoulChain.Cast")
end
item_0598 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0598)
____exports.item_0598 = item_0598
--- 门禁常驻（隐藏·仅用于史诗/传说互斥）：与史诗下级 item_0628 同 key，传说 200 > 史诗 100。
____exports.modifier_item_0598_mutex = __TS__Class()
local modifier_item_0598_mutex = ____exports.modifier_item_0598_mutex
modifier_item_0598_mutex.name = "modifier_item_0598_mutex"
__TS__ClassExtends(modifier_item_0598_mutex, BaseModifier_CS)
function modifier_item_0598_mutex.prototype.IsHidden(self)
	return true
end
function modifier_item_0598_mutex.prototype.IsPurgable(self)
	return false
end
function modifier_item_0598_mutex.prototype.GetMutexKey(self)
	return "item_0598_mutex"
end
function modifier_item_0598_mutex.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0598" and 200 or 100
end
modifier_item_0598_mutex = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0598_mutex)
____exports.modifier_item_0598_mutex = modifier_item_0598_mutex
--- 【灵魂链接】（挂敌·可见 debuff）：纯标记——链接者的反弹物理伤害目标；真 debuff 喂诅咒计数生态。
____exports.modifier_item_0598_link = __TS__Class()
local modifier_item_0598_link = ____exports.modifier_item_0598_link
modifier_item_0598_link.name = "modifier_item_0598_link"
__TS__ClassExtends(modifier_item_0598_link, BaseModifier_CS)
function modifier_item_0598_link.GetLocalizationCN(self)
	return { name = "灵魂链接", description = "与施放者灵魂相连：成为其反弹物理伤害的目标。" }
end
function modifier_item_0598_link.prototype.IsHidden(self)
	return false
end
function modifier_item_0598_link.prototype.IsDebuff(self)
	return true
end
function modifier_item_0598_link.prototype.IsPurgable(self)
	return false
end
function modifier_item_0598_link.prototype.GetTexture(self)
	return "item_soul_ring"
end
function modifier_item_0598_link.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValid(nil, parent) or not IsValid(nil, caster) then
		return
	end
	self:PlayEffects1(caster)
	self:PlayEffects1(parent)
	self:PlayEffects2(caster, parent)
end
function modifier_item_0598_link.prototype.PlayEffects1(self, unit)
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_grimstroke/grimstroke_soulchain_debuff.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		unit
	)
	local origin = unit:GetAbsOrigin()
	ParticleManager:SetParticleControlEnt(particle, 0, unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", origin, true)
	ParticleManager:SetParticleControlEnt(particle, 1, unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", origin, true)
	ParticleManager:SetParticleControlEnt(particle, 2, unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", origin, true)
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_item_0598_link.prototype.PlayEffects2(self, start, ____end)
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_grimstroke/grimstroke_soulchain.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		start
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		start,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		start:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		____end,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		____end:GetAbsOrigin(),
		true
	)
	self:AddParticle(particle, false, false, -1, false, false)
end
modifier_item_0598_link = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0598_link)
____exports.modifier_item_0598_link = modifier_item_0598_link
--- 监听（挂自己·隐藏）：仅减免链接目标的伤害，并按本次实际伤害×自身护甲×reflect% 反伤。
____exports.modifier_item_0598_self = __TS__Class()
local modifier_item_0598_self = ____exports.modifier_item_0598_self
modifier_item_0598_self.name = "modifier_item_0598_self"
__TS__ClassExtends(modifier_item_0598_self, BaseModifier_CS)
function modifier_item_0598_self.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0598_self.prototype.IsHidden(self)
	return true
end
function modifier_item_0598_self.prototype.IsPurgable(self)
	return false
end
function modifier_item_0598_self.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.linkTargetEnt = params and params.link_target_ent
end
function modifier_item_0598_self.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.victim ~= parent then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____opt_2 = event.ctx.spec.source
	if (____opt_2 and ____opt_2.custom_tag) == LINK_CUSTOM_TAG then
		return
	end
	local ability_current_damage = self:GetCurrentPipeDamage(event.final)
	if ability_current_damage <= 0 then
		return
	end
	local ____temp_4
	if self.linkTargetEnt ~= nil then
		____temp_4 = EntIndexToHScript(self.linkTargetEnt)
	else
		____temp_4 = nil
	end
	local target = ____temp_4
	if
		not target
		or not IsValidAlive(nil, target)
		or not target:HasModifier(____exports.modifier_item_0598_link.name)
	then
		return
	end
	local ability_value_damage_reduction_pct = ability:GetSpecialValueFor("ability_value_damage_reduction_pct")
	local ____math_min_7 = math.min
	local ____math_max_6 = math.max
	local ____temp_5
	if ability_value_damage_reduction_pct > 0 then
		____temp_5 = ability_value_damage_reduction_pct
	else
		____temp_5 = ability:GetSpecialValueFor("ability_damage_reduction_pct")
	end
	local ability_damage_reduction_pct = ____math_min_7(100, ____math_max_6(0, ____temp_5))
	local ____temp_8
	if event.ctx.spec.attacker == target then
		____temp_8 = ability_damage_reduction_pct
	else
		____temp_8 = 0
	end
	local ability_applied_damage_reduction_pct = ____temp_8
	if ability_applied_damage_reduction_pct > 0 then
		local ____event_final_9, ____mul_10 = event.final, "mul"
		if ____event_final_9[____mul_10] == nil then
			____event_final_9[____mul_10] = {}
		end
		local ____event_final_mul_11 = event.final.mul
		____event_final_mul_11[#____event_final_mul_11 + 1] =
			{ value = 1 - ability_applied_damage_reduction_pct / 100, source = "item_0598:灵魂链接" }
	end
	local ability_value_reflect_armor_pct = ability:GetSpecialValueFor("ability_value_reflect_armor_pct")
	local ____math_max_13 = math.max
	local ____temp_12
	if ability_value_reflect_armor_pct > 0 then
		____temp_12 = ability_value_reflect_armor_pct
	else
		____temp_12 = ability:GetSpecialValueFor("ability_reflect_armor_pct")
	end
	local ability_reflect_armor_pct = ____math_max_13(0, ____temp_12)
	if ability_reflect_armor_pct <= 0 then
		return
	end
	local ability_actual_damage = ability_current_damage * (1 - ability_applied_damage_reduction_pct / 100)
	local armor = parent:GetPhysicalArmorValue(true)
	local ability_reflect_damage = armor * (ability_reflect_armor_pct / 100) * ability_actual_damage
	if ability_reflect_damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = ability_reflect_damage,
		damage_type = 1,
		ability = ability,
		extra_data = {
			damage_tags = DamageTag.NO_PROC,
			custom_tag = LINK_CUSTOM_TAG,
			source_name = "item_0598:灵魂链接",
		},
	})
end
function modifier_item_0598_self.prototype.GetCurrentPipeDamage(self, final)
	local damage = final.base
	if final.add then
		for ____, value in ipairs(final.add) do
			damage = damage + value.value
		end
	end
	if final.mul then
		for ____, value in ipairs(final.mul) do
			damage = damage * value.value
		end
	end
	return math.max(0, damage)
end
modifier_item_0598_self = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0598_self)
____exports.modifier_item_0598_self = modifier_item_0598_self
return ____exports