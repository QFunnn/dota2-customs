--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


enigma_demonic_conversion_custom = class({})
LinkLuaModifier("modifier_demonic_conversion_custom_split", "abilities/heroes/enigma/enigma_demonic_conversion.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_demonic_conversion_magic_resist", "abilities/heroes/enigma/enigma_demonic_conversion.lua", LUA_MODIFIER_MOTION_NONE)


enigma_demonic_conversion_custom.spawn_unit_name = {
	"npc_dota_lesser_eidolon",
	"npc_dota_eidolon",
	"npc_dota_greater_eidolon",
	"npc_dota_dire_eidolon",
}


function enigma_demonic_conversion_custom:CastFilterResultTarget(target)
	local caster = self:GetCaster()

	if caster == target then return UF_SUCCESS end

	return UnitFilter(target,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetTeamNumber()
	)
end


function enigma_demonic_conversion_custom:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local origin = target:GetAbsOrigin()

	if not IsValidEntity(caster) then return end
	if not IsValidEntity(target) then return end

	if caster ~= target then
		target:Kill(self, caster)
	end

	local spawn_count = self:GetSpecialValueFor("spawn_count")
	local unit_name = self.spawn_unit_name[self:GetLevel()]
	local duration = self:GetDuration()
	local unit_origin = (caster == target) and (origin + caster:GetForwardVector() * 75) or origin

	self:SpawnEidolons(unit_name, unit_origin, caster, spawn_count, duration, true, true)
	caster:EmitSound("Hero_Enigma.Demonic_Conversion")
end


function enigma_demonic_conversion_custom:SpawnEidolons(unit_name, unit_origin, caster, spawn_count, duration, can_produce_eidolon, can_refresh_duration)
	for i = 1, spawn_count do
		local unit = CreateUnitByName(unit_name, unit_origin, true, caster, caster, caster:GetTeamNumber())

		unit:SetControllableByPlayer(caster:GetPlayerOwnerID(), true)
		unit:AddNewModifier(caster, self, "modifier_demonic_conversion", {duration = duration})		-- vanilla modifier takes care of everything but the split :)
		unit:AddNewModifier(caster, self, "modifier_demonic_conversion_custom_split", {duration = duration})
		unit:AddNewModifier(caster, self, "modifier_demonic_conversion_magic_resist", {duration = duration})

		unit.can_produce_eidolon = can_produce_eidolon
		unit.can_refresh_duration = can_refresh_duration
	end
	ResolveNPCPositions(unit_origin, 128)
end



modifier_demonic_conversion_custom_split = class({})

function modifier_demonic_conversion_custom_split:IsHidden() return true end
function modifier_demonic_conversion_custom_split:IsPurgable() return false end
function modifier_demonic_conversion_custom_split:IsDebuff() return true end


function modifier_demonic_conversion_custom_split:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_LIFETIME_FRACTION,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end


function modifier_demonic_conversion_custom_split:GetUnitLifetimeFraction( params )
	return (self:GetDieTime() - GameRules:GetGameTime()) / self:GetDuration()
end


function modifier_demonic_conversion_custom_split:OnCreated(kv)
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsValidEntity(self.caster) then return end
	if not IsValidEntity(self.parent) then return end
	if not IsValidEntity(self.ability) then return end

	self.split_attack_count = self.ability:GetSpecialValueFor("split_attack_count")
	self.life_extension = self.ability:GetSpecialValueFor("life_extension")
	self.attack_counter = 0
end


function modifier_demonic_conversion_custom_split:OnRefresh(kv)
	self:OnCreated(kv)
end


function modifier_demonic_conversion_custom_split:OnDestroy()
	if not IsServer() then return end
	if not self or self:IsNull() then return end
	if not IsValidEntity(self.parent) then return end
	self.parent:ForceKill(false)
end


function modifier_demonic_conversion_custom_split:GetModifierProcAttack_Feedback(event)
	if not IsValidEntity(self.parent) then return end

	local target = event.target

	if not IsValidEntity(target) then return end

	if self.attack_counter >= self.split_attack_count and self.parent.can_refresh_duration then
		self.parent.can_refresh_duration = false

		-- adjust the parent eidolon
		self.parent:SetHealth(self.parent:GetMaxHealth())
		local duration = self:GetRemainingTime() + self.life_extension
		local modifier = self.parent:FindModifierByName("modifier_demonic_conversion")
		if modifier then
			modifier:SetDuration(duration, true)
		end
		self:SetDuration(duration, true)

		if self.parent.can_produce_eidolon then
			self.parent.can_produce_eidolon = false
			-- spawn a new eidolon
			self.ability:SpawnEidolons(self.parent:GetUnitName(), self.parent:GetAbsOrigin(), self.caster, 1, duration, false, true)
		end
	end

	if target and target:GetTeamNumber() ~= self.parent:GetTeamNumber() and target.IsBuilding and not target:IsBuilding() then
		self.attack_counter = self.attack_counter + 1
	end
end


modifier_demonic_conversion_magic_resist = modifier_demonic_conversion_magic_resist or class({})


function modifier_demonic_conversion_magic_resist:IsHidden() return true end
function modifier_demonic_conversion_magic_resist:IsPurgable() return false end


function modifier_demonic_conversion_magic_resist:OnCreated()
	local ability = self:GetAbility()
	if not IsValidEntity(ability) then return end

	self.bonus_magic_resist = ability:GetSpecialValueFor("eidolon_bonus_magic_resist") or 0
end


function modifier_demonic_conversion_magic_resist:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS, -- GetModifierMagicalResistanceBonus
	}
end


function modifier_demonic_conversion_magic_resist:GetModifierMagicalResistanceBonus()
	return self.bonus_magic_resist or 0
end