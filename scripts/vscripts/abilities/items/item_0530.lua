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
local SUPPRESS_INTERVAL = 0.1
local LIONHEART_INTERVAL = 0.5
____exports.item_0530 = __TS__Class()
local item_0530 = ____exports.item_0530
item_0530.name = "item_0530"
__TS__ClassExtends(item_0530, BaseItem_CS)
function item_0530.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0530.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0530_controller.name
end
function item_0530.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local duration = math.max(0.1, self:GetSpecialValueFor("ability_blast_duration"))
	local existing = caster:FindModifierByName(____exports.modifier_item_0530_blast.name)
	if existing then
		existing:SetDuration(duration, true)
	else
		caster:AddNewModifier(caster, self, ____exports.modifier_item_0530_blast.name, { duration = duration })
	end
	caster:EmitSound("DOTA_Item.Armlet.Activate")
end
item_0530 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0530)
____exports.item_0530 = item_0530
--- 隐藏控制器：确保常驻「狮心王」被动挂载（爆战为主动定时，不由此开关）。
____exports.modifier_item_0530_controller = __TS__Class()
local modifier_item_0530_controller = ____exports.modifier_item_0530_controller
modifier_item_0530_controller.name = "modifier_item_0530_controller"
__TS__ClassExtends(modifier_item_0530_controller, BaseModifier_CS)
function modifier_item_0530_controller.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:EnsureLionheart()
end
function modifier_item_0530_controller.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:EnsureLionheart()
end
function modifier_item_0530_controller.prototype.EnsureLionheart(self)
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if
		IsValidAlive(nil, caster)
		and ability
		and not caster:HasModifier(____exports.modifier_item_0530_lionheart.name)
	then
		caster:AddNewModifier(caster, ability, ____exports.modifier_item_0530_lionheart.name, {})
	end
end
function modifier_item_0530_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not caster or caster:IsNull() then
		return
	end
	local blast = caster:FindModifierByName(____exports.modifier_item_0530_blast.name)
	if blast then
		blast:Destroy()
	end
	local lionheart = caster:FindModifierByName(____exports.modifier_item_0530_lionheart.name)
	if lionheart then
		lionheart:Destroy()
	end
end
function modifier_item_0530_controller.prototype.IsHidden(self)
	return true
end
function modifier_item_0530_controller.prototype.IsPurgable(self)
	return false
end
modifier_item_0530_controller = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0530_controller)
____exports.modifier_item_0530_controller = modifier_item_0530_controller
--- 常驻「狮心王」被动：身上每有一件【狮心】装备（含本件）→ 提供 ability_armor_per_lionheart 点护甲。
____exports.modifier_item_0530_lionheart = __TS__Class()
local modifier_item_0530_lionheart = ____exports.modifier_item_0530_lionheart
modifier_item_0530_lionheart.name = "modifier_item_0530_lionheart"
__TS__ClassExtends(modifier_item_0530_lionheart, BaseModifier_CS)
function modifier_item_0530_lionheart.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cached = -1
end
function modifier_item_0530_lionheart.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:Recalc(true)
	self:StartIntervalThink(LIONHEART_INTERVAL)
end
function modifier_item_0530_lionheart.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:Recalc(false)
end
function modifier_item_0530_lionheart.prototype.IsHidden(self)
	return true
end
function modifier_item_0530_lionheart.prototype.IsPurgable(self)
	return false
end
function modifier_item_0530_lionheart.prototype.GetAttributeBonus(self)
	local ____temp_0
	if self.cached > 0 then
		____temp_0 = self.cached
	else
		____temp_0 = 0
	end
	return { bonus_armor = ____temp_0 }
end
function modifier_item_0530_lionheart.prototype.Recalc(self, force)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local count = CountLionheartItems(nil, parent)
	local armorPerLionheart = math.max(0, ability:GetSpecialValueFor("ability_armor_per_lionheart"))
	local value = math.max(0, count * armorPerLionheart)
	if not force and math.abs(value - self.cached) < 0.01 then
		return
	end
	self.cached = value
	local ____ = not force and self:RefreshAttributes()
end
modifier_item_0530_lionheart = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0530_lionheart)
____exports.modifier_item_0530_lionheart = modifier_item_0530_lionheart
--- 爆战形态：清空并压制护盾，将最大护盾值转化为攻速 / 物理伤害增幅。
____exports.modifier_item_0530_blast = __TS__Class()
local modifier_item_0530_blast = ____exports.modifier_item_0530_blast
modifier_item_0530_blast.name = "modifier_item_0530_blast"
__TS__ClassExtends(modifier_item_0530_blast, BaseModifier_CS)
function modifier_item_0530_blast.GetLocalizationCN(self)
	return { name = "爆战", description = "护盾被清空且无法恢复，最大护盾值转化为攻击强化。" }
end
function modifier_item_0530_blast.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:SuppressShield(parent)
	self:StartIntervalThink(SUPPRESS_INTERVAL)
end
function modifier_item_0530_blast.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:SuppressShield(parent)
	self:RefreshAttributes()
end
function modifier_item_0530_blast.prototype.SuppressShield(self, parent)
	parent.__last_energy_shield_combat_time__ = GameRules:GetGameTime()
	parent:SetCurrentEnergyShield(0)
end
function modifier_item_0530_blast.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local maxShield = self:GetMaxShield(self:GetParent())
	local per1000 = maxShield / 1000
	local asPctPer1000 = math.max(0, ability:GetSpecialValueFor("ability_attackspeed_pct_per_1000"))
	local dmgPctPer1000 = math.max(0, ability:GetSpecialValueFor("ability_damage_pct_per_1000"))
	return { attack_speed_pct = per1000 * asPctPer1000, physical_damage_add_pct = per1000 * dmgPctPer1000 }
end
function modifier_item_0530_blast.prototype.GetMaxShield(self, parent)
	return math.max(0, MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0)
end
function modifier_item_0530_blast.prototype.IsHidden(self)
	return false
end
function modifier_item_0530_blast.prototype.IsDebuff(self)
	return false
end
function modifier_item_0530_blast.prototype.IsPurgable(self)
	return false
end
function modifier_item_0530_blast.prototype.GetTexture(self)
	return "item_armlet"
end
modifier_item_0530_blast = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0530_blast)
____exports.modifier_item_0530_blast = modifier_item_0530_blast
return ____exports