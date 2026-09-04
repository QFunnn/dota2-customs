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
local warningEffectRing = ____monster_base.warningEffectRing
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local CAST_POINT = 0.3
local CAST_DURATION = 0.5
local BUFF_DURATION = 8
local BONUS_ATTACK_DAMAGE = 30
local BONUS_ATTACK_SPEED = 150
local BONUS_MOVE_SPEED = 100
local AFTERIMAGE_CAST_PFX = "particles/item/kez_sai_afterimage_cast.vpcf"
local AFTERIMAGE_TRACKING_PFX = "particles/item/kez_sai_afterimage_tracking.vpcf"
local AFTERIMAGE_IMPACT_PFX = "particles/units/heroes/hero_kez/kez_sai_toss_impact.vpcf"
local AFTERIMAGE_RING_RADIUS = 450
local AFTERIMAGE_IMPACT_DELAY = 0.75
local AFTERIMAGE_IMPACT_RADIUS = 250
local AFTERIMAGE_DAMAGE_RATE = 15
local AFTERIMAGE_DASH_SOUND = "Hero_Kez.EchoSlash.Katana.Start"
local AFTERIMAGE_IMPACT_SOUND = "Hero_Kez.Katana.Impale.Start"
local SHADOW_PARTICLE = "particles/units/heroes/hero_kez/kez_sai_ultimate_wave.vpcf"
local BUFF_PARTICLE = "particles/units/heroes/hero_kez/kez_sai_afterimage_buff.vpcf"
local PULL_BUFF_PARTICLE = "particles/units/kez_003.vpcf"
local PULL_RADIUS = 600
local PULL_SPEED = 100
local GHOST_DURATION = 0.67
local GHOST_DASH_SEARCH_RANGE = 2500
____exports.boss_kez_3 = __TS__Class()
local boss_kez_3 = ____exports.boss_kez_3
boss_kez_3.name = "boss_kez_3"
__TS__ClassExtends(boss_kez_3, MonsterAbility_CS)
function boss_kez_3.prototype.Precache(self, context)
	PrecacheResource("particle", SHADOW_PARTICLE, context)
	PrecacheResource("particle", BUFF_PARTICLE, context)
	PrecacheResource("particle", AFTERIMAGE_CAST_PFX, context)
	PrecacheResource("particle", AFTERIMAGE_TRACKING_PFX, context)
	PrecacheResource("particle", AFTERIMAGE_IMPACT_PFX, context)
	PrecacheResource("particle", PULL_BUFF_PARTICLE, context)
end
function boss_kez_3.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		OnPhaseStart = function()
			self._caster:AddActivityModifier("kunai")
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local pfx = ParticleManager:CreateParticle(SHADOW_PARTICLE, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
			ParticleManager:SetParticleControl(pfx, 1, Vector(1250, 0, 1250))
			ParticleManager:ReleaseParticleIndex(pfx)
			EmitSoundOn("Hero_Kez.Sai.Draw", caster)
			____exports.modifier_boss_kez_3_pull:applys(caster, caster, self, { duration = BUFF_DURATION })
			____exports.modifier_boss_kez_3_ghost:applys(caster, caster, self, { duration = GHOST_DURATION })
		end,
	}
end
boss_kez_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_kez_3)
____exports.boss_kez_3 = boss_kez_3
--- 三技能牵引 buff：持续吸引周围敌人靠近自身
____exports.modifier_boss_kez_3_pull = __TS__Class()
local modifier_boss_kez_3_pull = ____exports.modifier_boss_kez_3_pull
modifier_boss_kez_3_pull.name = "modifier_boss_kez_3_pull"
__TS__ClassExtends(modifier_boss_kez_3_pull, BaseModifier_CS)
function modifier_boss_kez_3_pull.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self._pullPfx = ParticleManager:CreateParticle(PULL_BUFF_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(self._pullPfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self._pullPfx, 1, Vector(PULL_RADIUS, PULL_RADIUS, PULL_RADIUS))
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_kez_3_pull.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local casterPos = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		casterPos,
		nil,
		PULL_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local step = PULL_SPEED * FrameTime()
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue11
			end
			local ____opt_0 = enemy.GetUnitType
			local unitType = ____opt_0 and ____opt_0(enemy)
			if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
				goto __continue11
			end
			local enemyPos = enemy:GetAbsOrigin()
			local toCaster = casterPos:__sub(enemyPos)
			local distance = toCaster:Length2D()
			if distance <= 1 then
				goto __continue11
			end
			local moveDistance = math.min(step, distance)
			local nextPos = enemyPos:__add(toCaster:Normalized():__mul(moveDistance))
			nextPos.z = GetGroundHeight(nextPos, enemy)
			enemy:SetAbsOrigin(nextPos)
		end
		::__continue11::
	end
end
function modifier_boss_kez_3_pull.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._pullPfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self._pullPfx, false)
	ParticleManager:ReleaseParticleIndex(self._pullPfx)
	self._pullPfx = nil
