--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lizard_frenzy", "abilities/neutral_lizard_frenzy", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lizard_frenzy_buff", "abilities/neutral_lizard_frenzy", LUA_MODIFIER_MOTION_NONE)




neutral_lizard_frenzy = class({})

function neutral_lizard_frenzy:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end  
return "modifier_lizard_frenzy" 
end 


modifier_lizard_frenzy = class({})

function modifier_lizard_frenzy:IsPurgable() return false end

function modifier_lizard_frenzy:IsHidden() return true end

function modifier_lizard_frenzy:OnCreated(table)
if not IsServer() then return end
self.duration = self:GetAbility():GetSpecialValueFor("duration")
self.aoe = self:GetAbility():GetSpecialValueFor("aoe")
end



function modifier_lizard_frenzy:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
end

self:GetParent():AddNewModifier(self.parent, self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.3, anim = ACT_DOTA_CAST_ABILITY_1, parent_mod = self:GetName()})
end



function modifier_lizard_frenzy:EndCast()
if not IsServer() then return end

self:GetParent():EmitSound("n_creep_Thunderlizard_Big.Roar")

local targets = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.aoe, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,  DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

for _,target in pairs(targets) do  
  target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_lizard_frenzy_buff", {duration = self.duration})
end

end




modifier_lizard_frenzy_buff = class({})

function modifier_lizard_frenzy_buff:IsHidden() return false end
function modifier_lizard_frenzy_buff:IsPurgable() return true end

function modifier_lizard_frenzy_buff:OnCreated(table)

self.parent = self:GetParent()
self.parent:AddDamageEvent_out(self, true)

self.heal = self:GetAbility():GetSpecialValueFor("heal")/100
self.speed = self:GetAbility():GetSpecialValueFor("speed")
end

function modifier_lizard_frenzy_buff:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}

end

function modifier_lizard_frenzy_buff:DamageEvent_out(params)
if not IsServer() then return end
if self:GetParent() ~= params.attacker then return end
if params.inflictor ~= nil then return end
if params.unit:IsBuilding() then return end
 
self:GetParent():GenericHeal(params.damage*self.heal, self:GetAbility())
end

function modifier_lizard_frenzy_buff:GetEffectName() return "particles/neutral_fx/thunder_lizard_frenzy.vpcf" end

function modifier_lizard_frenzy_buff:GetModifierAttackSpeedBonus_Constant() 
return self.speed
end



