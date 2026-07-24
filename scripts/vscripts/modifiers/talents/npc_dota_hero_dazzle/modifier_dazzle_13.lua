--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dazzle_13=class({})

function modifier_dazzle_13:IsHidden() return true end
function modifier_dazzle_13:IsPurgable() return false end
function modifier_dazzle_13:IsPurgeException() return false end
function modifier_dazzle_13:RemoveOnDeath() return false end

function modifier_dazzle_13:OnCreated()
	self.bonus={7,14,21}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_dazzle_13:OnRefresh()
	self.bonus={7,14,21}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_dazzle_13:OnTakeDamage(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent() == params.unit then return end
    if params.unit:IsBuilding() then return end
    if params.damage <= 0 then return end
    if not self:GetParent():HasModifier("modifier_dazzle_nothl_projection_soul_clone") then return end
    if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
        if (params.inflictor == nil or (params.inflictor and params.inflictor:GetName() == "windrunner_focusfire_whirlwind")) and not self:GetParent():IsIllusion() and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION then 
            local heal = self.bonus[self:GetStackCount()] / 100 * params.damage
            local original_hero = self:GetParent().original_dazzle_hero
            original_hero:Heal(heal, nil)
            local effect_cast = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, original_hero)
            ParticleManager:ReleaseParticleIndex( effect_cast )
        end
    else
        if params.damage_type == DAMAGE_TYPE_PURE then return end
        if params.inflictor ~= nil and not self:GetParent():IsIllusion() and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION then 
            local bonus_percentage = 0
            for _, mod in pairs(self:GetParent():FindAllModifiers()) do
                if mod.GetModifierSpellLifestealRegenAmplify_Percentage and mod:GetModifierSpellLifestealRegenAmplify_Percentage() then
                    bonus_percentage = bonus_percentage + mod:GetModifierSpellLifestealRegenAmplify_Percentage()
                end
            end    
            local heal = self.bonus[self:GetStackCount()] / 100 * params.damage
            heal = heal * (bonus_percentage / 100 + 1)
            local original_hero = self:GetParent().original_dazzle_hero
            original_hero:Heal(heal, params.inflictor)
            local octarine = ParticleManager:CreateParticle( "particles/items3_fx/octarine_core_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, original_hero)
            ParticleManager:ReleaseParticleIndex( octarine )
        end
    end
end