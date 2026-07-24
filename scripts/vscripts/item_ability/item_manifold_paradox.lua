--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_manifold_paradox", "item_ability/item_manifold_paradox.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_manifold_paradox_dagger_caster", "item_ability/item_manifold_paradox.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_manifold_paradox_dagger_debuff", "item_ability/item_manifold_paradox.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_manifold_paradox_strike_buff", "item_ability/item_manifold_paradox.lua", LUA_MODIFIER_MOTION_HORIZONTAL)
--Abilities
if item_manifold_paradox == nil then
	item_manifold_paradox = class({})
end
function item_manifold_paradox:GetIntrinsicModifierName()
	return "modifier_item_manifold_paradox"
end
function item_manifold_paradox:OnProjectileHit(hTarget, vLocation)
	local hCaster = self:GetCaster()
	local dagger_duration = self:GetSpecialValueFor("dagger_duration")

	if IsValid(hCaster) and IsValid(hTarget) and hCaster:IsAlive() and hTarget:IsAlive() then
		hTarget:AddNewModifier(hCaster, self, "modifier_item_manifold_paradox_dagger_debuff", { duration = dagger_duration })
		local iAttackState = ATTACK_STATE_SKIPCOOLDOWN + ATTACK_STATE_IGNOREINVIS + ATTACK_STATE_NOT_USEPROJECTILE + ATTACK_STATE_NEVERMISS + ATTACK_STATE_NOT_USECASTATTACKORB
		hCaster:AddNewModifier(hCaster, self, "modifier_item_manifold_paradox_dagger_caster", {})
		hCaster:Attack(hTarget, iAttackState)
		hCaster:RemoveModifierByName("modifier_item_manifold_paradox_dagger_caster")
		EmitSoundOnLocationWithCaster(vLocation, "Hero_PhantomAssassin.Dagger.Target", hCaster)
	end
end
function item_manifold_paradox:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local strike_duration = self:GetSpecialValueFor("strike_duration")

	local vCasterPosition = hCaster:GetAbsOrigin()
	local vTargetPosition = hTarget:GetAbsOrigin()
	local vDirection = hTarget:GetAbsOrigin() - hCaster:GetAbsOrigin()
	vDirection.z = 0

	hCaster:EmitSound("Hero_PhantomAssassin.Strike.End")

	local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_strike_start.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(iParticleID, 0, vCasterPosition)
	ParticleManager:SetParticleControlForward(iParticleID, 0, vDirection:Normalized())
	ParticleManager:SetParticleControlEnt(iParticleID, 1, hCaster, PATTACH_CUSTOMORIGIN_FOLLOW, nil, vCasterPosition, true)
	ParticleManager:ReleaseParticleIndex(iParticleID)

	EmitSoundOnLocationWithCaster(vCasterPosition, "Hero_PhantomAssassin.Strike.Start", hCaster)

	FindClearSpaceForUnit(hCaster, vTargetPosition, true)

	local iParticleID = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
	ParticleManager:SetParticleControlEnt(iParticleID, 0, hCaster, PATTACH_CUSTOMORIGIN_FOLLOW, nil, hCaster:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(iParticleID)

	EmitSoundOnLocationWithCaster(hCaster:GetAbsOrigin(), "Hero_PhantomAssassin.Strike.End", hCaster)

	hCaster:AddNewModifier(hCaster, self, "modifier_item_manifold_paradox_strike_buff", { duration = strike_duration, index = hTarget:entindex() })
end
function item_manifold_paradox:LaunchDagger(hTarget)
	local hCaster = self:GetCaster()
	local dagger_speed = self:GetSpecialValueFor("dagger_speed")

	if IsValid(hCaster) and IsValid(hTarget) then
		local tInfo = {
			Ability = self,
			EffectName = ParticleManager:GetParticleReplacement("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_arcana.vpcf", hCaster),
			iSourceAttachment = hCaster:ScriptLookupAttachment("attach_attack2"),
			iMoveSpeed = dagger_speed,
			Target = hTarget,
			Source = hCaster,
			bProvidesVision = true,
			iVisionTeamNumber = hCaster:GetTeamNumber(),
			iVisionRadius = 0,
		}
		ProjectileManager:CreateTrackingProjectile(tInfo)
		hCaster:EmitSound("Hero_PhantomAssassin.Dagger.Cast")
	end

end
---------------------------------------------------------------------
--Modifiers
if modifier_item_manifold_paradox == nil then
	modifier_item_manifold_paradox = class({})
end
function modifier_item_manifold_paradox:IsHidden()
	return true
end
function modifier_item_manifold_paradox:IsDebuff()
	return false
end
function modifier_item_manifold_paradox:IsPurgable()
	return false
end
function modifier_item_manifold_paradox:OnCreated(params)
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
	self.crit_multiplier = self:GetAbilitySpecialValueFor("crit_multiplier")
	self.dagger_cooldown = self:GetAbilitySpecialValueFor("dagger_cooldown")
	self.dagger_radius = self:GetAbilitySpecialValueFor("dagger_radius")
	self.dagger_speed = self:GetAbilitySpecialValueFor("dagger_speed")
	self.bonus_evasion = self:GetAbilitySpecialValueFor("bonus_evasion")
	self.strike_lifesteal_pct = self:GetAbilitySpecialValueFor("strike_lifesteal_pct")
	if IsServer() then
		self.tRecords = {}
		self.bDaggerCooldown = false
		self:StartIntervalThink(FrameTime())
	end
end
function modifier_item_manifold_paradox:OnRefresh(params)
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
	self.crit_multiplier = self:GetAbilitySpecialValueFor("crit_multiplier")
	if IsServer() then
	end
end
function modifier_item_manifold_paradox:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_manifold_paradox:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}
end
function modifier_item_manifold_paradox:OnIntervalThink()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()

	if not self.bDaggerCooldown then
		local bTrigger = false
		local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, self.dagger_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() and IsValid(hAbility) then
				hAbility:LaunchDagger(unit)
				bTrigger = true
				break
			end
		end
		if bTrigger then
			self.bDaggerCooldown = true
			self:StartIntervalThink(self.dagger_cooldown)
		else
			self:StartIntervalThink(FrameTime())
		end
	else
		self.bDaggerCooldown = false
		self:StartIntervalThink(FrameTime())
	end
