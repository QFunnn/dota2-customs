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
local BLEED_MODIFIER_NAME = "modifier_generic_bleed"
local THINK_INTERVAL = 0.25
____exports.item_0348 = __TS__Class()
local item_0348 = ____exports.item_0348
item_0348.name = "item_0348"
__TS__ClassExtends(item_0348, BaseItem_CS)
function item_0348.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0348_butcher.name
end
item_0348 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0348)
____exports.item_0348 = item_0348
--- 佩戴者：普攻命中挂屠戮印记；周期检测自身流血刷新浴血增益。
____exports.modifier_item_0348_butcher = __TS__Class()
local modifier_item_0348_butcher = ____exports.modifier_item_0348_butcher
modifier_item_0348_butcher.name = "modifier_item_0348_butcher"
__TS__ClassExtends(modifier_item_0348_butcher, BaseModifier_CS)
function modifier_item_0348_butcher.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cached_bleed_pct = 0
	self.cached_outgoing_pct = 0
end
function modifier_item_0348_butcher.GetLocalizationCN(self)
	return { name = "浴血", description = "处于流血状态时提高流血伤害与最终伤害。" }
end
function modifier_item_0348_butcher.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0348_butcher.prototype.IsHidden(self)
	return false
end
function modifier_item_0348_butcher.prototype.IsPurgable(self)
	return false
end
function modifier_item_0348_butcher.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshBloodlust(true)
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0348_butcher.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshBloodlust(true)
end
function modifier_item_0348_butcher.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:CleanupAttributes()
end
function modifier_item_0348_butcher.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RefreshBloodlust(false)
end
function modifier_item_0348_butcher.prototype.GetAttributeBonus(self)
	return { bleed_outgoing_damage_pct = self.cached_bleed_pct, outgoing_damage_pct_2 = self.cached_outgoing_pct }
end
function modifier_item_0348_butcher.prototype.RefreshBloodlust(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local isBleeding = parent:HasModifier(BLEED_MODIFIER_NAME)
	local ____isBleeding_0
	if isBleeding then
		____isBleeding_0 = math.max(0, ability:GetSpecialValueFor("ability_value_bleeding_bleed_pct"))
	else
		____isBleeding_0 = 0
	end
	local nextBleedPct = ____isBleeding_0
	local ____isBleeding_1
	if isBleeding then
		____isBleeding_1 = math.max(0, ability:GetSpecialValueFor("ability_value_bleeding_outgoing_pct"))
	else
		____isBleeding_1 = 0
	end
	local nextOutgoingPct = ____isBleeding_1
	if not forceRefresh and nextBleedPct == self.cached_bleed_pct and nextOutgoingPct == self.cached_outgoing_pct then
		return
	end
	self.cached_bleed_pct = nextBleedPct
	self.cached_outgoing_pct = nextOutgoingPct
	self:SetStackCount(isBleeding and 1 or 0)
	self:RefreshAttributes()
end
function modifier_item_0348_butcher.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if not NotifyCustomDebuffApplyQuery(nil, target, parent, ability, ____exports.modifier_item_0348_mark.name) then
		return
	end
	target:AddNewModifier(parent, ability, ____exports.modifier_item_0348_mark.name, {})
end
modifier_item_0348_butcher = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0348_butcher)
____exports.modifier_item_0348_butcher = modifier_item_0348_butcher
--- 屠戮印记：层数随宿主已损失生命更新，仅放大施加者对宿主的伤害（HP_LOSS 除外）。
____exports.modifier_item_0348_mark = __TS__Class()
local modifier_item_0348_mark = ____exports.modifier_item_0348_mark
modifier_item_0348_mark.name = "modifier_item_0348_mark"
__TS__ClassExtends(modifier_item_0348_mark, BaseModifier_CS)
function modifier_item_0348_mark.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ability_loss_health_step_pct = 2
	self.ability_damage_bonus_per_step_pct = 1
	self.ability_damage_bonus_limit_pct = 0
end
function modifier_item_0348_mark.GetLocalizationCN(self)
	return { name = "屠戮", description = "受到印记施加者的伤害提高，生命越低效果越强。" }
end
function modifier_item_0348_mark.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0348_mark.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:UpdateStacks()
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0348_mark.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:UpdateStacks()
end
function modifier_item_0348_mark.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0348_mark.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:UpdateStacks()
end
function modifier_item_0348_mark.prototype.RefreshConfig(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.ability_loss_health_step_pct = math.max(1, ability:GetSpecialValueFor("ability_loss_health_step_pct"))
	self.ability_damage_bonus_per_step_pct =
		math.max(0, ability:GetSpecialValueFor("ability_damage_bonus_per_step_pct"))
	self.ability_damage_bonus_limit_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_damage_bonus_limit_pct"))
	local ability_mark_duration = math.max(1, ability:GetSpecialValueFor("ability_mark_duration"))
	self:SetDuration(ability_mark_duration, true)
end
function modifier_item_0348_mark.prototype.UpdateStacks(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local maxHealth = math.max(1, parent:GetMaxHealth())
	local lostHealthPct = math.max(0, math.min(100, (maxHealth - parent:GetHealth()) * 100 / maxHealth))
	local steps = math.floor(lostHealthPct / self.ability_loss_health_step_pct)
	local ampPct = math.min(self.ability_damage_bonus_limit_pct, steps * self.ability_damage_bonus_per_step_pct)
	self:SetStackCount(math.floor(ampPct))
end
function modifier_item_0348_mark.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	if event.ctx.spec.attacker ~= self:GetCaster() then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ability_damage_amp_pct = self:GetStackCount()
	if ability_damage_amp_pct <= 0 then
		return
	end
	local ____event_final_2, ____mul_3 = event.final, "mul"
	if ____event_final_2[____mul_3] == nil then
		____event_final_2[____mul_3] = {}
	end
	local ____event_final_mul_4 = event.final.mul
	____event_final_mul_4[#____event_final_mul_4 + 1] =
		{ value = 1 + ability_damage_amp_pct / 100, source = "item_0348:屠戮" }
end
function modifier_item_0348_mark.prototype.IsDebuff(self)
	return true
end
function modifier_item_0348_mark.prototype.IsPurgable(self)
	return false
end
function modifier_item_0348_mark.prototype.GetTexture(self)
	return "item_bloodthorn"
end
modifier_item_0348_mark = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0348_mark)
____exports.modifier_item_0348_mark = modifier_item_0348_mark
return ____exports