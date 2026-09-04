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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____ability_tag_context = require("shared.ability_tag_context")
local ResolveAbilityTags = ____ability_tag_context.ResolveAbilityTags
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local AOE_PARTICLE = "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp.vpcf"
local CUSTOM_TAG_0352 = "item_0352_sonic_strike"
____exports.item_0352 = __TS__Class()
local item_0352 = ____exports.item_0352
item_0352.name = "item_0352"
__TS__ClassExtends(item_0352, BaseItem_CS)
function item_0352.prototype.Precache(self, context)
	PrecacheResource("particle", AOE_PARTICLE, context)
end
function item_0352.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0352_sonic_barrier_tracker.name
end
item_0352 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0352)
____exports.item_0352 = item_0352
____exports.modifier_item_0352_sonic_barrier_tracker = __TS__Class()
local modifier_item_0352_sonic_barrier_tracker = ____exports.modifier_item_0352_sonic_barrier_tracker
modifier_item_0352_sonic_barrier_tracker.name = "modifier_item_0352_sonic_barrier_tracker"
__TS__ClassExtends(modifier_item_0352_sonic_barrier_tracker, BaseModifier_CS)
function modifier_item_0352_sonic_barrier_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0352_sonic_barrier_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0352_sonic_barrier_tracker.prototype.IsPurgable(self)
	return false
end
function modifier_item_0352_sonic_barrier_tracker.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	local ____opt_0 = castAbility.IsItem
	if ____opt_0 and ____opt_0(castAbility) then
		return
	end
	local ____opt_2 = castAbility.IsToggle
	if ____opt_2 and ____opt_2(castAbility) then
		return
	end
	if not self:IsMovementAbility(castAbility) then
		return
	end
	local ability_duration = math.max(0, ability:GetSpecialValueFor("ability_value_haste_duration"))
	if ability_duration <= 0 then
		return
	end
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0352_sonic_barrier.name,
		{ duration = ability_duration }
	)
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0352_empowered_strike.name,
		{ duration = ability_duration }
	)
end
function modifier_item_0352_sonic_barrier_tracker.prototype.IsMovementAbility(self, ability)
	local tags = ResolveAbilityTags(
		nil,
		MyGameRulesetManager and MyGameRulesetManager:GetAbilityConfig(ability:GetAbilityName())
	)
	return bit.band(tags, 4) ~= 0
end
modifier_item_0352_sonic_barrier_tracker =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0352_sonic_barrier_tracker)
____exports.modifier_item_0352_sonic_barrier_tracker = modifier_item_0352_sonic_barrier_tracker
____exports.modifier_item_0352_sonic_barrier = __TS__Class()
local modifier_item_0352_sonic_barrier = ____exports.modifier_item_0352_sonic_barrier
modifier_item_0352_sonic_barrier.name = "modifier_item_0352_sonic_barrier"
__TS__ClassExtends(modifier_item_0352_sonic_barrier, BaseModifier_CS)
function modifier_item_0352_sonic_barrier.GetLocalizationCN(self)
	return { name = "音障", description = "攻击速度和移动速度提高。" }
end
function modifier_item_0352_sonic_barrier.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local particle =
		ParticleManager:CreateParticle("particles/items2_fx/mask_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_item_0352_sonic_barrier.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	return {
		attack_speed = math.max(0, ability:GetSpecialValueFor("ability_bonus_attack_speed")),
		bonus_movespeed_pct = math.max(0, ability:GetSpecialValueFor("ability_bonus_movespeed_pct")),
	}
end
function modifier_item_0352_sonic_barrier.prototype.IsHidden(self)
	return false
end
function modifier_item_0352_sonic_barrier.prototype.IsDebuff(self)
	return false
end
function modifier_item_0352_sonic_barrier.prototype.IsPurgable(self)
	return true
end
function modifier_item_0352_sonic_barrier.prototype.GetTexture(self)
	return "item_force_boots"
end
modifier_item_0352_sonic_barrier = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0352_sonic_barrier)
____exports.modifier_item_0352_sonic_barrier = modifier_item_0352_sonic_barrier
--- 蓄势一击：位移技能后获得，监听首次攻击命中敌人，对其周围 ability_aoe_radius 范围内敌人
-- 造成 ability_value_health_damage_pct% 自身最大生命值的物理 AOE，随即消耗（销毁自身）。
-- 防回环用 NO_PROC + custom_tag（AOE 伤害不再触发自身一击）。
____exports.modifier_item_0352_empowered_strike = __TS__Class()
local modifier_item_0352_empowered_strike = ____exports.modifier_item_0352_empowered_strike
modifier_item_0352_empowered_strike.name = "modifier_item_0352_empowered_strike"
__TS__ClassExtends(modifier_item_0352_empowered_strike, BaseModifier_CS)
function modifier_item_0352_empowered_strike.GetLocalizationCN(self)
	return { name = "蓄势一击", description = "下一次攻击将造成范围生命值物理伤害。" }
end
function modifier_item_0352_empowered_strike.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0352_empowered_strike.prototype.IsHidden(self)
	return false
end
function modifier_item_0352_empowered_strike.prototype.IsDebuff(self)
	return false
end
function modifier_item_0352_empowered_strike.prototype.IsPurgable(self)
	return false
end
function modifier_item_0352_empowered_strike.prototype.GetTexture(self)
	return "item_force_boots"
end
function modifier_item_0352_empowered_strike.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local target = event.target
	if not self:IsValidEnemy(parent, target) then
		return
	end
	local radius = math.max(0, ability:GetSpecialValueFor("ability_aoe_radius"))
	local healthPct = math.max(0, ability:GetSpecialValueFor("ability_value_health_damage_pct"))
	local maxHealth = math.max(0, MyGameAttribute:GetAttribute(parent, "total_health") or parent:GetMaxHealth())
	local damage = maxHealth * (healthPct / 100)
	if radius > 0 and damage > 0 then
		local centerPos = target:GetAbsOrigin()
		self:PlayEffectsAt(parent, centerPos, radius)
		local enemies = FindUnitsInRadius(
			parent:GetTeamNumber(),
			centerPos,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			do
				if not self:IsValidEnemy(parent, enemy) then
					goto __continue38
				end
				Damage:ApplyDamage({
					attacker = parent,
					victim = enemy,
					damage = damage,
					damage_type = 1,
					ability = ability,
					extra_data = {
						damage_tags = DamageTag.NO_PROC,
						custom_tag = CUSTOM_TAG_0352,
						source_name = self:GetName(),
					},
				})
			end
			::__continue38::
		end
	end
	self:Destroy()
end
function modifier_item_0352_empowered_strike.prototype.IsValidEnemy(self, parent, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	return target:GetTeamNumber() ~= parent:GetTeamNumber()
end
function modifier_item_0352_empowered_strike.prototype.PlayEffectsAt(self, parent, pos, radius)
	local particle = MyGameHeroParticleManager:CreateParticle(AOE_PARTICLE, PATTACH_CUSTOMORIGIN, parent, parent)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, pos)
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(radius, 1, 1))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOnLocationWithCaster(pos, "Hero_Centaur.HoofStomp", parent)
end
modifier_item_0352_empowered_strike =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0352_empowered_strike)
____exports.modifier_item_0352_empowered_strike = modifier_item_0352_empowered_strike
return ____exports