--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_spirit_vessel_custom_passive", "abilities/items/item_spirit_vessel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_spirit_vessel_custom_active_enemy", "abilities/items/item_spirit_vessel_custom", LUA_MODIFIER_MOTION_NONE )

item_spirit_vessel_custom = class({})

function item_spirit_vessel_custom:GetIntrinsicModifierName()
return "modifier_item_spirit_vessel_custom_passive"
end

function item_spirit_vessel_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items4_fx/spirit_vessel_cast.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/urn_of_shadows_heal.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/spirit_vessel_damage.vpcf", context )
end

function item_spirit_vessel_custom:CastFilterResultTarget(target)
if not IsServer() then return end

if self:GetCurrentCharges() < 1 then 
	self:EndCd(0)
	self:StartCooldown(1)
	return
end

local caster = self:GetCaster()
if caster:GetTeam() ~= target:GetTeam() and target:IsMagicImmune() then
	return UF_FAIL_MAGIC_IMMUNE_ENEMY
end

if target:HasModifier("modifier_waveupgrade_boss") or target:GetUnitName() == "npc_roshan_custom" then 
	return UF_FAIL_OTHER
end

return UnitFilter( target, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
end


function item_spirit_vessel_custom:OnSpellStart()

local duration = self:GetSpecialValueFor("duration")
local caster = self:GetCaster()
local target = self:GetCursorTarget()

target:EmitSound("DOTA_Item.UrnOfShadows.Activate")

local particle_fx = ParticleManager:CreateParticle("particles/items4_fx/spirit_vessel_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
ParticleManager:SetParticleControl(particle_fx, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_fx, 1, target:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_fx)

target:AddNewModifier(caster, self, "modifier_item_spirit_vessel_custom_active_enemy", {duration = duration + 0.2})
self:SetCurrentCharges(self:GetCurrentCharges() - 1)
end



modifier_item_spirit_vessel_custom_passive = class(mod_visible)
function modifier_item_spirit_vessel_custom_passive:RemoveOnDeath()	return false end
function modifier_item_spirit_vessel_custom_passive:DestroyOnExpire() return false end

function modifier_item_spirit_vessel_custom_passive:OnCreated()
self.item = self:GetAbility()
self.parent = self:GetParent()

if self.parent:IsRealHero() then
	self.parent:AddDeathEvent(self, true)
end

self.soul_cooldown = self.item:GetSpecialValueFor("soul_cooldown")
self.bonus_armor = self.item:GetSpecialValueFor("bonus_armor")
self.bonus_mana_regen = self.item:GetSpecialValueFor("bonus_mana_regen")
self.bonus_agility = self.item:GetSpecialValueFor("bonus_all_stats")
self.bonus_strength = self.item:GetSpecialValueFor("bonus_all_stats")
self.bonus_intelligence = self.item:GetSpecialValueFor("bonus_all_stats")
self.health_bonus = self.item:GetSpecialValueFor("bonus_health")
self.mana_bonus = self.item:GetSpecialValueFor("bonus_mana")
self.radius = self.item:GetSpecialValueFor("soul_radius")
self.kill_charges = self.item:GetSpecialValueFor("soul_additional_charges")
self.max_health = self.item:GetSpecialValueFor("max_health")
self.max_mana = self.item:GetSpecialValueFor("max_mana")
if not IsSoloMode() then
	self.kill_charges = self.item:GetSpecialValueFor("duo_charge")
end
self.duration = self.soul_cooldown
self.max_stacks = self.item:GetSpecialValueFor("max_stacks")

if not IsServer() then return end

if not self.item.init then
	self.item.init = true
	self.item:SetCurrentCharges(math.max(self.item:GetCurrentCharges(), self.item:GetSpecialValueFor("init_charges")))
end

self:OnIntervalThink()
self:StartIntervalThink(1)
end

function modifier_item_spirit_vessel_custom_passive:OnIntervalThink()
if not IsServer() then return end
if not self.item or self.item:IsNull() then return end

local stack = math.min(self.max_stacks, self.item:GetSecondaryCharges())

if stack == self:GetStackCount() then return end

self:SetStackCount(stack)
self.parent:CalculateStatBonus(true)
end

function modifier_item_spirit_vessel_custom_passive:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_MANA_BONUS,
	MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_item_spirit_vessel_custom_passive:OnTooltip()
return self:GetStackCount()
end

function modifier_item_spirit_vessel_custom_passive:GetModifierConstantManaRegen()
return self.bonus_mana_regen
end

function modifier_item_spirit_vessel_custom_passive:GetModifierPhysicalArmorBonus()
return self.bonus_armor
end

function modifier_item_spirit_vessel_custom_passive:GetModifierBonusStats_Agility()
return self.bonus_agility
end

function modifier_item_spirit_vessel_custom_passive:GetModifierBonusStats_Intellect()
return self.bonus_intelligence
end

function modifier_item_spirit_vessel_custom_passive:GetModifierBonusStats_Strength()
return self.bonus_strength
end

function modifier_item_spirit_vessel_custom_passive:GetModifierHealthBonus()
return self.health_bonus + self:GetStackCount()*self.max_health
end

function modifier_item_spirit_vessel_custom_passive:GetModifierManaBonus()
return self.mana_bonus + self:GetStackCount()*self.max_mana
end

function modifier_item_spirit_vessel_custom_passive:DeathEvent(params)
local target = params.unit
if not self.parent:IsRealHero() then return end
if not target:IsValidKill(self.parent) then return end 
if not self.parent:IsAlive() then return end 

if ((self.parent:GetAbsOrigin() - target:GetAbsOrigin()):Length2D() <= self.radius or (params.attacker and params.attacker == self.parent)) then
	self.item:SetCurrentCharges(self.item:GetCurrentCharges() + self.kill_charges)
	self.item:SetSecondaryCharges(self.item:GetSecondaryCharges() + self.kill_charges)
end

end



modifier_item_spirit_vessel_custom_active_enemy = class({})
function modifier_item_spirit_vessel_custom_active_enemy:IsHidden() return false end
function modifier_item_spirit_vessel_custom_active_enemy:IsPurgable() return true end
function modifier_item_spirit_vessel_custom_active_enemy:OnCreated( params )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = 0.5
self.damage_per_second = self.ability:GetSpecialValueFor("soul_damage_amount")
self.enemy_hp_drain = self.ability:GetSpecialValueFor("enemy_hp_drain") / 100
self.hp_reduction_heal = -1 * self.ability:GetSpecialValueFor("hp_regen_reduction_enemy")
self.heal = self.ability:GetSpecialValueFor("soul_heal_amount")/100
self.duration = self.ability:GetSpecialValueFor("duration")/self.interval

if not IsServer() then return end
self.count = 0

self.caster:GenericParticle("particles/items2_fx/urn_of_shadows_heal.vpcf", self)
self.parent:GenericParticle("particles/items4_fx/spirit_vessel_damage.vpcf", self)

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_PURE}
self:StartIntervalThink(self.interval)
end

function modifier_item_spirit_vessel_custom_active_enemy:OnRefresh(table)
if not IsServer() then return end
self.count = 0
end

function modifier_item_spirit_vessel_custom_active_enemy:OnIntervalThink()
if not IsServer() then return end
local damage = self.damage_per_second + self.parent:GetHealth()*self.enemy_hp_drain
self.damageTable.damage = damage*self.interval

local real_damage = DoDamage(self.damageTable)
local result = self.caster:CanLifesteal(self.parent)
if result then
	self.caster:GenericHeal(real_damage*self.heal, self.ability, true, "")
end

self.count = self.count + 1
if self.count >= self.duration then
	self:Destroy()
end

end

function modifier_item_spirit_vessel_custom_active_enemy:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
}
end

function modifier_item_spirit_vessel_custom_active_enemy:GetModifierLifestealRegenAmplify_Percentage()
return self.hp_reduction_heal
end

function modifier_item_spirit_vessel_custom_active_enemy:GetModifierHealChange()
return self.hp_reduction_heal
end

function modifier_item_spirit_vessel_custom_active_enemy:GetModifierHPRegenAmplify_Percentage()
return self.hp_reduction_heal
end
