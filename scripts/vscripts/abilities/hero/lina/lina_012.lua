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
local modifier_lina_012_reheat_ring
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local MODIFIER_LINA_012_REHEAT_RING = "modifier_lina_012_reheat_ring"
local LINA_012_REHEAT_CUSTOM_TAG = "lina_012_reheat"
local LINA_012_SHIELD_PARTICLE = "particles/dd/fire_shield_f4.vpcf"
local LINA_012_IMPACT_PARTICLE = "particles/lina/huskar_inner_fire.vpcf"
____exports.lina_012 = __TS__Class()
local lina_012 = ____exports.lina_012
lina_012.name = "lina_012"
__TS__ClassExtends(lina_012, BaseHeroAbility)
function lina_012.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_012_SHIELD_PARTICLE, context)
	PrecacheResource("particle", LINA_012_IMPACT_PARTICLE, context)
end
function lina_012.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING }
end
function lina_012.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local duration = self:GetSpecialValue("lina_012", "duration")
	modifier_lina_012_reheat_ring:applys(caster, caster, self, { duration = duration })
end
lina_012 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_012)
____exports.lina_012 = lina_012
modifier_lina_012_reheat_ring = __TS__Class()
modifier_lina_012_reheat_ring.name = "modifier_lina_012_reheat_ring"
__TS__ClassExtends(modifier_lina_012_reheat_ring, BaseHeroModifier)
function modifier_lina_012_reheat_ring.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.temporaryShield = 0
	self.reheatValue = 0
end
function modifier_lina_012_reheat_ring.GetLocalizationCN(self)
	return {
		name = "回火护环",
		description = "获得临时护盾上限，并将护盾吸收的伤害转化为回火值。",
	}
end
function modifier_lina_012_reheat_ring.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_lina_012_reheat_ring.prototype.GetEffectName(self)
	return LINA_012_SHIELD_PARTICLE
end
function modifier_lina_012_reheat_ring.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	self.temporaryShield = self:CalculateTemporaryShield(parent, ability)
	parent:AddCurrentEnergyShield(self.temporaryShield, "next_frame_delta")
	self.reheatValue = 0
	self:SetStackCount(0)
	self:RefreshAttributes()
	if not IsServer() then
		return
	end
	self:OnReleaseDamage_CS()
end
function modifier_lina_012_reheat_ring.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:AddCurrentEnergyShield(self.temporaryShield, "next_frame_delta")
	self:OnReleaseDamage_CS()
end
function modifier_lina_012_reheat_ring.prototype.GetAttributeBonus(self)
	return { base_energy_shield = self.temporaryShield }
end
function modifier_lina_012_reheat_ring.prototype.OnReleaseDamage_CS(self)
	local parent = self:GetParent()
	local enemies = self:FindMonsterEnemies(parent:GetAbsOrigin(), 350)
	self:PlayImpactEffect(parent, parent, 350)
	local ability = self:GetAbility()
	local damage = ability:GetIntelligence(parent) * ability:GetSpecialValue("lina_012", "int_damage_pct") * 0.01
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(parent, parent:GetAbsOrigin(), 350, ability)
	end
	for ____, enemy in ipairs(enemies) do
		Damage:ApplyDamage({
			attacker = parent,
			victim = enemy,
			damage = damage,
			damage_type = 2,
			ability = self:GetAbility(),
		})
		enemy:KnockBack(parent, self:GetAbility(), {
			duration = 0.1,
			particleName = "",
			distance = 100,
			height = 0,
			origin_pos = parent:GetAbsOrigin(),
		})
	end
end
function modifier_lina_012_reheat_ring.prototype.GetTexture(self)
	return "lina_flame_cloak"
end
function modifier_lina_012_reheat_ring.prototype.CalculateTemporaryShield(self, parent, ability)
	local shieldMaxManaPct = ability:GetSpecialValue("lina_012", "shield_max_mana_pct")
	local totalMana = MyGameAttribute:GetAttribute(parent, "total_mana") or parent:GetMaxMana()
	return math.max(0, totalMana * (shieldMaxManaPct / 100))
end
function modifier_lina_012_reheat_ring.prototype.IsActiveAbilityDamage(self, event)
	if event.is_base_attack then
		return false
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return false
	end
	local ____opt_2 = event.source
	if (____opt_2 and ____opt_2.custom_tag) == LINA_012_REHEAT_CUSTOM_TAG then
		return false
	end
	if (event.final_damage or 0) <= 0 then
		return false
	end
	local sourceAbility = event.ability
	if not sourceAbility or not IsValid(nil, sourceAbility) or sourceAbility:IsNull() then
		return false
	end
	local ____opt_4 = sourceAbility.IsItem
	if ____opt_4 and ____opt_4(sourceAbility) then
		return false
	end
	local ____opt_6 = sourceAbility.GetBehaviorInt
	local behavior = ____opt_6 and ____opt_6(sourceAbility) or 0
	return bit.band(behavior, DOTA_ABILITY_BEHAVIOR_PASSIVE) == 0
end
function modifier_lina_012_reheat_ring.prototype.ApplyReheatExplosion(self, parent, ability, target, reheatValue)
	local damagePct = ability:GetSpecialValueFor("reheat_damage_pct")
	local damage = reheatValue * (damagePct / 100)
	local radius = ability:GetSpecialValue("lina_012", "reheat_radius")
	if damage <= 0 or radius <= 0 then
		return
	end
	self:PlayImpactEffect(target, parent, radius)
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(parent, target:GetAbsOrigin(), radius, ability)
	end
	local enemies = self:FindMonsterEnemies(target:GetAbsOrigin(), radius)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue31
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = ability,
				extra_data = {
					custom_tag = LINA_012_REHEAT_CUSTOM_TAG,
					source_name = ability:GetAbilityName(),
				},
			})
		end
		::__continue31::
	end
end
function modifier_lina_012_reheat_ring.prototype.PlayImpactEffect(self, target, caster, radius)
	local origin = target:GetAbsOrigin()
	EmitSoundOnLocationWithCaster(origin, "Hero_Snapfire.MortimerBlob.Impact", caster)
	local particle =
		MyGameHeroParticleManager:CreateParticle(LINA_012_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, origin)
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
modifier_lina_012_reheat_ring =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_lina_012_reheat_ring") }, modifier_lina_012_reheat_ring)
return ____exports