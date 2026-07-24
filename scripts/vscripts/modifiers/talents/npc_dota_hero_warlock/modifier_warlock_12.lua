--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_12_buff", "modifiers/talents/npc_dota_hero_warlock/modifier_warlock_12", LUA_MODIFIER_MOTION_NONE)

modifier_warlock_12 = class({})
function modifier_warlock_12:IsHidden() return true end
function modifier_warlock_12:IsPurgable() return false end
function modifier_warlock_12:IsPurgeException() return false end
function modifier_warlock_12:RemoveOnDeath() return false end

function modifier_warlock_12:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_warlock_12:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_warlock_12:IsAura() return true end
function modifier_warlock_12:IsAuraActiveOnDeath() return false end
function modifier_warlock_12:GetAuraRadius() return 1200 end
function modifier_warlock_12:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end
function modifier_warlock_12:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_warlock_12:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_warlock_12:GetModifierAura()	return "modifier_warlock_12_buff" end
function modifier_warlock_12:GetAuraDuration() return 0 end

modifier_warlock_12_buff = class({})
function modifier_warlock_12_buff:GetTexture()
    return "warlock_12"
end
function modifier_warlock_12_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end
function modifier_warlock_12_buff:GetModifierMoveSpeedBonus_Constant()
    local speed = {30,60}
    return speed[self:GetCaster():GetTalentLevel("modifier_warlock_12")]
end

function modifier_warlock_12_buff:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end