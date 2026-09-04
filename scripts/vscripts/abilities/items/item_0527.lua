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
local ____lionheart_set = require("shared.lionheart_set")
local CountLionheartItems = ____lionheart_set.CountLionheartItems
local LIONHEART_INTERVAL = 0.5
____exports.item_0527 = __TS__Class()
local item_0527 = ____exports.item_0527
item_0527.name = "item_0527"
__TS__ClassExtends(item_0527, BaseItem_CS)
function item_0527.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0527_controller.name
end
item_0527 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0527)
____exports.item_0527 = item_0527
--- 隐藏控制器：确保常驻「狮心王」被动挂载。
____exports.modifier_item_0527_controller = __TS__Class()
local modifier_item_0527_controller = ____exports.modifier_item_0527_controller
modifier_item_0527_controller.name = "modifier_item_0527_controller"
__TS__ClassExtends(modifier_item_0527_controller, BaseModifier_CS)
function modifier_item_0527_controller.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:EnsureLionheart()
end
function modifier_item_0527_controller.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:EnsureLionheart()
end
function modifier_item_0527_controller.prototype.EnsureLionheart(self)
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if
		IsValidAlive(nil, caster)
		and ability
		and not caster:HasModifier(____exports.modifier_item_0527_lionheart.name)
	then
		caster:AddNewModifier(caster, ability, ____exports.modifier_item_0527_lionheart.name, {})
	end
end
function modifier_item_0527_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not caster or caster:IsNull() then
		return
	end
	local lionheart = caster:FindModifierByName(____exports.modifier_item_0527_lionheart.name)
	if lionheart then
		lionheart:Destroy()
	end
end
function modifier_item_0527_controller.prototype.IsHidden(self)
	return true
end
function modifier_item_0527_controller.prototype.IsPurgable(self)
	return false
end
modifier_item_0527_controller = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0527_controller)
____exports.modifier_item_0527_controller = modifier_item_0527_controller
--- 常驻「狮心王」被动：按【狮心】装备数量提供护甲，并受配置的护甲加成上限约束。
____exports.modifier_item_0527_lionheart = __TS__Class()
local modifier_item_0527_lionheart = ____exports.modifier_item_0527_lionheart
modifier_item_0527_lionheart.name = "modifier_item_0527_lionheart"
__TS__ClassExtends(modifier_item_0527_lionheart, BaseModifier_CS)
function modifier_item_0527_lionheart.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cached = -1
end
function modifier_item_0527_lionheart.GetLocalizationCN(self)
	return {
		name = "狮心王",
		description = "每件【狮心】装备提高护甲值，最多生效3件（层数=当前生效件数）。",
	}
end
function modifier_item_0527_lionheart.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:Recalc(true)
	self:StartIntervalThink(LIONHEART_INTERVAL)
end
function modifier_item_0527_lionheart.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:Recalc(false)
end
function modifier_item_0527_lionheart.prototype.IsHidden(self)
	return false
end
function modifier_item_0527_lionheart.prototype.IsPurgable(self)
	return false
end
function modifier_item_0527_lionheart.prototype.GetAttributeBonus(self)
	local ____temp_0
	if self.cached > 0 then
		____temp_0 = self.cached
	else
		____temp_0 = 0
	end
	return { bonus_armor = ____temp_0 }
end
function modifier_item_0527_lionheart.prototype.Recalc(self, force)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local count = math.min(3, CountLionheartItems(nil, parent))
	if self:GetStackCount() ~= count then
		self:SetStackCount(count)
	end
	local ability_armor_per_lionheart = math.max(0, ability:GetSpecialValueFor("ability_value_armor_per_lionheart"))
	local ability_armor_bonus_max = math.max(0, ability:GetSpecialValueFor("ability_value_armor_bonus_max"))
	local uncappedArmor = math.max(0, count * ability_armor_per_lionheart)
	local ____temp_1
	if ability_armor_bonus_max > 0 then
		____temp_1 = math.min(uncappedArmor, ability_armor_bonus_max)
	else
		____temp_1 = uncappedArmor
	end
	local value = ____temp_1
	if not force and math.abs(value - self.cached) < 0.01 then
		return
	end
	self.cached = value
	local ____ = not force and self:RefreshAttributes()
end
modifier_item_0527_lionheart = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0527_lionheart)
____exports.modifier_item_0527_lionheart = modifier_item_0527_lionheart
return ____exports