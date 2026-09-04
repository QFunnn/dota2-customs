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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local px2 = "particles/boss/void_spirit_astral_step_impact_blue.vpcf"
local phantome_ab3_2 = __TS__Class()
phantome_ab3_2.name = "phantome_ab3_2"
__TS__ClassExtends(phantome_ab3_2, MonsterAbility_CS)
function phantome_ab3_2.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 1,
		counterBreakWindowDuration = 1,
		castDuration = 1.6,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		animationPlaybackRate = 0.8,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			local ____ = target and self:GetCaster():LockTargetForSpeed(target, 0.7, 15)
		end,
		OnStart = function()
			return self:Start()
		end,
	}
end
function phantome_ab3_2.prototype.Start(self)
	local unit = self:GetCaster()
	unit:AddNewModifier(unit, self, "phantome_ab3_2_pre", { duration = 0.45 })
	self:GetCaster():SetCustomValue("绝影斩击", 2)
end
phantome_ab3_2 = __TS__DecorateLegacy({ registerAbility(nil) }, phantome_ab3_2)
local phantome_ab3_2_pre = __TS__Class()
phantome_ab3_2_pre.name = "phantome_ab3_2_pre"
__TS__ClassExtends(phantome_ab3_2_pre, BaseModifier)
function phantome_ab3_2_pre.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.max = 1200
	self.min = 800
end
function phantome_ab3_2_pre.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.targer_point = self:GetCaster():GetAbsOrigin()
	local target = self:GetCaster():GetMinDistanceUnit(3500)
	if target then
		self:GetCaster():LockTargetForSpeed(target, 0.15, 15)
		self.targer_point = target:GetAbsOrigin()
	end
	self:StartIntervalThink(0.1)
end
function phantome_ab3_2_pre.prototype.OnIntervalThink(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local targer_point = caster:GetForwardVector():__mul(-300):__add(caster:GetAbsOrigin())
	caster:SetAnimation("c2_phantom_strike")
	caster:Mover(targer_point, 0.3)
	self:StartIntervalThink(-1)
end
function phantome_ab3_2_pre.prototype.GetEffectName(self)
	return "particles/econ/items/underlord/underlord_2021_immortal/underlord_2021_immortal_portal_buildup.vpcf"
end
function phantome_ab3_2_pre.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_wraithking_ghosts.vpcf"
end
function phantome_ab3_2_pre.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local unit = self:GetCaster()
	local ability = self:GetAbility()
	unit:SetAnimation("attack_flip")
	ScreenShake(unit:GetAbsOrigin(), 7, 7, 0.3, 3000, 0, true)
	local dis = math.max(self.min, math.min(self.max, unit:GetAbsOrigin():__sub(self.targer_point):Length2D()))
	local targer_point = unit:GetForwardVector():__mul(dis):__add(unit:GetAbsOrigin())
	local p = unit:GetAbsOrigin()
	unit:Mover(targer_point, 0.2)
	Timers:CreateTimer(0.08, function()
		local sound_start = "Hero_VoidSpirit.AstralStep.Start"
		local sound_end = "Hero_VoidSpirit.AstralStep.End"
		local particle_cast = "particles/boss/void_spirit_astral_step_blue.vpcf"
		local origin = p
		local target = targer_point
		if not IsValidAlive(nil, unit) then
			return
		end
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, unit)
		ParticleManager:SetParticleControl(effect_cast, 0, origin)
		ParticleManager:SetParticleControl(effect_cast, 1, target)
		ParticleManager:ReleaseParticleIndex(effect_cast)
		EmitSoundOnLocationWithCaster(origin, sound_start, unit)
		EmitSoundOnLocationWithCaster(target, sound_end, unit)
		local enemies = FindUnitsInLine(
			unit:GetTeamNumber(),
			origin,
			target:__add(unit:GetForwardVector():__mul(100)),
			nil,
			180,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
		)
		for ____, enemy in ipairs(enemies) do
			unit:PerformAttack(enemy, true, true, true, false, true, false, true)
			unit:MonsterDamage({ victim = enemy, damage_rate = 10, ability = ability, effectName = px2 })
		end
	end)
	unit:AddNewModifier(unit, ability, "phantome_ab3_2_slash", { duration = 0.65 })
end
phantome_ab3_2_pre = __TS__DecorateLegacy({ registerModifier(nil) }, phantome_ab3_2_pre)
local phantome_ab3_2_slash = __TS__Class()
phantome_ab3_2_slash.name = "phantome_ab3_2_slash"
__TS__ClassExtends(phantome_ab3_2_slash, BaseModifier)
function phantome_ab3_2_slash.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self:StartIntervalThink(0.4)
end
function phantome_ab3_2_slash.prototype.OnIntervalThink(self)
	local unit = self:GetCaster()
	if not IsValidAlive(nil, unit) then
		return
	end
	unit:SetAnimation("attack_swing")
	self:StartIntervalThink(-1)
end
function phantome_ab3_2_slash.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local unit = self:GetCaster()
	local pfx_name = "particles/boss/juggernaut_blade_fury_abyssal_start_p_2x.vpcf"
	ScreenShake(unit:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, unit)
	ParticleManager:SetParticleControl(pfx, 0, unit:GetAbsOrigin())
	local slashPfxDone = false
	Timers:CreateTimer(0.45, function()
		if slashPfxDone then
			return nil
		end
		slashPfxDone = true
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
	unit:EmitSound("Hero_Broodmother.SilkenBola.Target")
	local slashCount = tonumber(unit:GetCustomValue("绝影斩击") or 0)
	if slashCount < 3 then
		unit:AddNewModifier(unit, self:GetAbility(), "phantome_ab3_2_pre2", { duration = 0.16 })
		unit:SetCustomValue("绝影斩击", slashCount + 1)
	end
	local enemies = FindUnitsInRadius(
		unit:GetTeamNumber(),
		unit:GetAbsOrigin(),
		nil,
		500,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	local pos = self:GetCaster():GetAbsOrigin()
	GridNav:DestroyTreesAroundPoint(pos, 500, false)
	__TS__ArrayForEach(enemies, function(____, enemy)
		enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_custom_knockback", {
			duration = 0.5,
			should_stun = true,
			knockback_duration = 0.1,
			knockback_distance = 100,
			knockback_height = 0,
			center_x = pos.x,
			center_y = pos.y,
			center_z = pos.z,
		})
		unit:MonsterDamage({
			victim = enemy,
			damage_rate = 10,
			ability = self:GetAbility(),
			effectName = px2,
		})
	end)
end
phantome_ab3_2_slash = __TS__DecorateLegacy({ registerModifier(nil) }, phantome_ab3_2_slash)
local phantome_ab3_2_pre2 = __TS__Class()
phantome_ab3_2_pre2.name = "phantome_ab3_2_pre2"
__TS__ClassExtends(phantome_ab3_2_pre2, BaseModifier)
function phantome_ab3_2_pre2.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local unit = self:GetCaster()
	unit:AddNewModifier(unit, self:GetAbility(), "phantome_ab3_2_pre", { duration = 0.45 })
end
phantome_ab3_2_pre2 = __TS__DecorateLegacy({ registerModifier(nil) }, phantome_ab3_2_pre2)
return ____exports