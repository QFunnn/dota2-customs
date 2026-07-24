--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


clinkz_wind_walk_custom = class({})

LinkLuaModifier("modifier_clinkz_wind_walk_custom", "abilities/heroes/clinkz/wind_walk", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_clinkz_wind_walk_fade_custom", "abilities/heroes/clinkz/wind_walk", LUA_MODIFIER_MOTION_NONE )

function clinkz_wind_walk_custom:OnSpellStart()
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end

	local duration = self:GetSpecialValueFor("duration")
	local fade_time = self:GetSpecialValueFor("fade_time")

	caster:EmitSound("Hero_Clinkz.WindWalk")
	caster:AddNewModifier(caster, self, "modifier_clinkz_wind_walk_fade_custom", {duration = fade_time})
	caster:AddNewModifier(caster, self, "modifier_clinkz_wind_walk_custom", {duration = duration})
end


-----------------------------------------------------------------------------------------------------------------------------------------------------


modifier_clinkz_wind_walk_fade_custom = class({})

function modifier_clinkz_wind_walk_fade_custom:IsHidden() return true end
function modifier_clinkz_wind_walk_fade_custom:IsDebuff() return false end
function modifier_clinkz_wind_walk_fade_custom:IsPurgable() return false end
function modifier_clinkz_wind_walk_fade_custom:GetPriority() return 2 end

function modifier_clinkz_wind_walk_fade_custom:GetEffectName()
	return "particles/generic_hero_status/status_invisibility_start.vpcf"
end

function modifier_clinkz_wind_walk_fade_custom:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = false,
	}
end

function modifier_clinkz_wind_walk_fade_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_clinkz_wind_walk_fade_custom:OnCreated()
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_clinkz/clinkz_windwalk.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle);
end


--------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_clinkz_wind_walk_custom = class({})

function modifier_clinkz_wind_walk_custom:IsHidden() return false end
function modifier_clinkz_wind_walk_custom:IsDebuff() return false end
function modifier_clinkz_wind_walk_custom:IsPurgable() return false end
function modifier_clinkz_wind_walk_custom:GetPriority() return 1 end

function modifier_clinkz_wind_walk_custom:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.move_speed_bonus_pct = self:GetAbility():GetSpecialValueFor("move_speed_bonus_pct")
end

function modifier_clinkz_wind_walk_custom:OnRefresh()
	self:OnCreated()
	if not IsServer() then return end
	self:SpawnSkeletons()
end

function modifier_clinkz_wind_walk_custom:OnDestroy()
	if not IsServer() then return end
	self:SpawnSkeletons()
end

function modifier_clinkz_wind_walk_custom:SpawnSkeletons()
	local skeleton_count = self.ability:GetSpecialValueFor("skeletons_count")
	local skeleton_duration = self.ability:GetSpecialValueFor("skeleton_duration")

	local fv = self.caster:GetForwardVector()
	local angle = VectorToAngles(fv)
	local origin = self.caster:GetAbsOrigin()
	local offset = Vector(250, 0, 0)		-- distance from caster to skeletons
	local angle_offset = angle.y - 90		-- normal of given angle

	for i=1, skeleton_count do
		-- Y angle is yaw, don't ask me why
		local vector_rotate = RotatePosition(Vector(0, 0, 0), QAngle(0, angle_offset, 0), offset)	-- rotational offset vector
		local position = origin + vector_rotate		-- final positional vector of each skeleton

		local skeleton = CreateUnitByName("npc_dota_clinkz_skeleton_archer", position, true, self.caster, self.caster, self.caster:GetTeamNumber())
		if skeleton ~= nil then
			skeleton:SetForwardVector(fv)
			skeleton:EmitSound("Hero_Clinkz.Skeleton_Archer.Spawn")

			local burning_army = self.caster:FindAbilityByName("clinkz_burning_army")

			-- Sure Valve doing literally that in vanilla ability
			-- https://discord.com/channels/501306949434867713/997015568492281956/997021547577475103
			if burning_army and not burning_army:IsNull() and burning_army:GetLevel() == 0 then
				burning_army:SetLevel(1)
			end

			skeleton:AddNewModifier(self.caster, burning_army, "modifier_clinkz_burning_army", {
				duration = skeleton_duration, damage_percent = 30
			})

			local searing_arrows = skeleton:FindAbilityByName("clinkz_searing_arrows")
			local caster_ability = self.caster:FindAbilityByName("clinkz_searing_arrows")
			if IsValidEntity(searing_arrows) then
				searing_arrows:SetLevel(IsValidEntity(caster_ability) and caster_ability:GetLevel() or 1)
				searing_arrows:ToggleAutoCast()
			end

			local searing_arrows_talent = skeleton:FindAbilityByName("special_bonus_unique_clinkz_1")
			local caster_talent = self.caster:FindAbilityByName("special_bonus_unique_clinkz_1")
			if IsValidEntity(searing_arrows_talent) then
				searing_arrows_talent:SetLevel(IsValidEntity(caster_talent) and caster_talent:GetLevel() or 1)
				searing_arrows_talent:ToggleAutoCast()
			end
		end

		angle_offset = angle_offset + 180	-- rotate by X degrees for each skeleton
	end
end

function modifier_clinkz_wind_walk_custom:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}
end

function modifier_clinkz_wind_walk_custom:OnAttack(event)
	if not self or self:IsNull() then return end
	if not IsServer() then return end
	if not self.caster or self.caster:IsNull() then return end
	if event.attacker ~= self.caster then return end
	if self.caster:HasModifier("modifier_clinkz_wind_walk_fade_custom") then return end	-- During the fade time, Clinkz can cast abilities, use items and perform attacks without breaking the invisibility

	self:Destroy()
end

function modifier_clinkz_wind_walk_custom:OnAbilityExecuted(keys)
	if not self or self:IsNull() then return end
	if not IsServer() then return end
	if not self.caster or self.caster:IsNull() then return end
	if self.caster ~= keys.unit then return end
	if self.caster:HasModifier("modifier_clinkz_wind_walk_fade_custom") then return end	-- During the fade time, Clinkz can cast abilities, use items and perform attacks without breaking the invisibility

	-- Only original clinkz abilities should not break invis and remove the modifiers
	local exceptions = {
		["clinkz_death_pact_custom"] = true,
		["clinkz_burning_army"] = true,
	}
	if exceptions[keys.ability:GetAbilityName()] then return end

	self:Destroy()
end

function modifier_clinkz_wind_walk_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.move_speed_bonus_pct
end

function modifier_clinkz_wind_walk_custom:CheckState()
	local states = {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return states
end

function modifier_clinkz_wind_walk_custom:GetModifierInvisibilityLevel()
	return 1
end