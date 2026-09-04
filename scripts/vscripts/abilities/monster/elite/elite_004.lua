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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local POISON_ZONE_COUNT = 6
local POISON_ZONE_RADIUS = 200
local POISON_DURATION = 5
local POISON_TICK_INTERVAL = 1
local POISON_DAMAGE_RATE = 8
local SPRAY_RANGE = 600
local COOLDOWN = 5
local BULLET_EFFECT = "particles/units/heroes/hero_venomancer/venomancer_latent_poison_projectile.vpcf"
local POISON_EFFECT = "particles/viper_poison_crimson_debuff_ti7.vpcf"
____exports.elite_004 = __TS__Class()
local elite_004 = ____exports.elite_004
elite_004.name = "elite_004"
__TS__ClassExtends(elite_004, MonsterAbility_CS)
function elite_004.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function elite_004.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_004"
end
elite_004 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_004)
____exports.elite_004 = elite_004
____exports.modifier_elite_004 = __TS__Class()
local modifier_elite_004 = ____exports.modifier_elite_004
modifier_elite_004.name = "modifier_elite_004"
__TS__ClassExtends(modifier_elite_004, MonsterModifier_CS)
function modifier_elite_004.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():EmitSound("Hero_Viper.Nethertoxin.Cast")
end
function modifier_elite_004.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if caster:IsStunned() or caster:IsChanneling() or caster:IsSilenced() then
		return
	end
	local origin = caster:GetAbsOrigin()
	local zones = self:GenerateNonOverlappingZones(origin, POISON_ZONE_COUNT)
	for ____, zone in ipairs(zones) do
		CreateProjectile(nil, {
			ability = self:GetAbility(),
			caster = caster,
			effect_name = "particles/boss/boss_001.vpcf",
			target = zone,
			start_point = origin,
			projectile_type = "linear",
			projectile_speed = 700,
			projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			projectile_target_type = DOTA_UNIT_TARGET_NONE,
			projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
			projectile_distance = 2000,
			projectile_range = 0,
		})
		self:CreatePoisonZone(caster, zone)
	end
end
function modifier_elite_004.prototype.GenerateNonOverlappingZones(self, center, count)
	local zones = {}
	local attempts = 0
	while #zones < count and attempts < 100 do
		attempts = attempts + 1
		local angle = math.random() * math.pi * 2
		local dist = RandomFloat(POISON_ZONE_RADIUS, SPRAY_RANGE)
		local candidate = Vector(center.x + math.cos(angle) * dist, center.y + math.sin(angle) * dist, center.z)
		local overlaps = false
		for ____, existing in ipairs(zones) do
			if GetDistance(nil, candidate, existing) < POISON_ZONE_RADIUS * 1.6 then
				overlaps = true
				break
			end
		end
		if not overlaps then
			zones[#zones + 1] = candidate
		end
	end
	return zones
end
function modifier_elite_004.prototype.CreatePoisonZone(self, caster, pos)
	local pfx = ParticleManager:CreateParticle(POISON_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	local ticks = 0
	Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, caster) then
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			return nil
		end
		ticks = ticks + 1
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			pos,
			nil,
			POISON_ZONE_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = POISON_DAMAGE_RATE,
				ability = self:GetAbility(),
			})
		end
		if ticks >= POISON_DURATION then
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			return nil
		end
		return POISON_TICK_INTERVAL
	end)
end
function modifier_elite_004.prototype.IsHidden(self)
	return true
end
function modifier_elite_004.prototype.IsPurgable(self)
	return false
end
modifier_elite_004 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_004)
____exports.modifier_elite_004 = modifier_elite_004
return ____exports