end
function modifier_item_manifold_paradox:GetModifierPreAttack_CriticalStrike(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local record = params.record

	if IsValid(hTarget) and IsValid(hParent) and hTarget:IsAlive() then
		if RandomFloat(0, 100) < self.crit_chance or hParent:HasModifier("modifier_item_manifold_paradox_strike_buff") then
			if IsServer() then
				self.tRecords[record] = true
			end

			return self.crit_multiplier
		end
	end
end
function modifier_item_manifold_paradox:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local record = params.record

	if IsValid(hTarget) and IsValid(hParent) and hTarget:IsAlive() then
		if IsServer() then
			if hParent:HasModifier("modifier_item_manifold_paradox_strike_buff") then
				local iParticleID = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
				ParticleManager:ReleaseParticleIndex(iParticleID)
				local heal_amount = params.damage * self.strike_lifesteal_pct * 0.01
				hParent:HealWithParams(heal_amount, self:GetAbility(), true, true, hParent, false)
			end

			if self.tRecords[record] ~= nil then
				local particleID = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf", PATTACH_CUSTOMORIGIN, hTarget)
				ParticleManager:SetParticleControlEnt(particleID, 0, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin(), true)
				ParticleManager:SetParticleControl(particleID, 1, hTarget:GetAbsOrigin())
				ParticleManager:SetParticleControlForward(particleID, 1, (hParent:GetAbsOrigin() - hTarget:GetAbsOrigin()):Normalized())
				ParticleManager:ReleaseParticleIndex(particleID)

				EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace.Arcana", hParent)

				for i = #self.tRecords, 1, -1 do
					if i == record then
						table.remove(self.tRecords, i)
						break
					end
				end

			end
		end
	end
end
function modifier_item_manifold_paradox:GetModifierEvasion_Constant()
	return self.bonus_evasion
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_manifold_paradox_dagger_caster == nil then
	modifier_item_manifold_paradox_dagger_caster = class({})
end
function modifier_item_manifold_paradox_dagger_caster:IsHidden()
	return true
end
function modifier_item_manifold_paradox_dagger_caster:IsDebuff()
	return false
end
function modifier_item_manifold_paradox_dagger_caster:IsPurgable()
	return false
end
function modifier_item_manifold_paradox_dagger_caster:OnCreated(params)
	self.dagger_attack_factor = self:GetAbilitySpecialValueFor("dagger_attack_factor")
	self.dagger_base_damage = self:GetAbilitySpecialValueFor("dagger_base_damage")
	if IsServer() then
	end
end
function modifier_item_manifold_paradox_dagger_caster:OnRefresh(params)
	self.dagger_attack_factor = self:GetAbilitySpecialValueFor("dagger_attack_factor")
	self.dagger_base_damage = self:GetAbilitySpecialValueFor("dagger_base_damage")
	if IsServer() then
	end
end
function modifier_item_manifold_paradox_dagger_caster:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end
function modifier_item_manifold_paradox_dagger_caster:GetModifierDamageOutgoing_Percentage()
	return self.dagger_attack_factor
end
function modifier_item_manifold_paradox_dagger_caster:GetModifierPreAttack_BonusDamage()
	return self.dagger_base_damage
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_manifold_paradox_dagger_debuff == nil then
	modifier_item_manifold_paradox_dagger_debuff = class({})
end
function modifier_item_manifold_paradox_dagger_debuff:IsHidden()
	return false
end
function modifier_item_manifold_paradox_dagger_debuff:IsDebuff()
	return true
end
function modifier_item_manifold_paradox_dagger_debuff:IsPurgable()
	return true
end
function modifier_item_manifold_paradox_dagger_debuff:OnCreated(params)
	self.dagger_move_slow = self:GetAbilitySpecialValueFor("dagger_move_slow")
	if IsServer() then
	end
end
function modifier_item_manifold_paradox_dagger_debuff:OnRefresh(params)
	self.dagger_move_slow = self:GetAbilitySpecialValueFor("dagger_move_slow")
	if IsServer() then
	end
end
function modifier_item_manifold_paradox_dagger_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end
function modifier_item_manifold_paradox_dagger_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.dagger_move_slow
end
function modifier_item_manifold_paradox_dagger_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_manifold_paradox_dagger_debuff:GetEffectName()
	return "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_debuff_arcana.vpcf"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_manifold_paradox_strike_buff == nil then
	modifier_item_manifold_paradox_strike_buff = class({})
end
function modifier_item_manifold_paradox_strike_buff:IsHidden()
	return false
end
function modifier_item_manifold_paradox_strike_buff:IsDebuff()
	return false
end
function modifier_item_manifold_paradox_strike_buff:IsPurgable()
	return false
end
function modifier_item_manifold_paradox_strike_buff:OnCreated(params)
	self.dagger_radius = self:GetAbilitySpecialValueFor("dagger_radius")
	if IsServer() then
		if not self:ApplyHorizontalMotionController() then
			self:Destory()
		else
			self.hTarget = EntIndexToHScript(params.index)
			if IsValid(self.hTarget) then
				self:StartIntervalThink(0.1)
			else
				self:Destory()
			end
		end
	end
end
function modifier_item_manifold_paradox_strike_buff:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_manifold_paradox_strike_buff:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_manifold_paradox_strike_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_VISUAL_Z_DELTA,
	}
end
function modifier_item_manifold_paradox_strike_buff:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
	}
end
function modifier_item_manifold_paradox_strike_buff:OnHorizontalMotionInterrupted()
	self:Destroy()
end
function modifier_item_manifold_paradox_strike_buff:UpdateHorizontalMotion(me, dt)
	local hParent = self:GetParent()
	if IsValid(self.hTarget) then
		hParent:SetAbsOrigin(self.hTarget:GetAbsOrigin())
	else
		FindClearSpaceForUnit(hParent, hParent:GetAbsOrigin(), true)
		self:Destroy()
	end
end
function modifier_item_manifold_paradox_strike_buff:GetVisualZDelta()
	return 200
end
function modifier_item_manifold_paradox_strike_buff:OnIntervalThink()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()

	local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, self.dagger_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
	for _, unit in pairs(units) do
		if IsValid(unit) and unit:IsAlive() and IsValid(hAbility) then
			hAbility:LaunchDagger(unit)
			break
		end
	end
end