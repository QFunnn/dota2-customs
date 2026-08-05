--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_blob_jump_lua", "abilities/creeps/zone_6/zone_6", LUA_MODIFIER_MOTION_BOTH)

creep_blob_jump_lua = class({})

function creep_blob_jump_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
		context
	)
	PrecacheResource("particle", "particles/test_particle/ogre_melee_smash.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function creep_blob_jump_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_blob_jump_lua:OnSpellStart()
	if IsServer() then
		local kv = {
			vLocX = self:GetCursorPosition().x,
			vLocY = self:GetCursorPosition().y,
			vLocZ = self:GetCursorPosition().z,
		}

		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_creep_blob_jump_lua", kv)

		self.radius = self:GetSpecialValueFor("radius")
		self.stun_duration = self:GetSpecialValueFor("stun_duration")
		self.damage = self:GetSpecialValueFor("land_damage") + self:GetSpecialValueFor("diff_boost_damage")
		EmitSoundOn("Item.OgreSealTotem.Cast", self:GetCaster())
	end
end

function creep_blob_jump_lua:Smash()
	if IsServer() then
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
		self:GetCaster():Interrupt()

		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetCaster():GetOrigin(),
			self:GetCaster(),
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			0,
			false
		)
		for _, enemy in pairs(enemies) do
			if enemy ~= nil and enemy:IsInvulnerable() == false then
				local damageInfo = {
					victim = enemy,
					attacker = self:GetCaster(),
					damage = self.damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
					ability = self,
				}

				ApplyDamage(damageInfo)

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
					enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = self.stun_duration })
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------

modifier_creep_blob_jump_lua = class({})

local AMOEBA_MINIMUM_HEIGHT_ABOVE_LOWEST = 400
local AMOEBA_MINIMUM_HEIGHT_ABOVE_HIGHEST = 200
local AMOEBA_ACCELERATION_Z = 1500
local AMOEBA_MAX_HORIZONTAL_ACCELERATION = 1500

function modifier_creep_blob_jump_lua:IsHidden()
	return true
end

function modifier_creep_blob_jump_lua:IsPurgable()
	return false
end

function modifier_creep_blob_jump_lua:RemoveOnDeath()
	return false
end

function modifier_creep_blob_jump_lua:OnCreated(kv)
	if IsServer() then
		self.bHorizontalMotionInterrupted = false
		self.bDamageApplied = false
		self.bTargetTeleported = false

		if self:ApplyHorizontalMotionController() == false or self:ApplyVerticalMotionController() == false then
			self:Destroy()
			return
		end

		self.vStartPosition = GetGroundPosition(self:GetParent():GetOrigin(), self:GetParent())
		self.flCurrentTimeHoriz = 0.0
		self.flCurrentTimeVert = 0.0

		self.vLoc = Vector(kv.vLocX, kv.vLocY, kv.vLocZ)
		self.vLastKnownTargetPos = self.vLoc

		local duration = self:GetAbility():GetSpecialValueFor("duration")
		local flDesiredHeight = AMOEBA_MINIMUM_HEIGHT_ABOVE_LOWEST * duration * duration
		local flLowZ = math.min(self.vLastKnownTargetPos.z, self.vStartPosition.z)
		local flHighZ = math.max(self.vLastKnownTargetPos.z, self.vStartPosition.z)
		local flArcTopZ = math.max(flLowZ + flDesiredHeight, flHighZ + AMOEBA_MINIMUM_HEIGHT_ABOVE_HIGHEST)

		local flArcDeltaZ = flArcTopZ - self.vStartPosition.z
		self.flInitialVelocityZ = math.sqrt(2.0 * flArcDeltaZ * AMOEBA_ACCELERATION_Z)

		local flDeltaZ = self.vLastKnownTargetPos.z - self.vStartPosition.z
		local flSqrtDet = math.sqrt(
			math.max(0, (self.flInitialVelocityZ * self.flInitialVelocityZ) - 2.0 * AMOEBA_ACCELERATION_Z * flDeltaZ)
		)
		self.flPredictedTotalTime = math.max(
			(self.flInitialVelocityZ + flSqrtDet) / AMOEBA_ACCELERATION_Z,
			(self.flInitialVelocityZ - flSqrtDet) / AMOEBA_ACCELERATION_Z
		)

		self.vHorizontalVelocity = (self.vLastKnownTargetPos - self.vStartPosition) / self.flPredictedTotalTime
		self.vHorizontalVelocity.z = 0.0
	end
