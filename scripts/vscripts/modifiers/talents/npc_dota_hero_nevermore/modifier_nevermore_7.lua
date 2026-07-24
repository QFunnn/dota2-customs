--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nevermore_7_aura", "modifiers/talents/npc_dota_hero_nevermore/modifier_nevermore_7", LUA_MODIFIER_MOTION_NONE)

modifier_nevermore_7=class({})

function modifier_nevermore_7:IsHidden() return true end
function modifier_nevermore_7:IsPurgable() return false end
function modifier_nevermore_7:IsPurgeException() return false end
function modifier_nevermore_7:RemoveOnDeath() return false end

function modifier_nevermore_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end

function modifier_nevermore_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_nevermore_7:IsAura() return true end
function modifier_nevermore_7:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_nevermore_7:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_nevermore_7:GetAuraDuration() return 0.1 end
function modifier_nevermore_7:GetModifierAura()
    return "modifier_nevermore_7_aura"
end
function modifier_nevermore_7:GetAuraRadius()
    return 700
end

modifier_nevermore_7_aura = class({})
function modifier_nevermore_7_aura:GetTexture() return "nevermore_7" end
function modifier_nevermore_7_aura:IsPurgable() return false end
function modifier_nevermore_7_aura:IsPurgeException() return false end
function modifier_nevermore_7_aura:DeclareFunctions()
    return
    {
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
    }
end

function modifier_nevermore_7_aura:GetModifierPropertyRestorationAmplification()
	return ((100 - self:GetCaster():GetHealthPercent()) / 3) * -1
end