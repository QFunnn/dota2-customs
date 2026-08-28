--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_creep_arrow_lua_stun", "abilities/creeps/zone_4/zone_4", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

creep_arrow_lua = class({})

function creep_arrow_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_arrow_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local arrows_count = self:GetSpecialValueFor("arrows_count")
	local delay = 0.4
	local current_arrow = 0

	Timers:CreateTimer(0, function()
		if not caster or caster:IsNull() or not caster:IsAlive() then
			return nil
		end

		local target_pos = target:GetOrigin()

		local fDist = (target:GetOrigin() - caster:GetOrigin()):Length2D()
		if (fDist > 400) and target and target:IsMoving() then
			local vLeadingOffset = target:GetForwardVector() * RandomInt(200, 400)
			target_pos = target:GetOrigin() + vLeadingOffset
		end

		local vToTarget = (target_pos - caster:GetAbsOrigin()):Normalized()
		vToTarget.z = 0
		direction = vToTarget

		self:FireArrow(direction)

		current_arrow = current_arrow + 1
		if current_arrow < arrows_count then
			return delay
		end
	end)
end

function creep_arrow_lua:FireArrow(direction)
	local caster = self:GetCaster()
	local spawn_distance = self:GetSpecialValueFor("spawn_distance")

	-- Точка спавна чуть впереди кастера
	local spawn_point = caster:GetAbsOrigin() + direction * spawn_distance

	local arrow_speed = self:GetSpecialValueFor("arrow_speed")
	local arrow_radius = self:GetSpecialValueFor("arrow_radius")
	local arrow_distance = self:GetSpecialValueFor("arrow_distance")

	caster:EmitSound("Hero_Mirana.ArrowCast")

	local projectile_info = {
		Ability = self,
		EffectName = "particles/units/heroes/hero_mirana/mirana_spell_arrow.vpcf",
		vSpawnOrigin = spawn_point,
		fDistance = arrow_distance,
		fStartRadius = arrow_radius,
		fEndRadius = arrow_radius,
		Source = caster,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		bDeleteOnHit = true,
		vVelocity = direction * arrow_speed, -- Направление полета
		bProvidesVision = true,
		iVisionRadius = 500,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}

	ProjectileManager:CreateLinearProjectile(projectile_info)
end

function creep_arrow_lua:OnProjectileHit(target, location)
	if not target or target:IsMagicImmune() then
		return
	end

	local caster = self:GetCaster()

	target:EmitSound("Hero_Mirana.ArrowImpact")

	local damage = self:GetSpecialValueFor("base_damage") + self:GetSpecialValueFor("diff_boost_damage")

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})

	local stun_duration = self:GetSpecialValueFor("max_stun_duration")
	target:AddNewModifier(caster, self, "modifier_creep_arrow_lua_stun", { duration = stun_duration })

	return true
end

--------------------------------------------------------------------------------

modifier_creep_arrow_lua_stun = class({})

function modifier_creep_arrow_lua_stun:IsStunDebuff()
	return true
end
function modifier_creep_arrow_lua_stun:IsPurgeException()
	return true
end
function modifier_creep_arrow_lua_stun:CheckState()
	return { [MODIFIER_STATE_STUNNED] = true }
end
function modifier_creep_arrow_lua_stun:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end
function modifier_creep_arrow_lua_stun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_flop_lua", "abilities/creeps/zone_4/zone_4", LUA_MODIFIER_MOTION_BOTH)

creep_flop_lua = class({})

function creep_flop_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
		context
	)
	PrecacheResource("particle", "particles/test_particle/ogre_melee_smash.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function creep_flop_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_flop_lua:OnAbilityPhaseStart()
	if IsServer() then
		self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_2)
	end

	return true
end

function creep_flop_lua:OnAbilityPhaseInterrupted()
	if IsServer() then
		self:GetCaster():RemoveGesture(ACT_DOTA_CAST_ABILITY_2)
		self:GetCaster():RemoveModifierByName("modifier_techies_suicide_leap_animation")
	end
end

