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
local ITEM_0340_DAMAGE_RADIUS = 300
local ITEM_0340_DEFAULT_COOLDOWN = 8
____exports.item_0340 = __TS__Class()
local item_0340 = ____exports.item_0340
item_0340.name = "item_0340"
__TS__ClassExtends(item_0340, BaseItem_CS)
function item_0340.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0340_charged.name
end
item_0340 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0340)
____exports.item_0340 = item_0340
____exports.modifier_item_0340_charged = __TS__Class()
local modifier_item_0340_charged = ____exports.modifier_item_0340_charged
modifier_item_0340_charged.name = "modifier_item_0340_charged"
__TS__ClassExtends(modifier_item_0340_charged, BaseModifier_CS)
function modifier_item_0340_charged.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0340_charged.GetLocalizationCN(self)
	return { name = "毁灭重击", description = "下一次攻击造成范围伤害，并降低敌人的攻击力。" }
end
function modifier_item_0340_charged.prototype.OnAttackLanded_CS(self, event)
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
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local maxHealthDamagePct = math.max(0, ability:GetSpecialValue("item_0340", "ability_value_max_health_damage_pct"))
	if maxHealthDamagePct <= 0 then
		return
	end
	local maxHealth = math.max(0, MyGameAttribute:GetAttribute(parent, "total_health") or parent:GetMaxHealth())
	local damage = maxHealth * maxHealthDamagePct / 100
	if damage <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		ITEM_0340_DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue13
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = damage,
				damage_type = 1,
				ability = ability,
			})
			____exports.modifier_item_0340_destroyed:applys(
				enemy,
				parent,
				ability,
				{ duration = ability:GetSpecialValue("item_0340", "ability_debuff_duration") }
			)
		end
		::__continue13::
	end
	self:PlayEffects(target)
	self:StartAbilityCooldown(ability)
end
function modifier_item_0340_charged.prototype.IsHidden(self)
	return false
end
function modifier_item_0340_charged.prototype.IsDebuff(self)
	return false
end
function modifier_item_0340_charged.prototype.IsPurgable(self)
	return false
end
function modifier_item_0340_charged.prototype.GetTexture(self)
	return "item_icon_40"
end
function modifier_item_0340_charged.prototype.StartAbilityCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	local cooldown = ability:GetCooldown(level)
	local ____ability_1 = ability
	local ____ability_StartCooldown_2 = ability.StartCooldown
	local ____temp_0
	if cooldown > 0 then
		____temp_0 = cooldown
	else
		____temp_0 = ITEM_0340_DEFAULT_COOLDOWN
	end
	____ability_StartCooldown_2(____ability_1, ____temp_0)
end
function modifier_item_0340_charged.prototype.PlayEffects(self, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/econ/events/ti9/shovel_revealed_stasis_trap.vpcf",
		PATTACH_ABSORIGIN,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Hero_EarthShaker.Totem.Attack", target)
	ScreenShake(target:GetAbsOrigin(), 6, 6, 0.2, 800, 0, true)
end
modifier_item_0340_charged = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0340_charged)
____exports.modifier_item_0340_charged = modifier_item_0340_charged
____exports.modifier_item_0340_destroyed = __TS__Class()
local modifier_item_0340_destroyed = ____exports.modifier_item_0340_destroyed
modifier_item_0340_destroyed.name = "modifier_item_0340_destroyed"
__TS__ClassExtends(modifier_item_0340_destroyed, BaseModifier_CS)
function modifier_item_0340_destroyed.GetLocalizationCN(self)
	return { name = "毁灭", description = "攻击力降低，可叠加。" }
end
function modifier_item_0340_destroyed.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:AddOneStack()
end
function modifier_item_0340_destroyed.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:AddOneStack()
end
function modifier_item_0340_destroyed.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local attackReductionPct = math.max(0, ability:GetSpecialValue("item_0340", "ability_attack_reduction_pct"))
	local stacks = math.max(0, self:GetStackCount())
	if attackReductionPct <= 0 or stacks <= 0 then
		return {}
	end
	return { base_attack_damage_percent = -attackReductionPct * stacks }
end
function modifier_item_0340_destroyed.prototype.IsHidden(self)
	return true
end
function modifier_item_0340_destroyed.prototype.IsDebuff(self)
	return true
end
function modifier_item_0340_destroyed.prototype.IsPurgable(self)
	return true
end
function modifier_item_0340_destroyed.prototype.GetTexture(self)
	return "item_icon_40"
end
function modifier_item_0340_destroyed.prototype.AddOneStack(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local maxStacks = math.max(1, math.floor(ability:GetSpecialValue("item_0340", "ability_max_stacks")))
	local nextStacks = math.min(self:GetStackCount() + 1, maxStacks)
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
modifier_item_0340_destroyed = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0340_destroyed)
____exports.modifier_item_0340_destroyed = modifier_item_0340_destroyed
return ____exports