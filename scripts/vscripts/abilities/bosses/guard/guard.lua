--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_temple_guardian_hammer_throw", "abilities/bosses/guard/guard", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

temple_guardian_hammer_throw = class({})

function temple_guardian_hammer_throw:Precache(context)
	PrecacheResource("particle", "particles/test_particle/generic_attack_charge.vpcf", context)
	PrecacheResource("particle", "particles/test_particle/omniknight_wildaxe.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_beastmaster/beastmaster_wildaxes_hit.vpcf", context)
end

function temple_guardian_hammer_throw:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function temple_guardian_hammer_throw:OnAbilityPhaseStart()
	if IsServer() then
		self.nPreviewFX = ParticleManager:CreateParticle(
			"particles/test_particle/generic_attack_charge.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControlEnt(
			self.nPreviewFX,
			0,
			self:GetCaster(),
			PATTACH_POINT_FOLLOW,
			"attach_attack2",
			self:GetCaster():GetOrigin(),
			true
		)
		ParticleManager:SetParticleControl(self.nPreviewFX, 15, Vector(135, 192, 235))
		ParticleManager:SetParticleControl(self.nPreviewFX, 16, Vector(1, 0, 0))
		ParticleManager:ReleaseParticleIndex(self.nPreviewFX)

		EmitSoundOn("TempleGuardian.PreAttack", self:GetCaster())
	end

	return true
end

function temple_guardian_hammer_throw:OnAbilityPhaseInterrupted()
	if IsServer() then
		ParticleManager:DestroyParticle(self.nPreviewFX, true)
	end
end

function temple_guardian_hammer_throw:GetPlaybackRateOverride()
	return 0.5
end

function temple_guardian_hammer_throw:OnSpellStart()
	if IsServer() then
		ParticleManager:DestroyParticle(self.nPreviewFX, false)

		local vLocation = self:GetCursorPosition()

		local kv = {
			x = vLocation.x,
			y = vLocation.y,
		}
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_temple_guardian_hammer_throw", kv)
	end
end

--------------------------------------------------------------------------------

modifier_temple_guardian_hammer_throw = class({})

function modifier_temple_guardian_hammer_throw:IsHidden()
	return true
end

function modifier_temple_guardian_hammer_throw:IsPurgable()
	return false
end

function modifier_temple_guardian_hammer_throw:RemoveOnDeath()
	return false
end

function modifier_temple_guardian_hammer_throw:OnCreated(kv)
	if IsServer() then
		self.hammer_damage = self:GetAbility():GetSpecialValueFor("hammer_damage")
			+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
		self.throw_duration = self:GetAbility():GetSpecialValueFor("throw_duration")
		self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
		self.radius = self:GetAbility():GetSpecialValueFor("radius")

		self.hHitEntities = {}

		self.hHammer = CreateUnitByName(
			"npc_dota_beastmaster_axe",
			self:GetParent():GetOrigin(),
			false,
			nil,
			nil,
			self:GetParent():GetTeamNumber()
		)
		if self.hHammer == nil then
			self:Destroy()
			return
		end

		self.hHammer:AddEffects(EF_NODRAW)
		self.hHammer:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_beastmaster_axe_invulnerable", kv)

		self.vSourceLoc = self:GetCaster():GetOrigin()
		self.vSourceLoc.z = self.vSourceLoc.z + 180
		self.vTargetLoc = Vector(kv["x"], kv["y"], self.vSourceLoc.z)
		self.vToTarget = self.vTargetLoc - self.vSourceLoc
		self.vDir = self.vToTarget:Normalized()
		self.flDist = self.vToTarget:Length2D()

		self.flDieTime = GameRules:GetGameTime() + self.throw_duration
		self.bReturning = false

		self.nFXIndex =
			ParticleManager:CreateParticle("particles/test_particle/omniknight_wildaxe.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControlEnt(
			self.nFXIndex,
			0,
			self.hHammer,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self.hHammer:GetOrigin(),
			true
		)

		EmitSoundOn("TempleGuardian.HammerThrow", self:GetCaster())

		self:StartIntervalThink(0.05)
	end
