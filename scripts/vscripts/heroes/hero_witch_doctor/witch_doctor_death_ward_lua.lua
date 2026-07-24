--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_witch_doctor_death_ward_lua", "heroes/hero_witch_doctor/witch_doctor_death_ward_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if witch_doctor_death_ward_lua == nil then
	witch_doctor_death_ward_lua = class({})
end
function witch_doctor_death_ward_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local vPosition = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("damage")

	self.hDeathWard = CreateUnitByName("npc_dota_witch_doctor_death_ward", vPosition, true, hCaster, hCaster, hCaster:GetTeamNumber())
	self.hDeathWard:SetControllableByPlayer(hCaster:GetPlayerOwnerID(), true)
	self.hDeathWard:SetBaseDamageMin(damage)
	self.hDeathWard:SetBaseDamageMax(damage)
	self.hDeathWard:SetBaseAttackTime(0.1)
	self.hDeathWard:AddNewModifier(hCaster, self, "modifier_witch_doctor_death_ward_lua", nil)
end
function witch_doctor_death_ward_lua:OnChannelFinish(bInterrupted)
	if IsValid(self.hDeathWard) then
		self.hDeathWard:RemoveModifierByName("modifier_witch_doctor_death_ward_lua")
	end
end
function witch_doctor_death_ward_lua:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
	local tHashtable = GetHashtableByIndex(ExtraData.hashtable_index or -1)
	local hDeathWard = EntIndexToHScript(ExtraData.death_ward_ent_index or -1)
	local fDamage = ExtraData.damage or 0
	local hTrueTarget = EntIndexToHScript(ExtraData.jump_target_index or -1)
	if IsValid(hDeathWard) then
		self:Bounce(hDeathWard, hTrueTarget, fDamage, tHashtable)

		if IsValid(hTrueTarget) and not hTrueTarget:HasState(MODIFIER_STATE_DEBUFF_IMMUNE) then
			local tInfo = {
				ability = self,
				attacker = hDeathWard,
				victim = hTrueTarget,
				damage = fDamage,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_ALL_BLOCK,
			}
			ApplyDamage(tInfo)
		end
	end
	return true
end
function witch_doctor_death_ward_lua:Bounce(hDeathWard, hTarget, fDamage, tHashtable)
	tHashtable = tHashtable or CreateHashtable()
	if not IsValid(hTarget) then
		RemoveHashtable(tHashtable)
		return
	end
	local bounce_radius = self:GetSpecialValueFor("bounce_radius")
	local damage = self:GetSpecialValueFor("damage")

	table.insert(tHashtable, hTarget)

	local hNextTarget = Util:GetBounceTarget(hTarget, hDeathWard:GetTeamNumber(), hTarget:GetAbsOrigin(), bounce_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_CLOSEST, tHashtable, false)
	if not IsValid(hNextTarget) then
		RemoveHashtable(tHashtable)
		return
	end
	local tInfo = {
		Target = hNextTarget,
		vSourceLoc = hTarget:GetAttachmentOrigin(hTarget:ScriptLookupAttachment("attach_hitloc")),
		Ability = self,
		EffectName = hDeathWard:GetRangedProjectileName(),
		iMoveSpeed = hDeathWard:GetProjectileSpeed(),
		bIsAttack = true,
		flExpireTime = GameRules:GetGameTime() + 10,
		ExtraData = {
			death_ward_ent_index = hDeathWard:entindex(),
			hashtable_index = GetHashtableIndex(tHashtable),
			jump_target_index = hNextTarget:entindex(),
			damage = damage,
		},
	}
	ProjectileManager:CreateTrackingProjectile(tInfo)
end
function witch_doctor_death_ward_lua:IsHiddenWhenStolen()
	return false
end
---------------------------------------------------------------------
-- Modifiers
if modifier_witch_doctor_death_ward_lua == nil then
	modifier_witch_doctor_death_ward_lua = class({})
end
function modifier_witch_doctor_death_ward_lua:IsHidden()
	return true
end
function modifier_witch_doctor_death_ward_lua:IsDebuff()
	return false
end
function modifier_witch_doctor_death_ward_lua:IsPurgable()
	return false
