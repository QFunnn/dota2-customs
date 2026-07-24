--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_alchemist_gold_octarine", "abilities/items/item_alchemist_gold_octarine", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_octarine_active", "abilities/items/item_alchemist_gold_octarine", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_octarine_aura", "abilities/items/item_alchemist_gold_octarine", LUA_MODIFIER_MOTION_NONE)

item_alchemist_gold_octarine = class({})

function item_alchemist_gold_octarine:GetIntrinsicModifierName()
return "modifier_item_alchemist_gold_octarine"
end

function item_alchemist_gold_octarine:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/bloodstone_heal.vpcf", context )
end


function item_alchemist_gold_octarine:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration")

caster:EmitSound("DOTA_Item.Bloodstone.Cast")
caster:AddNewModifier(caster, self, "modifier_item_alchemist_gold_octarine_active", {duration = duration})
end




modifier_item_alchemist_gold_octarine = class(mod_hidden)
function modifier_item_alchemist_gold_octarine:RemoveOnDeath()	return false end

function modifier_item_alchemist_gold_octarine:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not self.parent.cdr_items then
  self.parent.cdr_items = {}
end
self.parent.cdr_items[self] = self.ability:GetSpecialValueFor("cdr_bonus")

self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.bonus_mana = self.ability:GetSpecialValueFor("bonus_mana")
self.bonus_mana_regen = self.ability:GetSpecialValueFor("mana_regen")
self.bonus_int = self.ability:GetSpecialValueFor("bonus_int")
self.ability.spell_amp = self.ability:GetSpecialValueFor("spell_amp")
self.ability.aura_radius = self.ability:GetSpecialValueFor("aura_radius")

self.lifesteal = self.ability:GetSpecialValueFor("spell_lifesteal") / 100
self.lifesteal_active = self.ability:GetSpecialValueFor("lifesteal_active") / 100

if self.parent:IsRealHero() then 
    self.parent:AddDamageEvent_out(self, true)
end 

end

function modifier_item_alchemist_gold_octarine:DamageEvent_out(params)
if not IsServer() then return end
if (params.unit:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 2000 then return end

local result = self.parent:CheckLifesteal(params, 1)
if not result then return end

local lifesteal = self.lifesteal
local hide_number = false

if self.parent:HasModifier("modifier_item_alchemist_gold_octarine_active") then
	hide_number = false
	lifesteal = self.lifesteal_active
end

self.parent:GenericHeal(params.damage * lifesteal * result, self.ability, hide_number, "particles/items3_fx/octarine_core_lifesteal.vpcf") 
end


function modifier_item_alchemist_gold_octarine:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_MANA_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
}
end

function modifier_item_alchemist_gold_octarine:GetModifierHealthBonus()
return self.bonus_health
end

function modifier_item_alchemist_gold_octarine:GetModifierManaBonus()
return self.bonus_mana
end

function modifier_item_alchemist_gold_octarine:GetModifierBonusStats_Intellect()
return self.bonus_int
end

function modifier_item_alchemist_gold_octarine:GetModifierPercentageManacostStacking()
return self.mana_reduce
end


function modifier_item_alchemist_gold_octarine:GetAuraRadius() return self.ability.aura_radius end
function modifier_item_alchemist_gold_octarine:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_alchemist_gold_octarine:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_alchemist_gold_octarine:GetModifierAura() return "modifier_item_alchemist_gold_octarine_aura" end
function modifier_item_alchemist_gold_octarine:IsAura() return not self.parent:HasModifier("modifier_item_bloodstone_custom") end



modifier_item_alchemist_gold_octarine_active = class(mod_visible)
function modifier_item_alchemist_gold_octarine_active:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.reduce =  self.ability:GetSpecialValueFor("mana_cost_active")

if not IsServer() then return end

local cd_inc = self.ability:GetSpecialValueFor("cd_inc")

for i = 0, 8 do
    local current_item = self.parent:GetItemInSlot(i)
    if current_item and not NoCdItems[current_item:GetName()] and current_item:GetName() ~= self.ability:GetName() then  
		local cooldown_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_cooldown_speed", {ability = current_item:entindex(), is_item = true, cd_inc = cd_inc})
		local name = self:GetName()

		cooldown_mod:SetEndRule(function()
			return self.parent:HasModifier(name)
		end)
    end
end

self.parent:GenericParticle("particles/generic_gameplay/rune_arcane_owner.vpcf", self)

local particle = ParticleManager:CreateParticle("particles/items_fx/bloodstone_heal.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(particle, 6, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_item_alchemist_gold_octarine_active:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
	MODIFIER_PROPERTY_MODEL_SCALE,
}
end

function modifier_item_alchemist_gold_octarine_active:GetModifierModelScale()
return 20
end

function modifier_item_alchemist_gold_octarine_active:GetModifierPercentageManacostStacking(params)
return self.reduce
end



modifier_item_alchemist_gold_octarine_aura = class(mod_visible)
function modifier_item_alchemist_gold_octarine_aura:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.damage = self.ability.spell_amp
if not IsServer() then return end
self.parent:GenericParticle("particles/items2_fx/veil_of_discord_debuff.vpcf", self)
end

function modifier_item_alchemist_gold_octarine_aura:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_item_alchemist_gold_octarine_aura:GetModifierIncomingDamage_Percentage(params)
if IsServer() and not params.inflictor then return end
if self.parent:HasModifier("modifier_item_bloodstone_custom_damage_inc") then return end
return self.damage
end