end

function modifier_creep_blob_jump_lua:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveHorizontalMotionController(self)
		self:GetParent():RemoveVerticalMotionController(self)
	end
end

function modifier_creep_blob_jump_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}

	return state
end

function modifier_creep_blob_jump_lua:UpdateHorizontalMotion(me, dt)
	if IsServer() then
		self.flCurrentTimeHoriz = math.min(self.flCurrentTimeHoriz + dt, self.flPredictedTotalTime)
		local t = self.flCurrentTimeHoriz / self.flPredictedTotalTime
		local vStartToTarget = self.vLastKnownTargetPos - self.vStartPosition
		local vDesiredPos = self.vStartPosition + t * vStartToTarget

		local vOldPos = me:GetOrigin()
		local vToDesired = vDesiredPos - vOldPos
		vToDesired.z = 0.0
		local vDesiredVel = vToDesired / dt
		local vVelDif = vDesiredVel - self.vHorizontalVelocity
		local flVelDif = vVelDif:Length2D()
		vVelDif = vVelDif:Normalized()
		local flVelDelta = math.min(flVelDif, AMOEBA_MAX_HORIZONTAL_ACCELERATION)

		self.vHorizontalVelocity = self.vHorizontalVelocity + vVelDif * flVelDelta * dt
		local vNewPos = vOldPos + self.vHorizontalVelocity * dt
		me:SetOrigin(vNewPos)
	end
end

