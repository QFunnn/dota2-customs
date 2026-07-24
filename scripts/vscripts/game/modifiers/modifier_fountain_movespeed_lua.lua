--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_fountain_movespeed_lua = modifier_fountain_movespeed_lua or class({})
LinkLuaModifier("modifier_fountain_movespeed_effect_lua", "game/modifiers/modifier_fountain_movespeed_lua", LUA_MODIFIER_MOTION_NONE)

function modifier_fountain_movespeed_lua:IsHidden() return false end
function modifier_fountain_movespeed_lua:IsAura() return true end
function modifier_fountain_movespeed_lua:IsPurgable() return false end
function modifier_fountain_movespeed_lua:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end


function modifier_fountain_movespeed_lua:IsAura() return true end
function modifier_fountain_movespeed_lua:GetAuraRadius() return 994 end		-- tower attack range + DOTA_HULL_SIZE_TOWER = 850 + 144 = 994
function modifier_fountain_movespeed_lua:GetAuraDuration() return self:GetStackCount() end		-- difference between fountain movespeed and rejuvenation
function modifier_fountain_movespeed_lua:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_fountain_movespeed_lua:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_fountain_movespeed_lua:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_fountain_movespeed_lua:GetModifierAura() return "modifier_fountain_movespeed_effect_lua" end

function modifier_fountain_movespeed_lua:OnCreated()
	self:SetStackCount(4)
end

modifier_fountain_movespeed_effect_lua = modifier_fountain_movespeed_effect_lua or class({})


function modifier_fountain_movespeed_effect_lua:GetTexture() return "kobold_taskmaster_speed_aura" end

function modifier_fountain_movespeed_effect_lua:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_fountain_movespeed_effect_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, -- GetModifierMoveSpeedBonus_Percentage
	}
end

modifier_fountain_movespeed_effect_lua.restrict_movespeed_buff_by_modifier_name = {
	"modifier_spirit_breaker_charge_of_darkness",
}


function modifier_fountain_movespeed_effect_lua:GetModifierMoveSpeedBonus_Percentage()
	for _, modifier_name in pairs(self.restrict_movespeed_buff_by_modifier_name) do
		if self:GetParent():HasModifier(modifier_name) then return 0 end
	end

	return 50
end