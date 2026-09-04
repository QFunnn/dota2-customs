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
local modifier_boss_storm_spirit_4_armor
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 1
local TARGET_SEARCH_RANGE = 1800
local STORM_RADIUS = 420
local STORM_DURATION = 4
local STORM_THINK_INTERVAL = 0.03
local STORM_MOVE_SPEED = 260
local STORM_CENTER_STUN_DURATION = 0.5
local STRIKE_INTERVAL = 0.5
local STRIKE_DAMAGE_RATE = 10
local ARMOR_REDUCTION_PER_STACK = 1
local ARMOR_DEBUFF_DURATION = 6
local WARNING_PARTICLE = "particles/monster/ability_warning_ring.vpcf"
local STORM_PARTICLE = "particles/boss/boss_storm_spirit/ak_razor_rain_storm.vpcf"
local STRIKE_PARTICLE = "particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf"
local BLINK_IMPACT_PARTICLE = "particles/stormspirit_overload_discharge.vpcf"
local RAZOR_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts"
local STORM_CAST_SOUND = "Hero_Razor.Storm.Cast"
local STORM_TARGET_SOUND = "Hero_Razor.UnstableCurrent.Target"
local STORM_LOOP_SOUND = "Hero_Razor.Storm.Loop"
--- 风暴之眼：前摇开始时锁定敌人当前位置，预警后生成短时高速追踪雷云。
____exports.boss_storm_spirit_4 = __TS__Class()
local boss_storm_spirit_4 = ____exports.boss_storm_spirit_4
boss_storm_spirit_4.name = "boss_storm_spirit_4"
__TS__ClassExtends(boss_storm_spirit_4, MonsterAbility_CS)
function boss_storm_spirit_4.prototype.Precache(self, context)
	PrecacheResource("particle", WARNING_PARTICLE, context)
	PrecacheResource("particle", STORM_PARTICLE, context)
	PrecacheResource("particle", STRIKE_PARTICLE, context)
	PrecacheResource("particle", BLINK_IMPACT_PARTICLE, context)
	PrecacheResource("soundfile", RAZOR_SOUND_EVENTS, context)
end
function boss_storm_spirit_4.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = TARGET_SEARCH_RANGE,
		castPoint = CAST_POINT,
		castDuration = 0,
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_4,
		castProgressBarColor = "blue",
		thunderizedCounterBreak = true,
		thunderizedCounterBreakStunDuration = 1,
		thunderizedDamageImmune = true,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:findCastTarget()) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		castError = function()
			return "附近没有可释放风暴之眼的目标"
		end,
		OnPhaseStart = function()
			return self:onPhaseStart()
		end,
		OnInterrupt = function()
			return self:cleanupCastPreview()
		end,
		OnFinish = function()
			return self:cleanupCastPreview()
		end,
		OnStart = function()
			return self:onStart()
		end,
	}
end
function boss_storm_spirit_4.prototype.onPhaseStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:findCastTarget()
	if not IsValidAlive(nil, target) then
		return
	end
	self.lockedTargetIndex = target:entindex()
	self.lockedStormPosition = GetGroundPosition(target:GetAbsOrigin(), caster)
	caster:LockTargetForSpeed(target, CAST_POINT, 4)
	self:startFixedWarning(caster, self.lockedStormPosition)
end
function boss_storm_spirit_4.prototype.onStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local startPosition = self.lockedStormPosition
	local targetIndex = self.lockedTargetIndex
	self:stopMovingWarning()
	if not startPosition then
		return
	end
	EmitSoundOn(STORM_CAST_SOUND, caster)
	CreateModifierThinker(
		caster,
		self,
		"modifier_boss_storm_spirit_4_storm",
		{ duration = STORM_DURATION, target_entindex = targetIndex },
		startPosition,
		caster:GetTeamNumber(),
		false
	)
	self:blinkToStormCenterAndStun(caster, startPosition)
end
function boss_storm_spirit_4.prototype.blinkToStormCenterAndStun(self, caster, stormCenter)
	ProjectileManager:ProjectileDodge(caster)
	FindClearSpaceForUnit(caster, stormCenter, true)
	self:playBlinkImpactEffect(caster:GetAbsOrigin())
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		stormCenter,
		nil,
		STORM_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue19
			end
			enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = STORM_CENTER_STUN_DURATION })
		end
		::__continue19::
	end
