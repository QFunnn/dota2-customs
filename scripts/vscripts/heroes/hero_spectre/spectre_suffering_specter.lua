--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spectre_suffering_specter", "heroes/hero_spectre/spectre_suffering_specter.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if spectre_suffering_specter == nil then
	spectre_suffering_specter = class({})
end
function spectre_suffering_specter:GetIntrinsicModifierName()
	local hCaster = self:GetCaster()
	if hCaster:HasAbility("spectre_suffering_specter") then
		return "modifier_spectre_suffering_specter"
	end
end
function spectre_suffering_specter:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end
function spectre_suffering_specter:OnSpellStart()
	local hTarget = self:GetCursorTarget()

	self:Fire(hTarget, true)
end
function spectre_suffering_specter:Fire(hTarget, bClearStacks)
	local hCaster = self:GetCaster()
	local base_damage = self:GetSpecialValueFor("base_damage")
	local speed = self:GetSpecialValueFor("speed")

	if IsValid(hCaster) and IsValid(hTarget) then
		local fDamage = base_damage

		local hBuff = hCaster:FindModifierByName("modifier_spectre_suffering_specter")
		if hBuff then
			fDamage = fDamage + hBuff:GetStackCount()
			if bClearStacks then
				hBuff:SetStackCount(0)
				hBuff:ClearStacks()
			end
		end

		EmitSoundOn("Hero_Spectre.HauntCast", hCaster)
		EmitSoundOn("Hero_Spectre.Haunt", hTarget)

		local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_suffering_specter.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
		ParticleManager:SetParticleControlEnt(iParticleID, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
		ParticleManager:SetParticleControl(iParticleID, 2, Vector(speed, 0, 0))
		ParticleManager:SetParticleControlEnt(iParticleID, 11, hCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin(), true)

		local tInfo = {
			Target = hTarget,
			Source = hCaster,
			Ability = self,
			EffectName = "",
			iMoveSpeed = speed,
			bIsAttack = false,
			-- flExpireTime = GameRules:GetGameTime() + 10,
			bDodgeable = true,
			ExtraData = {
				iParticleID = iParticleID,
				fDamage = fDamage,
			},
		}
		ProjectileManager:CreateTrackingProjectile(tInfo)

	end
end
function spectre_suffering_specter:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
	local hCaster = self:GetCaster()
	local iParticleID = ExtraData.iParticleID
	local fDamage = ExtraData.fDamage or 0
	local radius = self:GetSpecialValueFor("radius")
	local penalty_distance = self:GetSpecialValueFor("penalty_distance")
	local penalty_damage_max_pct = self:GetSpecialValueFor("penalty_damage_max_pct")

	if iParticleID then
		ParticleManager:DestroyParticle(iParticleID, false)
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
	if IsValid(hCaster) and IsValid(hTarget) and IsValid(self) and not hTarget:TriggerSpellAbsorb(self) then
		local units = FindUnitsInRadius(hCaster:GetTeamNumber(), hTarget:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				EmitSoundOn("Hero_ArcWarden.SparkWraith.Damage", unit)
				local fLocalDamage = fDamage

				if unit:IsRealHero() then
					local fRange = (hCaster:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D()
					if fRange > penalty_distance then
						fLocalDamage = math.min(fLocalDamage, unit:GetMaxHealth() * penalty_damage_max_pct * 0.01)
					end
				end
				ApplyDamage({
					victim = unit,
					attacker = hCaster,
					ability = self,
					damage = fLocalDamage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
					damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
				})
				SendOverheadEventMessage(nil, OVERHEAD_ALERT_DAMAGE, unit, fLocalDamage, nil)
			end
		end

	end
end
function spectre_suffering_specter:GetCastRange(vLocation, hTarget)
	return self.fCastrange or (self.BaseClass.GetCastRange(self, vLocation, nil))
end
---------------------------------------------------------------------
--Modifiers
if modifier_spectre_suffering_specter == nil then
	modifier_spectre_suffering_specter = class({})
end
function modifier_spectre_suffering_specter:IsHidden()
	return false
end
function modifier_spectre_suffering_specter:IsDebuff()
	return false
end
function modifier_spectre_suffering_specter:IsPurgable()
	return false
end
function modifier_spectre_suffering_specter:IsPurgeException()
	return false
end
function modifier_spectre_suffering_specter:OnCreated(params)
	self.save_pct = self:GetAbilitySpecialValueFor("save_pct")
	self.save_time = self:GetAbilitySpecialValueFor("save_time")
	self.bonus_health_pct = self:GetAbilitySpecialValueFor("bonus_health_pct")
	self.AbilityCastRange = self:GetAbilitySpecialValueFor("AbilityCastRange")
	if IsServer() then
		AddModifierEvents(MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT, self, self:GetParent())
		self.tRecords = {}
		self:StartIntervalThink(FrameTime())
		self:SetHasCustomTransmitterData(true)
	end
end
function modifier_spectre_suffering_specter:OnRefresh(params)
	self.save_pct = self:GetAbilitySpecialValueFor("save_pct")
	self.save_time = self:GetAbilitySpecialValueFor("save_time")
	self.bonus_health_pct = self:GetAbilitySpecialValueFor("bonus_health_pct")
	self.AbilityCastRange = self:GetAbilitySpecialValueFor("AbilityCastRange")
	if IsServer() then
	end
end
function modifier_spectre_suffering_specter:OnDestroy()
	if IsServer() then
		RemoveModifierEvents(MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT, self, self:GetParent())
	end
end
function modifier_spectre_suffering_specter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
	}
end
function modifier_spectre_suffering_specter:OnTakeDamageKillCredit(params)
	local hParent = self:GetParent()
	local fDamage = params.damage
	local iDamageFlags = params.damage_flags
	local hInflictor = params.inflictor

	if IsValid(hParent) and hParent == params.attacker and fDamage > 0 then
		if IsValid(hInflictor) and hInflictor.GetAbilityName and type(hInflictor.GetAbilityName) == "function" then
			local sInflictorName = hInflictor:GetAbilityName()
			if REFLECTION_ABILITIES[sInflictorName] ~= nil then
				local CurrentTime = GameRules:GetGameTime()
				local iStack = math.floor(params.damage * self.save_pct * 0.01)
				table.insert(self.tRecords, { iStack = iStack, fDieTime = CurrentTime + self.save_time })
				self:SetStackCount(self:GetStackCount() + iStack)
			end
		end
	end
end
function modifier_spectre_suffering_specter:OnIntervalThink()
	local hAbility = self:GetAbility()
	local CurrentTime = GameRules:GetGameTime()
	local iRemoveStack = 0
	for i = #self.tRecords, 1, -1 do
		if CurrentTime > self.tRecords[i].fDieTime then
			iRemoveStack = iRemoveStack + self.tRecords[i].iStack
			table.remove(self.tRecords, i)
		end
	end
	self:SetStackCount(math.max(0, self:GetStackCount() - iRemoveStack))
	if GameRules:IsDaytime() then
		self.fCastrange = self.AbilityCastRange
		self:SendBuffRefreshToClients()
	else
		self.fCastrange = 10000
		self:SendBuffRefreshToClients()
	end
	if IsValid(hAbility) then
		hAbility.fCastrange = self.fCastrange
	end
end
function modifier_spectre_suffering_specter:ClearStacks()
	if self.tRecords then
		for i = #self.tRecords, 1, -1 do
			table.remove(self.tRecords, i)
		end
	end
	self:SetStackCount(0)
end
function modifier_spectre_suffering_specter:OnTooltip()
	return self:GetStackCount()
end
function modifier_spectre_suffering_specter:GetModifierExtraHealthPercentage()
	return self.bonus_health_pct
end
function modifier_spectre_suffering_specter:AddCustomTransmitterData()
	return {
		fCastrange = self.fCastrange
	}
end
function modifier_spectre_suffering_specter:HandleCustomTransmitterData(t)
	self.fCastrange = t.fCastrange
	local hAbility = self:GetAbility()
	if IsValid(hAbility) then
		hAbility.fCastrange = t.fCastrange
	end
end