function creep_flop_lua:OnSpellStart()
	if IsServer() then
		self.stun_duration = self:GetSpecialValueFor("stun_duration")

		local vToTarget = self:GetCursorPosition() - self:GetCaster():GetOrigin()
		vToTarget = vToTarget:Normalized()
		local vLocation = self:GetCaster():GetOrigin() + vToTarget * 50
		local kv = {
			vLocX = vLocation.x,
			vLocY = vLocation.y,
			vLocZ = vLocation.z,
		}
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_creep_flop_lua", kv)
		EmitSoundOn("Item.OgreSealTotem.Cast", self:GetCaster())
	end
end

function creep_flop_lua:TryToDamage()
	if IsServer() then
		local radius = self:GetSpecialValueFor("radius")
		local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
		local silence_duration = self:GetSpecialValueFor("silence_duration")
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetCaster():GetOrigin(),
			self:GetCaster(),
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS,
			0,
			false
		)
		if #enemies > 0 then
			for _, enemy in pairs(enemies) do
				if
					enemy ~= nil
					and enemy:IsNull() == false
					and (not enemy:IsMagicImmune())
					and (not enemy:IsInvulnerable())
				then
					local DamageInfo = {
						victim = enemy,
						attacker = self:GetCaster(),
						ability = self,
						damage = damage,
						damage_type = DAMAGE_TYPE_PHYSICAL,
					}
					ApplyDamage(DamageInfo)
					if enemy:IsAlive() == false then
						local nFXIndex = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
							PATTACH_CUSTOMORIGIN,
							nil
						)
						ParticleManager:SetParticleControlEnt(
							nFXIndex,
							0,
							enemy,
							PATTACH_POINT_FOLLOW,
							"attach_hitloc",
							enemy:GetOrigin(),
							true
						)
						ParticleManager:SetParticleControl(nFXIndex, 1, enemy:GetOrigin())
						ParticleManager:SetParticleControlForward(nFXIndex, 1, -self:GetCaster():GetForwardVector())
						ParticleManager:SetParticleControlEnt(
							nFXIndex,
							10,
							enemy,
							PATTACH_ABSORIGIN_FOLLOW,
							nil,
							enemy:GetOrigin(),
							true
						)
						ParticleManager:ReleaseParticleIndex(nFXIndex)

						EmitSoundOn("Dungeon.BloodSplatterImpact", enemy)
					else
						enemy:AddNewModifier(
							self:GetCaster(),
							self,
							"modifier_stunned",
							{ duration = self.stun_duration }
						)
					end
				end
			end
		end

		local sound_cast = "Item.OgreSealTotem.Smash"
		-- EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
		EmitSoundOn(sound_cast, self:GetCaster())
		local nFXIndex = ParticleManager:CreateParticle(
			"particles/test_particle/ogre_melee_smash.vpcf",
			PATTACH_WORLDORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(nFXIndex, 0, self:GetCaster():GetOrigin())
		ParticleManager:SetParticleControl(nFXIndex, 1, Vector(self.radius, self.radius, self.radius))
		ParticleManager:ReleaseParticleIndex(nFXIndex)

		GridNav:DestroyTreesAroundPoint(self:GetCaster():GetOrigin(), radius, false)
	end
end

--------------------------------------------------------------------------------

modifier_creep_flop_lua = class({})

local OGRE_MINIMUM_HEIGHT_ABOVE_LOWEST = 150
local OGRE_MINIMUM_HEIGHT_ABOVE_HIGHEST = 33
local OGRE_ACCELERATION_Z = 1250
local OGRE_MAX_HORIZONTAL_ACCELERATION = 800

function modifier_creep_flop_lua:IsStunDebuff()
	return true
end

function modifier_creep_flop_lua:IsHidden()
	return true
end

function modifier_creep_flop_lua:IsPurgable()
	return false
end

function modifier_creep_flop_lua:RemoveOnDeath()
	return false
end

function modifier_creep_flop_lua:OnCreated(kv)
	if IsServer() then
		if self.nHopCount == nil then
			self.nHopCount = 1
			self.flop_distances = { 200, 300, 300 }
			-- local nFXIndex = ParticleManager:CreateParticle( "particles/act_2/ogre_seal_warcry.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
			-- ParticleManager:SetParticleControlEnt( nFXIndex, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
			-- ParticleManager:SetParticleControlEnt( nFXIndex, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "mouth", self:GetParent():GetOrigin(), true )
			-- ParticleManager:SetParticleControlEnt( nFXIndex, 6, self:GetParent(), PATTACH_POINT_FOLLOW, "eye_L", self:GetParent():GetOrigin(), true )
			-- ParticleManager:SetParticleControlEnt( nFXIndex, 7, self:GetParent(), PATTACH_POINT_FOLLOW, "eye_R", self:GetParent():GetOrigin(), true )
			-- self:AddParticle( nFXIndex, false, false, -1, false, false )
		end

		if self:GetCaster():IsRealHero() then
			self:GetCaster():StartGesture(ACT_DOTA_FLAIL)
		end

		self.bHorizontalMotionInterrupted = false
		self.bDamageApplied = false
		self.bTargetTeleported = false

		if self:ApplyHorizontalMotionController() == false or self:ApplyVerticalMotionController() == false then
			self:Destroy()
			return
		end

		self.flTimer = 0.0
		self.vStartPosition = GetGroundPosition(self:GetParent():GetOrigin(), self:GetParent())
		self.flCurrentTimeHoriz = 0.0
		self.flCurrentTimeVert = 0.0

		self.vLoc = Vector(kv.vLocX, kv.vLocY, kv.vLocZ)
		self.vLastKnownTargetPos = self.vLoc

		local duration = self:GetAbility():GetSpecialValueFor("duration")
		local flDesiredHeight = OGRE_MINIMUM_HEIGHT_ABOVE_LOWEST * self.nHopCount * duration * duration
		local flLowZ = math.min(self.vLastKnownTargetPos.z, self.vStartPosition.z)
		local flHighZ = math.max(self.vLastKnownTargetPos.z, self.vStartPosition.z)
		local flArcTopZ =
			math.max(flLowZ + flDesiredHeight, flHighZ + OGRE_MINIMUM_HEIGHT_ABOVE_HIGHEST * self.nHopCount)

		local flArcDeltaZ = flArcTopZ - self.vStartPosition.z
		self.flInitialVelocityZ = math.sqrt(2.0 * flArcDeltaZ * OGRE_ACCELERATION_Z * self.nHopCount)

		local flDeltaZ = self.vLastKnownTargetPos.z - self.vStartPosition.z
		local flSqrtDet = math.sqrt(
			math.max(
				0,
				(self.flInitialVelocityZ * self.flInitialVelocityZ)
					- 2.0 * OGRE_ACCELERATION_Z * self.nHopCount * flDeltaZ
			)
		)
		self.flPredictedTotalTime = math.max(
			(self.flInitialVelocityZ + flSqrtDet) / (OGRE_ACCELERATION_Z * self.nHopCount),
			(self.flInitialVelocityZ - flSqrtDet) / (OGRE_ACCELERATION_Z * self.nHopCount)
		)

		self.vHorizontalVelocity = (self.vLastKnownTargetPos - self.vStartPosition) / self.flPredictedTotalTime
		self.vHorizontalVelocity.z = 0.0
	end
end

function modifier_creep_flop_lua:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveHorizontalMotionController(self)
		self:GetParent():RemoveVerticalMotionController(self)

		if self:GetCaster():IsRealHero() then
			self:GetCaster():RemoveGesture(ACT_DOTA_FLAIL)
		end
	end
end

function modifier_creep_flop_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
	return funcs
end

function modifier_creep_flop_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

function modifier_creep_flop_lua:UpdateHorizontalMotion(me, dt)
	if IsServer() then
		self.flTimer = self.flTimer + dt
		self.flCurrentTimeHoriz = math.min(self.flCurrentTimeHoriz + dt, self.flPredictedTotalTime)
		local t = self.flCurrentTimeHoriz / self.flPredictedTotalTime
		local vStartToTarget = self.vLastKnownTargetPos - self.vStartPosition
		local vDesiredPos = self.vStartPosition + t * vStartToTarget

		if me:IsRealHero() then
			if not GridNav:CanFindPath(me:GetOrigin(), vDesiredPos) then
				self:Destroy()
				return
			end
		end

		local vOldPos = me:GetOrigin()
		local vToDesired = vDesiredPos - vOldPos
		vToDesired.z = 0.0
		local vDesiredVel = vToDesired / dt
		local vVelDif = vDesiredVel - self.vHorizontalVelocity
		local flVelDif = vVelDif:Length2D()
		vVelDif = vVelDif:Normalized()
		local flVelDelta = math.min(flVelDif, OGRE_MAX_HORIZONTAL_ACCELERATION * self.nHopCount)

		self.vHorizontalVelocity = self.vHorizontalVelocity + vVelDif * flVelDelta * dt
		local vNewPos = vOldPos + self.vHorizontalVelocity * dt
		me:SetOrigin(vNewPos)
	end
end

function modifier_creep_flop_lua:UpdateVerticalMotion(me, dt)
	if IsServer() then
		self.flCurrentTimeVert = self.flCurrentTimeVert + dt
		local bGoingDown = (-OGRE_ACCELERATION_Z * self.nHopCount * self.flCurrentTimeVert + self.flInitialVelocityZ)
			< 0

		local vNewPos = me:GetOrigin()
		vNewPos.z = self.vStartPosition.z
			+ (
				-0.5 * OGRE_ACCELERATION_Z * self.nHopCount * (self.flCurrentTimeVert * self.flCurrentTimeVert)
				+ self.flInitialVelocityZ * self.flCurrentTimeVert
			)

		local flGroundHeight = GetGroundHeight(vNewPos, self:GetParent())
		local bLanded = false
		if vNewPos.z < flGroundHeight and bGoingDown == true then
			vNewPos.z = flGroundHeight
			bLanded = true
		end

		me:SetOrigin(vNewPos)
		if bLanded == true then
			local bDoneHopping = self.nHopCount == 3

			if self.bHorizontalMotionInterrupted == false then
				if self.nHopCount > 1 then
					self:GetAbility():TryToDamage()
					self.flTimer = 0.0
				end
			else
				bDoneHopping = true
			end

			if bDoneHopping then
				self:Destroy()
			else
				self.nHopCount = self.nHopCount + 1
				self.vLoc = self.vLoc + self:GetCaster():GetForwardVector() * self.flop_distances[self.nHopCount]
				local kv = {
					vLocX = self.vLoc.x,
					vLocY = self.vLoc.y,
					vLocZ = self.vLoc.z,
				}
				self:OnCreated(kv)
			end
		end
	end
end

function modifier_creep_flop_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self.bHorizontalMotionInterrupted = true
	end
end

function modifier_creep_flop_lua:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_creep_flop_lua:GetOverrideAnimation(params)
	return ACT_DOTA_OVERRIDE_ABILITY_2
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_dispersion_lua", "abilities/creeps/zone_4/zone_4", LUA_MODIFIER_MOTION_NONE)

creep_dispersion_lua = class({})

function creep_dispersion_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_spectre/spectre_dispersion.vpcf", context)
end

function creep_dispersion_lua:GetIntrinsicModifierName()
	return "modifier_creep_dispersion_lua"
end

--------------------------------------------------------------------------------

modifier_creep_dispersion_lua = class({
	IsHidden = function()
		return true
	end,
	IsPurgable = function()
		return false
	end,
})

function modifier_creep_dispersion_lua:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	if not IsServer() then
		return
	end

	self.reflection_pct = self.ability:GetSpecialValueFor("damage_reflection_pct")
	self.diff_boost = self.ability:GetSpecialValueFor("diff_boost_damage")
	self.min_radius = self.ability:GetSpecialValueFor("min_radius")
	self.max_radius = self.ability:GetSpecialValueFor("max_radius")

	self.total_reflection_mult = (self.reflection_pct + self.diff_boost) / 100
	self.damage_type = self.ability:GetAbilityDamageType()

	self.last_pfx_time = 0
	self.pfx_throttle = 0.1
end

function modifier_creep_dispersion_lua:DeclareFunctions()
	return { MODIFIER_EVENT_ON_TAKEDAMAGE }
end

function modifier_creep_dispersion_lua:OnTakeDamage(params)
	if not IsServer() then
		return
	end

	if params.unit ~= self.parent or params.damage <= 10 then
		return
	end
	if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
		return
	end
	if params.attacker == self.parent or not params.attacker then
		return
	end

	local origin = self.parent:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		origin,
		self.parent,
		self.max_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	if #enemies == 0 then
		return
	end

	local current_time = GameRules:GetGameTime()
	local bPlayParticles = (current_time - self.last_pfx_time) >= self.pfx_throttle
	if bPlayParticles then
		self.last_pfx_time = current_time
	end

	for _, enemy in pairs(enemies) do
		local enemy_pos = enemy:GetAbsOrigin()
		local distance = (enemy_pos - origin):Length2D()

		local current_mult = 1.0
		if distance > self.min_radius then
			current_mult = math.max(0, 1.0 - ((distance - self.min_radius) / (self.max_radius - self.min_radius)))
		end

		local final_reflected_damage = params.damage * self.total_reflection_mult * current_mult

		if final_reflected_damage > 0 then
			ApplyDamage({
				victim = enemy,
				attacker = self.parent,
				damage = final_reflected_damage,
				damage_type = self.damage_type,
				damage_flags = DOTA_DAMAGE_FLAG_REFLECTION
					+ DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL
					+ DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
				ability = self.ability,
			})

			if bPlayParticles then
				local pfx = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_spectre/spectre_dispersion.vpcf",
					PATTACH_POINT_FOLLOW,
					self.parent
				)
				ParticleManager:SetParticleControlEnt(
					pfx,
					0,
					self.parent,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					origin,
					true
				)
				ParticleManager:SetParticleControlEnt(
					pfx,
					1,
					enemy,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					enemy_pos,
					true
				)
				ParticleManager:ReleaseParticleIndex(pfx)
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

require("data")

LinkLuaModifier("modifier_creep_spider_die_spawn_lua", "abilities/creeps/zone_4/zone_4", LUA_MODIFIER_MOTION_VERTICAL)
LinkLuaModifier(
	"modifier_creep_spider_die_spawn_lua_effect",
	"abilities/creeps/zone_4/zone_4",
	LUA_MODIFIER_MOTION_VERTICAL
)

creep_spider_die_spawn_lua = class({})

function creep_spider_die_spawn_lua:GetIntrinsicModifierName()
	return "modifier_creep_spider_die_spawn_lua"
end

--------------------------------------------------------------------------------

modifier_creep_spider_die_spawn_lua = class({})

function modifier_creep_spider_die_spawn_lua:IsHidden()
	return true
end

function modifier_creep_spider_die_spawn_lua:IsPurgable()
	return false
end

function modifier_creep_spider_die_spawn_lua:OnCreated()
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()

	self.explosion_delay = self.ability:GetSpecialValueFor("explosion_delay")
	self.debuff_duration = self.ability:GetSpecialValueFor("debuff_duration")
	self.spawn_count = self.ability:GetSpecialValueFor("spawn_count")

	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self.ability, "modifier_boss_damage_boost", {})
	end
end

function modifier_creep_spider_die_spawn_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_creep_spider_die_spawn_lua:OnDeath(keys)
	if IsServer() then
		if keys.unit == self:GetParent() then
			local ice_blast_particle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_final.vpcf",
				PATTACH_WORLDORIGIN,
				self:GetParent()
			)
			ParticleManager:SetParticleControl(ice_blast_particle, 0, self:GetParent():GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(ice_blast_particle)
			self:GetCaster():EmitSound("Hero_Ancient_Apparition.IceBlastRelease.Cast")

			Timers:CreateTimer(self.explosion_delay, function()
				self:GetCaster():EmitSound("Hero_Ancient_Apparition.IceBlast.Target")
				local enemies = FindUnitsInRadius(
					self:GetParent():GetTeamNumber(),
					self:GetParent():GetOrigin(),
					nil,
					400,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				for _, enemy in pairs(enemies) do
					enemy:AddNewModifier(
						enemy,
						self:GetAbility(),
						"modifier_creep_spider_die_spawn_lua_effect",
						{ duration = self.debuff_duration }
					)
				end
				for i = 1, self.spawn_count do
					local unit = CreateUnitByName(
						"npc_dota_zone_4_unit_4",
						self:GetParent():GetAbsOrigin() + RandomVector(RandomInt(150, 150)),
						true,
						self:GetParent(),
						self:GetParent(),
						self:GetParent():GetTeamNumber()
					)

					if self:GetParent().solo_event_player_id then
						unit.solo_event_player_id = self:GetParent().solo_event_player_id
					end

					local random_ability = passive[RandomInt(1, #passive)]
					rules:aura_dif(unit, random_ability)
				end
			end)
		end
	end
end

--------------------------------------------------------------------------------

modifier_creep_spider_die_spawn_lua_effect = class({})

function modifier_creep_spider_die_spawn_lua:IsHidden()
	return false
end
function modifier_creep_spider_die_spawn_lua_effect:IsDebuff()
	return true
end
function modifier_creep_spider_die_spawn_lua_effect:IsPurgable()
	return false
end

function modifier_creep_spider_die_spawn_lua_effect:GetEffectName()
	return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_debuff.vpcf"
end

function modifier_creep_spider_die_spawn_lua_effect:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_creep_spider_die_spawn_lua_effect:OnCreated(params)
	if not IsServer() then
		return
	end

	if params.caster_entindex then
		self.caster = EntIndexToHScript(params.caster_entindex)
	else
		self.caster = self:GetParent()
	end

	local damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

	self.damage_table = {
		victim = self:GetParent(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self.caster,
		ability = self:GetAbility(),
	}

	self:StartIntervalThink(1 - self:GetParent():GetStatusResistance())
end

function modifier_creep_spider_die_spawn_lua_effect:OnRefresh(params)
	self:OnCreated(params)
end

function modifier_creep_spider_die_spawn_lua_effect:OnIntervalThink()
	self:GetParent():EmitSound("Hero_Ancient_Apparition.IceBlastRelease.Tick")
	ApplyDamage(self.damage_table)
end

function modifier_creep_spider_die_spawn_lua_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
end

function modifier_creep_spider_die_spawn_lua_effect:GetDisableHealing()
	return 1
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_creep_snowball_lua_movement",
	"abilities/creeps/zone_4/zone_4",
	LUA_MODIFIER_MOTION_HORIZONTAL
)

creep_snowball_lua = class({})

function creep_snowball_lua:Precache(context)
	PrecacheResource("particle", "particles/gavnina/snow_ball.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tusk.vsndevts", context)
end

function creep_snowball_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_snowball_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	local duration = self:GetSpecialValueFor("snowball_duration")

	caster:AddNewModifier(caster, self, "modifier_creep_snowball_lua_movement", {
		target_entindex = target:entindex(),
		duration = duration,
	})
	caster:EmitSound("Hero_Tusk.Snowball.Cast")
end

--------------------------------------------------------------------------------

modifier_creep_snowball_lua_movement = class({})

function modifier_creep_snowball_lua_movement:IsHidden()
	return true
end
function modifier_creep_snowball_lua_movement:IsPurgable()
	return false
end
function modifier_creep_snowball_lua_movement:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_creep_snowball_lua_movement:OnCreated(params)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.target = EntIndexToHScript(params.target_entindex)

	self.speed = self:GetAbility():GetSpecialValueFor("snowball_speed")
	self.damage = self:GetAbility():GetSpecialValueFor("snowball_damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

	self.effect_cast =
		ParticleManager:CreateParticle("particles/gavnina/snow_ball.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)

	ParticleManager:SetParticleControl(self.effect_cast, 0, self.parent:GetOrigin())

	if self:ApplyHorizontalMotionController() == false then
		self:Destroy()
	end
end

function modifier_creep_snowball_lua_movement:UpdateHorizontalMotion(me, dt)
	if not IsServer() then
		return
	end

	if not self.target or self.target:IsNull() or not self.target:IsAlive() then
		self:Destroy()
		return
	end

	local my_pos = me:GetAbsOrigin()
	local target_pos = self.target:GetAbsOrigin()
	local distance_vec = target_pos - my_pos
	local distance = distance_vec:Length2D()
	local direction = distance_vec:Normalized()

	if distance < 170 then
		self:Hit(self.target)
		self:Destroy()
		return
	end

	local next_pos = my_pos + direction * self.speed * dt
	next_pos.z = GetGroundHeight(next_pos, me)

	me:SetOrigin(next_pos)
	me:FaceTowards(target_pos)

	ParticleManager:SetParticleControl(self.effect_cast, 1, direction * self.speed)
end

function modifier_creep_snowball_lua_movement:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_creep_snowball_lua_movement:Hit(target)
	if not IsServer() then
		return
	end

	target:EmitSound("Hero_Tusk.Snowball.ProjectileHit")

	ApplyDamage({
		victim = target,
		attacker = self.caster,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})

	target:AddNewModifier(
		self.caster,
		self:GetAbility(),
		"modifier_stunned",
		{ duration = self:GetAbility():GetSpecialValueFor("stun_duration") }
	)
end

function modifier_creep_snowball_lua_movement:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:RemoveHorizontalMotionController(self)
	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, false)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end

	FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)
end

function modifier_creep_snowball_lua_movement:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end

function modifier_creep_snowball_lua_movement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_creep_snowball_lua_movement:GetModifierModelChange()
	return "models/development/invisiblebox.vmdl"
end

--------------------------------------------------------------------------------

creep_ring_shards_lua = class({})

function creep_ring_shards_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_ring_shards_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local caster_pos = caster:GetAbsOrigin()
	local radius = self:GetSpecialValueFor("radius")
	local count = self:GetSpecialValueFor("count")

	local sound_cast = "Hero_Tusk.IceShards"
	-- EmitSoundOnLocationWithCaster(caster_pos, sound_cast, caster)
	EmitSoundOn(sound_cast, caster)

	for i = 1, count do
		local random_offset = RandomVector(RandomFloat(0, radius))
		local shard_pos = GetGroundPosition(caster_pos + random_offset, nil)
		self:CreateShard(shard_pos)
	end
end

function creep_ring_shards_lua:CreateShard(vLocation)
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("shard_duration")
	local damage = self:GetSpecialValueFor("shard_damage") + (self:GetSpecialValueFor("diff_boost_damage") or 0)
	local hit_radius = 150

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tusk/tusk_ice_shards.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, Vector(duration, 0, 0))
	for i = 1, 5 do
		ParticleManager:SetParticleControl(particle, i, vLocation + RandomVector(RandomFloat(0, 30)))
	end

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		vLocation,
		nil,
		hit_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
	end

	local blocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", { origin = vLocation })

	local ice_model = SpawnEntityFromTableSynchronous("prop_dynamic", {
		model = "models/particle/ice_shards.vmdl",
		origin = vLocation,
		angles = Vector(0, RandomInt(0, 360), 0),
		modelscale = 15,
	})

	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		vLocation,
		nil,
		100,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, unit in pairs(units) do
		FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
	end

	Timers:CreateTimer(duration, function()
		if blocker and not blocker:IsNull() then
			UTIL_Remove(blocker)
		end
		if ice_model and not ice_model:IsNull() then
			UTIL_Remove(ice_model)
		end
		if particle then
			ParticleManager:DestroyParticle(particle, false)
			ParticleManager:ReleaseParticleIndex(particle)
		end
	end)
end