end
function boss_storm_spirit_4.prototype.playBlinkImpactEffect(self, position)
	local pfx = ParticleManager:CreateParticle(BLINK_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function boss_storm_spirit_4.prototype.findCastTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
end
function boss_storm_spirit_4.prototype.startFixedWarning(self, caster, position)
	self:stopMovingWarning()
	local token = DoUniqueString("boss_storm_spirit_4_warning")
	self.warningToken = token
	self.warningPfx = ParticleManager:CreateParticle(WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.warningPfx, false)
	ParticleManager:SetParticleControl(self.warningPfx, 1, Vector(STORM_RADIUS, 0, -STORM_RADIUS / CAST_POINT))
	ParticleManager:SetParticleControl(self.warningPfx, 2, Vector(CAST_POINT, 0, 0))
	ParticleManager:SetParticleControl(self.warningPfx, 0, position)
	local elapsed = 0
	local function updateWarningColor()
		if self.warningPfx == nil then
			return
		end
		local progress = math.min(math.max(elapsed / CAST_POINT, 0), 1)
		ParticleManager:SetParticleControl(self.warningPfx, 15, Vector(0.7, 0.7 * (1 - progress), 0))
	end
	updateWarningColor(nil)
	Timers:CreateTimer(STORM_THINK_INTERVAL, function()
		if self.warningToken ~= token then
			return nil
		end
		if not IsValidAlive(nil, caster) then
			self:stopMovingWarning()
			return nil
		end
		elapsed = elapsed + STORM_THINK_INTERVAL
		updateWarningColor(nil)
		if elapsed >= CAST_POINT then
			self:stopMovingWarning()
			return nil
		end
		return STORM_THINK_INTERVAL
	end)
end
function boss_storm_spirit_4.prototype.cleanupCastPreview(self)
	self:stopMovingWarning()
	self.lockedTargetIndex = nil
	self.lockedStormPosition = nil
end
function boss_storm_spirit_4.prototype.stopMovingWarning(self)
	self.warningToken = nil
	if self.warningPfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self.warningPfx, false)
	ParticleManager:ReleaseParticleIndex(self.warningPfx)
	self.warningPfx = nil
end
boss_storm_spirit_4 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_storm_spirit_4)
____exports.boss_storm_spirit_4 = boss_storm_spirit_4
local modifier_boss_storm_spirit_4_storm = __TS__Class()
modifier_boss_storm_spirit_4_storm.name = "modifier_boss_storm_spirit_4_storm"
__TS__ClassExtends(modifier_boss_storm_spirit_4_storm, MonsterModifier_CS)
function modifier_boss_storm_spirit_4_storm.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.nextStrikeTime = 0
end
function modifier_boss_storm_spirit_4_storm.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_boss_storm_spirit_4_storm.prototype.IsHidden(self)
	return true
end
function modifier_boss_storm_spirit_4_storm.prototype.IsPurgable(self)
	return false
end
function modifier_boss_storm_spirit_4_storm.prototype.IsDebuff(self)
	return false
end
function modifier_boss_storm_spirit_4_storm.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	self.targetEntIndex = params and params.target_entindex
	self.nextStrikeTime = GameRules:GetGameTime()
	self:createStormParticle(parent)
	EmitSoundOn(STORM_LOOP_SOUND, parent)
	self:StartIntervalThink(STORM_THINK_INTERVAL)
	self:OnIntervalThink()
end
function modifier_boss_storm_spirit_4_storm.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_storm_spirit_4_storm.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if
		not IsValidAlive(nil, caster)
		or not ability
		or ability:IsNull()
		or not IsValid(nil, parent)
		or parent:IsNull()
	then
		self:Destroy()
		return
	end
	self:moveStorm(parent)
	self:updateStormParticle(parent)
	if GameRules:GetGameTime() < self.nextStrikeTime then
		return
	end
	self.nextStrikeTime = GameRules:GetGameTime() + STRIKE_INTERVAL
	local target = self:findLowestHealthTarget(caster, parent:GetAbsOrigin())
	if not target then
		return
	end
	self:strikeTarget(caster, ability, parent:GetAbsOrigin(), target)
end
function modifier_boss_storm_spirit_4_storm.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:destroyStormParticle()
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		StopSoundOn(STORM_LOOP_SOUND, parent)
		parent:SelfRemoveSelf()
	end
end
function modifier_boss_storm_spirit_4_storm.prototype.GetTexture(self)
	return "razor_eye_of_the_storm"
end
function modifier_boss_storm_spirit_4_storm.GetLocalizationCN(self)
	return { name = "风暴之眼", description = "周期性打击附近生命值最低的敌人。" }
