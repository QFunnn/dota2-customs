--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_shiva_custom_stats", "abilities/items/item_shivas_guard_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_shiva_custom_active", "abilities/items/item_shivas_guard_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_shiva_custom_aura", "abilities/items/item_shivas_guard_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_shiva_custom_slow", "abilities/items/item_shivas_guard_custom.lua", LUA_MODIFIER_MOTION_NONE )

item_shivas_guard_custom = class({})

function item_shivas_guard_custom:GetIntrinsicModifierName()
return "modifier_item_shiva_custom_stats" 
end

function item_shivas_guard_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/shivas_guard_active.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_slowed_cold.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_frost.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/veil_of_discord_debuff.vpcf", context )
end

function item_shivas_guard_custom:OnSpellStart()
local caster = self:GetCaster()

caster:EmitSound("DOTA_Item.ShivasGuard.Activate")
caster:Purge(false, true, false, false, false)
caster:AddNewModifier(caster, self, "modifier_item_shiva_custom_active", {duration = self.blast_radius/self.blast_speed, damage_k = self.multicast_k or 1})
end

modifier_item_shiva_custom_stats = class(mod_hidden)
function modifier_item_shiva_custom_stats:RemoveOnDeath() return false end
function modifier_item_shiva_custom_stats:OnCreated(keys)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")               
self.ability.aura_radius = self.ability:GetSpecialValueFor("aura_radius") 
self.ability.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")               
self.ability.aura_attack_speed = self.ability:GetSpecialValueFor("aura_attack_speed")         
self.ability.blast_damage = self.ability:GetSpecialValueFor("blast_damage")              
self.ability.blast_movement_speed = self.ability:GetSpecialValueFor("blast_movement_speed")      
self.ability.blast_debuff_duration = self.ability:GetSpecialValueFor("blast_debuff_duration")    
self.ability.blast_radius = self.ability:GetSpecialValueFor("blast_radius")              
self.ability.blast_speed = self.ability:GetSpecialValueFor("blast_speed")                 
end

function modifier_item_shiva_custom_stats:DeclareFunctions()
return 
{ 
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS, 
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_item_shiva_custom_stats:GetModifierPhysicalArmorBonus()
return self.ability.bonus_armor
end

function modifier_item_shiva_custom_stats:GetModifierSpellAmplify_Percentage()
return self.ability.bonus_damage
end


function modifier_item_shiva_custom_stats:GetAuraRadius() return self.ability.aura_radius end
function modifier_item_shiva_custom_stats:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_item_shiva_custom_stats:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_shiva_custom_stats:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_shiva_custom_stats:GetModifierAura() return "modifier_item_shiva_custom_aura" end
function modifier_item_shiva_custom_stats:IsAura() return true end


modifier_item_shiva_custom_aura = class(mod_visible)
function modifier_item_shiva_custom_aura:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
} 
end

function modifier_item_shiva_custom_aura:GetModifierAttackSpeedBonus_Constant()
return self.attack_slow
end

function modifier_item_shiva_custom_aura:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.attack_slow = self.ability.aura_attack_speed
end


modifier_item_shiva_custom_active = class(mod_hidden)
function modifier_item_shiva_custom_active:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_shiva_custom_active:RemoveOnDeath() return false end
function modifier_item_shiva_custom_active:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.ability.blast_speed
self.radius = self.ability.blast_radius
self.damage_duration = self.ability.resist_debuff_duration
self.slow_duration = self.ability.blast_debuff_duration

self.interval = 0.1
self.max_time = self.radius/self.speed

if not IsServer() then return end

self.damageTable = {attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, damage = self.ability.blast_damage*table.damage_k}

local player_id = self.parent:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_shivas")
self.impacted_effect = "particles/items2_fx/shivas_guard_impact.vpcf"
local default_effect = "particles/items2_fx/shivas_guard_active.vpcf"
if custom_effect_data then
    default_effect = custom_effect_data[1]
    self.impacted_effect = custom_effect_data[2]
end

self.particle = self.parent:GenericParticle(default_effect, self)
ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, (self.radius/self.speed)*2, self.speed))

self.targets = {}
self.current_radius = 10

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_item_shiva_custom_active:OnIntervalThink()
if not IsServer() then return end

for _,enemy in pairs(self.parent:FindTargets(self.current_radius)) do
	if not self.targets[enemy] then
		self.targets[enemy] = true
		enemy:AddNewModifier(self.parent, self.ability, "modifier_item_shiva_custom_slow", {duration = self.slow_duration*(1 - enemy:GetStatusResistance())})

		local hit_pfx = ParticleManager:CreateParticle(self.impacted_effect, PATTACH_ABSORIGIN_FOLLOW, enemy)
		ParticleManager:SetParticleControl(hit_pfx, 0, enemy:GetAbsOrigin())
		ParticleManager:SetParticleControl(hit_pfx, 1, self.parent:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(hit_pfx)

		self.damageTable.victim = enemy
		DoDamage(self.damageTable)
	end
end

AddFOWViewer(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), self.current_radius, self.interval*2, false)

if self.current_radius < self.radius then
	self.current_radius = self.current_radius + self.speed*self.interval
end

end



modifier_item_shiva_custom_slow = class({})
function modifier_item_shiva_custom_slow:IsHidden() return true end
function modifier_item_shiva_custom_slow:IsPurgable() return true end
function modifier_item_shiva_custom_slow:GetStatusEffectName() return "particles/status_fx/status_effect_frost.vpcf" end
function modifier_item_shiva_custom_slow:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL end
function modifier_item_shiva_custom_slow:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.slow = self.ability.blast_movement_speed
if not IsServer() then return end
self.parent:GenericParticle("particles/generic_gameplay/generic_slowed_cold.vpcf", self)
end

function modifier_item_shiva_custom_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_shiva_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end
