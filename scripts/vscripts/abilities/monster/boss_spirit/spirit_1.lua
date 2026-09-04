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
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local pfx1 = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_run_image.vpcf"
local pfx2 = "particles/underlord_debut_core_a.vpcf"
local pfx3 = "particles/boss/void_spirit_astral_step.vpcf"
local pfx4 = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf"
local pfx5 = "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
local pfx6 = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse.vpcf"
local pfx7 = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield_deflect.vpcf"
local pfx9 = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_dmg.vpcf"
local pfx10 = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf"
local pfx11 = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_absorb.vpcf"
local pfx12 = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_impact.vpcf"
local pfx13 = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield.vpcf"
local pfx14 = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_buff.vpcf"
local SND_AETHER_REMNANT = "Hero_VoidSpirit.AetherRemnant"
local SND_AETHER_CAST = "Hero_VoidSpirit.AetherRemnant.Cast"
local SND_AETHER_FIRE = "Hero_VoidSpirit.AetherRemnant"
local SND_ASTRAL_START = "Hero_VoidSpirit.AstralStep.Start"
local SND_ASTRAL_END = "Hero_VoidSpirit.AstralStep.End"
local SND_MARK_EXPLOSION = "Hero_VoidSpirit.AstralStep.MarkExplosion"
local SND_PULSE = "Hero_VoidSpirit.Pulse"
local SND_PULSE_CAST = "Hero_VoidSpirit.Pulse.Cast"
local SND_PULSE_TARGET = "Hero_VoidSpirit.Pulse.Target"
local SND_PULSE_DESTROY = "Hero_VoidSpirit.Pulse.Destroy"
--- 残阴：灵体抓人。发射残影投射物，命中后触发斩击；未命中则可能冲刺向最近目标。
local spirit_1 = __TS__Class()
spirit_1.name = "spirit_1"
__TS__ClassExtends(spirit_1, MonsterAbility_CS)
function spirit_1.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self["end"] = false
	self.target = nil
end
function spirit_1.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.5,
		castDuration = 2.2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		isNotMove = true,
		OnPhaseStart = function()
			return self:onPhaseStart()
		end,
		OnStart = function()
			return self:OnCastStart()
		end,
	}
end
function spirit_1.prototype.onPhaseStart(self)
	local caster = self:GetCaster()
	local pos = caster:GetAbsOrigin()
	local sound = CreateModifierThinker(
		caster,
		self,
		"modifier_dummy_thinker",
		{ duration = 10 },
		pos,
		caster:GetTeamNumber(),
		false
	)
	EmitSoundOn(SND_AETHER_REMNANT, sound)
	caster:AddNewModifier(caster, self, "modifier_spirit_1_buff", { duration = 1 })
end
function spirit_1.prototype.OnCastStart(self)
	local caster = self:GetCaster()
	if not IsServer() then
		return
	end
	self["end"] = false
	self.target = nil
	local dis = 1500
	local fow = caster:GetForwardVector()
	local curPos = caster:GetAbsOrigin():__add(fow:__mul(dis))
	local lockTarget = caster:GetMinDistanceUnit(2600) or caster
	caster:LockTargetForSpeed(lockTarget, 1, 2)
	local info = self:buildProjectileInfo(caster, curPos)
	caster.spirit_1_proj_info = info
	caster:EmitSound(SND_AETHER_CAST)
	caster:AddNewModifier(caster, self, "spirit_1_modifier_cast", { duration = 2.5 })
end
function spirit_1.prototype.buildProjectileInfo(self, caster, curPos)
	return {
		vSpawnOrigin = caster:GetAbsOrigin(),
		vVelocity = caster:GetForwardVector():__mul(1500),
		fMaxSpeed = 1500,
		fDistance = 2500,
		fExpireTime = GameRules:GetGameTime() + 10,
		fStartRadius = 100,
		fEndRadius = 100,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		bIgnoreSource = true,
		bHasFrontalCone = true,
		bDrawsOnMinimap = false,
		bVisibleToEnemies = true,
		EffectName = pfx1,
		Ability = self,
		Source = caster,
		bProvidesVision = true,
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeamNumber(),
		ExtraData = { cur_pos_x = curPos.x, cur_pos_y = curPos.y, cur_pos_z = curPos.z },
	}
