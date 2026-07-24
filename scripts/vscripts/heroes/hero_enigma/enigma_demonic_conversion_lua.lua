--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_enigma_demonic_conversion_lua", "heroes/hero_enigma/enigma_demonic_conversion_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_enigma_demonic_conversion_lua_summoned", "heroes/hero_enigma/enigma_demonic_conversion_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if enigma_demonic_conversion_lua == nil then
	enigma_demonic_conversion_lua = class({})
end
function enigma_demonic_conversion_lua:Summon(sUnitName)
	local hCaster = self:GetCaster()
	local eidolon_duration = self:GetSpecialValueFor("eidolon_duration")
	local eidelon_base_damage = self:GetSpecialValueFor("eidelon_base_damage")
	local eidelon_max_health = self:GetSpecialValueFor("eidelon_max_health")
	local health_gain = self:GetSpecialValueFor("health_gain")
	local mana_regen = self:GetSpecialValueFor("mana_regen")

	local iStack = 1
	local tBuff = hCaster:FindModifierByName("modifier_enigma_demonic_conversion_lua")
	if tBuff then
		iStack = tBuff:GetStackCount()
	end

	local unit = CreateUnitByName(sUnitName, hCaster:GetAbsOrigin(), true, hCaster, hCaster, hCaster:GetTeamNumber())
	unit:SetControllableByPlayer(hCaster:GetPlayerOwnerID(), false)
	unit:SetBaseDamageMin(eidelon_base_damage)
	unit:SetBaseDamageMax(eidelon_base_damage)
	unit:SetHPGain(health_gain)
	unit:SetManaRegenGain(mana_regen)
	unit:SetBaseMaxHealth(eidelon_max_health)
	unit:SetMaxHealth(eidelon_max_health)
	unit:SetHealth(eidelon_max_health)
	unit:AddNewModifier(hCaster, self, "modifier_enigma_demonic_conversion_lua_summoned", { duration = eidolon_duration })
	unit:CreatureLevelUp(iStack - 1)
	if IsValid(unit) then
		self.eidolon = unit
	end
end
function enigma_demonic_conversion_lua:OnSpellStart()
	local hCaster = self:GetCaster()

	if IsValid(hCaster) then

		local NameList = {
			"npc_dota_lesser_eidolon",
			"npc_dota_eidolon",
			"npc_dota_greater_eidolon",
			"npc_dota_dire_eidolon",
		}

		EmitSoundOn("Hero_Enigma.Demonic_Conversion", hCaster)

		if IsValid(self.eidolon) and self.eidolon:IsAlive() then
			--有已经召唤的
			if self.eidolon:GetUnitName() ~= NameList[self:GetLevel()] then
				--需要重新召唤
				-- self.eidolon:Kill(self, hCaster)
				self.eidolon:ForceKill(false)
				self:Summon(NameList[self:GetLevel()])
			else
				--不需要重新召唤
				local eidelon_base_damage = self:GetSpecialValueFor("eidelon_base_damage")
				local eidelon_max_health = self:GetSpecialValueFor("eidelon_max_health")
				local eidolon_duration = self:GetSpecialValueFor("eidolon_duration")
				local health_gain = self:GetSpecialValueFor("health_gain")
				local mana_regen = self:GetSpecialValueFor("mana_regen")
				self.eidolon:SetBaseDamageMin(eidelon_base_damage)
				self.eidolon:SetBaseDamageMax(eidelon_base_damage)
				self.eidolon:SetHPGain(health_gain)
				self.eidolon:SetManaRegenGain(mana_regen)
				self.eidolon:SetBaseMaxHealth(eidelon_max_health)
				self.eidolon:SetMaxHealth(eidelon_max_health)
				self.eidolon:SetHealth(eidelon_max_health)
				self.eidolon:SetHealth(self.eidolon:GetMaxHealth())
				local tSummonBuff = self.eidolon:FindModifierByName("modifier_enigma_demonic_conversion_lua_summoned")
				if tSummonBuff then
					self.eidolon:AddNewModifier(hCaster, self, "modifier_enigma_demonic_conversion_lua_summoned", { duration = tSummonBuff:GetRemainingTime() + eidolon_duration })
				end
			end
		else
			--没有已经召唤的
			self:Summon(NameList[self:GetLevel()])
		end
	end
end
function enigma_demonic_conversion_lua:GetIntrinsicModifierName()
	return "modifier_enigma_demonic_conversion_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_enigma_demonic_conversion_lua == nil then
	modifier_enigma_demonic_conversion_lua = class({})
end
function modifier_enigma_demonic_conversion_lua:IsHidden()
	return false
end
function modifier_enigma_demonic_conversion_lua:IsDebuff()
	return false
end
function modifier_enigma_demonic_conversion_lua:IsPurgable()
	return false
end
function modifier_enigma_demonic_conversion_lua:IsPurgeException()
	return false
end
function modifier_enigma_demonic_conversion_lua:RemoveOnDeath()
	return false
end
function modifier_enigma_demonic_conversion_lua:OnCreated(params)
	self.death_lose = self:GetAbilitySpecialValueFor("death_lose")
	if IsServer() then
		self:SetStackCount(1)
	end
end
function modifier_enigma_demonic_conversion_lua:OnRefresh(params)
	self.death_lose = self:GetAbilitySpecialValueFor("death_lose")
	if IsServer() then
	end
