--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_king_21_buff", "modifiers/talents/npc_dota_hero_skeleton_king/modifier_skeleton_king_21", LUA_MODIFIER_MOTION_NONE)

modifier_skeleton_king_21=class({})

function modifier_skeleton_king_21:IsHidden() return true end
function modifier_skeleton_king_21:IsPurgable() return false end
function modifier_skeleton_king_21:IsPurgeException() return false end
function modifier_skeleton_king_21:RemoveOnDeath() return false end

function modifier_skeleton_king_21:OnCreated()
    self.bonus = 500
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_skeleton_king_21:OnRefresh()
    self.bonus = 500
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_skeleton_king_21:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MANA_BONUS
    }
end

function modifier_skeleton_king_21:GetModifierManaBonus()
    return self.bonus
end

function modifier_skeleton_king_21:IsAuraActiveOnDeath()
    return true
end

function modifier_skeleton_king_21:IsAura()
    return true
end

function modifier_skeleton_king_21:GetModifierAura()
    return "modifier_skeleton_king_21_buff"
end

function modifier_skeleton_king_21:GetAuraRadius()
    return -1
end

function modifier_skeleton_king_21:GetAuraDuration()
    return 0
end

function modifier_skeleton_king_21:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_skeleton_king_21:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_skeleton_king_21:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

function modifier_skeleton_king_21:GetAuraEntityReject(hTarget)
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

modifier_skeleton_king_21_buff = class({})

function modifier_skeleton_king_21_buff:GetTexture()
    return "modifier_skeleton_king_21"
end

function modifier_skeleton_king_21_buff:CheckState()
    return
    {
        [MODIFIER_STATE_CANNOT_MISS] = true
    }
end