--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_witch_doctor_voodoo_switcheroo_lua", "heroes/hero_witch_doctor/witch_doctor_voodoo_switcheroo_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_witch_doctor_death_ward_lua", "heroes/hero_witch_doctor/witch_doctor_death_ward_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_witch_doctor_voodoo_switcheroo_lua_ward", "heroes/hero_witch_doctor/witch_doctor_voodoo_switcheroo_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if witch_doctor_voodoo_switcheroo_lua == nil then
	witch_doctor_voodoo_switcheroo_lua = class({})
end
function witch_doctor_voodoo_switcheroo_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	hCaster:AddNewModifier(hCaster, self, "modifier_witch_doctor_voodoo_switcheroo_lua", { duration = duration })

	if IsValid(self.hWard) then
		self.hWard:RemoveModifierByName("modifier_witch_doctor_death_ward_lua")
	end

	local hAbility = hCaster:FindAbilityByName("witch_doctor_death_ward_lua")
	if IsValid(hAbility) and hAbility:GetLevel() > 0 then
		local damage = hAbility:GetSpecialValueFor("damage")

		self.hWard = CreateUnitByName("npc_dota_witch_doctor_death_ward", hCaster:GetAbsOrigin(), true, hCaster, hCaster, hCaster:GetTeamNumber())
		self.hWard:SetControllableByPlayer(hCaster:GetPlayerOwnerID(), false)
		self.hWard:SetBaseDamageMin(damage)
		self.hWard:SetBaseDamageMax(damage)
		self.hWard:EmitSound("Hero_WitchDoctor.Death_WardBuild")
		self.hWard:AddNewModifier(hCaster, hAbility, "modifier_witch_doctor_death_ward_lua", { duration = duration })
		self.hWard:AddNewModifier(hCaster, self, "modifier_witch_doctor_voodoo_switcheroo_lua_ward", { duration = duration })
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_witch_doctor_voodoo_switcheroo_lua == nil then
	modifier_witch_doctor_voodoo_switcheroo_lua = class({})
end
function modifier_witch_doctor_voodoo_switcheroo_lua:IsHidden()
	return false
end
function modifier_witch_doctor_voodoo_switcheroo_lua:IsDebuff()
	return false
end
function modifier_witch_doctor_voodoo_switcheroo_lua:IsPurgable()
	return false
end
function modifier_witch_doctor_voodoo_switcheroo_lua:IsPurgeException()
	return false
end
function modifier_witch_doctor_voodoo_switcheroo_lua:OnCreated(params)
	if IsServer() then
		self:GetParent():AddNoDraw()
	end
end
function modifier_witch_doctor_voodoo_switcheroo_lua:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_witch_doctor_voodoo_switcheroo_lua:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveNoDraw()
	end
end
function modifier_witch_doctor_voodoo_switcheroo_lua:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		-- [MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_MUTED] = true,
	}
end
---------------------------------------------------------------------
--Modifiers
if modifier_witch_doctor_voodoo_switcheroo_lua_ward == nil then
	modifier_witch_doctor_voodoo_switcheroo_lua_ward = class({})
end
function modifier_witch_doctor_voodoo_switcheroo_lua_ward:IsHidden()
	return true
end
function modifier_witch_doctor_voodoo_switcheroo_lua_ward:IsDebuff()
	return false
end
function modifier_witch_doctor_voodoo_switcheroo_lua_ward:IsPurgable()
	return false
end
function modifier_witch_doctor_voodoo_switcheroo_lua_ward:IsPurgeException()
	return false
end
function modifier_witch_doctor_voodoo_switcheroo_lua_ward:OnCreated(params)
	self.attack_speed_reduction = self:GetAbilitySpecialValueFor("attack_speed_reduction")
end
function modifier_witch_doctor_voodoo_switcheroo_lua_ward:OnRefresh(params)
	self.attack_speed_reduction = self:GetAbilitySpecialValueFor("attack_speed_reduction")
end
function modifier_witch_doctor_voodoo_switcheroo_lua_ward:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end
function modifier_witch_doctor_voodoo_switcheroo_lua_ward:GetModifierAttackSpeedBonus_Constant()
	return -self.attack_speed_reduction
end