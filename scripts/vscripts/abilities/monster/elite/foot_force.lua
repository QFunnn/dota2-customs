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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local foot_force_time, foot_force_slow_modifier, foot_force_modifier
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local pfx_1 = "particles/ursa_earthshock2.vpcf"
local CAST_POINT = 1
local CAST_DURATION = 7
local foot_force = __TS__Class()
foot_force.name = "foot_force"
__TS__ClassExtends(foot_force, MonsterAbility_CS)
function foot_force.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 700,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			return self:StartCastPhase()
		end,
		OnInterrupt = function()
			return self:ClearCastState()
		end,
		OnStart = function()
			return self:StartSlamSequence()
		end,
	}
end
function foot_force.prototype.StartCastPhase(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	foot_force_time:applys(caster, caster, self, { duration = CAST_POINT })
end
function foot_force.prototype.StartSlamSequence(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	foot_force_time:remove(caster)
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	self:PlayInitialSlam(300)
	self:PlayEarthshockEffect(300)
end
function foot_force.prototype.ClearCastState(self)
	local caster = self:GetCaster()
	if not IsValid(nil, caster) or caster:IsNull() then
		return
	end
	caster:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
	foot_force_time:remove(caster)
	foot_force_modifier:remove(caster)
end
function foot_force.prototype.PlayInitialSlam(self, range)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(100))
	local sound_cast = "Hero_Ursa.Earthshock"
	local effect_cast =
		ParticleManager:CreateParticle("particles/boss_cow/sandking_epicenter.vpcf", PATTACH_WORLDORIGIN, nil)
	foot_force_modifier:applys(caster, caster, self, { duration = 4 })
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(range, 100, 100))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_cast, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, item)
		caster:MonsterDamage({ victim = item, damage_rate = 20, ability = self })
		item:KnockBack(caster, self, {
			duration = 0.2,
			origin_pos = caster:GetAbsOrigin(),
			stunDuration = 0.5,
			stun = true,
			distance = 150,
			height = 0,
		})
		foot_force_slow_modifier:applys(item, caster, self, { duration = 2 })
	end)
end
function foot_force.prototype.PlayEarthshockEffect(self, range)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(100))
	local sound_cast = "Hero_Ursa.Earthshock"
	local effect_cast = ParticleManager:CreateParticle(pfx_1, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControlForward(effect_cast, 0, caster:GetForwardVector())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(range, 100, 100))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_cast, caster)
end
function foot_force.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
	if target and extraData.dummy then
		local caster = self:GetCaster()
		local dummy = EntIndexToHScript(extraData.dummy)
		if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) or not IsValidAlive(nil, dummy) then
			return true
		end
		ScreenShake(target:GetAbsOrigin(), 4, 2, 2, 3000, 0, true)
		GridNav:DestroyTreesAroundPoint(target:GetAbsOrigin(), 300, false)
		dummy:EmitSound("Hero_PrimalBeast.RockThrow.Impact")
		local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CENTER_FOLLOW, caster)
		ParticleManager:SetParticleControl(effect_cast, 3, dummy:GetOrigin())
		ParticleManager:ReleaseParticleIndex(effect_cast)
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			dummy:GetAbsOrigin(),
			nil,
			200,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		__TS__ArrayForEach(enemies, function(____, unit)
			if not IsValidAlive(nil, caster) then
				return
			end
			if not IsValidAlive(nil, unit) then
				return
			end
			AddDeBuffStatus(nil, unit, caster, self, DebuffStatusType.STUN, { duration = 0.5 })
			unit:EmitSound("Hero_PrimalBeast.RockThrow.Stun")
			caster:MonsterDamage({ victim = unit, damage_rate = 20, ability = self })
		end)
		if IsValid(nil, dummy) and not dummy:IsNull() then
			dummy:RemoveSelf()
		end
		return true
	end
end
foot_force = __TS__DecorateLegacy({ registerAbility(nil) }, foot_force)
foot_force_time = __TS__Class()
foot_force_time.name = "foot_force_time"
__TS__ClassExtends(foot_force_time, MonsterModifier_CS)
function foot_force_time.prototype.GetEffectName(self)
	return "particles/underlord_2021_immortal_portal_buildup_crimson_max.vpcf"
