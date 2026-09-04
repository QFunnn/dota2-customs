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
local ____modifier_generic_ignite = require("modifiers.debuff.modifier_generic_ignite")
local modifier_generic_ignite = ____modifier_generic_ignite.modifier_generic_ignite
local BRAND_SYNC_INTERVAL = 0.5
____exports.item_0540 = __TS__Class()
local item_0540 = ____exports.item_0540
item_0540.name = "item_0540"
__TS__ClassExtends(item_0540, BaseItem_CS)
function item_0540.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0540_listener.name
end
item_0540 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0540)
____exports.item_0540 = item_0540
--- 固有监听：造成非 DOT 伤害且目标处于点燃时，挂【焚蚀】印记（印记自身跟随点燃层数）。
____exports.modifier_item_0540_listener = __TS__Class()
local modifier_item_0540_listener = ____exports.modifier_item_0540_listener
modifier_item_0540_listener.name = "modifier_item_0540_listener"
__TS__ClassExtends(modifier_item_0540_listener, BaseModifier_CS)
function modifier_item_0540_listener.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0540_listener.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if not target:HasModifier(modifier_generic_ignite.name) then
		return
	end
	if target:HasModifier(____exports.modifier_item_0540_brand.name) then
		return
	end
	target:AddNewModifier(parent, ability, ____exports.modifier_item_0540_brand.name, {})
end
function modifier_item_0540_listener.prototype.IsHidden(self)
	return true
end
function modifier_item_0540_listener.prototype.IsPurgable(self)
	return false
end
modifier_item_0540_listener = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0540_listener)
____exports.modifier_item_0540_listener = modifier_item_0540_listener
--- 【焚蚀】印记：跟随目标点燃层数，按层降护甲% + 增受到魔法伤害%。点燃消失即自毁。
____exports.modifier_item_0540_brand = __TS__Class()
local modifier_item_0540_brand = ____exports.modifier_item_0540_brand
modifier_item_0540_brand.name = "modifier_item_0540_brand"
__TS__ClassExtends(modifier_item_0540_brand, BaseModifier_CS)
function modifier_item_0540_brand.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedStacks = 0
	self.perStack = 0
end
function modifier_item_0540_brand.GetLocalizationCN(self)
	return { name = "焚蚀", description = "护甲值降低、受到的魔法伤害提高，随点燃层数增强。" }
end
function modifier_item_0540_brand.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = math.max(0, ability:GetSpecialValueFor("ability_pct_per_stack"))
	else
		____ability_0 = 0
	end
	self.perStack = ____ability_0
	self:SyncWithIgnite()
	self:StartIntervalThink(BRAND_SYNC_INTERVAL)
end
function modifier_item_0540_brand.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0540_brand.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:SyncWithIgnite()
end
function modifier_item_0540_brand.prototype.GetAttributeBonus(self)
	local value = self.perStack * self.cachedStacks
	return { base_armor_pct = -value, incoming_magical_damage_increase_pct = value }
end
function modifier_item_0540_brand.prototype.IsDebuff(self)
	return true
end
function modifier_item_0540_brand.prototype.IsPurgable(self)
	return false
end
function modifier_item_0540_brand.prototype.GetTexture(self)
	return "item_veil_of_discord"
end
function modifier_item_0540_brand.prototype.SyncWithIgnite(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		self:Destroy()
		return
	end
	local ignite = parent:FindModifierByName(modifier_generic_ignite.name)
	local ____ignite_1
	if ignite then
		____ignite_1 = ignite:GetStackCount()
	else
		____ignite_1 = 0
	end
	local stacks = ____ignite_1
	if stacks <= 0 then
		self:Destroy()
		return
	end
	if stacks ~= self.cachedStacks then
		self.cachedStacks = stacks
		self:RefreshAttributes()
	end
end
modifier_item_0540_brand = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0540_brand)
____exports.modifier_item_0540_brand = modifier_item_0540_brand
return ____exports