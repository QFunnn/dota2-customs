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
____exports.item_0567 = __TS__Class()
local item_0567 = ____exports.item_0567
item_0567.name = "item_0567"
__TS__ClassExtends(item_0567, BaseItem_CS)
function item_0567.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0567.name
end
item_0567 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0567)
____exports.item_0567 = item_0567
--- 监听攻击命中，并按当前物品版本添加追猎印记。
____exports.modifier_item_0567 = __TS__Class()
local modifier_item_0567 = ____exports.modifier_item_0567
modifier_item_0567.name = "modifier_item_0567"
__TS__ClassExtends(modifier_item_0567, BaseModifier_CS)
function modifier_item_0567.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0567.prototype.IsHidden(self)
	return true
end
function modifier_item_0567.prototype.IsPurgable(self)
	return false
end
function modifier_item_0567.prototype.GetMutexKey(self)
	return "lie_sha_mutex"
end
function modifier_item_0567.prototype.GetMutexPriority(self)
	local ____opt_0 = self:GetAbility()
	return (____opt_0 and ____opt_0:GetAbilityName()) == "item_0567" and 200 or 100
end
function modifier_item_0567.prototype.OnAttackLanded_CS(self, event)
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
	if ability:GetAbilityName() == "item_0567" then
		local ability_trigger_chance_pct = ability:GetSpecialValueFor("ability_value_trigger_chance_pct")
		if not RollPercentage(ability_trigger_chance_pct) then
			return
		end
		if not NotifyCustomDebuffApplyQuery(nil, target, parent, ability, ____exports.modifier_item_0567_mark.name) then
			return
		end
		target:AddNewModifier(parent, ability, ____exports.modifier_item_0567_mark.name, {})
		return
	end
	self:ApplyLegacyMark(parent, target, ability)
end
function modifier_item_0567.prototype.ApplyLegacyMark(self, parent, target, ability)
	local targetIndex = target:GetEntityIndex()
	if self.lastTargetIndex ~= nil and self.lastTargetIndex ~= targetIndex then
		local oldTarget = EntIndexToHScript(self.lastTargetIndex)
		if oldTarget and IsValid(nil, oldTarget) and oldTarget.FindModifierByNameAndCaster then
			local ____opt_2 = oldTarget:FindModifierByNameAndCaster(____exports.modifier_item_0567_mark.name, parent)
			if ____opt_2 ~= nil then
				____opt_2:Destroy()
			end
		end
	end
	self.lastTargetIndex = targetIndex
	if not NotifyCustomDebuffApplyQuery(nil, target, parent, ability, ____exports.modifier_item_0567_mark.name) then
		return
	end
	target:AddNewModifier(parent, ability, ____exports.modifier_item_0567_mark.name, {})
end
modifier_item_0567 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0567)
____exports.modifier_item_0567 = modifier_item_0567
--- 追猎印记：仅放大印记施加者对宿主造成的伤害。
____exports.modifier_item_0567_mark = __TS__Class()
local modifier_item_0567_mark = ____exports.modifier_item_0567_mark
modifier_item_0567_mark.name = "modifier_item_0567_mark"
__TS__ClassExtends(modifier_item_0567_mark, BaseModifier_CS)
function modifier_item_0567_mark.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ability_dmg_pct_per_stack = 0
	self.ability_value_max_stacks = 1
	self.shouldDoubleAtMaxStacks = false
end
function modifier_item_0567_mark.GetLocalizationCN(self)
	return {
		name = "追猎",
		description = "受到印记施加者的伤害提高；达到最大层数时效果翻倍。",
	}
end
function modifier_item_0567_mark.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0567_mark.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:SetStackCount(1)
end
function modifier_item_0567_mark.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:SetStackCount(math.min(self.ability_value_max_stacks, self:GetStackCount() + 1))
end
function modifier_item_0567_mark.prototype.RefreshConfig(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_name = ability:GetAbilityName()
	self.ability_dmg_pct_per_stack = ability:GetSpecialValueFor("ability_dmg_pct_per_stack")
	self.ability_value_max_stacks = math.max(
		1,
		math.floor(
			ability:GetSpecialValueFor(
				ability_name == "item_0586" and "ability_max_stacks" or "ability_value_max_stacks"
			)
		)
	)
	self.shouldDoubleAtMaxStacks = ability_name == "item_0567"
	local ability_mark_duration = ability:GetSpecialValueFor("ability_mark_duration")
	self:SetDuration(ability_mark_duration, true)
end
function modifier_item_0567_mark.prototype.OnDamagePreApply_CS(self, event)
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
	local stackCount = self:GetStackCount()
	local ability_damage_amp_pct = self.ability_dmg_pct_per_stack * stackCount
	if self.shouldDoubleAtMaxStacks and stackCount >= self.ability_value_max_stacks then
		ability_damage_amp_pct = ability_damage_amp_pct * 2
	end
	if ability_damage_amp_pct <= 0 then
		return
	end
	local ____event_final_4, ____mul_5 = event.final, "mul"
	if ____event_final_4[____mul_5] == nil then
		____event_final_4[____mul_5] = {}
	end
	local ____event_final_mul_6 = event.final.mul
	____event_final_mul_6[#____event_final_mul_6 + 1] =
		{ value = 1 + ability_damage_amp_pct / 100, source = "item_0567:猎杀印记" }
end
function modifier_item_0567_mark.prototype.IsDebuff(self)
	return true
end
function modifier_item_0567_mark.prototype.IsPurgable(self)
	return false
end
function modifier_item_0567_mark.prototype.GetTexture(self)
	return "item_bloodthorn"
end
modifier_item_0567_mark = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0567_mark)
____exports.modifier_item_0567_mark = modifier_item_0567_mark
return ____exports