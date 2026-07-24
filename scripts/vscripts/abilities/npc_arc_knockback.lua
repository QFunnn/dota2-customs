--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("npc_arc_knockback_passive", "abilities/npc_arc_knockback.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("npc_arc_knockback_passive2", "abilities/npc_arc_knockback.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_knockback_cd", "abilities/npc_arc_knockback.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_knockback", "abilities/npc_arc_knockback.lua", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_arc_knockback_buf", "abilities/npc_arc_knockback.lua", LUA_MODIFIER_MOTION_NONE)

npc_arc_knockback = class({})

function npc_arc_knockback:OnSpellStart()


    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_arc_knockback_cd", {duration = self:GetCooldownTimeRemaining()})

    self.knockback_duration     = 0.5
    self.knockback_distance     = self:GetSpecialValueFor("distance")
    self.duration     = self:GetSpecialValueFor("duration")
    self.radius     = 400
    self.caster = self:GetCaster()
    position = self.caster:GetAbsOrigin()
    self:GetCaster():EmitSound("Hero_KeeperOfTheLight.BlindingLight")
 
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_aoe.vpcf", PATTACH_POINT_FOLLOW,  self.caster)
    ParticleManager:SetParticleControl(particle, 0, position)
    ParticleManager:SetParticleControl(particle, 1, position)
    ParticleManager:SetParticleControl(particle, 2, Vector(self.radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(particle)

    local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), position, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
   
    for _, enemy in pairs(enemies) do
       
        
        enemy:FaceTowards(position * (-1))
        enemy:SetForwardVector((enemy:GetAbsOrigin() - position):Normalized())
        
        enemy:AddNewModifier(self.caster, self, "modifier_arc_knockback_buf", {duration = self.duration* (1 - enemy:GetStatusResistance()) })
        
        if enemy:HasModifier("modifier_arc_knockback") then
            enemy:FindModifierByName("modifier_arc_knockback"):Destroy()
        end
        
        enemy:AddNewModifier(self.caster, self, "modifier_arc_knockback", {pos =  position, duration = self.knockback_duration * (1 - enemy:GetStatusResistance())})
    end

end

modifier_arc_knockback = class({})
function modifier_arc_knockback:IsHidden() return true end

function modifier_arc_knockback:OnCreated(table)
    if not IsServer() then return end
    unit = self:GetParent()
    position = self:GetCaster():GetAbsOrigin()

         local distance = (unit:GetAbsOrigin() - position):Length2D()
            local direction = (unit:GetAbsOrigin() - position):Normalized()
            local bump_point = position - direction * (distance + 250)
            local knockbackProperties =
            {
                center_x = bump_point.x,
                center_y = bump_point.y,
                center_z = bump_point.z,
                duration = 0.5,
                knockback_duration = 0.5,
                knockback_distance = self:GetAbility():GetSpecialValueFor("distance"),
                knockback_height = 0
            }
                
            if not unit:HasModifier("modifier_knockback") then
                unit:AddNewModifier( unit, self, "modifier_knockback", knockbackProperties )
             end
end


function modifier_arc_knockback:OnDestroy()
if not IsServer() then return end
      local angel = self:GetParent():GetAbsOrigin()
  angel.z = 0.0
  angel = angel:Normalized()
self:GetParent():SetForwardVector(angel)
end




modifier_arc_knockback_buf = class({})

function modifier_arc_knockback_buf:IsHidden() return false end
function modifier_arc_knockback_buf:IsPurgable() return false end

function modifier_arc_knockback_buf:OnTooltip() return  self.slow end

function modifier_arc_knockback_buf:IsDebuff() return true end
function modifier_arc_knockback_buf:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
          MODIFIER_PROPERTY_TOOLTIP

}
end






function modifier_arc_knockback_buf:OnCreated(table)
    self.slow = -self:GetAbility():GetSpecialValueFor("slow")
end




function modifier_arc_knockback_buf:GetModifierMoveSpeedBonus_Percentage() return self.slow end





function npc_arc_knockback:GetIntrinsicModifierName() return "npc_arc_knockback_passive" end
 
npc_arc_knockback_passive = class ({})

function npc_arc_knockback_passive:IsHidden() return true end

function npc_arc_knockback_passive:OnCreated(table)
if not IsServer() then return end
self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "npc_arc_knockback_passive2" , {})
end

function npc_arc_knockback_passive:DeclareFunctions() return {

    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS

} end



function npc_arc_knockback_passive:GetActivityTranslationModifiers() return "walk" end



npc_arc_knockback_passive2 = class ({})

function npc_arc_knockback_passive2:IsHidden() return true end


function npc_arc_knockback_passive2:DeclareFunctions() return {

    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS

} end



function npc_arc_knockback_passive2:GetActivityTranslationModifiers() return "fast" end 


modifier_arc_knockback_cd = class({})

function modifier_arc_knockback_cd:IsHidden() return false end
function modifier_arc_knockback_cd:IsPurgable() return false end