end
function modifier_boss_storm_spirit_4_storm.prototype.createStormParticle(self, parent)
	self.stormPfx = ParticleManager:CreateParticle(STORM_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleShouldCheckFoW(self.stormPfx, false)
	ParticleManager:SetParticleControlEnt(
		self.stormPfx,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.stormPfx, 1, Vector(STORM_RADIUS, 0, 0))
end
function modifier_boss_storm_spirit_4_storm.prototype.updateStormParticle(self, parent)
	if self.stormPfx == nil then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	ParticleManager:SetParticleControlEnt(
		self.stormPfx,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
end
function modifier_boss_storm_spirit_4_storm.prototype.destroyStormParticle(self)
	if self.stormPfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self.stormPfx, false)
	ParticleManager:ReleaseParticleIndex(self.stormPfx)
	self.stormPfx = nil
end
function modifier_boss_storm_spirit_4_storm.prototype.moveStorm(self, parent)
	local chaseTarget = self:getChaseTarget()
	if not IsValidAlive(nil, chaseTarget) then
		return
	end
	if not chaseTarget then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	local targetPosition = GetGroundPosition(chaseTarget:GetAbsOrigin(), parent)
	local toTarget = Vector(targetPosition.x - origin.x, targetPosition.y - origin.y, 0)
	local distance = toTarget:Length2D()
	if distance <= 0.01 then
		return
	end
	local stepDistance = STORM_MOVE_SPEED * STORM_THINK_INTERVAL
	local ____temp_3
	if distance <= stepDistance then
		____temp_3 = targetPosition
	else
		____temp_3 = origin:__add(toTarget:Normalized():__mul(stepDistance))
	end
	local nextPosition = ____temp_3
	local groundedPosition = GetGroundPosition(nextPosition, parent)
	parent:SetAbsOrigin(groundedPosition)
	parent:SetForwardVector(toTarget:Normalized())
end
function modifier_boss_storm_spirit_4_storm.prototype.getChaseTarget(self)
	if self.targetEntIndex == nil then
		return nil
	end
	local target = EntIndexToHScript(self.targetEntIndex)
	local ____IsValidAlive_result_4
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_4 = target
	else
		____IsValidAlive_result_4 = nil
	end
	return ____IsValidAlive_result_4
end
function modifier_boss_storm_spirit_4_storm.prototype.findLowestHealthTarget(self, caster, origin)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		STORM_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)
	local selected
	local selectedHealth = math.huge
	local selectedDistance = math.huge
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue69
			end
			local health = enemy:GetHealth()
			local distance = GetDistance(nil, origin, enemy:GetAbsOrigin())
			if health < selectedHealth or health == selectedHealth and distance < selectedDistance then
				selected = enemy
				selectedHealth = health
				selectedDistance = distance
			end
		end
		::__continue69::
	end
	return selected
end
function modifier_boss_storm_spirit_4_storm.prototype.strikeTarget(self, caster, ability, stormOrigin, target)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	self:playStrikeParticle(stormOrigin, target)
	EmitSoundOn(STORM_TARGET_SOUND, target)
	caster:MonsterDamage({ victim = target, damage_rate = STRIKE_DAMAGE_RATE, damage_type = 1, ability = ability })
	modifier_boss_storm_spirit_4_armor:applys(target, caster, ability, { duration = ARMOR_DEBUFF_DURATION })
end
function modifier_boss_storm_spirit_4_storm.prototype.playStrikeParticle(self, stormOrigin, target)
	if not IsValidAlive(nil, target) then
		return
	end
	local targetOrigin = target:GetAbsOrigin()
	local sourceOrigin = stormOrigin:__add(Vector(0, 0, 800))
	local pfx = ParticleManager:CreateParticle(STRIKE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, targetOrigin)
	ParticleManager:SetParticleControl(pfx, 1, sourceOrigin)
	ParticleManager:ReleaseParticleIndex(pfx)
end
modifier_boss_storm_spirit_4_storm = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_storm_spirit_4_storm") },
	modifier_boss_storm_spirit_4_storm
)
modifier_boss_storm_spirit_4_armor = __TS__Class()
modifier_boss_storm_spirit_4_armor.name = "modifier_boss_storm_spirit_4_armor"
__TS__ClassExtends(modifier_boss_storm_spirit_4_armor, MonsterModifier_CS)
function modifier_boss_storm_spirit_4_armor.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end
function modifier_boss_storm_spirit_4_armor.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end
function modifier_boss_storm_spirit_4_armor.prototype.GetAttributeBonus(self)
	return { bonus_armor = -ARMOR_REDUCTION_PER_STACK * self:GetStackCount() }
end
function modifier_boss_storm_spirit_4_armor.prototype.IsHidden(self)
	return false
end
function modifier_boss_storm_spirit_4_armor.prototype.IsDebuff(self)
	return true
end
function modifier_boss_storm_spirit_4_armor.prototype.IsPurgable(self)
	return true
end
function modifier_boss_storm_spirit_4_armor.prototype.GetTexture(self)
	return "razor_eye_of_the_storm"
end
function modifier_boss_storm_spirit_4_armor.GetLocalizationCN(self)
	return { name = "风暴之眼减甲", description = "护甲降低。" }
end
modifier_boss_storm_spirit_4_armor = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_storm_spirit_4_armor") },
	modifier_boss_storm_spirit_4_armor
)
return ____exports