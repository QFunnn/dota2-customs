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
local THINK_INTERVAL = 0.1
local PROJECTILE_SPEED = 1100
local LAUNCH_HEIGHT = 100
local FIREBALL_PARTICLE = "particles/units/heroes/hero_phoenix/phoenix_base_attack.vpcf"
____exports.item_0524 = __TS__Class()
local item_0524 = ____exports.item_0524
item_0524.name = "item_0524"
__TS__ClassExtends(item_0524, BaseItem_CS)
function item_0524.prototype.Precache(self, context)
	PrecacheResource("particle", FIREBALL_PARTICLE, context)
end
function item_0524.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0524_fire_spirits.name
end
item_0524 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0524)
____exports.item_0524 = item_0524
____exports.modifier_item_0524_fire_spirits = __TS__Class()
local modifier_item_0524_fire_spirits = ____exports.modifier_item_0524_fire_spirits
modifier_item_0524_fire_spirits.name = "modifier_item_0524_fire_spirits"
__TS__ClassExtends(modifier_item_0524_fire_spirits, BaseModifier_CS)
function modifier_item_0524_fire_spirits.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.storedDistance = 0
	self.nextFireballTime = 0
end
function modifier_item_0524_fire_spirits.GetLocalizationCN(self)
	return {
		name = "火识",
		description = "移动积攒火识层数；附近有敌人时消耗火识发射火球，造成最大魔法值魔法伤害并可能灼烧。",
	}
end
function modifier_item_0524_fire_spirits.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.lastPosition = self:GetParent():GetAbsOrigin()
	self.storedDistance = 0
	self.nextFireballTime = 0
	self:SetStackCount(0)
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0524_fire_spirits.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0524_fire_spirits.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local now = GameRules:GetGameTime()
	local cur = parent:GetAbsOrigin()
	if self.lastPosition then
		self.storedDistance = self.storedDistance + GetDistance(nil, self.lastPosition, cur)
	end
	self.lastPosition = cur
	local distancePerStack = math.max(1, ability:GetSpecialValueFor("ability_distance_per_summon"))
	local maxStacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_max_spirits")))
	local stacks = self:GetStackCount()
	while self.storedDistance >= distancePerStack and stacks < maxStacks do
		self.storedDistance = self.storedDistance - distancePerStack
		stacks = stacks + 1
	end
	if stacks >= maxStacks then
		self.storedDistance = 0
	end
	if stacks ~= self:GetStackCount() then
		self:SetStackCount(stacks)
	end
	if stacks <= 0 then
		return
	end
	if now < self.nextFireballTime then
		return
	end
	local radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local target = self:FindClosestEnemy(parent, radius)
	if not target then
		return
	end
	local fireballCd = math.max(0.1, ability:GetSpecialValueFor("ability_attack_interval"))
	self.nextFireballTime = now + fireballCd
	self:SetStackCount(stacks - 1)
	self:LaunchFireball(parent, ability, target)
end
function modifier_item_0524_fire_spirits.prototype.FindClosestEnemy(self, parent, radius)
	if radius <= 0 then
		return nil
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue21
			end
			return enemy
		end
		::__continue21::
	end
	return nil
end
function modifier_item_0524_fire_spirits.prototype.LaunchFireball(self, caster, ability, target)
	local manaPct = math.max(0, ability:GetSpecialValueFor("ability_value_mana_damage_pct"))
	local burnDuration = math.max(0, ability:GetSpecialValueFor("ability_burn_duration"))
	local burnChance = math.max(0, ability:GetSpecialValueFor("ability_burn_chance_pct"))
	local damage = self:GetMaxMana(caster) * (manaPct / 100)
	if damage <= 0 then
		return
	end
	local startPoint = caster:GetAbsOrigin() + Vector(0, 0, LAUNCH_HEIGHT)
	CreateProjectile(nil, {
		caster = caster,
		ability = ability,
		effect_name = FIREBALL_PARTICLE,
		target = target,
		start_point = startPoint,
		projectile_type = "tracking",
		projectile_speed = PROJECTILE_SPEED,
		on_hit = function(____, hitTarget)
			if not IsServer() then
				return true
			end
			if
				not IsValidAlive(nil, caster)
				or not hitTarget
				or not IsValidAlive(nil, hitTarget)
				or hitTarget:IsBuilding()
			then
				return true
			end
			if hitTarget:GetTeamNumber() == caster:GetTeamNumber() then
				return true
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = hitTarget,
				damage = damage,
				damage_type = 2,
				ability = ability,
				extra_data = {
					damage_tags = DamageTag.NO_PROC,
					custom_tag = "item_0524_fireball",
					source_name = self:GetName(),
				},
			})
			if burnDuration > 0 and RollPercentage(burnChance) then
				AddDeBuffStatus(nil, hitTarget, caster, ability, DebuffStatusType.BURN, { duration = burnDuration })
			end
			return true
		end,
	})
end
function modifier_item_0524_fire_spirits.prototype.GetMaxMana(self, unit)
	return math.max(0, MyGameAttribute:GetAttribute(unit, "total_mana") or 0)
end
function modifier_item_0524_fire_spirits.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0524_fire_spirits.prototype.IsPurgable(self)
	return false
end
modifier_item_0524_fire_spirits = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0524_fire_spirits)
____exports.modifier_item_0524_fire_spirits = modifier_item_0524_fire_spirits
return ____exports