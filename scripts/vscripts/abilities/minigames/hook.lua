--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_minigames_pudge_hook", "abilities/minigames/hook.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_minigames_pudge_hook_enemy", "abilities/minigames/hook.lua", LUA_MODIFIER_MOTION_NONE )

if minigames_pudge_hook == nil then
	minigames_pudge_hook = class({})
end

function minigames_pudge_hook:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_pudge_cute/pudge_cute_meathook.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_pudge/pudge_meathook_impact.vpcf", context)
end

function minigames_pudge_hook:OnAbilityPhaseStart()
	self:GetCaster():StartGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
	return true
end

function minigames_pudge_hook:OnAbilityPhaseInterrupted()
	self:GetCaster():RemoveGesture( ACT_DOTA_OVERRIDE_ABILITY_1 )
end

function minigames_pudge_hook:OnSpellStart()
	local caster = self:GetCaster()

	local vHookOffset = Vector( 0, 0, 96 )
	local target_position = GetGroundPosition(self:GetCursorPosition() + vHookOffset, caster)

	if target_position == caster:GetAbsOrigin() then
		target_position = target_position + caster:GetForwardVector()
	end

	local Width = self:GetSpecialValueFor("width")
	local Speed = self:GetSpecialValueFor("speed")

	local MaxRange = self:GetEffectiveCastRange(caster:GetAbsOrigin(), caster)

	local vKillswitch = Vector(((MaxRange / Speed) * 2) + 10, 0, 0)
	local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge_cute/pudge_cute_meathook.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleAlwaysSimulate(fx)
	ParticleManager:SetParticleControlEnt(fx, 0, caster, PATTACH_POINT_FOLLOW, "attach_weapon_chain_rt", caster:GetAbsOrigin() + vHookOffset, true)
	ParticleManager:SetParticleControl(fx, 2, Vector(Speed, MaxRange, Width))
	ParticleManager:SetParticleControl(fx, 3, vKillswitch)
	ParticleManager:SetParticleControl(fx, 4, Vector( 1, 0, 0 ) )
	ParticleManager:SetParticleControl(fx, 5, Vector( 0, 0, 0 ) )
	ParticleManager:SetParticleControl(fx, 7, Vector(1, 0, 0))

	local projectile_info = {
		Ability = self,
		EffectName = nil,
		vSpawnOrigin = caster:GetAbsOrigin(),
		fDistance = MaxRange,
		fStartRadius = Width,
		fEndRadius = Width,
		Source = caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		fExpireTime = GameRules:GetGameTime() + ((MaxRange / Speed)),
		vVelocity = CalculateDirection(target_position, caster:GetAbsOrigin()) * Speed * Vector(1, 1, 0),
		bProvidesVision = false,
		bDeleteOnHit = true,
		ExtraData = {
			width = Width,
			speed = Speed,
			pfx_index = fx,
			state = "forward"
		}
	}

	self.hook_target = nil
	self.hook_start = caster:GetAbsOrigin()
	self.hook_proj = ProjectileManager:CreateLinearProjectile(projectile_info)

	EmitSoundOn("Minigames.Hook.Cast", caster)

	-- caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)

	caster:AddNewModifier(caster, self, "modifier_minigames_pudge_hook", {duration=vKillswitch})
end

function minigames_pudge_hook:ClearHookTarget(target)
	if target and not target:IsNull() then
		target.hook_ability = self
	end
end

function minigames_pudge_hook:OnProjectileThink_ExtraData(vLocation, ExtraData)
	if ExtraData.state == "forward" then
		ParticleManager:SetParticleControl(ExtraData.pfx_index, 1, GetGroundPosition(vLocation, self:GetCaster()))

		local radius = ExtraData.width

		for _, ent in pairs(Entities:FindAllInSphere(GetGroundPosition(vLocation, self:GetCaster()), radius)) do
			if ent.GetContainedItem ~= nil and (GetGroundPosition(vLocation, self:GetCaster()) - ent:GetAbsOrigin()):Length2D() < radius then
				self:OnProjectileHit_ExtraData(ent, vLocation, ExtraData)
			end
		end
	end

	if ExtraData.state == "back" then
		local target = self.hook_target
		if target and not target:IsNull() and (target.GetContainedItem ~= nil or target:IsAlive()) and target.hook_ability == self and CalculateDistance(target, self.hook_start) > 100 then
			local bIsRune = target.GetContainedItem ~= nil

			if bIsRune then
				ParticleManager:SetParticleControlEnt(ExtraData.pfx_index, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin() + Vector( 0, 0, 96 ), true)
				target:SetAbsOrigin(GetGroundPosition(vLocation, self:GetCaster()))
			else
				ParticleManager:SetParticleControlEnt(ExtraData.pfx_index, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin() + Vector( 0, 0, 96 ), true)
				target:SetAbsOrigin(GetGroundPosition(vLocation, target))
			end
		else
			ParticleManager:SetParticleControl(ExtraData.pfx_index, 1, vLocation)
		end
	end
