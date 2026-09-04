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
local ITEM_0341_HIT_PARTICLE = "particles/units/heroes/hero_wisp/wisp_tether_hit.vpcf"
local ITEM_0341_SLOW_EFFECT = "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf"
local ITEM_0341_SLOW_STATUS = "particles/status_fx/status_effect_drow_frost_arrow.vpcf"
____exports.item_0341 = __TS__Class()
local item_0341 = ____exports.item_0341
item_0341.name = "item_0341"
__TS__ClassExtends(item_0341, BaseItem_CS)
function item_0341.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_0341_HIT_PARTICLE, context)
	PrecacheResource("particle", ITEM_0341_SLOW_EFFECT, context)
	PrecacheResource("particle", ITEM_0341_SLOW_STATUS, context)
end
function item_0341.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0341_tracker.name
end
item_0341 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0341)
____exports.item_0341 = item_0341
____exports.modifier_item_0341_tracker = __TS__Class()
local modifier_item_0341_tracker = ____exports.modifier_item_0341_tracker
modifier_item_0341_tracker.name = "modifier_item_0341_tracker"
__TS__ClassExtends(modifier_item_0341_tracker, BaseModifier_CS)
function modifier_item_0341_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0341_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0341_tracker.prototype.IsPurgable(self)
	return false
end
function modifier_item_0341_tracker.prototype.OnAttackLanded_CS(self, event)
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
	local ability_hit_count = math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_hit_count")))
	local ability_all_stats_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_all_stats_damage_pct"))
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_hit_interval = math.max(0.03, ability:GetSpecialValueFor("ability_hit_interval"))
	local ability_slow_pct = math.max(0, ability:GetSpecialValueFor("ability_slow_pct"))
	local ability_slow_duration = math.max(0, ability:GetSpecialValueFor("ability_slow_duration"))
	local damagePerHit = self:GetAllStats(parent) * (ability_all_stats_damage_pct / 100)
	if damagePerHit <= 0 then
		return
	end
	local hitCount = 0
	self:Timer(0, function()
		if not IsValidAlive(nil, parent) or not IsValid(nil, target) then
			return
		end
		local enemies = self:FindDamageTargets(parent, target:GetAbsOrigin(), ability_radius)
		for ____, enemy in ipairs(enemies) do
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				ability = ability,
				damage = damagePerHit,
				damage_type = 2,
				extra_data = {
					damage_tags = DamageTag.DOT,
					source_name = self:GetName(),
				},
			})
		end
		self:PlayHitEffect(target)
		hitCount = hitCount + 1
		if hitCount < ability_hit_count then
			return ability_hit_interval
		end
	end)
	if ability_slow_pct > 0 and ability_slow_duration > 0 then
		if NotifyCustomDebuffApplyQuery(nil, target, parent, ability, ____exports.modifier_item_0341_freeze.name) then
			____exports.modifier_item_0341_freeze:applys(
				target,
				parent,
				ability,
				{ duration = ability_slow_duration, slow_pct = ability_slow_pct }
			)
		end
	end
	self:StartAbilityCooldown(ability)
end
function modifier_item_0341_tracker.prototype.StartAbilityCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	local cooldown = ability:GetCooldown(level)
	local ____ability_1 = ability
	local ____ability_StartCooldown_2 = ability.StartCooldown
	local ____temp_0
	if cooldown > 0 then
		____temp_0 = cooldown
	else
		____temp_0 = 3
	end
	____ability_StartCooldown_2(____ability_1, ____temp_0)
end
function modifier_item_0341_tracker.prototype.GetAllStats(self, parent)
	local strength = MyGameAttribute:GetAttribute(parent, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	return math.max(0, strength + agility + intelligence)
end
function modifier_item_0341_tracker.prototype.FindDamageTargets(self, parent, center, radius)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local result = {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue24
			end
			result[#result + 1] = enemy
		end
		::__continue24::
	end
	return result
end
function modifier_item_0341_tracker.prototype.PlayHitEffect(self, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		ITEM_0341_HIT_PARTICLE,
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
modifier_item_0341_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0341_tracker)
____exports.modifier_item_0341_tracker = modifier_item_0341_tracker
____exports.modifier_item_0341_freeze = __TS__Class()
local modifier_item_0341_freeze = ____exports.modifier_item_0341_freeze
modifier_item_0341_freeze.name = "modifier_item_0341_freeze"
__TS__ClassExtends(modifier_item_0341_freeze, BaseModifier_CS)
function modifier_item_0341_freeze.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.slowPct = 0
end
function modifier_item_0341_freeze.GetLocalizationCN(self)
	return { name = "冰封", description = "移动速度降低。" }
end
function modifier_item_0341_freeze.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:UpdateParams(params)
end
function modifier_item_0341_freeze.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:UpdateParams(params)
end
function modifier_item_0341_freeze.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -self.slowPct }
end
function modifier_item_0341_freeze.prototype.IsHidden(self)
	return false
end
function modifier_item_0341_freeze.prototype.IsDebuff(self)
	return true
end
function modifier_item_0341_freeze.prototype.IsPurgable(self)
	return true
end
function modifier_item_0341_freeze.prototype.GetEffectName(self)
	return ITEM_0341_SLOW_EFFECT
end
function modifier_item_0341_freeze.prototype.GetStatusEffectName(self)
	return ITEM_0341_SLOW_STATUS
end
function modifier_item_0341_freeze.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_0341_freeze.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_item_0341_freeze.prototype.GetTexture(self)
	return "ancient_apparition_chilling_touch"
end
function modifier_item_0341_freeze.prototype.UpdateParams(self, params)
	self.slowPct = math.max(0, tonumber(params.slow_pct or 0))
	self:RefreshAttributes()
end
modifier_item_0341_freeze = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0341_freeze)
____exports.modifier_item_0341_freeze = modifier_item_0341_freeze
return ____exports