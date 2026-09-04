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
--- 击杀叠加灵魂，灵魂层数提升攻击力，死亡后层数清零。
____exports.item_0258 = __TS__Class()
local item_0258 = ____exports.item_0258
item_0258.name = "item_0258"
__TS__ClassExtends(item_0258, BaseItem_CS)
function item_0258.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0258.name
end
item_0258 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0258)
____exports.item_0258 = item_0258
____exports.modifier_item_0258 = __TS__Class()
local modifier_item_0258 = ____exports.modifier_item_0258
modifier_item_0258.name = "modifier_item_0258"
__TS__ClassExtends(modifier_item_0258, BaseModifier_CS)
function modifier_item_0258.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH, target = { scope = "global" } } }
end
function modifier_item_0258.GetLocalizationCN(self)
	return { name = "附魂", description = "击杀单位获得灵魂，死亡时失去所有灵魂。" }
end
function modifier_item_0258.prototype.OnUnitDeath_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ____event_entindex_killed_0
	if event.entindex_killed then
		____event_entindex_killed_0 = EntIndexToHScript(event.entindex_killed)
	else
		____event_entindex_killed_0 = nil
	end
	local killed = ____event_entindex_killed_0
	local ____event_entindex_attacker_1
	if event.entindex_attacker then
		____event_entindex_attacker_1 = EntIndexToHScript(event.entindex_attacker)
	else
		____event_entindex_attacker_1 = nil
	end
	local attacker = ____event_entindex_attacker_1
	local ability = self:GetAbility()
	if not killed or not ability then
		return
	end
	if killed == parent then
		if self:GetStackCount() ~= 0 then
			self:SetStackCount(0)
			self:RefreshAttributes()
		end
		return
	end
	if attacker ~= parent then
		return
	end
	if killed:IsBuilding() then
		return
	end
	self:PlayEffect(killed)
	local maxSouls = ability:GetSpecialValueFor("ability_max_souls")
	local nextStacks = math.min(maxSouls, self:GetStackCount() + 1)
	if nextStacks == self:GetStackCount() then
		return
	end
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
function modifier_item_0258.prototype.PlayEffect(self, target)
	local caster = self:GetCaster()
	CreateProjectile(nil, {
		projectile_type = "tracking",
		target = caster,
		caster = target,
		ability = self:GetAbility(),
		effect_name = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf",
		projectile_speed = 800,
		start_point = target:GetAbsOrigin(),
	})
end
function modifier_item_0258.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_2
	if ability then
		____ability_2 = ability:GetSpecialValueFor("ability_bonus_attack_damage_per_soul")
	else
		____ability_2 = 0
	end
	local bonusAttackPerSoul = ____ability_2
	return { bonus_attack_damage = self:GetStackCount() * bonusAttackPerSoul }
end
function modifier_item_0258.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0258.prototype.IsPurgable(self)
	return false
end
modifier_item_0258 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0258)
____exports.modifier_item_0258 = modifier_item_0258
return ____exports