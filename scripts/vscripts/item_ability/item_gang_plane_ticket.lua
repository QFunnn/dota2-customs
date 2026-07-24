--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gang_letter", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_letter_effect", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_letter_fade", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_plane_ticket", "item_ability/item_gang_plane_ticket.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_gang_plane_ticket == nil then
	item_gang_plane_ticket = class({}) ---@class CDOTA_Item_Lua
end
function item_gang_plane_ticket:GetAOERadius()
	return self:GetSpecialValueFor("blink_radius")
end

function item_gang_plane_ticket:GetCastRange()
	return self:GetSpecialValueFor("AbilityCastRange")
end

function item_gang_plane_ticket:OnSpellStart()
	local hCaster = self:GetCaster()
	local vLocation = self:GetCursorPosition()
	local aura_radius = self:GetSpecialValueFor("aura_radius")
	local blink_radius = self:GetSpecialValueFor("blink_radius")

	if IsValid(hCaster) and vLocation then
		local duration = self:GetSpecialValueFor("duration")
		local vDir = (vLocation - hCaster:GetAbsOrigin()):Normalized()
		local fRange = math.min(self:GetCaster():GetCastRangeBonus() + self:GetSpecialValueFor("AbilityCastRange"), (vLocation - hCaster:GetAbsOrigin()):Length2D())
		vLocation = hCaster:GetAbsOrigin() + vDir * fRange
		
		local units = FindUnitsInRadius(hCaster:GetTeamNumber(), hCaster:GetAbsOrigin(), nil, aura_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() and unit:HasModifier("modifier_item_gang_letter_effect") then
				if unit:IsRangedAttacker() then
					FindClearSpaceForUnit(unit, vLocation + RandomVector(RandomFloat(50, blink_radius)), true)
				else
					FindClearSpaceForUnit(unit, vLocation, true)
				end
			end
		end

		local iParticleID = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
		ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(iParticleID)

		EmitSoundOn("DOTA_Item.BlinkDagger.Activate", hCaster)

		FindClearSpaceForUnit(hCaster, vLocation, true)

		local bHit = false
		units = FindUnitsInRadius(hCaster:GetTeamNumber(), hCaster:GetAbsOrigin(), nil, blink_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				bHit = true
				unit:AddNewModifier(hCaster, self, "modifier_item_gang_plane_ticket", { duration = duration * unit:GetStatusResistanceFactor(hCaster) })
			end
		end
		if bHit then
			EmitSoundOn("Hero_DarkWillow.Fear.Target", hCaster)
		end

		local iParticleID2 = ParticleManager:CreateParticle("particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
		ParticleManager:SetParticleControl(iParticleID2, 0, hCaster:GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID2, 1, Vector(blink_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(iParticleID2)

		EmitSoundOn("Hero_DarkWillow.Fear.Location", hCaster)
	end
end
function item_gang_plane_ticket:GetIntrinsicModifierName()
	return "modifier_item_gang_letter"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_gang_plane_ticket == nil then
	modifier_item_gang_plane_ticket = class({}) ---@class CDOTA_Modifier_Lua
end
function modifier_item_gang_plane_ticket:IsDebuff(params)
	return true
end
function modifier_item_gang_plane_ticket:IsHidden(params)
	return false
end
function modifier_item_gang_plane_ticket:IsPurgable(params)
	return false
end
function modifier_item_gang_plane_ticket:IsPurgeException(params)
	return false
end
function modifier_item_gang_plane_ticket:CheckState()
	return {
		[MODIFIER_STATE_FEARED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end
function modifier_item_gang_plane_ticket:OnCreated(params)
	if IsServer() then
		local hParent = self:GetParent()
		local hCaster = self:GetCaster()
		if IsValid(hParent) and IsValid(hCaster) then
			local vDir = (hParent:GetAbsOrigin() - hCaster:GetAbsOrigin()):Normalized()
			hParent:MoveToPosition(hParent:GetAbsOrigin() + vDir * 10000)
		end
	end
end
function modifier_item_gang_plane_ticket:OnRefresh(params)
	if IsServer() then
		local hParent = self:GetParent()
		local hCaster = self:GetCaster()
		if IsValid(hParent) and IsValid(hCaster) then
			local vDir = (hParent:GetAbsOrigin() - hCaster:GetAbsOrigin()):Normalized()
			hParent:MoveToPosition(hParent:GetAbsOrigin() + vDir * 10000)
		end
	end
end
function modifier_item_gang_plane_ticket:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_gang_plane_ticket:DeclareFunctions()
	return {
	}
end
function modifier_item_gang_plane_ticket:GetStatusEffectName()
	return "particles/status_fx/status_effect_lone_druid_savage_roar.vpcf"
end
function modifier_item_gang_plane_ticket:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_item_gang_plane_ticket:GetEffectName()
	return "particles/units/heroes/hero_lone_druid/lone_druid_savage_roar_debuff.vpcf"
end
function modifier_item_gang_plane_ticket:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end