end

function modifier_temple_guardian_hammer_throw:OnIntervalThink()
	if IsServer() then
		local flPct = (self.flDieTime - GameRules:GetGameTime()) / self.throw_duration
		local t = 1.0 - flPct

		local vPos = self.vSourceLoc + (self.vDir * self.flDist * t * 2)
		if self.bReturning == true then
			vPos = self.vTargetLoc - (self.vDir * self.flDist * (t - 0.5) * 2)
		end

		if FrameTime() > 0.0 then
			local vVel = vPos - self.hHammer:GetOrigin() / FrameTime()
			self.hHammer:SetVelocity(vVel)
		end

		self.hHammer:SetOrigin(vPos)

		local enemies = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),
			self.hHammer:GetOrigin(),
			self.hHammer,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			0,
			false
		)
		for _, enemy in pairs(enemies) do
			if enemy ~= nil and enemy:IsInvulnerable() == false and self:HasHitTarget(enemy) == false then
				self:AddHitTarget(enemy)
				local damageInfo = {
					victim = enemy,
					attacker = self:GetCaster(),
					damage = self.hammer_damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
					ability = self:GetAbility(),
				}
				ApplyDamage(damageInfo)
				enemy:AddNewModifier(
					self:GetCaster(),
					self:GetAbility(),
					"modifier_stunned",
					{ duration = self.stun_duration }
				)
				EmitSoundOn("TempleGuardian.HammerThrow.Damage", enemy)

				local nFXIndex = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_beastmaster/beastmaster_wildaxes_hit.vpcf",
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
				ParticleManager:ReleaseParticleIndex(nFXIndex)
			end
		end

		if t >= 0.5 then
			self.bReturning = true
		end

		if t >= 0.95 then
			self:Destroy()
		end
	end
end

function modifier_temple_guardian_hammer_throw:OnDestroy()
	if IsServer() then
		UTIL_Remove(self.hHammer)
		ParticleManager:DestroyParticle(self.nFXIndex, true)
	end
end

function modifier_temple_guardian_hammer_throw:HasHitTarget(enemy)
	if IsServer() then
		for _, hitEnemy in pairs(self.hHitEntities) do
			if hitEnemy == enemy then
				return true
			end
		end
		return false
	end
end

function modifier_temple_guardian_hammer_throw:AddHitTarget(enemy)
	if IsServer() then
		table.insert(self.hHitEntities, enemy)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_ogre_tank_melee_smash_thinker", "abilities/bosses/guard/guard", LUA_MODIFIER_MOTION_NONE)

temple_guardian_rage_hammer_smash = class({})

function temple_guardian_rage_hammer_smash:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function temple_guardian_rage_hammer_smash:OnAbilityPhaseStart()
	if IsServer() then
		EmitSoundOn("TempleGuardian.PreAttack", self:GetCaster())
	end
	return true
end

function temple_guardian_rage_hammer_smash:GetPlaybackRateOverride()
	return 0.6090
end

function temple_guardian_rage_hammer_smash:OnSpellStart()
	if IsServer() then
		local flSpeed = self:GetSpecialValueFor("base_swing_speed")
		local vToTarget = self:GetCursorPosition() - self:GetCaster():GetOrigin()
		vToTarget = vToTarget:Normalized()
		local vTarget = self:GetCaster():GetOrigin() + vToTarget * self:GetCastRange(self:GetCaster():GetOrigin(), nil)
		local hThinker = CreateModifierThinker(
			self:GetCaster(),
			self,
			"modifier_ogre_tank_melee_smash_thinker",
			{ duration = flSpeed },
			vTarget,
			self:GetCaster():GetTeamNumber(),
			false
		)
	end
end

-------------------------------------------------------------------------

modifier_ogre_tank_melee_smash_thinker = class({})

