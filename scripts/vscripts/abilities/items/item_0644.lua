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
local SELF_POISON_STACK = 1
local SELF_POISON_CHECK_INTERVAL = 1
____exports.item_0644 = __TS__Class()
local item_0644 = ____exports.item_0644
item_0644.name = "item_0644"
__TS__ClassExtends(item_0644, BaseItem_CS)
function item_0644.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0644_world_curse.name
end
item_0644 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0644)
____exports.item_0644 = item_0644
____exports.modifier_item_0644_world_curse = __TS__Class()
local modifier_item_0644_world_curse = ____exports.modifier_item_0644_world_curse
modifier_item_0644_world_curse.name = "modifier_item_0644_world_curse"
__TS__ClassExtends(modifier_item_0644_world_curse, BaseModifier_CS)
function modifier_item_0644_world_curse.GetLocalizationCN(self)
	return {
		name = "蚀界诅咒",
		description = "生命值大于50%时使自身处于中毒状态且中毒伤害降低；中毒可以造成魔法暴击。",
	}
end
function modifier_item_0644_world_curse.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:EnsureSelfPoison()
	self:StartIntervalThink(SELF_POISON_CHECK_INTERVAL)
end
function modifier_item_0644_world_curse.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local rolled = ability:GetSpecialValueFor("ability_value_c_poison_damage_reduction_pct")
	local ____math_max_1 = math.max
	local ____temp_0
	if rolled > 0 then
		____temp_0 = rolled
	else
		____temp_0 = ability:GetSpecialValueFor("ability_c_poison_damage_reduction_pct")
	end
	local reductionPct = ____math_max_1(0, ____temp_0)
	return { poison_outgoing_damage_pct = -reductionPct }
end
function modifier_item_0644_world_curse.prototype.OnIntervalThink(self)
	self:EnsureSelfPoison()
end
function modifier_item_0644_world_curse.prototype.EnsureSelfPoison(self)
	local parent = self:GetParent()
	if not parent or not IsValidAlive(nil, parent) then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_self_poison_health_pct = math.max(0, ability:GetSpecialValueFor("ability_self_poison_health_pct"))
	if parent:GetHealthPercent() <= ability_self_poison_health_pct then
		local selfPoison = parent:FindModifierByNameAndCaster("modifier_generic_poison", parent)
		if selfPoison then
			selfPoison:Destroy()
		end
		return
	end
	if parent:HasModifier("modifier_generic_poison") then
		return
	end
	AddDeBuffStatus(nil, parent, parent, ability, DebuffStatusType.POISON, { stack = SELF_POISON_STACK })
end
function modifier_item_0644_world_curse.prototype.GetMutexKey(self)
	return "item_0644_poison_curse_mutex"
end
function modifier_item_0644_world_curse.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0644" and 200 or 100
end
function modifier_item_0644_world_curse.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_CRIT_QUERY }
end
function modifier_item_0644_world_curse.prototype.OnDamageCritQuery_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.ctx.spec.attacker ~= parent then
		return
	end
	if event.ctx.spec.victim == parent then
		return
	end
	local source = event.ctx.spec.source
	if not source or source.debuff_status ~= DebuffStatusType.POISON then
		return
	end
	local magicalCritChancePct = math.max(0, MyGameAttribute:GetAttribute(parent, "magical_crit_chance_pct") or 0)
	local omniCritChancePct = math.max(0, MyGameAttribute:GetAttribute(parent, "omni_crit_chance_pct") or 0)
	local totalMagicalCritChancePct = math.max(0, math.min(100, magicalCritChancePct + omniCritChancePct))
	if totalMagicalCritChancePct <= 0 then
		return
	end
	if RollPseudoRandomPercentage(totalMagicalCritChancePct, DOTA_PSEUDO_RANDOM_PHANTOMASSASSIN_CRIT, parent) then
		event.force_crit = true
	end
end
function modifier_item_0644_world_curse.prototype.IsHidden(self)
	return false
end
function modifier_item_0644_world_curse.prototype.IsDebuff(self)
	return true
end
function modifier_item_0644_world_curse.prototype.IsPurgable(self)
	return false
end
function modifier_item_0644_world_curse.prototype.GetTexture(self)
	return "venomancer_poison_sting"
end
modifier_item_0644_world_curse = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0644_world_curse)
____exports.modifier_item_0644_world_curse = modifier_item_0644_world_curse
return ____exports