--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rubick_magic_duel", "heroes/hero_rubick/rubick_magic_duel.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rubick_magic_duel_spell_amp", "heroes/hero_rubick/rubick_magic_duel.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rubick_magic_duel_creep_cd", "heroes/hero_rubick/rubick_magic_duel.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if rubick_magic_duel == nil then
	rubick_magic_duel = class({})
end
function rubick_magic_duel:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")

	if IsValid(hCaster) and IsValid(hTarget) and hCaster:IsAlive() and hTarget:IsAlive() then
		local tDuelBuff = hTarget:FindModifierByNameAndCaster("modifier_rubick_magic_duel", hCaster)
		EmitSoundOn("Hero_LegionCommander.Duel.Cast", hCaster)
		if not tDuelBuff then
			local vMidPos = hCaster:GetAbsOrigin():Lerp(hTarget:GetAbsOrigin(), 0.5)
			local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_rubick/rubick_magic_duel_ring.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
			ParticleManager:SetParticleControl(iParticleID, 0, vMidPos)
			-- ParticleManager:ReleaseParticleIndex(iParticleID)
			local tCasterBuff = hCaster:AddNewModifier(hCaster, self, "modifier_rubick_magic_duel", { duration = duration * hTarget:GetStatusResistanceFactor(hCaster), target_index = hTarget:entindex() })
			tCasterBuff:AddParticle(iParticleID, false, false, -1, false, false)

			hTarget:AddNewModifier(hCaster, self, "modifier_rubick_magic_duel", { duration = duration * hTarget:GetStatusResistanceFactor(hCaster), target_index = hTarget:entindex() })

		end
	end
end
------------------------
if modifier_rubick_magic_duel == nil then
	modifier_rubick_magic_duel = class({})
end
function modifier_rubick_magic_duel:IsHidden()
	return false
end
function modifier_rubick_magic_duel:IsDebuff()
	return true
end
function modifier_rubick_magic_duel:IsPurgable()
	return false
end
function modifier_rubick_magic_duel:IsPurgeException()
	return false
end
function modifier_rubick_magic_duel:OnCreated(params)
	self.reward_spell_amp = self:GetAbilitySpecialValueFor("reward_spell_amp")
	self.scepter_damage_reduction_pct = self:GetAbilitySpecialValueFor("scepter_damage_reduction_pct")
	if IsServer() then
		local target_index = params.target_index
		if target_index ~= nil then
			self.hTarget = EntIndexToHScript(target_index)
			self:StartIntervalThink(0.3)
			self:OnIntervalThink()
		else
			self:OnDestroy()
		end
		local hCaster = self:GetCaster()
		local hParent = self:GetParent()
		if hCaster == hParent then
			EmitSoundOn("Hero_LegionCommander.Duel", hParent)
		end
		self.hDuelTarget = hCaster
		if hParent == hCaster then
			self.hDuelTarget = self.hTarget
		end

		self.bReward = false --标记是否给予奖励
		self.bCreep = false --标记是否需要CD
		if hParent:IsRealHero() or (not hParent:IsHero() and not hParent:IsIllusion() and not hCaster:HasModifier("modifier_rubick_magic_duel_creep_cd")) then
			self.bReward = true
		end
		if hParent:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
			self.bCreep = true
		end
	end
end
function modifier_rubick_magic_duel:OnRefresh()
	self.reward_spell_amp = self:GetAbilitySpecialValueFor("reward_spell_amp")
	self.scepter_damage_reduction_pct = self:GetAbilitySpecialValueFor("scepter_damage_reduction_pct")
	if IsServer() then
	end
end
function modifier_rubick_magic_duel:OnRemoved(bDeath)
	if IsServer() then
		local hParent = self:GetParent()
		if bDeath then
			local hCaster = self:GetCaster()
			local hAbility = self:GetAbility()
			if self.bReward then
				self.hDuelTarget:AddNewModifier(hCaster, hAbility, "modifier_rubick_magic_duel_spell_amp", { stack = self.reward_spell_amp })
				if self.bCreep and hCaster == self.hDuelTarget then
					self.hDuelTarget:AddNewModifier(hCaster, hAbility, "modifier_rubick_magic_duel_creep_cd", {})
				end
			end

			EmitSoundOn("Hero_LegionCommander.Duel.Victory", self.hDuelTarget)
		end
	end
