--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("npc_arc_field_passive", "abilities/npc_arc_field.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("npc_arc_field_passive2", "abilities/npc_arc_field.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_field_cd", "abilities/npc_arc_field.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_field", "abilities/npc_arc_field.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_field_buf", "abilities/npc_arc_field.lua", LUA_MODIFIER_MOTION_NONE)

npc_arc_field = class({})

function npc_arc_field:OnSpellStart()
    self.duration = self:GetSpecialValueFor("duration")
    self:GetCaster():EmitSound("Hero_ArcWarden.MagneticField.Cast")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_arc_field_cd", {duration = self:GetCooldownTimeRemaining()})
    CreateModifierThinker(self:GetCaster(), self, "modifier_arc_field", {duration = self.duration}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)

end





modifier_arc_field = class({})

function modifier_arc_field:IsHidden() return true end

function modifier_arc_field:IsPurgable() return false end

function modifier_arc_field:IsAura() return true end

function modifier_arc_field:GetAuraDuration() return 0.1 end

function modifier_arc_field:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end

function modifier_arc_field:OnCreated(table)
    if not IsServer() then return end

    self.radius             = self:GetAbility():GetSpecialValueFor("radius")
    self.evasion     = self:GetAbility():GetSpecialValueFor("evasion")

    self:GetParent():EmitSound("Hero_ArcWarden.MagneticField")
self.magnetic_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.magnetic_particle, 1, Vector(self:GetAbility():GetSpecialValueFor("radius"), 1, 1))
    self:AddParticle(self.magnetic_particle, false, false, 1, false, false)


end    

function modifier_arc_field:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end

function modifier_arc_field:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end

function modifier_arc_field:GetModifierAura() return "modifier_arc_field_buf" end




modifier_arc_field_buf = class({})

function modifier_arc_field_buf:IsHidden() return false end
function modifier_arc_field_buf:IsPurgable() return false end
function modifier_arc_field_buf:DeclareFunctions() return 
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    MODIFIER_PROPERTY_TOOLTIP

} end


function modifier_arc_field_buf:OnTooltip() return self.speed end
function modifier_arc_field_buf:GetActivityTranslationModifiers() return "faster" end

function modifier_arc_field_buf:OnCreated()
    if self:GetAbility() then
        self.evasion = self:GetAbility():GetSpecialValueFor("evasion")
        self.speed = self:GetAbility():GetSpecialValueFor("speed")
    elseif self:GetAuraOwner() and self:GetAuraOwner():HasModifier("modifier_arc_field") then
        self.evasion = self:GetAuraOwner():FindModifierByName("modifier_arc_field").evasion
    else
        self:Destroy()
    end
end

function modifier_arc_field_buf:GetModifierAttackSpeedBonus_Constant() return self.speed end

function modifier_arc_field_buf:GetModifierIncomingDamage_Percentage(keys)
    if keys.attacker and self:GetAuraOwner() and self:GetAuraOwner():HasModifier("modifier_arc_field")
     and self:GetAuraOwner():FindModifierByName("modifier_arc_field").radius 
     and (keys.attacker:GetAbsOrigin() - self:GetAuraOwner():GetAbsOrigin()):Length2D() > self:GetAuraOwner():FindModifierByName("modifier_arc_field").radius then
        return -self.evasion
    end
end







function npc_arc_field:GetIntrinsicModifierName() return "npc_arc_field_passive" end
 
npc_arc_field_passive = class ({})

function npc_arc_field_passive:IsHidden() return true end

function npc_arc_field_passive:OnCreated(table)
if not IsServer() then return end
self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "npc_arc_field_passive2" , {})
end

function npc_arc_field_passive:DeclareFunctions() return {

    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS

} end



function npc_arc_field_passive:GetActivityTranslationModifiers() return "walk" end



npc_arc_field_passive2 = class ({})

function npc_arc_field_passive2:IsHidden() return true end


function npc_arc_field_passive2:DeclareFunctions() return {

    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS

} end



function npc_arc_field_passive2:GetActivityTranslationModifiers() return "fast" end 


modifier_arc_field_cd = class({})

function modifier_arc_field_cd:IsHidden() return false end
function modifier_arc_field_cd:IsPurgable() return false end