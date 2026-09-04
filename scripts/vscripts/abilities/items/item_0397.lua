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
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ITEM_0397_POISON_BURST_EFFECT = "particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf"
local ITEM_0397_BURST_TAG = "item_0397_poison_burst"
____exports.item_0397 = __TS__Class()
local item_0397 = ____exports.item_0397
item_0397.name = "item_0397"
__TS__ClassExtends(item_0397, BaseItem_CS)
function item_0397.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0397_snake_shadow.name
end
item_0397 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0397)
____exports.item_0397 = item_0397
____exports.modifier_item_0397_snake_shadow = __TS__Class()
local modifier_item_0397_snake_shadow = ____exports.modifier_item_0397_snake_shadow
modifier_item_0397_snake_shadow.name = "modifier_item_0397_snake_shadow"
__TS__ClassExtends(modifier_item_0397_snake_shadow, BaseModifier_CS)
function modifier_item_0397_snake_shadow.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.burstProgress = {}
end
function modifier_item_0397_snake_shadow.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEBUFF_STATUS_APPLY_QUERY }
end
function modifier_item_0397_snake_shadow.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.2)
end
function modifier_item_0397_snake_shadow.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0397_snake_shadow.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return {}
	end
	if not parent:HasModifier("modifier_generic_poison") then
		return {}
	end
	local rolledPoison = ability:GetSpecialValueFor("ability_value_self_poison_bonus_poison_pct")
	local ____math_max_1 = math.max
	local ____temp_0
	if rolledPoison > 0 then
		____temp_0 = rolledPoison
	else
		____temp_0 = ability:GetSpecialValueFor("ability_self_poison_bonus_poison_pct")
	end
	local bonusPoisonPct = ____math_max_1(0, ____temp_0)
	local rolledDamage = ability:GetSpecialValueFor("ability_value_self_poison_bonus_damage_pct")
	local ____math_max_3 = math.max
	local ____temp_2
	if rolledDamage > 0 then
		____temp_2 = rolledDamage
	else
		____temp_2 = ability:GetSpecialValueFor("ability_self_poison_bonus_damage_pct")
	end
	local bonusDamagePct = ____math_max_3(0, ____temp_2)
	return { poison_outgoing_damage_pct = bonusPoisonPct, outgoing_damage_pct = bonusDamagePct }
end
function modifier_item_0397_snake_shadow.prototype.OnDebuffStatusApplyQuery_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.caster ~= parent then
		return
	end
	if event.status ~= DebuffStatusType.POISON then
		return
	end
	if event.cancelled then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target == parent or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local rolledThreshold = ability:GetSpecialValueFor("ability_value_c_burst_stack_threshold")
	local ____math_max_6 = math.max
	local ____math_floor_5 = math.floor
	local ____temp_4
	if rolledThreshold > 0 then
		____temp_4 = rolledThreshold
	else
		____temp_4 = ability:GetSpecialValueFor("ability_burst_stack_threshold")
	end
	local threshold = ____math_max_6(1, ____math_floor_5(____temp_4))
	local ____math_max_11 = math.max
	local ____math_floor_10 = math.floor
	local ____opt_7 = event.params
	if ____opt_7 ~= nil then
		____opt_7 = ____opt_7.stack
	end
	local ____opt_7_9 = ____opt_7
	if ____opt_7_9 == nil then
		____opt_7_9 = 1
	end
	local appliedStack = ____math_max_11(1, ____math_floor_10(__TS__Number(____opt_7_9)))
	local targetIndex = target:entindex()
	local progress = (self.burstProgress[targetIndex] or 0) + appliedStack
	if progress < threshold then
		self.burstProgress[targetIndex] = progress
		return
	end
	self.burstProgress[targetIndex] = progress % threshold
	local rolledPct = ability:GetSpecialValueFor("ability_value_burst_damage_all_stats_pct")
	local ____math_max_13 = math.max
	local ____temp_12
	if rolledPct > 0 then
		____temp_12 = rolledPct
	else
		____temp_12 = ability:GetSpecialValueFor("ability_burst_damage_all_stats_pct")
	end
	local burstPct = ____math_max_13(0, ____temp_12)
	local damage = self:GetAllStats(parent) * (burstPct / 100)
	if damage > 0 then
		Damage:ApplyDamage({
			attacker = parent,
			victim = target,
			damage = damage,
			damage_type = 2,
			ability = ability,
			extra_data = {
				debuff_status = DebuffStatusType.POISON,
				custom_tag = ITEM_0397_BURST_TAG,
				source_name = "item_0397_poison_burst",
			},
		})
	end
	self:PlayEffects3(target)
end
function modifier_item_0397_snake_shadow.prototype.IsHidden(self)
	return true
end
function modifier_item_0397_snake_shadow.prototype.IsPurgable(self)
	return false
end
function modifier_item_0397_snake_shadow.prototype.GetAllStats(self, parent)
	local strength = MyGameAttribute:GetAttribute(parent, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	return math.max(0, strength + agility + intelligence)
end
function modifier_item_0397_snake_shadow.prototype.PlayEffects3(self, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		ITEM_0397_POISON_BURST_EFFECT,
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	target:EmitSound("Hero_Venomancer.PoisonNova")
end
modifier_item_0397_snake_shadow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0397_snake_shadow)
____exports.modifier_item_0397_snake_shadow = modifier_item_0397_snake_shadow
return ____exports