end
function modifier_rubick_magic_duel:OnDestroy()
	if IsServer() then
		local hCaster = self:GetCaster()
		local hParent = self:GetParent()
		local hDuelTarget = hCaster
		if hParent == hCaster then
			hDuelTarget = self.hTarget
		end
		hDuelTarget:RemoveModifierByNameAndCaster("modifier_rubick_magic_duel", hCaster)
		StopSoundOn("Hero_LegionCommander.Duel", hCaster)
	end
end
function modifier_rubick_magic_duel:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_TAUNTED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end
function modifier_rubick_magic_duel:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function modifier_rubick_magic_duel:GetModifierIncomingDamage_Percentage(params)
	local hAttacker = params.attacker
	if hAttacker ~= self.hDuelTarget then
		return self.scepter_damage_reduction_pct
	end
end
function modifier_rubick_magic_duel:OnIntervalThink()
	local hParent = self:GetParent()

	local bCastDone = false
	if not hParent:IsChanneling() and hParent:GetCurrentActiveAbility() == nil and IsValid(self.hDuelTarget) and self.hDuelTarget:IsAlive() then
		local tNormalAbilities = {}
		for i = 0, hParent:GetAbilityCount() - 1 do
			local hAbility = hParent:GetAbilityByIndex(i)
			if IsValid(hAbility) and not hAbility:IsHidden() and hAbility:IsCooldownReady() and hAbility:IsFullyCastable() and not HasBehavior(hAbility, DOTA_ABILITY_BEHAVIOR_CHANNELLED) and not hAbility:IsToggle() and not hAbility:IsPassive() and hAbility:GetAbilityName() ~= "rubick_magic_duel" then
				table.insert(tNormalAbilities, hAbility)
			end
		end
		if #tNormalAbilities > 0 then
			local hAbilitytoCast = tNormalAbilities[RandomInt(1, #tNormalAbilities)]
			if HasBehavior(hAbilitytoCast, DOTA_ABILITY_BEHAVIOR_POINT) or HasBehavior(hAbilitytoCast, DOTA_ABILITY_BEHAVIOR_OPTIONAL_POINT) then
				hParent:CastAbilityOnPosition(self.hDuelTarget:GetAbsOrigin() + RandomVector(RandomFloat(0, 50)), hAbilitytoCast, hParent:GetPlayerOwnerID())
				bCastDone = true
			elseif HasBehavior(hAbilitytoCast, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
				local iAbilityTargetTeam = hAbilitytoCast:GetAbilityTargetTeam()
				if iAbilityTargetTeam == DOTA_UNIT_TARGET_TEAM_FRIENDLY then
					hParent:CastAbilityOnTarget(hParent, hAbilitytoCast, hParent:GetPlayerOwnerID())
					bCastDone = true
				elseif iAbilityTargetTeam == DOTA_UNIT_TARGET_TEAM_ENEMY then
					hParent:CastAbilityOnTarget(self.hDuelTarget, hAbilitytoCast, hParent:GetPlayerOwnerID())
					bCastDone = true
				elseif iAbilityTargetTeam == DOTA_UNIT_TARGET_TEAM_BOTH or iAbilityTargetTeam == DOTA_UNIT_TARGET_TEAM_CUSTOM then
					hParent:CastAbilityOnTarget(self.hDuelTarget, hAbilitytoCast, hParent:GetPlayerOwnerID())
					bCastDone = true
				end
			elseif HasBehavior(hAbilitytoCast, DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
				hParent:CastAbilityNoTarget(hAbilitytoCast, hParent:GetPlayerOwnerID())
				bCastDone = true
			end
		end


		if not bCastDone then
			local tChannelAbilities = {}
			for i = 0, hParent:GetAbilityCount() - 1 do
				local hAbility = hParent:GetAbilityByIndex(i)
				if IsValid(hAbility) and not hAbility:IsHidden() and hAbility:IsCooldownReady() and hAbility:IsFullyCastable() and HasBehavior(hAbility, DOTA_ABILITY_BEHAVIOR_CHANNELLED) and not hAbility:IsToggle() and not hAbility:IsPassive() and hAbility:GetAbilityName() ~= "rubick_magic_duel" then
					table.insert(tChannelAbilities, hAbility)
				end
			end
			if #tChannelAbilities > 0 then
				local hAbilitytoCast = tChannelAbilities[RandomInt(1, #tChannelAbilities)]
				if HasBehavior(hAbilitytoCast, DOTA_ABILITY_BEHAVIOR_POINT) or HasBehavior(hAbilitytoCast, DOTA_ABILITY_BEHAVIOR_OPTIONAL_POINT) then
					hParent:CastAbilityOnPosition(self.hDuelTarget:GetAbsOrigin() + RandomVector(RandomFloat(0, 50)), hAbilitytoCast, hParent:GetPlayerOwnerID())
					bCastDone = true
				elseif HasBehavior(hAbilitytoCast, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
					hParent:CastAbilityOnTarget(self.hDuelTarget, hAbilitytoCast, hParent:GetPlayerOwnerID())
					bCastDone = true
				elseif HasBehavior(hAbilitytoCast, DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
					hParent:CastAbilityNoTarget(hAbilitytoCast, hParent:GetPlayerOwnerID())
					bCastDone = true
				end
			end
		end
		if not bCastDone then
			hParent:Hold()
		end
	end
end
------------------------
if modifier_rubick_magic_duel_spell_amp == nil then
	modifier_rubick_magic_duel_spell_amp = class({})
end
function modifier_rubick_magic_duel_spell_amp:IsHidden()
	return false
end
function modifier_rubick_magic_duel_spell_amp:IsDebuff()
	return false
end
function modifier_rubick_magic_duel_spell_amp:IsPurgable()
	return false
end
function modifier_rubick_magic_duel_spell_amp:IsPurgeException()
	return false
end
function modifier_rubick_magic_duel_spell_amp:RemoveOnDeath()
	return false
end
function modifier_rubick_magic_duel_spell_amp:OnCreated(params)
	if IsServer() then
		local hParent = self:GetParent()
		local iStack = params.stack or 1
		self:SetStackCount(iStack)
		local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_rubick/rubick_magic_duel_victory.vpcf", PATTACH_OVERHEAD_FOLLOW, hParent)
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
end
function modifier_rubick_magic_duel_spell_amp:OnRefresh(params)
	if IsServer() then
		local hParent = self:GetParent()
		local iStack = params.stack or 1
		self:SetStackCount(self:GetStackCount() + iStack)
		local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_rubick/rubick_magic_duel_victory.vpcf", PATTACH_OVERHEAD_FOLLOW, hParent)
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
end
function modifier_rubick_magic_duel_spell_amp:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end
function modifier_rubick_magic_duel_spell_amp:GetModifierSpellAmplify_Percentage(params)
	local hInflictor = params.inflictor
	if IsServer() then
		if IsValid(hInflictor) then
			local sAbilityName = hInflictor:GetAbilityName()
			if PERCENTAGE_ABILITIES and PERCENTAGE_ABILITIES[sAbilityName] then
				return 0
			else
				return self:GetStackCount()
			end
		end
	end

	return self:GetStackCount()
end
------------------------
if modifier_rubick_magic_duel_creep_cd == nil then
	modifier_rubick_magic_duel_creep_cd = class({})
end
function modifier_rubick_magic_duel_creep_cd:IsHidden()
	return false
end
function modifier_rubick_magic_duel_creep_cd:IsDebuff()
	return true
end
function modifier_rubick_magic_duel_creep_cd:IsPurgable()
	return false
end
function modifier_rubick_magic_duel_creep_cd:IsPurgeException()
	return false
end
function modifier_rubick_magic_duel_creep_cd:RemoveOnDeath()
	return false
end
function modifier_rubick_magic_duel_creep_cd:OnCreated(params)
	if IsServer() then
		AddModifierEvents(MODIFIER_EVENT_ON_MODIFIER_ADDED, self, self:GetParent())
	end
end
function modifier_rubick_magic_duel_creep_cd:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_rubick_magic_duel_creep_cd:OnDestroy()
	if IsServer() then
		RemoveModifierEvents(MODIFIER_EVENT_ON_MODIFIER_ADDED, self, self:GetParent())
	end
end
function modifier_rubick_magic_duel_creep_cd:OnModifierAdded(params)
	local tBuff = params.added_buff
	if IsValid(tBuff) then
		if tBuff:GetName() == "modifier_hero_refreshing" then
			self:Destroy()
		end
	end
end