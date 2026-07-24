--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wisp_11_buff", "modifiers/talents/npc_dota_hero_wisp/modifier_wisp_11", LUA_MODIFIER_MOTION_NONE)

modifier_wisp_11=class({})

function modifier_wisp_11:IsHidden() return true end
function modifier_wisp_11:IsPurgable() return false end
function modifier_wisp_11:IsPurgeException() return false end
function modifier_wisp_11:RemoveOnDeath() return false end

function modifier_wisp_11:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_wisp_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_wisp_11:IsAura()
    return true
end

function modifier_wisp_11:GetModifierAura()
    return "modifier_wisp_11_buff"
end

function modifier_wisp_11:IsAuraActiveOnDeath()
    return true
end

function modifier_wisp_11:GetAuraRadius()
    return -1
end

function modifier_wisp_11:GetAuraDuration()
    return 0
end

function modifier_wisp_11:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_wisp_11:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_wisp_11:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

function modifier_wisp_11:GetAuraEntityReject(hTarget)
    if not IsServer() then return end
    if hTarget == self:GetCaster() then
        return false
    end
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

modifier_wisp_11_buff = class({})
function modifier_wisp_11_buff:IsPurgable() return false end
function modifier_wisp_11_buff:IsPurgeException() return false end
function modifier_wisp_11_buff:IsHidden() return true end
function modifier_wisp_11_buff:OnCreated()
    self.bonus = {15,30}
    self.damage = 50
    self.radius = 250
end
function modifier_wisp_11_buff:DeclareFunctions()
    return
    {
         
    }
end

function modifier_wisp_11_buff:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if RollPercentage(self.bonus[self:GetCaster():GetTalentLevel("modifier_wisp_11")]) then
        local units = FindUnitsInRadius(params.attacker:GetTeamNumber(), params.target:GetOrigin(), nil, self:GetCaster():GetAoeBonus(self.radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
        for _,unit in pairs(units) do
            ApplyDamage({ victim = unit, attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL })
        end
        local particle = ParticleManager:CreateParticle("particles/wisp_custom/attack_explosion.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, params.target:GetOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        EmitSoundOn("Hero_Wisp.Spirits.Target", params.target)
    end
end