function modifier_creep_blob_jump_lua:UpdateVerticalMotion(me, dt)
	if IsServer() then
		self.flCurrentTimeVert = self.flCurrentTimeVert + dt
		local bGoingDown = (-AMOEBA_ACCELERATION_Z * self.flCurrentTimeVert + self.flInitialVelocityZ) < 0

		local vNewPos = me:GetOrigin()
		vNewPos.z = self.vStartPosition.z
			+ (
				-0.5 * AMOEBA_ACCELERATION_Z * (self.flCurrentTimeVert * self.flCurrentTimeVert)
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
			if self.bHorizontalMotionInterrupted == false then
				self:GetAbility():Smash()
			end

			self:Destroy()
		end
	end
end

function modifier_creep_blob_jump_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self.bHorizontalMotionInterrupted = true
	end
end

function modifier_creep_blob_jump_lua:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_creep_blob_jump_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
	return funcs
end

function modifier_creep_blob_jump_lua:GetOverrideAnimation(params)
	return ACT_DOTA_CAST_ABILITY_1
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

require("data")

LinkLuaModifier("modifier_creep_blob_die_spawn_lua", "abilities/creeps/zone_6/zone_6", LUA_MODIFIER_MOTION_VERTICAL)
LinkLuaModifier(
	"modifier_creep_blob_die_spawn_lua_effect",
	"abilities/creeps/zone_6/zone_6",
	LUA_MODIFIER_MOTION_VERTICAL
)

creep_blob_die_spawn_lua = class({})

function creep_blob_die_spawn_lua:GetIntrinsicModifierName()
	return "modifier_creep_blob_die_spawn_lua"
end

-----------------------------------------------------------------------------------------

modifier_creep_blob_die_spawn_lua = class({})

function modifier_creep_blob_die_spawn_lua:IsHidden()
	return true
end

function modifier_creep_blob_die_spawn_lua:IsPurgable()
	return false
end

function modifier_creep_blob_die_spawn_lua:OnCreated()
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.count = self:GetAbility():GetSpecialValueFor("count")
	self.miss = self:GetAbility():GetSpecialValueFor("miss")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_creep_blob_die_spawn_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_creep_blob_die_spawn_lua:OnDeath(keys)
	if IsServer() then
		if keys.unit == self:GetParent() then
			local enemies = FindUnitsInRadius(
				self:GetParent():GetTeamNumber(),
				self:GetParent():GetOrigin(),
				self:GetParent(),
				self.radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			for _, enemy in pairs(enemies) do
				enemy:AddNewModifier(
					enemy,
					nil,
					"modifier_creep_blob_die_spawn_lua_effect",
					{ duration = self.duration }
				)
			end
			for i = 1, self.count do
				local unit = CreateUnitByName(
					"npc_dota_zone_6_unit_2",
					self:GetParent():GetAbsOrigin() + RandomVector(RandomInt(150, 150)),
					true,
					self:GetParent(),
					self:GetParent(),
					DOTA_TEAM_NEUTRALS
				)

				if self:GetParent().solo_event_player_id then
					unit.solo_event_player_id = self:GetParent().solo_event_player_id
				end

				local random_ability = passive[RandomInt(1, #passive)]
				rules:aura_dif(unit, random_ability)
			end
		end
	end
end

-----------------------------------------------------------------------------------------

modifier_creep_blob_die_spawn_lua_effect = class({})

function modifier_creep_blob_die_spawn_lua_effect:IsHidden()
	return false
end
function modifier_creep_blob_die_spawn_lua_effect:IsDebuff()
	return true
end
function modifier_creep_blob_die_spawn_lua_effect:IsPurgable()
	return false
end

function modifier_creep_blob_die_spawn_lua_effect:OnCreated()
	if self:GetAbility() then
		self.miss = self:GetAbility():GetSpecialValueFor("miss")
	end
end

function modifier_creep_blob_die_spawn_lua_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
	}
end

function modifier_creep_blob_die_spawn_lua_effect:GetModifierMiss_Percentage()
	return self.miss
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_blob_mana_burn_lua", "abilities/creeps/zone_6/zone_6", LUA_MODIFIER_MOTION_NONE)

creep_blob_mana_burn_lua = class({})

function creep_blob_mana_burn_lua:GetIntrinsicModifierName()
	return "modifier_creep_blob_mana_burn_lua"
end

--------------------------------------------------------------------------------

modifier_creep_blob_mana_burn_lua = class({})

function modifier_creep_blob_mana_burn_lua:IsHidden()
	return true
end

function modifier_creep_blob_mana_burn_lua:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_creep_blob_mana_burn_lua:OnAttackLanded(params)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local target = params.target
	local ability = self:GetAbility()
	if params.attacker ~= parent or not target or target:IsNull() or not target:IsAlive() then
		return
	end
	if target:IsMagicImmune() or target:IsInvulnerable() or target:IsBuilding() then
		return
	end

	local target_mana = target:GetMana()
	if not target_mana or target:GetMaxMana() <= 0 then
		return
	end

	local mana_to_burn = ability:GetSpecialValueFor("mana_per_hit")
	local damage_ratio = ability:GetSpecialValueFor("damage_per_burn")

	local actual_burn = math.min(target_mana, mana_to_burn)

	if actual_burn > 0 then
		target:Script_ReduceMana(actual_burn, nil)

		ApplyDamage({
			victim = target,
			attacker = parent,
			damage = actual_burn * damage_ratio,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = ability,
		})

		target:EmitSound("Hero_Antimage.ManaBreak")
		local pfx = ParticleManager:CreateParticle(
			"particles/generic_gameplay/generic_manaburn.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			target
		)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_waveform_lua", "abilities/creeps/zone_6/zone_6", LUA_MODIFIER_MOTION_HORIZONTAL)

creep_waveform_lua = class({})

function creep_waveform_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_morphling/morphling_waveform.vpcf", context)
end

function creep_waveform_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_waveform_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target_point = self:GetCursorPosition()
	local speed = self:GetSpecialValueFor("speed")
	local cast_range = self:GetCastRange(target_point, nil)

	local origin = caster:GetAbsOrigin()
	local direction = (target_point - origin):Normalized()
	local distance = (target_point - origin):Length2D()

	if distance > cast_range then
		distance = cast_range
		target_point = origin + direction * distance
	end

	local duration = distance / speed

	caster:AddNewModifier(caster, self, "modifier_creep_waveform_lua", {
		x = target_point.x,
		y = target_point.y,
		z = target_point.z,
		duration = duration,
	})

	caster:EmitSound("Hero_Morphling.Waveform")
end

--------------------------------------------------------------------------------

modifier_creep_waveform_lua = class({})

function modifier_creep_waveform_lua:IsHidden()
	return true
end
function modifier_creep_waveform_lua:IsPurgable()
	return false
end
function modifier_creep_waveform_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_creep_waveform_lua:OnCreated(kv)
	if not IsServer() then
		return
	end

	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.pos = Vector(kv.x, kv.y, kv.z)
	self.speed = self.ability:GetSpecialValueFor("speed")
	self.width = self.ability:GetSpecialValueFor("width")

	local damage = self.ability:GetSpecialValueFor("damage")
	local boost = self.ability:GetSpecialValueFor("diff_boost_damage")
	self.total_damage = damage + boost

	self.hit_targets = {}

	self.effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_morphling/morphling_waveform.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		0,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.parent:GetOrigin(),
		true
	)

	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end

function modifier_creep_waveform_lua:UpdateHorizontalMotion(me, dt)
	if not IsServer() then
		return
	end

	local my_pos = me:GetAbsOrigin()
	local distance_vec = self.pos - my_pos
	local distance = distance_vec:Length2D()
	local direction = distance_vec:Normalized()

	if distance < (self.speed * dt) then
		me:SetOrigin(self.pos)
		self:Destroy()
		return
	end

	local next_pos = my_pos + direction * self.speed * dt
	next_pos.z = GetGroundHeight(next_pos, me)

	me:SetOrigin(next_pos)
	me:FaceTowards(self.pos)

	ParticleManager:SetParticleControl(self.effect_cast, 1, direction * self.speed)

	local enemies = FindUnitsInRadius(
		me:GetTeamNumber(),
		next_pos,
		nil,
		self.width,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		if not self.hit_targets[enemy:GetEntityIndex()] then
			self.hit_targets[enemy:GetEntityIndex()] = true

			ApplyDamage({
				victim = enemy,
				attacker = me,
				damage = self.total_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self.ability,
			})

			enemy:EmitSound("Hero_Morphling.Waveform.Target")
		end
	end
end

function modifier_creep_waveform_lua:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:RemoveHorizontalMotionController(self)
	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, false)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end
	FindClearSpaceForUnit(self.parent, self.parent:GetOrigin(), true)
end

function modifier_creep_waveform_lua:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end

function modifier_creep_waveform_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_creep_waveform_lua:GetModifierModelChange()
	return "models/development/invisiblebox.vmdl"
end

function modifier_creep_waveform_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_water_heal", "abilities/creeps/zone_6/zone_6", LUA_MODIFIER_MOTION_VERTICAL)

creep_water_heal = class({})

function creep_water_heal:GetIntrinsicModifierName()
	return "modifier_creep_water_heal"
end

--------------------------------------------------------------------------------

modifier_creep_water_heal = class({})

function modifier_creep_water_heal:IsHidden()
	return true
end

function modifier_creep_water_heal:IsPurgable()
	return false
end

function modifier_creep_water_heal:OnCreated(kv)
	self:StartIntervalThink(0.2)
end

function modifier_creep_water_heal:OnIntervalThink()
	if self:GetParent():GetHealthPercent() < 90 then
		self:SetStackCount(self:GetStackCount() + 1)
	else
		self:SetStackCount(0)
	end
end

function modifier_creep_water_heal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_creep_water_heal:GetModifierHealthRegenPercentage()
	return 0.3 * self:GetStackCount()
end

function modifier_creep_water_heal:GetModifierAttackSpeedBonus_Constant()
	return 1 * self:GetStackCount()
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

creep_torrent_lua = class({})

function creep_torrent_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_torrent_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_bubbles_fxset.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf",
		context
	)
end

function creep_torrent_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local team = caster:GetTeamNumber()

	local delay = self:GetSpecialValueFor("delay")
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	local fx_pre = ParticleManager:CreateParticle(
		"particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_bubbles_fxset.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(fx_pre, 0, point)
	ParticleManager:SetParticleControl(fx_pre, 1, Vector(radius, 0, 0))

	local sound_cast = "Ability.TorrentCast"
	-- EmitSoundOnLocationWithCaster(point, sound_cast, caster)
	EmitSoundOn(sound_cast, caster)

	Timers:CreateTimer(delay, function()
		ParticleManager:DestroyParticle(fx_pre, false)
		ParticleManager:ReleaseParticleIndex(fx_pre)

		local fx_main = ParticleManager:CreateParticle(
			"particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(fx_main, 0, point)
		ParticleManager:SetParticleControl(fx_main, 1, Vector(radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(fx_main)

		local sound_cast = "Ability.Torrent"
		-- EmitSoundOnLocationWithCaster(point, sound_cast, caster)
		EmitSoundOn(sound_cast, caster)

		local enemies = FindUnitsInRadius(
			team,
			point,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = stun_duration })

			ApplyDamage({
				victim = enemy,
				attacker = caster,
				damage = damage,
				damage_type = self:GetAbilityDamageType(),
				ability = self,
			})

			local knockback = {
				should_stun = 1,
				knockback_duration = stun_duration,
				duration = stun_duration,
				knockback_distance = 0,
				knockback_height = 400,
				center_x = enemy:GetAbsOrigin().x,
				center_y = enemy:GetAbsOrigin().y,
				center_z = enemy:GetAbsOrigin().z,
			}
			enemy:AddNewModifier(caster, self, "modifier_knockback", knockback)
		end
	end)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

creep_undercurrent_lua = class({})

LinkLuaModifier("modifier_creep_undercurrent_passive", "abilities/creeps/zone_6/zone_6", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_undercurrent_aura_debuff", "abilities/creeps/zone_6/zone_6", LUA_MODIFIER_MOTION_NONE)

function creep_undercurrent_lua:GetIntrinsicModifierName()
	return "modifier_creep_undercurrent_passive"
end

--------------------------------------------------------------------------------

modifier_creep_undercurrent_passive = class({})

function modifier_creep_undercurrent_passive:IsHidden()
	return false
end

function modifier_creep_undercurrent_passive:OnCreated()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.resistance = self:GetAbility():GetSpecialValueFor("resistance")
end

function modifier_creep_undercurrent_passive:IsAura()
	return true
end
function modifier_creep_undercurrent_passive:GetModifierAura()
	return "modifier_creep_undercurrent_aura_debuff"
end
function modifier_creep_undercurrent_passive:GetAuraRadius()
	return self.radius
end
function modifier_creep_undercurrent_passive:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_creep_undercurrent_passive:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_creep_undercurrent_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_creep_undercurrent_passive:GetModifierMagicalResistanceBonus()
	if not IsServer() then
		return
	end

	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		self:GetParent(),
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	return #enemies * self.resistance
end

--------------------------------------------------------------------------------

modifier_creep_undercurrent_aura_debuff = class({})

function modifier_creep_undercurrent_aura_debuff:OnCreated()
	self.turn_slow = self:GetAbility():GetSpecialValueFor("turn_rate_slow")
	self.resistance = self:GetAbility():GetSpecialValueFor("resistance")
end

function modifier_creep_undercurrent_aura_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_creep_undercurrent_aura_debuff:GetModifierTurnRate_Percentage()
	return -self.turn_slow
end

function modifier_creep_undercurrent_aura_debuff:GetModifierMagicalResistanceBonus()
	return -self.resistance
end