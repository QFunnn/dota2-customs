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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local LINA_010_PROJECTILE_PARTICLE = "particles/units/heroes/hero_snapfire/snapfire_lizard_blobs_arced.vpcf"
local LINA_010_IMPACT_PARTICLE = "particles/lina/huskar_inner_fire.vpcf"
--- 丽娜技能 010：Q 熔岩弹（点地 collideground 投射物）
____exports.lina_010 = __TS__Class()
local lina_010 = ____exports.lina_010
lina_010.name = "lina_010"
__TS__ClassExtends(lina_010, BaseHeroAbility)
function lina_010.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_010_PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", LINA_010_IMPACT_PARTICLE, context)
end
function lina_010.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0.45,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE,
	}
end
function lina_010.prototype.GetAOERadius(self)
	return self:GetSpecialValue("lina_010", "impact_radius")
end
function lina_010.prototype.OnAbilityPhaseStart(self)
	if not IsServer() then
		return false
	end
	self:GetCaster():EmitSound("Ability.PreLightStrikeArray")
	return true
end
function lina_010.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local cursor = self:GetCursorPosition()
	local projectileSpeed = self:GetSpecialValue("lina_010", "projectile_speed")
	local impactRadius = self:GetSpecialValue("lina_010", "impact_radius")
	local stunDuration = self:GetSpecialValue("lina_010", "stun_duration")
	local intDamagePct = self:GetSpecialValue("lina_010", "int_damage_pct")
	local burnDuration = self:GetSpecialValue("lina_010", "burn_duration")
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____temp_3 = not IsValid(nil, self)
	if not ____temp_3 then
		local ____opt_0 = self.IsNull
		local ____temp_2 = ____opt_0 and ____opt_0(self)
		if ____temp_2 == nil then
			____temp_2 = false
		end
		____temp_3 = ____temp_2
	end
	if ____temp_3 then
		return
	end
	caster:EmitSound("Hero_Lina.FlameCloak.Cast")
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		projectile_type = "collideground",
		effect_name = LINA_010_PROJECTILE_PARTICLE,
		projectile_speed = projectileSpeed,
		target = cursor,
		on_hit = function(____, _hitTarget, location)
			if not IsServer() then
				return true
			end
			if not IsValidAlive(nil, caster) then
				return true
			end
			local groundZ = GetGroundHeight(location, caster) or location.z
			local center = Vector(location.x, location.y, groundZ)
			EmitSoundOnLocationWithCaster(location, "Ability.LightStrikeArray", caster)
			self:PlayImpactEffects(center, impactRadius)
			self:DealImpactDamage(caster, center, impactRadius, intDamagePct, stunDuration, burnDuration)
			return true
		end,
	})
end
function lina_010.prototype.PlayImpactEffects(self, center, radius)
	local caster = self:GetCaster()
	local pid = MyGameHeroParticleManager:CreateParticle(LINA_010_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(pid, 0, center)
	MyGameHeroParticleManager:SetParticleControl(pid, 1, Vector(radius, 0, 0))
	MyGameHeroParticleManager:ReleaseParticleIndex(pid)
end
function lina_010.prototype.DealImpactDamage(self, caster, center, radius, intDamagePct, stunDuration, burnDuration)
	local hero = caster
	if not IsValidAlive(nil, hero) then
		return
	end
	local intellect = hero:GetIntellect(false)
	local damage = intellect * intDamagePct / 100
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(caster, center, radius, self)
	end
	local enemies = self:FindMonsterEnemies(center, radius)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue17
			end
			local ____opt_6 = enemy.GetUnitType
			local ut = ____opt_6 and ____opt_6(enemy)
			if ut == UnitType.BUILDING or ut == UnitType.DESTRUCTIBLE then
				goto __continue17
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = self,
				extra_data = { source_name = self:GetAbilityName() },
			})
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = stunDuration })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.BURN, { duration = burnDuration })
		end
		::__continue17::
	end
end
lina_010 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_010)
____exports.lina_010 = lina_010
return ____exports