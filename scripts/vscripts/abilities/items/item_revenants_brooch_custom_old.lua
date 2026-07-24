--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_revenants_brooch_custom", "abilities/items/item_revenants_brooch_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_revenants_brooch_custom_counter", "abilities/items/item_revenants_brooch_custom", LUA_MODIFIER_MOTION_NONE)

item_revenants_brooch_custom = class({})

function item_revenants_brooch_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items3_fx/octarine_core_lifesteal.vpcf", context )
PrecacheResource( "particle","particles/items_fx/revenant_brooch_projectile.vpcf", context )
PrecacheResource( "particle","particles/items5_fx/revenant_brooch.vpcf", context )
end


function item_revenants_brooch_custom:GetIntrinsicModifierName()
return "modifier_revenants_brooch_custom"
end

function item_revenants_brooch_custom:GetManaCost(level)
if not self or not self:GetCaster() then return end
return self:GetCaster():GetMaxMana()*self:GetSpecialValueFor("manacost_per_hit")/100
end


function item_revenants_brooch_custom:GetAbilityTextureName()
if not self or not self:GetCaster() then return end 

if self:GetCaster():HasModifier("modifier_revenants_brooch_custom_counter") then
    return "item_revenants_brooch_active"
end
return "item_revenants_brooch"
end



function item_revenants_brooch_custom:OnToggle()
local caster = self:GetCaster()

if caster:HasModifier("modifier_revenants_brooch_custom_counter") then
    caster:RemoveModifierByName("modifier_revenants_brooch_custom_counter")
else
    caster:AddNewModifier(caster,self,"modifier_revenants_brooch_custom_counter", {})
    caster:EmitSound("Item.Brooch.Cast")
end

self:StartCooldown(0.5)
end



modifier_revenants_brooch_custom = class({})

function modifier_revenants_brooch_custom:IsHidden()
    return true
end

function modifier_revenants_brooch_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_revenants_brooch_custom:GetModifierPreAttack_BonusDamage()
    return self.bonus_damage
end



function modifier_revenants_brooch_custom:OnCreated()

self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
self.lifesteal = self:GetAbility():GetSpecialValueFor("spell_lifesteal")/100
self.lifesteal_creeps = self:GetAbility():GetSpecialValueFor("spell_lifesteal_creep")

if not IsServer() then return end 

self.parent = self:GetParent()
if self.parent:IsRealHero() then 
    self.parent:AddDamageEvent_out(self)
end 

end


function modifier_revenants_brooch_custom:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:CheckLifesteal(params, 1) then return end
if (params.unit:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 2000 then return end

local lifesteal = self.lifesteal*params.damage

if not params.unit:IsHero() then
    lifesteal = lifesteal/self.lifesteal_creeps
end

self.parent:GenericHeal(lifesteal, self:GetAbility(), true, "particles/items3_fx/octarine_core_lifesteal.vpcf")

end





modifier_revenants_brooch_custom_counter = class({})
function modifier_revenants_brooch_custom_counter:IsHidden() return false end
function modifier_revenants_brooch_custom_counter:IsPurgable() return false end

function modifier_revenants_brooch_custom_counter:OnCreated(params)

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.name = self.ability:GetName()

self.damage_reduce = self.ability:GetSpecialValueFor("damage_reduction")
self.health_cost = self.ability:GetSpecialValueFor("healthcost_per_hit")/100

if not IsServer() then return end
self.parent:AddNewModifier(self.parent, nil, "modifier_item_revenants_brooch_active", {})
self:StartIntervalThink(0.2)
end

function modifier_revenants_brooch_custom_counter:OnDestroy()
if not IsServer() then return end

self.parent:RemoveModifierByName("modifier_item_revenants_brooch_active")
end


function modifier_revenants_brooch_custom_counter:OnIntervalThink()
if not IsServer() then return end 

local item = self.parent:FindItemInInventory(self.name)

if not item or item:IsInBackpack() or self.parent:IsIllusion() then 
    self:Destroy()
    return
end 

end 


function modifier_revenants_brooch_custom_counter:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PROJECTILE_NAME,
    MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL,
    MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
}
end

function modifier_revenants_brooch_custom_counter:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end


function modifier_revenants_brooch_custom_counter:HasMana()
if IsClient() then
    return true
end

if self.parent:GetMaxMana() == 0 or self.parent:GetMana() >= self.ability:GetEffectiveManaCost(self.ability:GetLevel()) then 
    return true
else 
    return false
end

end


function modifier_revenants_brooch_custom_counter:GetModifierProjectileName()
if not self.ability then return "" end
if not self:HasMana() then return end

return "particles/items_fx/revenant_brooch_projectile.vpcf"
end


function modifier_revenants_brooch_custom_counter:GetOverrideAttackMagical()
if self.parent:IsIllusion() then return 0 end
if not self.ability then return 0 end
if not self:HasMana() then return 0 end
return 1
end

function modifier_revenants_brooch_custom_counter:GetModifierTotalDamageOutgoing_Percentage(params)
local parent = self.parent

if self.parent:IsIllusion() then return 0 end
if params.inflictor and params.inflictor:GetName() ~= "muerta_gunslinger_custom" then return 0 end
if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return 0 end
if params.damage_type == DAMAGE_TYPE_MAGICAL then return 0 end
if not self.ability then return 0 end
if parent:HasModifier("modifier_custom_juggernaut_blade_fury") then return 0 end

if not self:HasMana() then 
    self.ability:ToggleAbility()
    return 0 
end

if not params.no_attack_cooldown or parent:HasModifier("modifier_alchemist_chemical_rage_custom_legendary") then
    if parent:GetMaxMana() ~= 0 then 
        self.parent:SetMana(math.max(1, self.parent:GetMana() - self.ability:GetEffectiveManaCost(self.ability:GetLevel())))
    else 
        self.parent:SetHealth(math.max(1, self.parent:GetHealth() - self.parent:GetMaxHealth()*self.health_cost))
    end
end

local damageTable = {
    attacker = self.parent,
    damage = params.original_damage,
    damage_type = DAMAGE_TYPE_MAGICAL,
    victim = params.target,
    ability = self.ability,
    damage_flags = DOTA_DAMAGE_FLAG_MAGIC_AUTO_ATTACK
}
DoDamage(damageTable)

params.target:EmitSound("Item.Brooch.Target." .. (self.parent:IsRangedAttacker() and "Ranged" or "Melee"))


return -200
end



function modifier_revenants_brooch_custom_counter:CheckState()
if not self.ability then return {} end
if not self:HasMana() then return {} end
return 
{
    [MODIFIER_STATE_CANNOT_MISS] = true,
    [MODIFIER_STATE_CANNOT_TARGET_BUILDINGS] = true
}
end

function modifier_revenants_brooch_custom_counter:GetEffectName()
return "particles/items5_fx/revenant_brooch.vpcf"
end

function modifier_revenants_brooch_custom_counter:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end