function modifier_ogre_tank_melee_smash_thinker:OnCreated(kv)
	if IsServer() then
		self.impact_radius = self:GetAbility():GetSpecialValueFor("impact_radius")
		self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
		self.damage = self:GetAbility():GetSpecialValueFor("damage")
			+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

		self:StartIntervalThink(0.01)
	end
end

function modifier_ogre_tank_melee_smash_thinker:OnIntervalThink()
	if IsServer() then
		if
			self:GetCaster() == nil
			or self:GetCaster():IsNull()
			or self:GetCaster():IsAlive() == false
			or self:GetCaster():IsStunned()
		then
			UTIL_Remove(self:GetParent())
			return -1
		end
	end
end

function modifier_ogre_tank_melee_smash_thinker:OnDestroy()
	if IsServer() then
		if self:GetCaster() ~= nil and self:GetCaster():IsAlive() then
			local sound_cast = "OgreTank.GroundSmash"
			-- EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
			EmitSoundOn(sound_cast, self:GetCaster())
			local nFXIndex = ParticleManager:CreateParticle(
				"particles/test_particle/ogre_melee_smash.vpcf",
				PATTACH_WORLDORIGIN,
				self:GetCaster()
			)
			ParticleManager:SetParticleControl(nFXIndex, 0, self:GetParent():GetOrigin())
			ParticleManager:SetParticleControl(
				nFXIndex,
				1,
				Vector(self.impact_radius, self.impact_radius, self.impact_radius)
			)
			ParticleManager:ReleaseParticleIndex(nFXIndex)

			local enemies = FindUnitsInRadius(
				self:GetParent():GetTeamNumber(),
				self:GetParent():GetOrigin(),
				self:GetParent(),
				self.impact_radius,
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
						enemy:AddNewModifier(
							self:GetCaster(),
							self:GetAbility(),
							"modifier_stunned",
							{ duration = self.stun_duration }
						)
					end
				end
			end
		end

		ScreenShake(self:GetParent():GetOrigin(), 10.0, 100.0, 0.5, 1300.0, 0, true)

		UTIL_Remove(self:GetParent())
	end
end

-------------------------------------------------------------------------
-------------------------------------------------------------------------

LinkLuaModifier("modifier_temple_guardian_wrath_thinker", "abilities/bosses/guard/guard", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_temple_guardian_immunity", "abilities/bosses/guard/guard", LUA_MODIFIER_MOTION_NONE)

temple_guardian_wrath = class({})

function temple_guardian_wrath:Precache(context)
	PrecacheResource("particle", "particles/test_particle/dungeon_generic_blast_pre.vpcf", context)
	PrecacheResource("particle", "particles/test_particle/dungeon_generic_blast.vpcf", context)
end

function temple_guardian_wrath:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function temple_guardian_wrath:GetChannelAnimation()
	return ACT_DOTA_CHANNEL_ABILITY_4
end

function temple_guardian_wrath:OnAbilityPhaseStart()
	if IsServer() then
		self.channel_duration = self:GetSpecialValueFor("channel_duration")
		local fImmuneDuration = self.channel_duration + self:GetCastPoint()
		self:GetCaster()
			:AddNewModifier(self:GetCaster(), self, "modifier_temple_guardian_immunity", { duration = fImmuneDuration })
	end
	return true
end

function temple_guardian_wrath:OnSpellStart()
	if IsServer() then
		self.effect_radius = self:GetSpecialValueFor("effect_radius")
		self.interval = self:GetSpecialValueFor("interval")

		self.flNextCast = 0.0

		EmitSoundOn("TempleGuardian.Wrath.Cast", self:GetCaster())
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_omninight_guardian_angel", {})
	end
end

function temple_guardian_wrath:OnChannelThink(flInterval)
	if IsServer() then
		self.flNextCast = self.flNextCast + flInterval
		if self.flNextCast >= self.interval then
			local nMaxAttempts = 7
			local nAttempts = 0
			local vPos = nil

			repeat
				vPos = self:GetCaster():GetOrigin() + RandomVector(RandomInt(50, self.effect_radius))
				local hThinkersNearby = Entities:FindAllByClassnameWithin("npc_dota_thinker", vPos, 600)
				local hOverlappingWrathThinkers = {}

				for _, hThinker in pairs(hThinkersNearby) do
					if hThinker:HasModifier("modifier_temple_guardian_wrath_thinker") then
						table.insert(hOverlappingWrathThinkers, hThinker)
					end
				end
				nAttempts = nAttempts + 1
				if nAttempts >= nMaxAttempts then
					break
				end
			until #hOverlappingWrathThinkers == 0

			CreateModifierThinker(
				self:GetCaster(),
				self,
				"modifier_temple_guardian_wrath_thinker",
				{},
				vPos,
				self:GetCaster():GetTeamNumber(),
				false
			)
			self.flNextCast = self.flNextCast - self.interval
		end
	end
end

function temple_guardian_wrath:OnChannelFinish(bInterrupted)
	if IsServer() then
		self:GetCaster():RemoveModifierByName("modifier_omninight_guardian_angel")
	end
end

-----------------------------------------------------------------------------

modifier_temple_guardian_immunity = class({})

function modifier_temple_guardian_immunity:IsHidden()
	return true
end

function modifier_temple_guardian_immunity:IsPurgable()
	return false
end

function modifier_temple_guardian_immunity:CheckState()
	local state = {}
	if IsServer() then
		state[MODIFIER_STATE_MAGIC_IMMUNE] = true
		state[MODIFIER_STATE_INVULNERABLE] = true
		state[MODIFIER_STATE_OUT_OF_GAME] = true
	end

	return state
end

function modifier_temple_guardian_immunity:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

---------------------------------------------------------------------------------

modifier_temple_guardian_wrath_thinker = class({})

function modifier_temple_guardian_wrath_thinker:OnCreated(kv)
	if IsServer() then
		self.delay = self:GetAbility():GetSpecialValueFor("delay")
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
		self.blast_damage = self:GetAbility():GetSpecialValueFor("blast_damage")
			+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

		self:StartIntervalThink(self.delay)

		local nFXIndex = ParticleManager:CreateParticle(
			"particles/test_particle/dungeon_generic_blast_pre.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(nFXIndex, 0, self:GetParent():GetOrigin())
		ParticleManager:SetParticleControl(nFXIndex, 1, Vector(self.radius, self.delay, 1.0))
		ParticleManager:SetParticleControl(nFXIndex, 15, Vector(175, 238, 238))
		ParticleManager:SetParticleControl(nFXIndex, 16, Vector(1, 0, 0))
		ParticleManager:ReleaseParticleIndex(nFXIndex)
	end
end

function modifier_temple_guardian_wrath_thinker:OnIntervalThink()
	if IsServer() then
		local nFXIndex = ParticleManager:CreateParticle(
			"particles/test_particle/dungeon_generic_blast.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(nFXIndex, 0, self:GetParent():GetOrigin())
		ParticleManager:SetParticleControl(nFXIndex, 1, Vector(self.radius, self.radius, self.radius))
		ParticleManager:SetParticleControl(nFXIndex, 15, Vector(175, 238, 238))
		ParticleManager:SetParticleControl(nFXIndex, 16, Vector(1, 0, 0))
		ParticleManager:ReleaseParticleIndex(nFXIndex)

		EmitSoundOn("TempleGuardian.Wrath.Explosion", self:GetParent())
		local enemies = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),
			self:GetParent():GetOrigin(),
			nil,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
			FIND_CLOSEST,
			false
		)
		for _, enemy in pairs(enemies) do
			if enemy ~= nil and enemy:IsInvulnerable() == false then
				local damageInfo = {
					victim = enemy,
					attacker = self:GetCaster(),
					damage = self.blast_damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self:GetAbility(),
				}
				ApplyDamage(damageInfo)
			end
		end

		UTIL_Remove(self:GetParent())
	end
end