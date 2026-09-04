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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local imba_grimstroke_dark_artistry_modfier
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local BACKSTEP_DISTANCE = 400
local SEARCH_RANGE = 3000
local BARRAGE_DURATION = 0.5
local IMPACT_RADIUS = 250
local IMPACT_DAMAGE_RATE = 6
local IMPACT_DAMAGE_TICKS = 4
____exports.boss_night_002 = __TS__Class()
local boss_night_002 = ____exports.boss_night_002
boss_night_002.name = "boss_night_002"
__TS__ClassExtends(boss_night_002, MonsterAbility_CS)
function boss_night_002.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.3,
		castDuration = 1.8,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_3_END,
		isNotMove = true,
		OnStart = function()
			return self:startBackstepBarrage()
		end,
	}
end
function boss_night_002.prototype.startBackstepBarrage(self)
	local caster = self:GetCaster()
	caster:AddNewModifier(caster, self, "modifier_pause_actions", { duration = 1.8 })
	ParticleManager:CreateParticle(
		"particles/econ/events/diretide_2020/death_effect/death_dt20_post.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
	local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
	caster:SetForwardVector(
		target and GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin()) or caster:GetForwardVector()
	)
	caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-BACKSTEP_DISTANCE)), 0.3)
	self:Timer(0.6, function()
		caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
		imba_grimstroke_dark_artistry_modfier:applys(caster, caster, self, { duration = BARRAGE_DURATION })
	end)
end
boss_night_002 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_night_002)
____exports.boss_night_002 = boss_night_002
imba_grimstroke_dark_artistry_modfier = __TS__Class()
imba_grimstroke_dark_artistry_modfier.name = "imba_grimstroke_dark_artistry_modfier"
__TS__ClassExtends(imba_grimstroke_dark_artistry_modfier, BaseModifier_CS)
function imba_grimstroke_dark_artistry_modfier.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.03)
end
function imba_grimstroke_dark_artistry_modfier.prototype.OnIntervalThink(self)
	self:createProjectileArc()
end
function imba_grimstroke_dark_artistry_modfier.prototype.createProjectileArc(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:EmitSound("Hero_Spectre.DaggerCast")
	local p0 = caster:GetAbsOrigin()
	local p3 = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(math.random(900, 1500)))
	local fv = p0:__sub(p3):Normalized()
	local ____temp_0
	if math.random(1, 2) == 1 then
		____temp_0 = -math.random(50, 100)
	else
		____temp_0 = math.random(50, 100)
	end
	local angle = ____temp_0
	local fv2 = RotateVector2D(nil, fv, angle)
	local p1 = p0:__add(fv:__mul(500)):__add(fv2:__mul(1500))
	p1.z = math.random(258, 1500)
	local impactPoint = p3:__add(Vector(math.random(-600, 600), math.random(-600, 600), 0))
	local travelTime = math.random(1.1, 1.6)
	self:playBezierParticle("particles/zisefeibiao/beastmaster_wildaxe_p.vpcf", { p0, p1, impactPoint }, travelTime)
	self:Timer(travelTime, function()
		return self:explodeProjectile(caster, impactPoint)
	end)
end
function imba_grimstroke_dark_artistry_modfier.prototype.explodeProjectile(self, caster, impactPoint)
	if not IsValidAlive(nil, caster) then
		return
	end
	local groundImpactPoint = GetGroundPosition(impactPoint, caster)
	self:playImpactParticle(groundImpactPoint)
	local tick = 0
	Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		tick = tick + 1
		self:damageImpactArea(caster, groundImpactPoint)
		if tick < IMPACT_DAMAGE_TICKS then
			return 0.06
		end
	end)
	ScreenShake(groundImpactPoint, 20, 20, 0.1, 2500, 0, true)
end
function imba_grimstroke_dark_artistry_modfier.prototype.playImpactParticle(self, impactPoint)
	local burst = ParticleManager:CreateParticle(
		"particles/nightstalker_crippling_fear_aura_burst.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(burst, 0, impactPoint)
	ParticleManager:ReleaseParticleIndex(burst)
	local aura = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_night_stalker/nightstalker_crippling_fear_aura.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(aura, 0, impactPoint)
	ParticleManager:SetParticleControl(aura, 2, Vector(IMPACT_RADIUS, IMPACT_RADIUS, 0))
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(aura, true)
		ParticleManager:ReleaseParticleIndex(aura)
	end)
end
function imba_grimstroke_dark_artistry_modfier.prototype.damageImpactArea(self, caster, impactPoint)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		impactPoint,
		nil,
		IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		return caster:MonsterDamage({
			victim = enemy,
			damage_rate = IMPACT_DAMAGE_RATE,
			ability = self:GetAbility(),
		})
	end)
end
function imba_grimstroke_dark_artistry_modfier.prototype.playPointParticle(self, name, point, duration, cp2)
	local pfx = ParticleManager:CreateParticle(name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point)
	if cp2 then
		ParticleManager:SetParticleControl(pfx, 2, cp2)
	end
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx, true)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function imba_grimstroke_dark_artistry_modfier.prototype.playBezierParticle(self, name, points, duration)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local thinker = CreateModifierThinker(
		caster,
		self:GetAbility(),
		"modifier_dummy_thinker",
		{ duration = duration + 0.2 },
		points[1],
		caster:GetTeamNumber(),
		false
	)
	if not IsValidAlive(nil, thinker) then
		return
	end
	local pfx = ParticleManager:CreateParticle(name, PATTACH_ABSORIGIN_FOLLOW, thinker)
	ParticleManager:SetParticleControl(pfx, 0, points[1])
	thinker:Bezier2Mover(points, duration, nil, false, true)
	Timers:CreateTimer(duration + 0.1, function()
		ParticleManager:DestroyParticle(pfx, true)
		ParticleManager:ReleaseParticleIndex(pfx)
		if IsValid(nil, thinker) then
			thinker:RemoveSelf()
		end
	end)
end
function imba_grimstroke_dark_artistry_modfier.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		caster:StartGesture(ACT_DOTA_ATTACK)
	end
end
imba_grimstroke_dark_artistry_modfier =
	__TS__DecorateLegacy({ registerModifier(nil) }, imba_grimstroke_dark_artistry_modfier)
return ____exports