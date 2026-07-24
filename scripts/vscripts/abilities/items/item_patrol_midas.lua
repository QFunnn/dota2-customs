--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_patrol_midas = class({})

function item_patrol_midas:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/hand_of_midas.vpcf", context )
end

function item_patrol_midas:CastFilterResultTarget(target)
  if IsServer() then
    local caster = self:GetCaster()

    if target:HasModifier("modifier_waveupgrade_boss") or target:GetUnitName() == "npc_roshan_custom" or dota1x6:IsPatrol(target:GetUnitName()) then 
      return UF_FAIL_OTHER
    end


    return UnitFilter( target, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
  end
end



function item_patrol_midas:OnSpellStart()
if not IsServer() then return end

self:GetCaster():EmitSound("DOTA_Item.Hand_Of_Midas")

local bonus_gold = self:GetSpecialValueFor("gold")
self:GetCaster():ModifyGoldFiltered(bonus_gold , true , DOTA_ModifyGold_CreepKill)
self:GetCaster():SendNumber(0, bonus_gold)


dota1x6:AddBluePoints(self:GetCaster(), self:GetSpecialValueFor("blue"))

local item_effect = ParticleManager:CreateParticle( "particles/items2_fx/hand_of_midas.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCursorTarget())
ParticleManager:SetParticleControl( item_effect, 0, self:GetCursorTarget():GetAbsOrigin() )
ParticleManager:SetParticleControlEnt(item_effect, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin(), true )
  
ParticleManager:ReleaseParticleIndex(item_effect)

self:GetCursorTarget():Kill(self, self:GetCaster())
self:SpendCharge(0)
end