end
function modifier_boss_kez_3_pull.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false }
end
function modifier_boss_kez_3_pull.GetLocalizationCN(self)
	return { name = "虚空牵引", description = "持续吸引周围敌人靠近自身。" }
end
modifier_boss_kez_3_pull = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_kez_3_pull)
____exports.modifier_boss_kez_3_pull = modifier_boss_kez_3_pull
--- 遁入暗影：半透明 + 极速接近玩家，到期现身切入战斗
____exports.modifier_boss_kez_3_ghost = __TS__Class()
local modifier_boss_kez_3_ghost = ____exports.modifier_boss_kez_3_ghost
modifier_boss_kez_3_ghost.name = "modifier_boss_kez_3_ghost"
__TS__ClassExtends(modifier_boss_kez_3_ghost, BaseModifier_CS)
function modifier_boss_kez_3_ghost.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
function modifier_boss_kez_3_ghost.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_HEALTH_BAR] = true }
end
function modifier_boss_kez_3_ghost.prototype.GetModifierInvisibilityLevel(self)
	return 0.7
end
function modifier_boss_kez_3_ghost.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local nearest = caster:GetMinDistanceUnit(GHOST_DASH_SEARCH_RANGE)
	if nearest then
		local casterPos = caster:GetAbsOrigin()
		local enemyPos = nearest:GetAbsOrigin()
		local dir = enemyPos:__sub(casterPos):Normalized()
		local targetPos = enemyPos:__add(dir:__mul(100))
		targetPos.z = GetGroundPosition(targetPos, caster).z
		caster:SetForwardVector(dir)
		caster:SetAnimation("sai_forcestaff")
		caster:Mover(targetPos, GHOST_DURATION)
	end
end
function modifier_boss_kez_3_ghost.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:MoveToPositionAggressive(caster:GetAbsOrigin())
	____exports.modifier_boss_kez_3_buff:applys(caster, caster, self._ability, { duration = BUFF_DURATION })
end
function modifier_boss_kez_3_ghost.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
modifier_boss_kez_3_ghost = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_kez_3_ghost)
____exports.modifier_boss_kez_3_ghost = modifier_boss_kez_3_ghost
--- 短刀战斗 buff：攻击加成 + 攻击额外伤害，到期切回长刀
____exports.modifier_boss_kez_3_buff = __TS__Class()
local modifier_boss_kez_3_buff = ____exports.modifier_boss_kez_3_buff
modifier_boss_kez_3_buff.name = "modifier_boss_kez_3_buff"
__TS__ClassExtends(modifier_boss_kez_3_buff, BaseModifier_CS)
function modifier_boss_kez_3_buff.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self._buffPfx = ParticleManager:CreateParticle(BUFF_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		self._buffPfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"eye_r",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self._buffPfx,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"eye_l",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self._buffPfx,
		3,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self._buffPfx,
		4,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		Vector(0, 0, 0),
		true
	)
end
function modifier_boss_kez_3_buff.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 1)
	EmitSoundOn("Hero_Kez.Katana.Draw", caster)
	caster:ClearActivityModifiers()
	ParticleManager:DestroyParticle(self._buffPfx, false)
	ParticleManager:ReleaseParticleIndex(self._buffPfx)
end
function modifier_boss_kez_3_buff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_boss_kez_3_buff.prototype.GetActivityTranslationModifiers(self)
	return "haste"
