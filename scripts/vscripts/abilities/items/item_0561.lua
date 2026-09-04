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
local THINK_INTERVAL = 0.2
____exports.item_0561 = __TS__Class()
local item_0561 = ____exports.item_0561
item_0561.name = "item_0561"
__TS__ClassExtends(item_0561, BaseItem_CS)
function item_0561.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0561.name
end
item_0561 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0561)
____exports.item_0561 = item_0561
____exports.modifier_item_0561 = __TS__Class()
local modifier_item_0561 = ____exports.modifier_item_0561
modifier_item_0561.name = "modifier_item_0561"
__TS__ClassExtends(modifier_item_0561, BaseModifier_CS)
function modifier_item_0561.GetLocalizationCN(self)
	return { name = "淬厄", description = "每承受一个负面状态，获得额外伤害与伤害减免。" }
end
function modifier_item_0561.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:EnsureCurses()
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0561.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	for ____, name in ipairs(____exports.modifier_item_0561.CURSE_NAMES) do
		local ____opt_0 = parent:FindModifierByName(name)
		if ____opt_0 ~= nil then
			____opt_0:Destroy()
		end
	end
end
function modifier_item_0561.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	self:EnsureCurses()
	self:RefreshAttributes()
end
function modifier_item_0561.prototype.EnsureCurses(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	for ____, name in ipairs(____exports.modifier_item_0561.CURSE_NAMES) do
		if not parent:HasModifier(name) then
			parent:AddNewModifier(parent, ability, name, {})
		end
	end
end
function modifier_item_0561.prototype.IsHidden(self)
	return true
end
function modifier_item_0561.prototype.IsDebuff(self)
	return false
end
function modifier_item_0561.prototype.IsPurgable(self)
	return false
end
function modifier_item_0561.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return {}
	end
	local pctPer = math.max(0, ability:GetSpecialValueFor("ability_pct_per_debuff"))
	if pctPer <= 0 then
		return {}
	end
	local count = self:CountDebuffs(parent)
	if count <= 0 then
		return {}
	end
	local total = count * pctPer
	return { outgoing_damage_pct = total, damage_reduction_pct = total }
end
function modifier_item_0561.prototype.CountDebuffs(self, parent)
	local mods = parent:FindAllModifiers() or {}
	local n = 0
	for ____, m in ipairs(mods) do
		if m.IsDebuff and m:IsDebuff() then
			n = n + 1
		end
	end
	return n
end
modifier_item_0561.CURSE_NAMES =
	{ "modifier_item_0561_curse_slow", "modifier_item_0561_curse_mind", "modifier_item_0561_curse_decay" }
modifier_item_0561 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0561)
____exports.modifier_item_0561 = modifier_item_0561
--- 【蹒跚】三厄之一：移动速度降低（轻微·喂淬厄计数）。
____exports.modifier_item_0561_curse_slow = __TS__Class()
local modifier_item_0561_curse_slow = ____exports.modifier_item_0561_curse_slow
modifier_item_0561_curse_slow.name = "modifier_item_0561_curse_slow"
__TS__ClassExtends(modifier_item_0561_curse_slow, BaseModifier_CS)
function modifier_item_0561_curse_slow.GetLocalizationCN(self)
	return { name = "蹒跚", description = "移动速度降低。" }
end
function modifier_item_0561_curse_slow.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_2
	if ability then
		____ability_2 = math.max(0, ability:GetSpecialValueFor("ability_curse_slow_pct"))
	else
		____ability_2 = 0
	end
	local pct = ____ability_2
	return { bonus_movespeed_pct = -pct }
end
function modifier_item_0561_curse_slow.prototype.IsHidden(self)
	return false
end
function modifier_item_0561_curse_slow.prototype.IsDebuff(self)
	return true
end
function modifier_item_0561_curse_slow.prototype.IsPurgable(self)
	return false
end
function modifier_item_0561_curse_slow.prototype.GetTexture(self)
	return "item_tranquil_boots"
end
modifier_item_0561_curse_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0561_curse_slow)
____exports.modifier_item_0561_curse_slow = modifier_item_0561_curse_slow
--- 【裂识】三厄之一：魔法抗性降低（轻微·喂淬厄计数）。
____exports.modifier_item_0561_curse_mind = __TS__Class()
local modifier_item_0561_curse_mind = ____exports.modifier_item_0561_curse_mind
modifier_item_0561_curse_mind.name = "modifier_item_0561_curse_mind"
__TS__ClassExtends(modifier_item_0561_curse_mind, BaseModifier_CS)
function modifier_item_0561_curse_mind.GetLocalizationCN(self)
	return { name = "裂识", description = "魔法抗性降低。" }
end
function modifier_item_0561_curse_mind.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_3
	if ability then
		____ability_3 = math.max(0, ability:GetSpecialValueFor("ability_curse_magic_resist"))
	else
		____ability_3 = 0
	end
	local value = ____ability_3
	return { base_magic_resistance = -value }
end
function modifier_item_0561_curse_mind.prototype.IsHidden(self)
	return false
end
function modifier_item_0561_curse_mind.prototype.IsDebuff(self)
	return true
end
function modifier_item_0561_curse_mind.prototype.IsPurgable(self)
	return false
end
function modifier_item_0561_curse_mind.prototype.GetTexture(self)
	return "item_null_talisman"
end
modifier_item_0561_curse_mind = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0561_curse_mind)
____exports.modifier_item_0561_curse_mind = modifier_item_0561_curse_mind
--- 【腐养】三厄之一：恢复效果降低（轻微·喂淬厄计数）。
____exports.modifier_item_0561_curse_decay = __TS__Class()
local modifier_item_0561_curse_decay = ____exports.modifier_item_0561_curse_decay
modifier_item_0561_curse_decay.name = "modifier_item_0561_curse_decay"
__TS__ClassExtends(modifier_item_0561_curse_decay, BaseModifier_CS)
function modifier_item_0561_curse_decay.GetLocalizationCN(self)
	return { name = "腐养", description = "恢复效果降低。" }
end
function modifier_item_0561_curse_decay.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_4
	if ability then
		____ability_4 = math.max(0, ability:GetSpecialValueFor("ability_curse_regen_pct"))
	else
		____ability_4 = 0
	end
	local pct = ____ability_4
	return { regen_amp_pct = -pct }
end
function modifier_item_0561_curse_decay.prototype.IsHidden(self)
	return false
end
function modifier_item_0561_curse_decay.prototype.IsDebuff(self)
	return true
end
function modifier_item_0561_curse_decay.prototype.IsPurgable(self)
	return false
end
function modifier_item_0561_curse_decay.prototype.GetTexture(self)
	return "item_urn_of_shadows"
end
modifier_item_0561_curse_decay = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0561_curse_decay)
____exports.modifier_item_0561_curse_decay = modifier_item_0561_curse_decay
return ____exports