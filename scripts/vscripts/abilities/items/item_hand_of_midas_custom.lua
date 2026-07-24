--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_hand_of_midas_custom", "abilities/items/item_hand_of_midas_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_midas_noblue", "abilities/items/item_hand_of_midas_custom", LUA_MODIFIER_MOTION_NONE)


item_hand_of_midas_custom = class({})

function item_hand_of_midas_custom:GetAbilityTextureName()
    if self:GetCaster() then
        return wearables_system:GetAbilityIconReplacement(self.caster, "item_hand_of_midas", self)
    end
end


function item_hand_of_midas_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/hand_of_midas.vpcf", context )
end

function item_hand_of_midas_custom:GetIntrinsicModifierName()
	return "modifier_item_hand_of_midas_custom"
end

function item_hand_of_midas_custom:CastFilterResultTarget(target)
  if IsServer() then
    local caster = self:GetCaster()

    if target:GetTeamNumber() == DOTA_TEAM_CUSTOM_5 or target:IsAncient() or dota1x6:IsPatrol(target:GetUnitName()) or target.is_patrol_creep then
      return UF_FAIL_OTHER
    end


    return UnitFilter( target, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
  end
end



function item_hand_of_midas_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()
local gold = self:GetSpecialValueFor("gold")

self:GiveBonuses(target, false)

target:SetMinimumGoldBounty(0)
target:SetMaximumGoldBounty(0)

if (caster:GetQuest() == "General.Quest_5") then 
    caster:UpdateQuest(gold)
end
caster:GiveGold(gold, true)

local mod = caster:AddNewModifier(caster, self, "modifier_item_midas_noblue", {duration = 0.1})

self:GetCursorTarget():Kill(self, caster)
mod:Destroy()
end



function item_hand_of_midas_custom:GiveBonuses(target, givegold)
if not IsServer() then return end

local caster = self:GetCaster()
local duo_bonus = 1

if not IsSoloMode() then
    duo_bonus = self:GetSpecialValueFor("duo_bonus")
end

if givegold == true then 
    local bonus_gold = self:GetSpecialValueFor("gold")/duo_bonus
    if (caster:GetQuest() == "General.Quest_5")  then 
        caster:UpdateQuest(bonus_gold)
    end
    caster:GiveGold(bonus_gold, true)

    dota1x6:AddBluePoints(caster, self:GetSpecialValueFor("blue")/duo_bonus)
else
    local points = 0
    if BluePoints[target:GetUnitName()] then 
        points = BluePoints[target:GetUnitName()]*self:GetSpecialValueFor("blue_creeps")
    end
    dota1x6:AddBluePoints(caster, points)
end

caster:EmitSound("DOTA_Item.Hand_Of_Midas")

local name = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/items2_fx/hand_of_midas.vpcf", self)

local item_effect = ParticleManager:CreateParticle( name, PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:SetParticleControl( item_effect, 0, target:GetAbsOrigin() )
ParticleManager:SetParticleControlEnt(item_effect, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
ParticleManager:ReleaseParticleIndex(item_effect)
end




modifier_item_hand_of_midas_custom = class({})
function modifier_item_hand_of_midas_custom:IsHidden() return true end
function modifier_item_hand_of_midas_custom:IsPurgable() return false end
function modifier_item_hand_of_midas_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_hand_of_midas_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
}
end


function modifier_item_hand_of_midas_custom:GetModifierAttackSpeedBonus_Constant()
return self.speed 
end

function modifier_item_hand_of_midas_custom:GetModifierMoveSpeedBonus_Constant()
return self.move 
end

function modifier_item_hand_of_midas_custom:OnCreated(table)
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)

self.ability = self:GetAbility()

self.move = self.ability:GetSpecialValueFor("move_speed")
self.speed = self.ability:GetSpecialValueFor("attack_speed")
self.radius = self.ability:GetSpecialValueFor("radius")
end 


function modifier_item_hand_of_midas_custom:DeathEvent(params)
if not IsServer() then return end
if not self.parent:IsRealHero() then return end
if not self.ability then return end
if self.parent:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
if self ~= self.parent:FindAllModifiersByName(self:GetName())[1] then return end
if not params.unit:IsValidKill(self.parent) then return end
if self.parent:IsTempestDouble() then return end

local attacker = params.attacker 

if attacker.owner then 
    attacker = attacker.owner
end 

if ((self.parent:GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() > self.radius) and attacker ~= self:GetParent() then return end

self.ability:GiveBonuses(params.unit, true)
end




modifier_item_midas_noblue = class({})
function modifier_item_midas_noblue:IsHidden() return true end
function modifier_item_midas_noblue:IsPurgable() return false end