--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_soulguard_custom", "abilities/items/item_soulguard_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_soulguard_custom_reflect", "abilities/items/item_soulguard_custom", LUA_MODIFIER_MOTION_NONE)

item_soulguard_custom = class({})

function item_soulguard_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items/soulguard_active.vpcf", context )
PrecacheResource( "particle","particles/items/soulguard_active_heal.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queenofpain_return.vpcf", context )
end

function item_soulguard_custom:GetIntrinsicModifierName()
return "modifier_item_soulguard_custom"
end

function item_soulguard_custom:OnSpellStart()
local caster = self:GetCaster()

caster:EmitSound("Item.Soulguard_active")
caster:EmitSound("Item.Soulguard_active2")
caster:AddNewModifier(caster, self, "modifier_item_soulguard_custom_reflect", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_soulguard_custom = class(mod_hidden)
function modifier_item_soulguard_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
}
end

function modifier_item_soulguard_custom:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_item_soulguard_custom:GetModifierBonusStats_Strength()
return self.bonus_strength
end

function modifier_item_soulguard_custom:GetModifierPhysicalArmorBonus()
return self.bonus_armor
end

function modifier_item_soulguard_custom:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength")
 
self.passive_reflect = self.ability:GetSpecialValueFor("passive_reflection_pct")/100
self.active_reflect = self.ability:GetSpecialValueFor("active_reflection")/100
self.const_reflect = self.ability:GetSpecialValueFor("passive_reflection_constant")

if self.parent:IsRealHero() then 
    self.parent:AddDamageEvent_inc(self, true)
end 

end

function modifier_item_soulguard_custom:DamageEvent_inc(params)
if not IsServer() then return end
if not IsValid(self.ability) then return end
if params.unit ~= self.parent then return end
if not params.attacker:IsUnit() then return end
if not self.parent:IsRealHero() then return end
if params.attacker == self.parent then return end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end

local target = params.attacker
local real_damage = params.damage
local original_damage = params.original_damage

local damage = 0
if not params.inflictor then
    damage = self.const_reflect
end

local mod = self.parent:FindModifierByName("modifier_item_soulguard_custom_reflect")
if mod then
    damage = damage + original_damage*self.active_reflect
    if target:IsRealHero() then 
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(target:GetPlayerOwnerID()), "generic_sound",  {sound = "DOTA_Item.BladeMail.Damage"})
    end
    local heal = real_damage
    mod:SetStackCount(mod:GetStackCount() + heal)

    local caster_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_queenofpain/queenofpain_return.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(caster_pfx, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(caster_pfx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(caster_pfx)
end

if damage <= 0 then return end
DoDamage({victim = target, attacker = self.parent, damage = damage, damage_type = params.damage_type, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_REFLECTION, ability = self.ability})
end



modifier_item_soulguard_custom_reflect = class(mod_visible)
function modifier_item_soulguard_custom_reflect:GetEffectName() return "particles/items/soulguard_active.vpcf" end
function modifier_item_soulguard_custom_reflect:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.active_mana = self.ability:GetSpecialValueFor("active_mana")/100
self.active_heal = self.ability:GetSpecialValueFor("active_heal")/100

if not IsServer() then return end
self:SetStackCount(self.ability:GetSpecialValueFor("AbilityHealthCost")*self.ability:GetSpecialValueFor("active_heal")/100)
end

function modifier_item_soulguard_custom_reflect:OnDestroy()
if not IsServer() then return end
if not IsValid(self.ability) then return end
if not self.parent:IsAlive() then return end
if self:GetStackCount() == 0 then return end

self.parent:GenericParticle("particles/items/soulguard_active_heal.vpcf")
self.parent:GenericHeal(self:GetStackCount()*self.active_heal, self.ability, false, "")
self.parent:GiveMana(self:GetStackCount()*self.active_mana)
self.parent:SendNumber(OVERHEAD_ALERT_MANA_ADD, self:GetStackCount()*self.active_mana)

self.parent:EmitSound("Item.BM_heal")
end

function modifier_item_soulguard_custom_reflect:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
}
end

function modifier_item_soulguard_custom_reflect:GetModifierPercentageManacostStacking(params)
return 100
end
