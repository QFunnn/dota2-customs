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
____exports.item_0649 = __TS__Class()
local item_0649 = ____exports.item_0649
item_0649.name = "item_0649"
__TS__ClassExtends(item_0649, BaseItem_CS)
function item_0649.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/units/heroes/hero_puck/puck_phase_shift.vpcf", context)
end
function item_0649.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0649_phase_controller.name
end
item_0649 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0649)
____exports.item_0649 = item_0649
--- 隐藏控制器：按固定周期施加短暂相位状态。
____exports.modifier_item_0649_phase_controller = __TS__Class()
local modifier_item_0649_phase_controller = ____exports.modifier_item_0649_phase_controller
modifier_item_0649_phase_controller.name = "modifier_item_0649_phase_controller"
__TS__ClassExtends(modifier_item_0649_phase_controller, BaseModifier_CS)
function modifier_item_0649_phase_controller.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartPhaseTimer()
end
function modifier_item_0649_phase_controller.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:StartPhaseTimer()
end
function modifier_item_0649_phase_controller.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local ability_duration = ability:GetSpecialValueFor("ability_duration")
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0649_phase.name, { duration = ability_duration })
end
function modifier_item_0649_phase_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0649_phase_controller.prototype.IsHidden(self)
	return true
end
function modifier_item_0649_phase_controller.prototype.IsPurgable(self)
	return false
end
function modifier_item_0649_phase_controller.prototype.StartPhaseTimer(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_interval = ability:GetSpecialValueFor("ability_interval")
	self:StartIntervalThink(ability_interval)
end
modifier_item_0649_phase_controller =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0649_phase_controller)
____exports.modifier_item_0649_phase_controller = modifier_item_0649_phase_controller
--- 相位窗口：阻止最终伤害应用，但不改变单位的可控、可攻击或可选中状态。
____exports.modifier_item_0649_phase = __TS__Class()
local modifier_item_0649_phase = ____exports.modifier_item_0649_phase
modifier_item_0649_phase.name = "modifier_item_0649_phase"
__TS__ClassExtends(modifier_item_0649_phase, BaseModifier_CS)
function modifier_item_0649_phase.GetLocalizationCN(self)
	return { name = "相位", description = "免疫伤害，但仍可行动、攻击、被攻击和受到控制。" }
end
function modifier_item_0649_phase.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_FINAL_PRE_APPLY }
end
function modifier_item_0649_phase.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:TriggerPhaseEntry()
end
function modifier_item_0649_phase.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:TriggerPhaseEntry()
end
function modifier_item_0649_phase.prototype.OnDamageFinalPreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.ctx.spec.victim ~= parent or event.ctx.spec.force_kill then
		return
	end
	event.prevent_apply = true
end
function modifier_item_0649_phase.prototype.IsHidden(self)
	return false
end
function modifier_item_0649_phase.prototype.IsDebuff(self)
	return false
end
function modifier_item_0649_phase.prototype.IsPurgable(self)
	return false
end
function modifier_item_0649_phase.prototype.GetTexture(self)
	return "icon_zb98_17"
end
function modifier_item_0649_phase.prototype.TriggerPhaseEntry(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:FireSyntheticEvasion(parent)
	self:PlayEffects1(parent)
end
function modifier_item_0649_phase.prototype.FireSyntheticEvasion(self, parent)
	local evasionEvent = {
		attacker = parent,
		target = parent,
		ability = self:GetAbility(),
		is_miss = true,
		attack_damage = 0,
		final_damage = 0,
		original_damage = 0,
		damage_type = 1,
		damage_flag = ApplyDamageFlag.NO_FLAG,
		is_base_attack = true,
		is_cleave = false,
		is_kill = false,
		extra_data = { custom_tag = "item_0649_phase_evasion", source_name = "item_0649:相位" },
	}
	MyGameEvent:FireEvent(BusinessEvents.ON_TAKE_ATTACK_MISS, evasionEvent, { scope = "entity", entity = parent })
end
function modifier_item_0649_phase.prototype.PlayEffects1(self, parent)
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_puck/puck_phase_shift.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
	parent:EmitSound("Hero_Puck.Phase_Shift")
end
modifier_item_0649_phase = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0649_phase)
____exports.modifier_item_0649_phase = modifier_item_0649_phase
return ____exports