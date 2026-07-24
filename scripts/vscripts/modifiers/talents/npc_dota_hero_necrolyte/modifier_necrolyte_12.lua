--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_necrolyte_12_debuff", "modifiers/talents/npc_dota_hero_necrolyte/modifier_necrolyte_12", LUA_MODIFIER_MOTION_NONE)

modifier_necrolyte_12=class({})

function modifier_necrolyte_12:IsHidden() return true end
function modifier_necrolyte_12:IsPurgable() return false end
function modifier_necrolyte_12:IsPurgeException() return false end
function modifier_necrolyte_12:RemoveOnDeath() return false end

function modifier_necrolyte_12:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local necrolyte_reapers_scythe_custom = self:GetCaster():FindAbilityByName("necrolyte_reapers_scythe_custom")
    if necrolyte_reapers_scythe_custom then
        necrolyte_reapers_scythe_custom:SetActivated(false)
        necrolyte_reapers_scythe_custom:SetHidden(true)
    end
end

function modifier_necrolyte_12:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local necrolyte_reapers_scythe_custom = self:GetCaster():FindAbilityByName("necrolyte_reapers_scythe_custom")
    if necrolyte_reapers_scythe_custom then
        necrolyte_reapers_scythe_custom:SetActivated(false)
        necrolyte_reapers_scythe_custom:SetHidden(true)
    end
end

function modifier_necrolyte_12:DeclareFunctions()
    return
    {
         
    }
end

function modifier_necrolyte_12:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target == self:GetParent() then return end
    if RollPercentage(33) then
        params.target:AddNewModifier(self:GetCaster(), nil, "modifier_necrolyte_12_debuff", {duration = 1})
    end
end

modifier_necrolyte_12_debuff = class({})
function modifier_necrolyte_12_debuff:IsPurgable() return false end
function modifier_necrolyte_12_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_necrolyte_12_debuff:GetTexture()
    return "necrolyte_12"
end
function modifier_necrolyte_12_debuff:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/necrolyte_scythe_start_custom.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_necrolyte_12_debuff:OnDestroy()
    if not IsServer() then return end
    local agility_damage = {50,75,100}
    local necrolyte_reapers_scythe_custom = self:GetCaster():FindAbilityByName("necrolyte_reapers_scythe_custom")
    local damage = self:GetCaster():GetAgility() / 100 * agility_damage[self:GetCaster():GetTalentLevel("modifier_necrolyte_12")]
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = necrolyte_reapers_scythe_custom})
    self:GetParent():EmitSound("Hero_Necrolyte.ProjectileImpact")
end