end
function foot_force_time.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_wraithking_ghosts.vpcf"
end
foot_force_time = __TS__DecorateLegacy({ registerModifier(nil) }, foot_force_time)
foot_force_slow_modifier = __TS__Class()
foot_force_slow_modifier.name = "foot_force_slow_modifier"
__TS__ClassExtends(foot_force_slow_modifier, MonsterModifier_CS)
function foot_force_slow_modifier.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_ursa/ursa_earthshock_modifier.vpcf"
end
function foot_force_slow_modifier.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function foot_force_slow_modifier.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function foot_force_slow_modifier.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	return -50
end
foot_force_slow_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, foot_force_slow_modifier)
foot_force_modifier = __TS__Class()
foot_force_modifier.name = "foot_force_modifier"
__TS__ClassExtends(foot_force_modifier, MonsterModifier_CS)
function foot_force_modifier.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.num = 0
end
function foot_force_modifier.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function foot_force_modifier.prototype.OnIntervalThink(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	self:PlayEffect(400 + self.num * 100)
	self.num = self.num + 1
	if self.num == 3 then
		self:PlayEffect2(550)
		self:StartIntervalThink(0.6)
	end
	if self.num == 4 then
		self:PlayEffect2(550)
	end
	if self.num > 2 then
		self:StartRock(self.num + 2)
	end
	ScreenShake(caster:GetAbsOrigin(), 4 + self.num, 5 + self.num, 0.2, 3000, 0, true)
end
function foot_force_modifier.prototype.PlayEffect(self, range)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(100))
	local sound_cast = "Hero_Ursa.Earthshock"
	local effect_cast =
		ParticleManager:CreateParticle("particles/boss_cow/sandking_epicenter.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControlForward(effect_cast, 0, caster:GetForwardVector())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(range, 10, 10))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_cast, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		range * 0.8,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, item)
		if not IsValidAlive(nil, caster) or not IsValidAlive(nil, item) then
			return
		end
		foot_force_slow_modifier:applys(item, caster, self:GetAbility(), { duration = 2 })
		caster:MonsterDamage({
			victim = item,
			damage_rate = 25,
			ability = self:GetAbility(),
		})
		item:KnockBack(caster, self:GetAbility(), {
			duration = 0.5,
			origin_pos = caster:GetAbsOrigin(),
			stunDuration = 0.3,
			stun = true,
			distance = 150,
			height = 0,
		})
	end)
end
function foot_force_modifier.prototype.PlayEffect2(self, range)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(100))
	local sound_cast = "Hero_Ursa.Earthshock"
	local effect_cast = ParticleManager:CreateParticle(pfx_1, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControlForward(effect_cast, 0, caster:GetForwardVector())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(range, 100, 100))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_cast, caster)
end
function foot_force_modifier.prototype.StartRock(self, rock_num)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pos = caster:GetForwardVector()
	local speed = 900
	local arr = GetRotateVectors(nil, pos, rock_num, 360 / rock_num)
	local dumys = {}
	__TS__ArrayForEach(arr, function(____, item)
		local dummy = CreateModifierThinker(
			caster,
			self:GetAbility(),
			"modifier_imba_rock_throw_thinker2",
			{ duration = 1 },
			caster:GetOrigin():__add(item:__mul(math.random(500, 700))),
			caster:GetTeamNumber(),
			false
		)
		dumys[#dumys + 1] = dummy
	end)
	__TS__ArrayForEach(dumys, function(____, dummy)
		local info = {
			Target = dummy,
			Source = caster,
			Ability = self:GetAbility(),
			EffectName = "particles/primal_beast_rock_throw_arc.vpcf",
			iMoveSpeed = speed,
			bDrawsOnMinimap = false,
			bDodgeable = false,
			bIsAttack = false,
			bVisibleToEnemies = true,
			bReplaceExisting = false,
			flExpireTime = GameRules:GetGameTime() + 10,
			bProvidesVision = false,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
			ExtraData = { dummy = dummy:entindex() },
		}
		ProjectileManager:CreateTrackingProjectile(info)
	end)
end
foot_force_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, foot_force_modifier)
local modifier_imba_rock_throw_thinker2 = __TS__Class()
modifier_imba_rock_throw_thinker2.name = "modifier_imba_rock_throw_thinker2"
__TS__ClassExtends(modifier_imba_rock_throw_thinker2, MonsterModifier_CS)
function modifier_imba_rock_throw_thinker2.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
end
function modifier_imba_rock_throw_thinker2.prototype.OnCreated(self, params)
	if not self:GetAbility() then
		return
	end
	if not IsServer() then
		return
	end
	local radius = 200
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_preview.vpcf"
	local effect_cast = ParticleManager:CreateParticleForTeam(
		particle_cast,
		PATTACH_CENTER_FOLLOW,
		self.parent,
		self.caster:GetTeamNumber()
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, 0, 0))
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(radius, 0, 0))
	local particle_cast2 = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_preview.vpcf"
	local effect_cast2 =
		ParticleManager:CreateParticleForTeam(particle_cast2, PATTACH_CENTER_FOLLOW, self.parent, DOTA_TEAM_GOODGUYS)
	ParticleManager:SetParticleControl(effect_cast2, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast2, 1, Vector(radius, 0, -radius * 3))
	ParticleManager:SetParticleControl(effect_cast2, 2, Vector(radius, 0, 0))
	self.effect_cast = effect_cast
	self.effect_cast2 = effect_cast2
end
function modifier_imba_rock_throw_thinker2.prototype.OnRemoved(self)
	if not IsServer() then
		return
	end
	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, true)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end
	if self.effect_cast2 then
		ParticleManager:DestroyParticle(self.effect_cast2, true)
		ParticleManager:ReleaseParticleIndex(self.effect_cast2)
	end
	self:StartIntervalThink(-1)
end
modifier_imba_rock_throw_thinker2 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_imba_rock_throw_thinker2)
return ____exports