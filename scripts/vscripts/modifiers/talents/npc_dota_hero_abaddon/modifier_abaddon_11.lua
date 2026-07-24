--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_abaddon_11=class({})

function modifier_abaddon_11:IsHidden() return true end
function modifier_abaddon_11:IsPurgable() return false end
function modifier_abaddon_11:IsPurgeException() return false end
function modifier_abaddon_11:RemoveOnDeath() return false end

function modifier_abaddon_11:OnCreated()
    self.bonus = {5,10,15}
    self.bonus2 = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_abaddon_11:OnRefresh()
    self.bonus = {5,10,15}
    self.bonus2 = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_abaddon_11:DeclareFunctions()
	return
	{
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_abaddon_11:OnTakeDamage(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent() == params.unit then return end
    if params.unit:IsBuilding() then return end
    if params.damage <= 0 then return end
    if params.unit:IsIllusion() then return end
    if params.inflictor ~= nil and not self:GetParent():IsIllusion() and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION then 
    	local bonus_percentage = 0
        for _, mod in pairs(self:GetParent():FindAllModifiers()) do
            if mod.GetModifierSpellLifestealRegenAmplify_Percentage and mod:GetModifierSpellLifestealRegenAmplify_Percentage() then
                bonus_percentage = bonus_percentage + mod:GetModifierSpellLifestealRegenAmplify_Percentage()
            end
        end    
        local heal = self.bonus[self:GetStackCount()] / 100 * params.damage
        heal = heal * (bonus_percentage / 100 + 1)
        self:GetParent():Heal(heal, params.inflictor)
        local octarine = ParticleManager:CreateParticle( "particles/items3_fx/octarine_core_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.attacker )
		ParticleManager:ReleaseParticleIndex( octarine )
    end
end

function modifier_abaddon_11:GetModifierSpellAmplify_Percentage()
    return self.bonus2[self:GetStackCount()]
end