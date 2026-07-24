--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_king_20_debuff", "modifiers/talents/npc_dota_hero_skeleton_king/modifier_skeleton_king_20", LUA_MODIFIER_MOTION_NONE)

modifier_skeleton_king_20=class({})

function modifier_skeleton_king_20:IsHidden() return true end
function modifier_skeleton_king_20:IsPurgable() return false end
function modifier_skeleton_king_20:IsPurgeException() return false end
function modifier_skeleton_king_20:RemoveOnDeath() return false end

function modifier_skeleton_king_20:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_skeleton_king_20:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_skeleton_king_20:IsAura() return true end
function modifier_skeleton_king_20:GetAuraRadius() return 1200 end
function modifier_skeleton_king_20:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_skeleton_king_20:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_skeleton_king_20:GetModifierAura() return "modifier_skeleton_king_20_debuff" end
function modifier_skeleton_king_20:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE end

modifier_skeleton_king_20_debuff = class({})

function modifier_skeleton_king_20_debuff:OnCreated()
    self.bonus = {-6,-12,-18}
end

function modifier_skeleton_king_20_debuff:GetTexture() return "modifier_skeleton_king_20" end

function modifier_skeleton_king_20_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
end
function modifier_skeleton_king_20_debuff:GetModifierPropertyRestorationAmplification()
    return self.bonus[self:GetCaster():GetTalentLevel("modifier_skeleton_king_20")]
end