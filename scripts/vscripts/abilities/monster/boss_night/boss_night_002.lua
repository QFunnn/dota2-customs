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
local boss_night_002_modifier_start
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local DAMAGE_EFFECT =
	"particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_hit.vpcf"
local DAGGER_PROJECTILE_EFFECT = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile_2.vpcf"
local DAGGER_DAMAGE_RATE = 15
local DAGGER_PROJECTILE_SPEED = 1400
local DAGGER_PROJECTILE_DISTANCE = 3600
local DAGGER_PROJECTILE_RADIUS = 50
local DAGGER_PROJECTILE_HEIGHT = 120
local DAGGER_BARRAGE_WAVE_COUNT = 5
local DAGGER_BARRAGE_WAVE_INTERVAL = 0.7
local boss_night_002 = __TS__Class()
boss_night_002.name = "boss_night_002"
__TS__ClassExtends(boss_night_002, MonsterAbility_CS)
function boss_night_002.prototype.Precache(self, context)
	PrecacheResource("particle", DAMAGE_EFFECT, context)
	PrecacheResource("particle", DAGGER_PROJECTILE_EFFECT, context)
	PrecacheResource("particle", "particles/econ/events/diretide_2020/death_effect/death_dt20_post.vpcf", context)
	PrecacheResource("particle", "particles/ui_mouseactions/range_finder_linear.vpcf", context)
end
function boss_night_002.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 1.2,
		castDuration = 4.2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_3_END,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local phasePfx = ParticleManager:CreateParticle(
				"particles/econ/events/diretide_2020/death_effect/death_dt20_post.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				caster
			)
			ParticleManager:ReleaseParticleIndex(phasePfx)
			caster:AddNewModifier(caster, self, "boss_night_002_modifier_pre", { duration = 1.2 })
		end,
		OnStart = function()
			local caster = self:GetCaster()
			boss_night_002_modifier_start:applys(caster, caster, self, {})
		end,
	}
end
function boss_night_002.prototype.GetIntrinsicModifierName(self)
	return "modifier_imba_night_stalker_void"
end
boss_night_002 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_night_002)
local boss_night_002_modifier_pre = __TS__Class()
boss_night_002_modifier_pre.name = "boss_night_002_modifier_pre"
__TS__ClassExtends(boss_night_002_modifier_pre, BaseModifier_CS)
function boss_night_002_modifier_pre.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.num = 0
end
function boss_night_002_modifier_pre.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self:GetCaster():SetAnimation("attack_spin_effigy")
	local target = self:GetCaster():GetMinDistanceUnit(3500)
	local ____target_0
	if target then
		____target_0 = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	else
		____target_0 = caster:GetForwardVector()
	end
	local forward = ____target_0
	if target then
		caster:LockTargetForSpeed(target, 0.6, 4)
	end
	caster:Mover(caster:GetAbsOrigin():__add(forward:__mul(-350)), 0.3)
	local fow = caster:GetForwardVector()
	self.pfx = ParticleManager:CreateParticle(
		"particles/ui_mouseactions/range_finder_linear.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(self.pfx, 0, caster:GetAbsOrigin():__add(Vector(0, 0, 200)))
	ParticleManager:SetParticleControl(
		self.pfx,
		1,
		caster:GetAbsOrigin():__add(fow:__mul(100)):__add(Vector(0, 0, 200))
	)
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(300, 200, 800))
	ParticleManager:SetParticleControl(self.pfx, 4, fow)
	ParticleManager:SetParticleControl(self.pfx, 15, Vector(1, 0, 0))
	ParticleManager:SetParticleControlForward(self.pfx, 1, fow)
	self:StartIntervalThink(FrameTime())
end
function boss_night_002_modifier_pre.prototype.OnIntervalThink(self)
	if self.pfx then
		if not IsValidAlive(nil, self:GetCaster()) then
			return
		end
		local fow = self:GetCaster():GetForwardVector()
		self.num = self.num + 1
		ParticleManager:SetParticleControl(
			self.pfx,
			1,
			self:GetCaster():GetAbsOrigin():__add(fow:__mul(math.min(50, self.num) * 15)):__add(Vector(0, 0, 200))
		)
		ParticleManager:SetParticleControlForward(self.pfx, 1, fow)
	end