end
function spirit_1.prototype.PlayEffects5(self)
	local caster = self:GetCaster()
	local pfx = ParticleManager:CreateParticle(pfx7, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
	ParticleManager:SetParticleControl(pfx, 1, Vector(200, 200, 200))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function spirit_1.prototype.TriggerSlash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, self.target) then
		return
	end
	if not self.target or self.target:IsNull() or not self.target:IsAlive() then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	if caster:GetAbsOrigin():__sub(self.target:GetAbsOrigin()):Length2D() > 3500 then
		return
	end
	caster:AddNewModifier(caster, self, "modifier_pause_actions", { duration = 0.5 })
	local fow = self.target:GetAbsOrigin():__sub(caster:GetAbsOrigin()):Normalized()
	caster:Mover(caster:GetAbsOrigin():__sub(fow:__mul(250)), 0.4)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.6)
	self:Timer(0.4, function()
		if self.target and not self.target:IsNull() then
			if not IsValidAlive(nil, self.target) then
				return
			end
			self:Slash(self.target:GetAbsOrigin():__add(fow:__mul(300)), 200)
			self:PlayEffects3(self.target)
		end
		return
	end)
end
function spirit_1.prototype.Slash(self, target, radius)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	FindClearSpaceForUnit(caster, target, true)
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		origin,
		target,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue19
			end
			caster:PerformAttack(enemy, true, true, true, false, true, false, true)
			enemy:AddNewModifier(caster, self, "modifier_spirit_astral_step_debuff", { duration = 0.6 })
			self:PlayEffects2(enemy)
		end
		::__continue19::
	end
	self:PlayEffects1(origin, target)
end
function spirit_1.prototype.OnProjectileHit_ExtraData(self, hTarget, _vLocation, _ExtraData)
	if not hTarget then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local p = caster:GetAbsOrigin()
	hTarget:KnockBack(caster, self, {
		duration = 2,
		origin_pos = p,
		stun = true,
		distance = 100,
		height = 1,
	})
	if self["end"] then
		return
	end
	self["end"] = true
	self.target = hTarget
	self:playHitAbsorbEffect(hTarget, caster)
	self:TriggerSlash()
end
function spirit_1.prototype.playHitAbsorbEffect(self, target, caster)
	local pfx = ParticleManager:CreateParticle(pfx11, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function spirit_1.prototype.PlayEffects1(self, origin, target)
	local pfx = ParticleManager:CreateParticle(pfx3, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, target)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(origin, SND_ASTRAL_START, self:GetCaster())
	EmitSoundOnLocationWithCaster(target, SND_ASTRAL_END, self:GetCaster())
	self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
end
function spirit_1.prototype.PlayEffects2(self, target)
	local pfx = ParticleManager:CreateParticle(pfx4, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function spirit_1.prototype.PlayEffects3(self, target)
	if not IsValidAlive(nil, target) then
		return
	end
	local origin = target:GetAbsOrigin()
	local n = 0
	self:Timer(0.15, function()
		n = n + 1
		local fow = RandomVector(math.random(300, 500))
		local z = math.random(100, 200)
		local pfx = ParticleManager:CreateParticle(pfx3, PATTACH_WORLDORIGIN, self:GetCaster())
		ParticleManager:SetParticleControl(pfx, 0, origin:__sub(fow):__add(Vector(0, 0, z)))
		ParticleManager:SetParticleControl(pfx, 1, origin:__add(fow):__add(Vector(0, 0, z)))
		ParticleManager:ReleaseParticleIndex(pfx)
		EmitSoundOnLocationWithCaster(origin:__sub(fow), SND_ASTRAL_START, self:GetCaster())
		EmitSoundOnLocationWithCaster(origin:__add(fow), SND_ASTRAL_END, self:GetCaster())
		self._caster:MonsterDamage({ victim = target, damage_rate = 5, ability = self })
		if n > 3 then
			return
		end
		return 0.15
	end)
end
spirit_1 = __TS__DecorateLegacy({ registerAbility(nil) }, spirit_1)
local spirit_1_modifier_cast = __TS__Class()
spirit_1_modifier_cast.name = "spirit_1_modifier_cast"
__TS__ClassExtends(spirit_1_modifier_cast, BaseModifier_CS)
function spirit_1_modifier_cast.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.did05 = false
	self.did1 = false
	self.did16 = false
	self.did22 = false
end
function spirit_1_modifier_cast.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.05)
end
function spirit_1_modifier_cast.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local t = self:GetElapsedTime()
	local info = caster.spirit_1_proj_info
	if t >= 0.5 and not self.did05 then
		self.did05 = true
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.4)
	end
	if t >= 1 and not self.did1 then
		self.did1 = true
		self:fireWave(caster, info, 3, 1500)
	end
	if t >= 1.6 and not self.did16 then
		self.did16 = true
		if not ability["end"] then
			self:fireWave(caster, info, 2, 3300, 3200)
		end
	end
	if t >= 2.2 and not self.did22 then
		self.did22 = true
		if not ability["end"] then
			ability["end"] = true
			local target = caster:GetMinDistanceUnit(2600)
			if target then
				if not IsValidAlive(nil, target) then
					return
				end
				local dist = caster:GetAbsOrigin():__sub(target:GetAbsOrigin()):Length2D()
				if dist > 1000 then
					ability:PlayEffects5()
					local fow = target:GetAbsOrigin():__sub(caster:GetAbsOrigin()):Normalized()
					caster:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 1)
					FindClearSpaceForUnit(caster, caster:GetAbsOrigin():__add(fow:__mul(dist * 0.4)), true)
				end
			end
		end
		self:Destroy()
	end
