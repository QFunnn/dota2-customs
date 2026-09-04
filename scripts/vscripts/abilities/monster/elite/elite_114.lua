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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1000
local CAST_POINT = 1.3
local DASH_DURATION = 0.35
local SLASH_DELAY = 0.08
local CAST_DURATION = DASH_DURATION + SLASH_DELAY + 0.25
local DASH_DISTANCE = 700
local WARNING_WIDTH = 400
local SLASH_RADIUS = 320
local DASH_DAMAGE_RATE = 20
local SLASH_DAMAGE_RATE = 30
local STUN_DURATION = 0.6
local WARNING_EFFECT =
	"particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_dragon_iron_dragon.vpcf"
local DASH_EFFECT = "particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_iron_dragon.vpcf"
local SLASH_EFFECT = "particles/units/heroes/hero_razor/razor_plasmafield.vpcf"
local LIGHTNING_EFFECT = "particles/econ/items/zeus/arcana_chariot/zeus_arcana_thundergods_wrath_start.vpcf"
local RAZOR_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts"
local ZEUS_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts"
local DASH_SOUND = "Hero_Razor.Storm.Cast"
local SLASH_SOUND = "Hero_Razor.PlasmaField"
local HIT_SOUND = "Hero_Zuus.LightningBolt"
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
--- 精英技能 114 - 雷霆冲刺：前冲后在落点发动一次圆形斩击。
____exports.elite_114 = __TS__Class()
local elite_114 = ____exports.elite_114
elite_114.name = "elite_114"
__TS__ClassExtends(elite_114, MonsterAbility_CS)
function elite_114.prototype.Precache(self, context)
	PrecacheResource("particle", WARNING_EFFECT, context)
	PrecacheResource("particle", DASH_EFFECT, context)
	PrecacheResource("particle", SLASH_EFFECT, context)
	PrecacheResource("particle", LIGHTNING_EFFECT, context)
	PrecacheResource("soundfile", RAZOR_SOUND_EVENTS, context)
	PrecacheResource("soundfile", ZEUS_SOUND_EVENTS, context)
