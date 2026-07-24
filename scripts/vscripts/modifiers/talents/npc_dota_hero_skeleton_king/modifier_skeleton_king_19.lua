--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_king_19_buff", "modifiers/talents/npc_dota_hero_skeleton_king/modifier_skeleton_king_19", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skeleton_king_19_debuff", "modifiers/talents/npc_dota_hero_skeleton_king/modifier_skeleton_king_19", LUA_MODIFIER_MOTION_NONE)

modifier_skeleton_king_19=class({})

function modifier_skeleton_king_19:IsHidden() return true end
function modifier_skeleton_king_19:IsPurgable() return false end
function modifier_skeleton_king_19:IsPurgeException() return false end
function modifier_skeleton_king_19:RemoveOnDeath() return false end

function modifier_skeleton_king_19:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_skeleton_king_19:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_skeleton_king_19:IsAura()
    return true
end

function modifier_skeleton_king_19:GetModifierAura()
    return "modifier_skeleton_king_19_buff"
end

function modifier_skeleton_king_19:GetAuraRadius()
    return -1
end

function modifier_skeleton_king_19:GetAuraDuration()
    return 0
end

function modifier_skeleton_king_19:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_skeleton_king_19:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_skeleton_king_19:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

function modifier_skeleton_king_19:GetAuraEntityReject(hTarget)
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

modifier_skeleton_king_19_buff = class({})

function modifier_skeleton_king_19_buff:GetTexture()
    return "modifier_skeleton_king_19"
end

function modifier_skeleton_king_19_buff:OnCreated()
    self.duration = 4
end

function modifier_skeleton_king_19_buff:DeclareFunctions()
    return
    {
         
    }
end

function modifier_skeleton_king_19_buff:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    params.target:AddNewModifier(self:GetCaster(), nil, "modifier_skeleton_king_19_debuff", {duration = self.duration})
end

modifier_skeleton_king_19_debuff = class({})

function modifier_skeleton_king_19_debuff:GetTexture()
    return "modifier_skeleton_king_19"
end

function modifier_skeleton_king_19_debuff:OnCreated()
    self.slow = -20
end

function modifier_skeleton_king_19_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_skeleton_king_19_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.slow
end