end
function spirit_1_modifier_cast.prototype.fireWave(self, caster, info, count, speed, fMaxSpeed)
	if not IsValidAlive(nil, caster) then
		return
	end
	local fow = caster:GetForwardVector()
	local arr = GetRotateVectors(nil, fow, count, 40)
	caster:Mover(caster:GetAbsOrigin():__sub(fow:__mul(150)), 0.4)
	if count == 3 then
		ScreenShake(caster:GetAbsOrigin(), 10, 10, 0.1, 2000, 0, true)
	else
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	end
	local pos = caster:GetAbsOrigin():__add(Vector(0, 0, 150))
	local pfx = ParticleManager:CreateParticle(pfx2, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	ParticleManager:SetParticleControl(pfx, 4, pos)
	local ringReleased = false
	local function releaseRingPfx()
		if ringReleased then
			return
		end
		ringReleased = true
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
	Timers:CreateTimer(1.8, function()
		releaseRingPfx(nil)
		return nil
	end)
	if info then
		info.vSpawnOrigin = caster:GetAbsOrigin()
		if fMaxSpeed ~= nil then
			info.fMaxSpeed = fMaxSpeed
		end
		__TS__ArrayForEach(arr, function(____, item)
			info.vVelocity = item:__mul(speed)
			if speed > 2000 then
				caster:EmitSound(SND_AETHER_FIRE)
			end
			ProjectileManager:CreateLinearProjectile(info)
		end)
	end
end
spirit_1_modifier_cast = __TS__DecorateLegacy({ registerModifier(nil) }, spirit_1_modifier_cast)
local modifier_spirit_1_buff = __TS__Class()
modifier_spirit_1_buff.name = "modifier_spirit_1_buff"
__TS__ClassExtends(modifier_spirit_1_buff, BaseModifier_CS)
function modifier_spirit_1_buff.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.radius = 500
	self.speed = 1200
	self.damage = 20
	self.base_absorb = 40
	self.hero_absorb = 30
	self.return_speed = 600
	self.shield = 30
end
function modifier_spirit_1_buff.prototype.OnCreated(self, _kv)
	if not IsServer() then
		return
	end
	self.shield = self.shield + self.base_absorb
	self:SetStackCount(self.shield)
	self:PlayEffects1()
	self:PlayEffects2()
	self:PlayEffects5()
	self:OnTakeDamage()
end
function modifier_spirit_1_buff.prototype.OnTakeDamage(self)
	local caster = self:GetParent()
	local loc = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		loc,
		nil,
		600,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	local ability = self:GetAbility()
	__TS__ArrayForEach(enemies, function(____, target)
		self:PlayEffects3(target)
		self:PlayEffects4(target)
		target:KnockBack(caster, ability, {
			duration = 0.3,
			origin_pos = loc,
			stun = true,
			distance = 400,
			height = 0,
		})
		self._caster:MonsterDamage({ victim = target, damage_rate = 20, ability = ability })
	end)
end
function modifier_spirit_1_buff.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	EmitSoundOn(SND_PULSE_DESTROY, self:GetParent())
end
function modifier_spirit_1_buff.prototype.Absorb(self)
	self.shield = self.shield + self.hero_absorb
	self:SetStackCount(self.shield)
end
function modifier_spirit_1_buff.prototype.GetStatusEffectName(self)
	return pfx5
end
function modifier_spirit_1_buff.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_spirit_1_buff.prototype.PlayEffects1(self)
	local pfx = ParticleManager:CreateParticle(pfx6, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(pfx, 1, Vector(self.radius * 2, self.radius * 2, self.radius * 2))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn(SND_PULSE, self:GetParent())
end
function modifier_spirit_1_buff.prototype.PlayEffects2(self)
	local parent = self:GetParent()
	local pfx = ParticleManager:CreateParticle(pfx13, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(pfx, 1, Vector(100, 100, 100))
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	self:AddParticle(pfx, false, false, 15, false, false)
	local pfx2 = ParticleManager:CreateParticle(pfx14, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:ReleaseParticleIndex(pfx2)
	EmitSoundOn(SND_PULSE_CAST, parent)
end
function modifier_spirit_1_buff.prototype.PlayEffects3(self, target)
	target:EmitSound(SND_PULSE_TARGET)
	local pfx = ParticleManager:CreateParticle(pfx12, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_spirit_1_buff.prototype.PlayEffects4(self, target)
	local pfx = ParticleManager:CreateParticle(pfx11, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_spirit_1_buff.prototype.PlayEffects5(self)
	local parent = self:GetParent()
	local pfx = ParticleManager:CreateParticle(pfx7, PATTACH_POINT_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(pfx, 0, parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
	ParticleManager:SetParticleControl(pfx, 1, Vector(300, 300, 300))
	ParticleManager:ReleaseParticleIndex(pfx)
end
modifier_spirit_1_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_spirit_1_buff)
local spirit_astral_step_debuff = __TS__Class()
spirit_astral_step_debuff.name = "spirit_astral_step_debuff"
__TS__ClassExtends(spirit_astral_step_debuff, BaseModifier_CS)
function spirit_astral_step_debuff.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.slow = -40
end
function spirit_astral_step_debuff.prototype.IsHidden(self)
	return false
end
function spirit_astral_step_debuff.prototype.IsDebuff(self)
	return true
end
function spirit_astral_step_debuff.prototype.IsPurgable(self)
	return true
end
function spirit_astral_step_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function spirit_astral_step_debuff.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = self.slow }
end
function spirit_astral_step_debuff.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	ScreenShake(self:GetParent():GetAbsOrigin(), 10, 10, 0.1, 2000, 0, true)
	self:GetCaster():MonsterDamage({
		victim = self:GetParent(),
		damage_rate = 30,
		ability = self:GetAbility(),
	})
	self:playExplosion()
end
function spirit_astral_step_debuff.prototype.GetEffectName(self)
	return pfx10
end
function spirit_astral_step_debuff.prototype.GetStatusEffectName(self)
	return pfx5
end
function spirit_astral_step_debuff.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function spirit_astral_step_debuff.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function spirit_astral_step_debuff.prototype.playExplosion(self)
	local pfx = ParticleManager:CreateParticle(pfx9, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn(SND_MARK_EXPLOSION, self:GetParent())
end
spirit_astral_step_debuff = __TS__DecorateLegacy({ registerModifier(nil) }, spirit_astral_step_debuff)
return ____exports