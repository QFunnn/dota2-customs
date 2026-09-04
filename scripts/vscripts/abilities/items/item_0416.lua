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
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local FindEnemies = ____item_0409_shared.FindEnemies
local GetAgility = ____item_0409_shared.GetAgility
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
____exports.item_0416 = __TS__Class()
local item_0416 = ____exports.item_0416
item_0416.name = "item_0416"
__TS__ClassExtends(item_0416, BaseItem_CS)
function item_0416.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0416_shadow_gait.name
end
item_0416 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0416)
____exports.item_0416 = item_0416
____exports.modifier_item_0416_shadow_gait = __TS__Class()
local modifier_item_0416_shadow_gait = ____exports.modifier_item_0416_shadow_gait
modifier_item_0416_shadow_gait.name = "modifier_item_0416_shadow_gait"
__TS__ClassExtends(modifier_item_0416_shadow_gait, BaseModifier_CS)
function modifier_item_0416_shadow_gait.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.storedDistance = 0
end
function modifier_item_0416_shadow_gait.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_MISS }
end
function modifier_item_0416_shadow_gait.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.lastPosition = self:GetParent():GetAbsOrigin()
	self:StartIntervalThink(0.2)
end
function modifier_item_0416_shadow_gait.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local currentPosition = parent:GetAbsOrigin()
	if not self.lastPosition then
		self.lastPosition = currentPosition
		return
	end
	self.storedDistance = self.storedDistance + GetDistance(nil, self.lastPosition, currentPosition)
	self.lastPosition = currentPosition
	local ability_distance_per_stack = math.max(1, ability:GetSpecialValueFor("ability_distance_per_stack"))
	local ability_max_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_max_stacks")))
	while self.storedDistance >= ability_distance_per_stack and self:GetStackCount() < ability_max_stacks do
		self.storedDistance = self.storedDistance - ability_distance_per_stack
		self:SetStackCount(self:GetStackCount() + 1)
	end
	if self:GetStackCount() >= ability_max_stacks then
		self.storedDistance = 0
	end
end
function modifier_item_0416_shadow_gait.prototype.OnTakeAttackMiss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.target ~= parent or event.is_miss ~= true then
		return
	end
	if not IsValidAlive(nil, parent) or self:GetStackCount() <= 0 then
		return
	end
	self:SetStackCount(self:GetStackCount() - 1)
	self:TriggerAfterimage(parent, ability)
end
function modifier_item_0416_shadow_gait.prototype.IsPurgable(self)
	return false
end
function modifier_item_0416_shadow_gait.prototype.GetTexture(self)
	return "item_icon_m50_05"
end
function modifier_item_0416_shadow_gait.prototype.TriggerAfterimage(self, parent, ability)
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_agility_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_agility_damage_pct"))
	local ability_duration = math.max(0, ability:GetSpecialValueFor("ability_duration"))
	local damage = GetAgility(nil, parent) * (ability_agility_damage_pct / 100)
	for ____, enemy in ipairs(FindEnemies(nil, parent, parent:GetAbsOrigin(), ability_radius)) do
		do
			if not IsValidEnemyUnit(nil, parent, enemy) then
				goto __continue19
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = damage,
				damage_type = 1,
				ability = ability,
				extra_data = {
					custom_tag = "item_0416_afterimage",
					source_name = self:GetName(),
				},
			})
		end
		::__continue19::
	end
	if ability_duration > 0 then
		parent:AddNewModifier(
			parent,
			ability,
			____exports.modifier_item_0416_shadow_speed.name,
			{ duration = ability_duration }
		)
	end
	self:PlayEffects1(parent)
end
function modifier_item_0416_shadow_gait.prototype.PlayEffects1(self, parent)
	parent:EmitSound("DOTA_Item.Butterfly")
end
modifier_item_0416_shadow_gait = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0416_shadow_gait)
____exports.modifier_item_0416_shadow_gait = modifier_item_0416_shadow_gait
____exports.modifier_item_0416_shadow_speed = __TS__Class()
local modifier_item_0416_shadow_speed = ____exports.modifier_item_0416_shadow_speed
modifier_item_0416_shadow_speed.name = "modifier_item_0416_shadow_speed"
__TS__ClassExtends(modifier_item_0416_shadow_speed, BaseModifier_CS)
function modifier_item_0416_shadow_speed.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	return { bonus_movespeed_pct = ability and ability:GetSpecialValueFor("ability_bonus_movespeed_pct") or 0 }
end
function modifier_item_0416_shadow_speed.prototype.IsPurgable(self)
	return true
end
modifier_item_0416_shadow_speed = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0416_shadow_speed)
____exports.modifier_item_0416_shadow_speed = modifier_item_0416_shadow_speed
return ____exports