end
function elite_114.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 8,
		castProgressBarColor = "blue",
		thunderizedCounterBreak = true,
		thunderizedCounterBreakStunDuration = 1,
		thunderizedDamageImmune = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT - 0.1)
			end
			self:WarningEffect(caster:GetAbsOrigin(), self:GetWarningEnd(caster), CAST_POINT, {
				startWidth = 200,
				endWidth = 200,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
			self:StartWarningEffect(caster)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:ClearWarningEffect()
			self:StartThunderDash(caster)
		end,
		OnFinish = function()
			return self:ClearAllEffects()
		end,
		OnInterrupt = function()
			return self:ClearAllEffects()
		end,
	}
end
function elite_114.prototype.StartWarningEffect(self, caster)
	self:ClearWarningEffect()
	local pfx = ParticleManager:CreateParticle(WARNING_EFFECT, PATTACH_CENTER_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_CENTER_FOLLOW,
		"attach_attack2",
		caster:GetAbsOrigin(),
		true
	)
	self.warningPfx = pfx
	self:UpdateWarningForward(caster, 0)
end
function elite_114.prototype.UpdateWarningForward(self, caster, elapsed)
	if self.warningPfx == nil or not IsValidAlive(nil, caster) then
		return
	end
	ParticleManager:SetParticleControlForward(self.warningPfx, 0, caster:GetForwardVector())
	if elapsed >= CAST_POINT then
		return
	end
	return self:Timer(FrameTime(), function()
		return self:UpdateWarningForward(caster, elapsed + FrameTime())
	end)
end
function elite_114.prototype.StartThunderDash(self, caster)
	local forward = caster:GetForwardVector()
	local start = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local ____end = getGroundPosition(nil, start:__add(forward:__mul(DASH_DISTANCE)), caster)
	caster:AddNewModifier(caster, self, "modifier_elite_114_thunder_dash", { duration = DASH_DURATION })
	self:StartDashEffect(caster)
	EmitSoundOn(DASH_SOUND, caster)
	local t = __TS__New(Set)
	local isSlashStarted = false
	local slashCenter
	local function finishDash(____, stopPosition)
		if isSlashStarted then
			return
		end
		isSlashStarted = true
		if IsValidAlive(nil, caster) then
			if stopPosition ~= nil then
				slashCenter = getGroundPosition(nil, stopPosition, caster)
				FindClearSpaceForUnit(caster, slashCenter, true)
			end
			self:PlayLightningAt(slashCenter or caster:GetAbsOrigin())
			caster:RemoveModifierByName("modifier_elite_114_thunder_dash")
		end
		self:ClearDashEffect()
		self:Timer(SLASH_DELAY, function()
			return self:CircleSlash(caster, slashCenter)
		end)
	end
	caster:Mover(____end, DASH_DURATION, function(____, point)
		if self:HitDashEnemies(caster, point, forward, t) then
			finishDash(nil, point)
			return true
		end
	end, nil, true, true)
	self:Timer(DASH_DURATION, finishDash)
end
function elite_114.prototype.HitDashEnemies(self, caster, position, forward, hitTargets)
	if not IsValidAlive(nil, caster) then
		return false
	end
	local hitCenter = getGroundPosition(nil, position:__add(forward:__mul(80)), caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		hitCenter,
		nil,
		120,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local hasNewHit = false
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue28
			end
			local idx = enemy:GetEntityIndex()
			if hitTargets:has(idx) then
				goto __continue28
			end
			hitTargets:add(idx)
			hasNewHit = true
			caster:MonsterDamage({ victim = enemy, damage_rate = DASH_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
			enemy:KnockBack(caster, self, {
				duration = 0.1,
				distance = 50,
				height = 0,
				direction = forward,
				particleName = "",
			})
			EmitSoundOn(HIT_SOUND, enemy)
		end
		::__continue28::
	end
	return hasNewHit
end
function elite_114.prototype.GetWarningEnd(self, caster)
	local origin = caster:GetAbsOrigin()
	return origin:__add(caster:GetForwardVector():__mul(DASH_DISTANCE))
end
function elite_114.prototype.StartDashEffect(self, caster)
	self:ClearDashEffect()
	local pfx = ParticleManager:CreateParticle(DASH_EFFECT, PATTACH_POINT_FOLLOW, caster)
	for ____, cp in ipairs({ 0, 2, 4, 5 }) do
		ParticleManager:SetParticleControlEnt(
			pfx,
			cp,
			caster,
			PATTACH_CENTER_FOLLOW,
			"attach_attack2",
			caster:GetAbsOrigin(),
			true
		)
	end
	self.dashPfx = pfx
end
function elite_114.prototype.CircleSlash(self, caster, forcedCenter)
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = forcedCenter or getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local pfx_name = "particles/boss/juggernaut_blade_fury_abyssal_start_p_2x1.vpcf"
	ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, center)
	self:PlaySlashEffect(center)
	caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
	self:Timer(0.06, function()
		self:DamageSlashEnemies(caster, center)
	end)
end
function elite_114.prototype.PlaySlashEffect(self, center)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlayLightningAt(center)
	EmitSoundOnLocationWithCaster(center, SLASH_SOUND, caster)
end
function elite_114.prototype.PlayLightningAt(self, point)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local groundPoint = getGroundPosition(nil, point, caster)
	local pfx = ParticleManager:CreateParticle(LIGHTNING_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, groundPoint:__add(Vector(0, 0, 50)))
	ParticleManager:SetParticleControl(pfx, 1, groundPoint:__add(Vector(0, 0, 50)))
	ParticleManager:SetParticleControl(pfx, 2, groundPoint:__add(Vector(0, 0, 50)))
	ParticleManager:SetParticleControl(pfx, 3, groundPoint:__add(Vector(0, 0, 50)))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_114.prototype.DamageSlashEnemies(self, caster, center)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		SLASH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue44
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = SLASH_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
			EmitSoundOn(HIT_SOUND, enemy)
		end
		::__continue44::
	end
end
function elite_114.prototype.ClearDashEffect(self)
	if self.dashPfx ~= nil then
		ParticleManager:DestroyParticle(self.dashPfx, false)
		ParticleManager:ReleaseParticleIndex(self.dashPfx)
		self.dashPfx = nil
	end
end
function elite_114.prototype.ClearWarningEffect(self)
	if self.warningPfx ~= nil then
		ParticleManager:DestroyParticle(self.warningPfx, false)
		ParticleManager:ReleaseParticleIndex(self.warningPfx)
		self.warningPfx = nil
	end
end
function elite_114.prototype.ClearAllEffects(self)
	self:ClearWarningEffect()
	self:ClearDashEffect()
end
function elite_114.prototype.GetIntrinsicModifierName(self)
	return "elite_114_modifier"
end
elite_114 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_114)
____exports.elite_114 = elite_114
--- 雷霆精英的常驻环绕特效。
____exports.elite_114_modifier = __TS__Class()
local elite_114_modifier = ____exports.elite_114_modifier
elite_114_modifier.name = "elite_114_modifier"
__TS__ClassExtends(elite_114_modifier, MonsterModifier_CS)
function elite_114_modifier.prototype.GetEffectName(self)
	return "particles/econ/items/razor/razor_arcana/razor_arcana_base_ambient_game.vpcf"
end
function elite_114_modifier.prototype.IsHidden(self)
	return true
end
elite_114_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, elite_114_modifier)
____exports.elite_114_modifier = elite_114_modifier
____exports.modifier_elite_114_thunder_dash = __TS__Class()
local modifier_elite_114_thunder_dash = ____exports.modifier_elite_114_thunder_dash
modifier_elite_114_thunder_dash.name = "modifier_elite_114_thunder_dash"
__TS__ClassExtends(modifier_elite_114_thunder_dash, MonsterModifier_CS)
function modifier_elite_114_thunder_dash.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test2.vpcf"
end
function modifier_elite_114_thunder_dash.prototype.IsHidden(self)
	return true
end
modifier_elite_114_thunder_dash =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_114_thunder_dash") }, modifier_elite_114_thunder_dash)
____exports.modifier_elite_114_thunder_dash = modifier_elite_114_thunder_dash
return ____exports