--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_broodmother_spin_web_web_lua_buff", "heroes/hero_broodmother/modifier_broodmother_spin_web_web_lua.lua", LUA_MODIFIER_MOTION_NONE)
modifier_broodmother_spin_web_web_lua = class({})

function modifier_broodmother_spin_web_web_lua:IsHidden()
	return true
end
function modifier_broodmother_spin_web_web_lua:IsDebuff()
	return false
end
function modifier_broodmother_spin_web_web_lua:IsPurgable()
	return false
end
function modifier_broodmother_spin_web_web_lua:IsPurgeException()
	return false
end
function modifier_broodmother_spin_web_web_lua:IsAura()
	return true
end
function modifier_broodmother_spin_web_web_lua:GetAuraRadius()
	return self.radius
end
function modifier_broodmother_spin_web_web_lua:GetAuraSearchFlags()
	return true
end
function modifier_broodmother_spin_web_web_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_broodmother_spin_web_web_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_broodmother_spin_web_web_lua:GetModifierAura()
	return "modifier_broodmother_spin_web_web_lua_buff"
end
function modifier_broodmother_spin_web_web_lua:GetAuraEntityReject(unit)
	if GetUnitKeyValuesByName(unit:GetUnitName()).BaseClass == "npc_dota_broodmother_spiderling" or unit:IsRealHero() then
		return false
	else
		return true
	end
end
function modifier_broodmother_spin_web_web_lua:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end
function modifier_broodmother_spin_web_web_lua:OnRefresh(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end
function modifier_broodmother_spin_web_web_lua:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
--web buff---------
modifier_broodmother_spin_web_web_lua_buff = class({})

function modifier_broodmother_spin_web_web_lua_buff:IsHidden()
	return true
end
function modifier_broodmother_spin_web_web_lua_buff:IsDebuff()
	return false
end
function modifier_broodmother_spin_web_web_lua_buff:IsPurgable()
	return false
end
function modifier_broodmother_spin_web_web_lua_buff:IsPurgeException()
	return false
end
function modifier_broodmother_spin_web_web_lua_buff:OnCreated(kv)
	self.heath_regen = self:GetAbilitySpecialValueFor("heath_regen")
	self.bonus_movespeed = self:GetAbilitySpecialValueFor("bonus_movespeed")
	self.bonus_turn_rate = self:GetAbilitySpecialValueFor("bonus_turn_rate")
end
function modifier_broodmother_spin_web_web_lua_buff:OnRefresh(kv)
	self.heath_regen = self:GetAbilitySpecialValueFor("heath_regen")
	self.bonus_movespeed = self:GetAbilitySpecialValueFor("bonus_movespeed")
	self.bonus_turn_rate = self:GetAbilitySpecialValueFor("bonus_turn_rate")
end
function modifier_broodmother_spin_web_web_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_TURN_RATE_CONSTANT,
	}
end
function modifier_broodmother_spin_web_web_lua_buff:CheckState()
	return {
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_OBSTRUCTIONS] = true,
	}
end
function modifier_broodmother_spin_web_web_lua_buff:GetModifierTurnRateConstant()
	return self.bonus_turn_rate
end
function modifier_broodmother_spin_web_web_lua_buff:GetModifierConstantHealthRegen()
	return self.heath_regen
end
function modifier_broodmother_spin_web_web_lua_buff:GetModifierMoveSpeedBonus_Percentage()
	local hParent = self:GetParent()
	return self.bonus_movespeed * hParent:GetHealthPercent() * 0.01
end