end

function minigames_pudge_hook:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
	if ExtraData.state == "forward" then
		local caster = self:GetCaster()

		if caster == hTarget then
			return
		end

		caster:RemoveModifierByName("modifier_minigames_pudge_hook")

		ParticleManager:SetParticleControl(ExtraData.pfx_index, 4, Vector( 0, 0, 0 ) )
		ParticleManager:SetParticleControl(ExtraData.pfx_index, 5, Vector( 1, 0, 0 ) )

		self.hook_target = hTarget
		self:ClearHookTarget(hTarget)

		if hTarget and not hTarget:IsNull() then
			hTarget:EmitSound("Minigames.Hook.Target.Impact")
			-- EmitSoundOnLocationWithCaster(hTarget:GetAbsOrigin(), "Minigames.Hook.Retract", hTarget)
			local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_pudge/pudge_meathook_impact.vpcf", PATTACH_CUSTOMORIGIN, hTarget)
			ParticleManager:SetParticleControlEnt(nFXIndex, 0, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin() + Vector( 0, 0, 96 ), true)
			ParticleManager:ReleaseParticleIndex(nFXIndex)

			if hTarget.GetContainedItem == nil then
				hTarget:AddNewModifier(caster, self, "modifier_minigames_pudge_hook_enemy", {duration=5})

				local MinDamage = self:GetSpecialValueFor("damage_min")
				local MaxDamage = self:GetSpecialValueFor("damage_max")

				local MaxRange = self:GetEffectiveCastRange(caster:GetAbsOrigin(), caster)-250

				local DistanceTravelled = CalculateDistance(vLocation, self.hook_start)

				local FullPct = math.min(DistanceTravelled, MaxRange)/MaxRange

				local Damage = math.round(MinDamage + (MaxDamage - MinDamage) * FullPct)

				ApplyDamage({
					victim = hTarget,
					damage = Damage,
					damage_type = DAMAGE_TYPE_PURE,
					damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
					attacker = caster,
					ability = self
				})
			end
		end

		local pos = (hTarget and not hTarget:IsNull()) and hTarget:GetAbsOrigin() or vLocation

		local projectile_info = {
			Target = caster,
			Source = nil,
			Ability = self,
			EffectName = nil,
			iMoveSpeed = ExtraData.speed,
			vSourceLoc = pos,
			bDrawsOnMinimap = false,
			bDodgeable = false,
			bIsAttack = false,
			bVisibleToEnemies = true,
			bReplaceExisting = false,
			bProvidesVision = false,
			ExtraData = {
				hook_spd = ExtraData.speed,
				pfx_index = ExtraData.pfx_index,
				state = "back",
			}
		}
		ProjectileManager:CreateTrackingProjectile(projectile_info)
		if self:GetCaster():IsAlive() then
			self:GetCaster():FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
		end
		if self.hook_proj then
			ProjectileManager:DestroyLinearProjectile(self.hook_proj)
		end
		return true
	end

	if ExtraData.state == "back" then
		ParticleManager:DestroyParticle(ExtraData.pfx_index, true)
		ParticleManager:ReleaseParticleIndex(ExtraData.pfx_index)

		StopSoundOn("Minigames.Hook.Cast", self:GetCaster())
		
		self:GetCaster():EmitSound("Minigames.Hook.End")

		if self.hook_target and not self.hook_target:IsNull() and self.hook_target.hook_ability == self then
			FindClearSpaceForUnit(self.hook_target, self.hook_target:GetAbsOrigin(), true)
			ResolveNPCPositions(self.hook_target:GetAbsOrigin(), 200)

			if self.hook_target.GetContainedItem == nil then
				self.hook_target:RemoveModifierByName("modifier_minigames_pudge_hook_enemy")
			end
		end

		return true
	end
end

modifier_minigames_pudge_hook = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	CheckState				= function(self)
		return {
			[MODIFIER_STATE_ROOTED] = true,
		}
	end,
})

modifier_minigames_pudge_hook_enemy = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsMotionController      = function(self) return false end,
    GetMotionControllerPriority        = function(self) return DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST end,

	CheckState				= function(self)
		return {
			[MODIFIER_STATE_STUNNED] = true,
		}
	end,
})