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
--- 参与计数的四种通用持续伤害状态。
local DOT_MODIFIER_NAMES =
	{ "modifier_generic_bleed", "modifier_generic_poison", "modifier_generic_burning", "modifier_generic_ignite" }
local THINK_INTERVAL = 0.2
--- 最近攻击目标的“交战记忆”时长（秒）：脱离攻击超过此时长，持续伤害加成归零。
local TARGET_MEMORY_DURATION = 3
____exports.item_0568 = __TS__Class()
local item_0568 = ____exports.item_0568
item_0568.name = "item_0568"
__TS__ClassExtends(item_0568, BaseItem_CS)
function item_0568.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0568.name
end
item_0568 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0568)
____exports.item_0568 = item_0568
--- 固有被动：按当前交战目标身上自己施加的 DOT 种类数，提高自身持续伤害(dot_outgoing_damage_pct)。
____exports.modifier_item_0568 = __TS__Class()
local modifier_item_0568 = ____exports.modifier_item_0568
modifier_item_0568.name = "modifier_item_0568"
__TS__ClassExtends(modifier_item_0568, BaseModifier_CS)
function modifier_item_0568.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedTypes = 0
	self.lastAttackTime = -100
end
function modifier_item_0568.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0568.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.cachedTypes = 0
	self.lastAttackTime = -100
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0568.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0568.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	self.lastTarget = target
	self.lastAttackTime = GameRules:GetGameTime()
end
function modifier_item_0568.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	local types = self:ResolveTargetDotTypes()
	if types ~= self.cachedTypes then
		self.cachedTypes = types
		self:RefreshAttributes()
	end
end
function modifier_item_0568.prototype.IsHidden(self)
	return true
end
function modifier_item_0568.prototype.IsPurgable(self)
	return false
end
function modifier_item_0568.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or self.cachedTypes <= 0 then
		return {}
	end
	local pctPerType = math.max(0, ability:GetSpecialValueFor("ability_value_dot_amp_per_dot_type"))
	if pctPerType <= 0 then
		return {}
	end
	return { dot_outgoing_damage_pct = self.cachedTypes * pctPerType }
end
function modifier_item_0568.prototype.ResolveTargetDotTypes(self)
	local target = self.lastTarget
	if not target or not IsValidAlive(nil, target) then
		return 0
	end
	if GameRules:GetGameTime() - self.lastAttackTime > TARGET_MEMORY_DURATION then
		return 0
	end
	local parent = self:GetParent()
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return 0
	end
	local n = 0
	for ____, name in ipairs(DOT_MODIFIER_NAMES) do
		local dot = target:FindModifierByName(name)
		if dot and dot:GetCaster() == parent then
			n = n + 1
		end
	end
	return n
end
modifier_item_0568 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0568)
____exports.modifier_item_0568 = modifier_item_0568
return ____exports