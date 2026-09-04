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
____exports.item_0344 = __TS__Class()
local item_0344 = ____exports.item_0344
item_0344.name = "item_0344"
__TS__ClassExtends(item_0344, BaseItem_CS)
function item_0344.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0344_love.name
end
item_0344 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0344)
____exports.item_0344 = item_0344
____exports.modifier_item_0344_love = __TS__Class()
local modifier_item_0344_love = ____exports.modifier_item_0344_love
modifier_item_0344_love.name = "modifier_item_0344_love"
__TS__ClassExtends(modifier_item_0344_love, BaseModifier_CS)
function modifier_item_0344_love.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0344_love.prototype.IsHidden(self)
	return true
end
function modifier_item_0344_love.prototype.IsPurgable(self)
	return false
end
function modifier_item_0344_love.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local target = event.target
	if not self:IsValidEnemy(parent, target) then
		return
	end
	local ability_value_trigger_chance_pct =
		math.min(100, math.max(0, ability:GetSpecialValueFor("ability_value_trigger_chance_pct")))
	if ability_value_trigger_chance_pct <= 0 or not RollPercentage(ability_value_trigger_chance_pct) then
		return
	end
	local ability_value_damage_all_stats_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_damage_all_stats_pct"))
	local damage = self:GetAllStats(parent) * (ability_value_damage_all_stats_pct / 100)
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = damage,
		damage_type = 4,
		ability = ability,
		extra_data = { source_name = self:GetName() },
	})
	self:ApplyRandomDebuff(parent, target, ability)
	self:StartAbilityCooldown(ability)
end
function modifier_item_0344_love.prototype.ApplyRandomDebuff(self, parent, target, ability)
	local ability_debuff_duration = math.max(0, ability:GetSpecialValueFor("ability_debuff_duration"))
	repeat
		local ____switch14 = RandomInt(1, 4)
		local ____cond14 = ____switch14 == 1
		if ____cond14 then
			AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.POISON, { stack = 1 })
			return
		end
		____cond14 = ____cond14 or ____switch14 == 2
		if ____cond14 then
			AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.BURN, { duration = ability_debuff_duration })
			return
		end
		____cond14 = ____cond14 or ____switch14 == 3
		if ____cond14 then
			AddDeBuffStatus(
				nil,
				target,
				parent,
				ability,
				DebuffStatusType.ICE_SLOW,
				{ stack = 1, duration = ability_debuff_duration }
			)
			return
		end
		do
			AddDeBuffStatus(
				nil,
				target,
				parent,
				ability,
				DebuffStatusType.VULNERABLE,
				{ stack = 1, duration = ability_debuff_duration }
			)
		end
	until true
end
function modifier_item_0344_love.prototype.GetAllStats(self, parent)
	local strength = MyGameAttribute:GetAttribute(parent, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	return math.max(0, strength + agility + intelligence)
end
function modifier_item_0344_love.prototype.IsValidEnemy(self, parent, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	return target:GetTeamNumber() ~= parent:GetTeamNumber()
end
function modifier_item_0344_love.prototype.StartAbilityCooldown(self, ability)
	local ability_level = math.max(0, ability:GetLevel() - 1)
	ability:StartCooldown(ability:GetCooldown(ability_level))
end
modifier_item_0344_love = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0344_love)
____exports.modifier_item_0344_love = modifier_item_0344_love
return ____exports