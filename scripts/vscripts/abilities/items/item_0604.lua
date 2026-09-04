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
local TICK_INTERVAL = 1
____exports.item_0604 = __TS__Class()
local item_0604 = ____exports.item_0604
item_0604.name = "item_0604"
__TS__ClassExtends(item_0604, BaseItem_CS)
function item_0604.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0604.name
end
item_0604 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0604)
____exports.item_0604 = item_0604
--- 固有被动「过热」：层数 = 层数>阈值的增益数；每层 +技伤，并每秒燃烧当前生命（按层数）。
____exports.modifier_item_0604 = __TS__Class()
local modifier_item_0604 = ____exports.modifier_item_0604
modifier_item_0604.name = "modifier_item_0604"
__TS__ClassExtends(modifier_item_0604, BaseModifier_CS)
function modifier_item_0604.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.overheatStacks = 0
end
function modifier_item_0604.GetLocalizationCN(self)
	return {
		name = "过热",
		description = "每有一个高叠层增益即获得一层过热：每层提高技能伤害，并每秒燃烧当前生命。",
	}
end
function modifier_item_0604.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(TICK_INTERVAL)
	self:OnIntervalThink()
end
function modifier_item_0604.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0604.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	self.overheatStacks = self:CountOverheatStacks(parent, ability)
	self:SetStackCount(self.overheatStacks)
	self:RefreshAttributes()
	if self.overheatStacks <= 0 then
		return
	end
	local burnPct = math.max(0, ability:GetSpecialValueFor("ability_burn_current_pct")) * self.overheatStacks
	if burnPct <= 0 then
		return
	end
	parent:CostHeal(
		parent:GetHealth() * burnPct / 100,
		{ ability = ability, source = { source_name = "item_0604:过热" } }
	)
end
function modifier_item_0604.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or self.overheatStacks <= 0 then
		return {}
	end
	local rolledAmp = ability:GetSpecialValueFor("ability_value_spell_amp_per_stack")
	local ____math_max_1 = math.max
	local ____temp_0
	if rolledAmp > 0 then
		____temp_0 = rolledAmp
	else
		____temp_0 = ability:GetSpecialValueFor("ability_spell_amp_per_stack")
	end
	local ampPerStack = ____math_max_1(0, ____temp_0)
	return { spell_amplify_pct = self.overheatStacks * ampPerStack }
end
function modifier_item_0604.prototype.CountOverheatStacks(self, parent, ability)
	local thresholdRolled = ability:GetSpecialValueFor("ability_value_c_buff_stack_threshold")
	local ____math_floor_3 = math.floor
	local ____temp_2
	if thresholdRolled > 0 then
		____temp_2 = thresholdRolled
	else
		____temp_2 = ability:GetSpecialValueFor("ability_buff_stack_threshold")
	end
	local threshold = ____math_floor_3(____temp_2)
	local mods = parent:FindAllModifiers() or {}
	local count = 0
	for ____, m in ipairs(mods) do
		do
			local ____temp_6 = not m
			if not ____temp_6 then
				local ____opt_4 = m.IsNull
				____temp_6 = ____opt_4 and ____opt_4(m)
			end
			if ____temp_6 then
				goto __continue16
			end
			if m:GetName() == ____exports.modifier_item_0604.name then
				goto __continue16
			end
			local anyMod = m
			if anyMod.IsDebuff == nil or anyMod:IsDebuff() then
				goto __continue16
			end
			if anyMod.IsHidden == nil or anyMod:IsHidden() then
				goto __continue16
			end
			if m:GetStackCount() > threshold then
				count = count + 1
			end
		end
		::__continue16::
	end
	return count
end
function modifier_item_0604.prototype.IsHidden(self)
	return false
end
function modifier_item_0604.prototype.IsDebuff(self)
	return false
end
function modifier_item_0604.prototype.IsPurgable(self)
	return false
end
function modifier_item_0604.prototype.GetMutexKey(self)
	return "item_0604_mutex"
end
function modifier_item_0604.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0604" and 200 or 100
end
function modifier_item_0604.prototype.GetTexture(self)
	return "item_refresher"
end
modifier_item_0604 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0604)
____exports.modifier_item_0604 = modifier_item_0604
return ____exports