end
function modifier_witch_doctor_death_ward_lua:IsPurgeException()
	return false
end
function modifier_witch_doctor_death_ward_lua:IsStunDebuff()
	return false
end
function modifier_witch_doctor_death_ward_lua:AllowIllusionDuplicate()
	return false
end
function modifier_witch_doctor_death_ward_lua:RemoveOnDeath()
	return false
end
function modifier_witch_doctor_death_ward_lua:OnCreated(params)
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	self.bonus_attack_range = self:GetAbilitySpecialValueFor("talent_bonus_attack_range")
	self.bonus_accuracy = self:GetAbilitySpecialValueFor("bonus_accuracy")

	if IsServer() then
		self.accuracy = IsValid(hCaster) and hCaster:HasScepter()
		self:StartIntervalThink(0)
		hParent:EmitSound("Hero_WitchDoctor.Death_WardBuild")
	end
end
function modifier_witch_doctor_death_ward_lua:OnDestroy(params)
	if IsServer() then
		self:GetParent():StopSound("Hero_WitchDoctor.Death_WardBuild")
		self:GetParent():ForceKill(false)
		self:GetParent():AddNoDraw()
	end
end
function modifier_witch_doctor_death_ward_lua:OnIntervalThink()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	if IsServer() then
		if not IsValid(hCaster) then
			self:Destroy()
		end
		local fRange = hParent:Script_GetAttackRange() + hParent:GetHullRadius()
		local vPosition = hParent:GetAbsOrigin()
		local hForceAttackTarget = hParent:GetForceAttackTarget()
		if not IsValid(hForceAttackTarget) or not hForceAttackTarget:IsPositionInRange(vPosition, fRange) or UnitFilter(hForceAttackTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, hParent:GetTeamNumber()) ~= UF_SUCCESS or hForceAttackTarget:HasState(MODIFIER_STATE_DEBUFF_IMMUNE) then
			hParent:SetForceAttackTarget(nil)
			hForceAttackTarget = nil
		end
		if hForceAttackTarget == nil then
			local tTargets = FindUnitsInRadius(hParent:GetTeamNumber(), vPosition, nil, fRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
			for _, enemy in pairs(tTargets) do
				if IsValid(enemy) and not enemy:HasState(MODIFIER_STATE_DEBUFF_IMMUNE) then
					hParent:SetForceAttackTarget(enemy)
					break
				end
			end
		end
	end
end
function modifier_witch_doctor_death_ward_lua:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_CANNOT_MISS] = self.accuracy,
	}
end
function modifier_witch_doctor_death_ward_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		-- MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ORDER,
		-- MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_START,
	}
end
function modifier_witch_doctor_death_ward_lua:GetModifierAttackRangeBonus(params)
	return self.bonus_attack_range
end
function modifier_witch_doctor_death_ward_lua:OnOrder(params)
	local hParent = self:GetParent()
	if params.unit == hParent then
		if params.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET then
			local hTarget = params.target
			local fRange = hParent:Script_GetAttackRange() + hParent:GetHullRadius()
			local vPosition = hParent:GetAbsOrigin()
			if IsValid(hTarget) and hTarget.IsPositionInRange and type(hTarget.IsPositionInRange) == "function" and hTarget:IsPositionInRange(vPosition, fRange) and UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, hParent:GetTeamNumber()) == UF_SUCCESS then
				hParent:SetForceAttackTarget(hTarget)
			end
		end
	end
end
function modifier_witch_doctor_death_ward_lua:OnAttackLanded(params)
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if params.attacker == hParent then
		if IsValid(hCaster) then
			if hCaster:HasScepter() then
				local hAbility = self:GetAbility()
				if IsValid(hAbility) and hAbility.Bounce ~= nil then
					hAbility:Bounce(hParent, params.target, params.original_damage)
				end
			end
		end
	end
end
function modifier_witch_doctor_death_ward_lua:OnAttackStart(params)
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if params.attacker == hParent then
		if IsValid(hCaster) then
			if RandomFloat(0, self.bonus_accuracy) <= 50 then
				self.accuracy = true
			else
				self.accuracy = false
			end
		end
	end
end