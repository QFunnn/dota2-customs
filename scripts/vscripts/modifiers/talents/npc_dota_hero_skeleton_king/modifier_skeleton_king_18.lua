--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_king_18_buff", "modifiers/talents/npc_dota_hero_skeleton_king/modifier_skeleton_king_18", LUA_MODIFIER_MOTION_NONE)

modifier_skeleton_king_18=class({})

function modifier_skeleton_king_18:IsHidden() return true end
function modifier_skeleton_king_18:IsPurgable() return false end
function modifier_skeleton_king_18:IsPurgeException() return false end
function modifier_skeleton_king_18:RemoveOnDeath() return false end

function modifier_skeleton_king_18:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_skeleton_king_18:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_skeleton_king_18:IsAura()
    return true
end

function modifier_skeleton_king_18:GetModifierAura()
    return "modifier_skeleton_king_18_buff"
end

function modifier_skeleton_king_18:IsAuraActiveOnDeath()
    return true
end

function modifier_skeleton_king_18:GetAuraRadius()
    return -1
end

function modifier_skeleton_king_18:GetAuraDuration()
    return 0
end

function modifier_skeleton_king_18:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_skeleton_king_18:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_skeleton_king_18:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

function modifier_skeleton_king_18:GetAuraEntityReject(hTarget)
    if not IsServer() then return end
    if hTarget:IsRealHero() and not hTarget:IsIllusion() then
        return true
    end
    if hTarget:GetOwner() == self:GetCaster() then
        return false
    end
    local modifier_illusion = hTarget:FindModifierByName("modifier_illusion")
    if modifier_illusion and modifier_illusion:GetCaster() == self:GetCaster() then
        return false
    end
    return true
end

modifier_skeleton_king_18_buff = class({})

function modifier_skeleton_king_18_buff:GetTexture()
    return "modifier_skeleton_king_18"
end

function modifier_skeleton_king_18_buff:OnCreated()
    self.bonus = {1,2,3}
    self.per_bonus = 2
end

function modifier_skeleton_king_18_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_skeleton_king_18_buff:GetModifierDamageOutgoing_Percentage()
    if IsClient() then return end
    return self.bonus[self:GetCaster():GetTalentLevel("modifier_skeleton_king_18")] * ((self:GetAuraOwner():GetSpellAmplification(false) * 100) / self.per_bonus)
end