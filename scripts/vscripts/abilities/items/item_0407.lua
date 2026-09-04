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
____exports.item_0407 = __TS__Class()
local item_0407 = ____exports.item_0407
item_0407.name = "item_0407"
__TS__ClassExtends(item_0407, BaseItem_CS)
function item_0407.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0407_ember_ring.name
end
item_0407 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0407)
____exports.item_0407 = item_0407
____exports.modifier_item_0407_ember_ring = __TS__Class()
local modifier_item_0407_ember_ring = ____exports.modifier_item_0407_ember_ring
modifier_item_0407_ember_ring.name = "modifier_item_0407_ember_ring"
__TS__ClassExtends(modifier_item_0407_ember_ring, BaseModifier_CS)
function modifier_item_0407_ember_ring.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0407_ember_ring.prototype.IsHidden(self)
	return true
end
function modifier_item_0407_ember_ring.prototype.IsPurgable(self)
	return false
end
function modifier_item_0407_ember_ring.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if not self:IsValidTriggerDamage(event) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local target = event.victim
	if not self:IsValidEnemy(parent, target) then
		return
	end
	if target:HasModifier("modifier_generic_burning") then
		return
	end
	local ability_burn_duration = ability:GetSpecialValueFor("ability_burn_duration")
	if ability_burn_duration <= 0 then
		return
	end
	AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.BURN, { duration = ability_burn_duration })
	self:StartAbilityCooldown(ability)
	self:PlayEffects1(target)
end
function modifier_item_0407_ember_ring.prototype.IsValidTriggerDamage(self, event)
	if (event.final_damage or 0) <= 0 then
		return false
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return false
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.DOT) then
		return false
	end
	local ____opt_3 = event.source
	if (____opt_3 and ____opt_3.custom_tag) == "item_0408_ash_codex" then
		return false
	end
	return true
end
function modifier_item_0407_ember_ring.prototype.IsValidEnemy(self, parent, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	return target:GetTeamNumber() ~= parent:GetTeamNumber()
end
function modifier_item_0407_ember_ring.prototype.StartAbilityCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	local ability_cooldown = ability:GetCooldown(level)
	local ____ability_6 = ability
	local ____ability_StartCooldown_7 = ability.StartCooldown
	local ____temp_5
	if ability_cooldown > 0 then
		____temp_5 = ability_cooldown
	else
		____temp_5 = 0.5
	end
	____ability_StartCooldown_7(____ability_6, ____temp_5)
end
function modifier_item_0407_ember_ring.prototype.PlayEffects1(self, target)
	EmitSoundOn("Hero_Huskar.Burning_Spear.Cast", target)
end
modifier_item_0407_ember_ring = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0407_ember_ring)
____exports.modifier_item_0407_ember_ring = modifier_item_0407_ember_ring
return ____exports