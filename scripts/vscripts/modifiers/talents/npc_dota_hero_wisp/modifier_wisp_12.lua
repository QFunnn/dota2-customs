--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wisp_12_buff", "modifiers/talents/npc_dota_hero_wisp/modifier_wisp_12", LUA_MODIFIER_MOTION_NONE)

modifier_wisp_12=class({})

function modifier_wisp_12:IsHidden() return true end
function modifier_wisp_12:IsPurgable() return false end
function modifier_wisp_12:IsPurgeException() return false end
function modifier_wisp_12:RemoveOnDeath() return false end

function modifier_wisp_12:OnCreated()
    self.bonus2={5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_wisp_12:OnRefresh()
    self.bonus2={5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_wisp_12:IsAura()
    return true
end

function modifier_wisp_12:GetModifierAura()
    return "modifier_wisp_12_buff"
end

function modifier_wisp_12:IsAuraActiveOnDeath()
    return true
end

function modifier_wisp_12:GetAuraRadius()
    return -1
end

function modifier_wisp_12:GetAuraDuration()
    return 0
end

function modifier_wisp_12:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_wisp_12:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_wisp_12:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

function modifier_wisp_12:GetAuraEntityReject(hTarget)
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

function modifier_wisp_12:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
    }
end

function modifier_wisp_12:GetModifierBonusStats_Strength()
    return self.bonus2[self:GetStackCount()]
end

modifier_wisp_12_buff = class({})

function modifier_wisp_12_buff:GetTexture()
    return "wisp_12"
end

function modifier_wisp_12_buff:OnCreated()
    self.bonus = {-20,-40}
end

function modifier_wisp_12_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_wisp_12_buff:GetModifierIncomingDamage_Percentage()
    return self.bonus[self:GetCaster():GetTalentLevel("modifier_wisp_12")]
end