end
function modifier_boss_kez_3_buff.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_boss_kez_3_buff.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local casterPos = parent:GetAbsOrigin()
	local impactPos = GetGroundPosition(target:GetAbsOrigin(), target)
	local retreatDirection = casterPos:__sub(impactPos)
	local ____temp_2
	if retreatDirection:Length2D() > 0.01 then
		____temp_2 = retreatDirection:Normalized()
	else
		____temp_2 = parent:GetForwardVector():__mul(-1)
	end
	local backDirection = ____temp_2
	local ringFlat = casterPos:__add(backDirection:__mul(AFTERIMAGE_RING_RADIUS))
	local ringPoint = GetGroundPosition(ringFlat, parent)
	local ringDir = impactPos:__sub(ringPoint):Normalized()
	warningEffectRing(nil, parent, impactPos, AFTERIMAGE_IMPACT_RADIUS, AFTERIMAGE_IMPACT_DELAY, { speed = 0 })
	local castPfx = ParticleManager:CreateParticle(AFTERIMAGE_CAST_PFX, PATTACH_ABSORIGIN, parent)
	ParticleManager:SetParticleControl(castPfx, 0, casterPos)
	ParticleManager:SetParticleControl(castPfx, 1, casterPos)
	ParticleManager:SetParticleControl(castPfx, 2, ringPoint)
	ParticleManager:SetParticleControl(castPfx, 3, casterPos)
	ParticleManager:SetParticleControl(castPfx, 5, Vector(1, 0, 0))
	ParticleManager:SetParticleControlEnt(
		castPfx,
		7,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0),
		true
	)
	Timers:CreateTimer(0.45, function()
		ParticleManager:DestroyParticle(castPfx, false)
		ParticleManager:ReleaseParticleIndex(castPfx)
		if not IsValidAlive(nil, parent) then
			return
		end
		EmitSoundOnLocationWithCaster(ringPoint, AFTERIMAGE_DASH_SOUND, parent)
		local trackPfx = ParticleManager:CreateParticle(AFTERIMAGE_TRACKING_PFX, PATTACH_ABSORIGIN_FOLLOW, parent)
		ParticleManager:SetParticleControl(trackPfx, 4, ringPoint)
		ParticleManager:SetParticleControl(trackPfx, 1, impactPos)
		ParticleManager:SetParticleControlTransformForward(trackPfx, 4, ringPoint, ringDir)
		ParticleManager:SetParticleControl(trackPfx, 5, Vector(1, 0, 0))
		ParticleManager:SetParticleControlEnt(
			trackPfx,
			7,
			parent,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_attack1",
			Vector(0, 0, 0),
			true
		)
		Timers:CreateTimer(0.5, function()
			ParticleManager:DestroyParticle(trackPfx, false)
			ParticleManager:ReleaseParticleIndex(trackPfx)
		end)
	end)
	Timers:CreateTimer(AFTERIMAGE_IMPACT_DELAY, function()
		if not IsValidAlive(nil, parent) then
			return
		end
		local impactPfx = ParticleManager:CreateParticle(AFTERIMAGE_IMPACT_PFX, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(impactPfx, 0, impactPos)
		ParticleManager:SetParticleControl(impactPfx, 1, impactPos)
		ParticleManager:SetParticleControlTransformForward(impactPfx, 1, impactPos, ringDir)
		ParticleManager:ReleaseParticleIndex(impactPfx)
		EmitSoundOnLocationWithCaster(impactPos, AFTERIMAGE_IMPACT_SOUND, parent)
		local enemies = FindUnitsInRadius(
			parent:GetTeamNumber(),
			impactPos,
			nil,
			AFTERIMAGE_IMPACT_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) then
					goto __continue49
				end
				local ____opt_3 = enemy.GetUnitType
				local unitType = ____opt_3 and ____opt_3(enemy)
				if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
					goto __continue49
				end
				parent:MonsterDamage({
					victim = enemy,
					damage_rate = AFTERIMAGE_DAMAGE_RATE,
					ability = ability,
					damage_type = 1,
				})
			end
			::__continue49::
		end
	end)
end
function modifier_boss_kez_3_buff.prototype.GetAttributeBonus(self)
	return {
		all_attack_damage_percent = BONUS_ATTACK_DAMAGE,
		attack_speed = BONUS_ATTACK_SPEED,
		bonus_movespeed = BONUS_MOVE_SPEED,
	}
end
function modifier_boss_kez_3_buff.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false }
end
function modifier_boss_kez_3_buff.prototype.GetStatusEffectName(self)
	return "particles/units/heroes/hero_kez/status_effect_kez_afterimage_buff.vpcf"
end
function modifier_boss_kez_3_buff.GetLocalizationCN(self)
	return {
		name = "遁入暗影",
		description = "增加攻击力、攻击速度和移动速度，攻击时造成额外伤害。",
	}
end
modifier_boss_kez_3_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_kez_3_buff)
____exports.modifier_boss_kez_3_buff = modifier_boss_kez_3_buff
return ____exports