end
function modifier_enigma_demonic_conversion_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_enigma_demonic_conversion_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end
function modifier_enigma_demonic_conversion_lua:OnDeath(params)
	local hParent = self:GetParent()
	local hUnit = params.unit
	local hCaster = self:GetCaster()
	local hAbility = self:GetAbility()
	local hAttacker = params.attacker

	if IsServer() then
		if IsValid(hAbility) then
			if hUnit == hParent or hUnit == hAbility.eidolon then
				if IsValid(hCaster) then
					self:SetStackCount(math.max(1, self:GetStackCount() - self.death_lose))
				end
			elseif IsValid(hAbility.eidolon) and hAbility.eidolon:IsAlive() and hAttacker == hAbility.eidolon and hParent:GetTeamNumber() ~= hUnit:GetTeamNumber() then
				if hUnit:IsRealHero() then
					self:SetStackCount(self:GetStackCount() + self:GetSpecialValueFor("hero_kill_upgrade"))
				else
					local tBuff = hAbility.eidolon:FindModifierByName("modifier_enigma_demonic_conversion_lua_summoned")
					if tBuff then
						tBuff:DecrementStackCount()
					end
				end
			end
		end
	end
end
function modifier_enigma_demonic_conversion_lua:OnTooltip()
	return self:GetStackCount()
end
function modifier_enigma_demonic_conversion_lua:GetModifierTotalDamageOutgoing_Percentage(params)
	local hParent = self:GetParent()
	local hInflictor = params.inflictor
	local hAbility = self:GetAbility()
	local hTarget = params.target

	if IsServer() then
		if hInflictor and hInflictor:GetAbilityName() == "enigma_malefice" then
			local eidelon_fire = self:GetAbilitySpecialValueFor("eidelon_fire")
			if eidelon_fire > 0 and IsValid(hParent) and IsValid(hTarget) then
				if IsValid(hAbility.eidolon) and hAbility.eidolon:IsAlive() then
					local hStrike = hAbility.eidolon:FindAbilityByName("enigma_demonic_conversion_lua_strike")
					if IsValid(hStrike) then
						hStrike:Fire(hTarget)
					end
				end
			end
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_enigma_demonic_conversion_lua_summoned == nil then
	modifier_enigma_demonic_conversion_lua_summoned = class({})
end
function modifier_enigma_demonic_conversion_lua_summoned:IsHidden()
	return false
end
function modifier_enigma_demonic_conversion_lua_summoned:IsDebuff()
	return false
end
function modifier_enigma_demonic_conversion_lua_summoned:IsPurgable()
	return false
end
function modifier_enigma_demonic_conversion_lua_summoned:IsPurgeException()
	return false
end
function modifier_enigma_demonic_conversion_lua_summoned:OnCreated(params)
	self.eidolon_bonus_attack_speed = self:GetAbilitySpecialValueFor("eidolon_bonus_attack_speed")
	self.eidolon_bonus_damage = self:GetAbilitySpecialValueFor("eidolon_bonus_damage")
	self.upgrade_kill_count = self:GetAbilitySpecialValueFor("upgrade_kill_count")
	self.modelscale = self:GetAbilitySpecialValueFor("modelscale")
	if IsServer() then
		self:SetStackCount(self.upgrade_kill_count)
	end
end
function modifier_enigma_demonic_conversion_lua_summoned:OnRefresh(params)
	self.eidolon_bonus_attack_speed = self:GetAbilitySpecialValueFor("eidolon_bonus_attack_speed")
	self.eidolon_bonus_damage = self:GetAbilitySpecialValueFor("eidolon_bonus_damage")
	self.upgrade_kill_count = self:GetAbilitySpecialValueFor("upgrade_kill_count")
	self.modelscale = self:GetAbilitySpecialValueFor("modelscale")
	if IsServer() then
	end
end
function modifier_enigma_demonic_conversion_lua_summoned:OnDestroy()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	if IsServer() then
		hParent:Kill(self:GetAbility(), hCaster)
	end
end
function modifier_enigma_demonic_conversion_lua_summoned:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_LIFETIME_FRACTION,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end
function modifier_enigma_demonic_conversion_lua_summoned:GetUnitLifetimeFraction(params)
	return ((self:GetDieTime() - GameRules:GetGameTime()) / self:GetDuration())
end
function modifier_enigma_demonic_conversion_lua_summoned:GetModifierAttackSpeedBonus_Constant()
	return self.eidolon_bonus_attack_speed
end
function modifier_enigma_demonic_conversion_lua_summoned:GetModifierBaseAttack_BonusDamage()
	return self.eidolon_bonus_damage
end
function modifier_enigma_demonic_conversion_lua_summoned:OnStackCountChanged(iStackCount)
	if IsServer() then
		if self:GetStackCount() <= 0 then
			local hParent = self:GetParent()
			if IsValid(hParent) and hParent:IsAlive() then
				hParent:CreatureLevelUp(1)
			end
			local hCaster = self:GetCaster()
			if IsValid(hCaster) then
				local tBuff = hCaster:FindModifierByName("modifier_enigma_demonic_conversion_lua")
				if tBuff then
					tBuff:IncrementStackCount()
				end
			end
			self:SetStackCount(self.upgrade_kill_count)
		end
	end
end
function modifier_enigma_demonic_conversion_lua_summoned:GetModifierModelScale()
	local hParent = self:GetParent()
	return hParent:GetLevel() * self.modelscale
end