end
function boss_night_002_modifier_pre.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.pfx ~= nil then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
end
boss_night_002_modifier_pre = __TS__DecorateLegacy({ registerModifier(nil) }, boss_night_002_modifier_pre)
boss_night_002_modifier_start = __TS__Class()
boss_night_002_modifier_start.name = "boss_night_002_modifier_start"
__TS__ClassExtends(boss_night_002_modifier_start, BaseModifier_CS)
function boss_night_002_modifier_start.prototype.createDaggerProjectiles(self, dirs, getPosition, effectName)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	caster:EmitSound("Hero_Nightstalker.Void")
	__TS__ArrayForEach(dirs, function(____, dir)
		local startPoint = caster:GetAbsOrigin():__add(Vector(0, 0, DAGGER_PROJECTILE_HEIGHT)):__add(dir:__mul(100))
		local targetPoint = getPosition(nil, dir)
		local direction = targetPoint:__sub(startPoint)
		direction.z = 0
		local directionLength = direction:Length2D()
		if directionLength <= 0.01 then
			return
		end
		local flyDirection = direction:__mul(1 / directionLength)
		CreateProjectile(nil, {
			caster = caster,
			ability = ability,
			effect_name = effectName,
			projectile_type = "linear",
			start_point = startPoint,
			direction = flyDirection,
			projectile_speed = DAGGER_PROJECTILE_SPEED,
			projectile_distance = math.min(DAGGER_PROJECTILE_DISTANCE, directionLength),
			projectile_range = DAGGER_PROJECTILE_RADIUS,
			projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			projectile_target_flags = DOTA_UNIT_TARGET_FLAG_RESPECT_OBSTRUCTIONS,
			on_hit = function(____, hitTarget)
				if not hitTarget or not IsValidAlive(nil, hitTarget) then
					return true
				end
				if not IsValidAlive(nil, caster) then
					return true
				end
				caster:MonsterDamage({
					victim = hitTarget,
					damage_rate = DAGGER_DAMAGE_RATE,
					ability = ability,
					effectName = DAMAGE_EFFECT,
				})
				return true
			end,
		})
	end)
end
function boss_night_002_modifier_start.prototype.OnCreated(self, params)
	local caster = self:GetCaster()
	if not IsServer() then
		return
	end
	local n = 0
	self:Timer(0, function()
		local currentWave = n
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
		local target = self:GetCaster():GetMinDistanceUnit(3500)
		local ____ = target and caster:LockTargetForSpeed(target, 0.32, 3.5)
		self:Timer(0.2, function()
			local fow = caster:GetForwardVector()
			local num = math.random(3, 5)
			local angle = math.random(18, 28)
			local arr = GetRotateVectors(nil, fow, num, angle)
			self:createDaggerProjectiles(arr, function(____, dir)
				return caster:GetOrigin():__add(dir:__mul(3600)):__add(Vector(0, 0, 150))
			end, DAGGER_PROJECTILE_EFFECT)
			self:Timer(0.15, function()
				local forward = caster:GetForwardVector()
				local nextArr = GetRotateVectors(nil, forward, num + 1, angle)
				self:createDaggerProjectiles(nextArr, function(____, dir)
					return caster:GetOrigin():__add(dir:__mul(math.random(2400, 3600)))
				end, DAGGER_PROJECTILE_EFFECT)
				if currentWave >= DAGGER_BARRAGE_WAVE_COUNT - 1 then
					self:Destroy()
				end
			end)
		end)
		n = n + 1
		if n >= DAGGER_BARRAGE_WAVE_COUNT then
			return
		end
		return DAGGER_BARRAGE_WAVE_INTERVAL
	end)
end
boss_night_002_modifier_start = __TS__DecorateLegacy({ registerModifier(nil) }, boss_night_002_modifier_start)
local modifier_imba_night_stalker_void = __TS__Class()
modifier_imba_night_stalker_void.name = "modifier_imba_night_stalker_void"
__TS__ClassExtends(modifier_imba_night_stalker_void, BaseModifier_CS)
function modifier_imba_night_stalker_void.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_imba_night_stalker_void.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_ATTACK
end
function modifier_imba_night_stalker_void.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_ULTRA + 10001
end
function modifier_imba_night_stalker_void.prototype.GetActivityTranslationModifiers(self)
	return "nihility"
end
function modifier_imba_night_stalker_void.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
modifier_imba_night_stalker_void = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_imba_night_stalker_void)
return ____exports