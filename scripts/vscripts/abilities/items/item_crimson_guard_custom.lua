--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_crimson_guard_custom", "abilities/items/item_crimson_guard_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_crimson_guard_custom_active", "abilities/items/item_crimson_guard_custom", LUA_MODIFIER_MOTION_NONE)

item_crimson_guard_custom = class({})

function item_crimson_guard_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/vanguard_active.vpcf", context )
PrecacheResource( "particle","particles/items/crimson_guard_hit.vpcf", context )
end

function item_crimson_guard_custom:GetIntrinsicModifierName()
return "modifier_item_crimson_guard_custom"
end

function item_crimson_guard_custom:OnSpellStart()
local caster = self:GetCaster()

caster:EmitSound("Item.CrimsonGuard.Cast")
caster:AddNewModifier(caster, self, "modifier_item_crimson_guard_custom_active", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_crimson_guard_custom = class(mod_hidden)
function modifier_item_crimson_guard_custom:RemoveOnDeath() return false end
function modifier_item_crimson_guard_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_crimson_guard_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.health = self.ability:GetSpecialValueFor("bonus_health")
self.armor = self.ability:GetSpecialValueFor("bonus_armor")
self.regen = self.ability:GetSpecialValueFor("bonus_health_regen")
self.chance = self.ability:GetSpecialValueFor("block_chance")
self.block = self.ability:GetSpecialValueFor("block_damage_melee")
end

function modifier_item_crimson_guard_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
}
end

function modifier_item_crimson_guard_custom:GetModifierConstantHealthRegen()
return self.regen
end

function modifier_item_crimson_guard_custom:GetModifierPhysicalArmorBonus()
return self.armor
end

function modifier_item_crimson_guard_custom:GetModifierHealthBonus()
return self.health
end

function modifier_item_crimson_guard_custom:GetModifierPhysical_ConstantBlock(params)
if not IsServer() then return end
if not RollPseudoRandomPercentage(self.chance, 2622, self.parent) then return end
if self.parent == params.attacker then return end
if params.inflictor then return end
if params.damage_type ~= DAMAGE_TYPE_PHYSICAL then return end

return self.block
end



modifier_item_crimson_guard_custom_active = class(mod_visible)
function modifier_item_crimson_guard_custom_active:OnCreated( params )
self.parent = self:GetParent()
self.ability = self:GetAbility()

if IsClient() then
	local pfx = ParticleManager:CreateParticle("particles/items2_fx/vanguard_active.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(pfx, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(pfx, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
	self:AddParticle(pfx, false, false, 15, false, false)
end

self.reduce = self:GetAbility():GetSpecialValueFor("active_reduce")
end

function modifier_item_crimson_guard_custom_active:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end


function modifier_item_crimson_guard_custom_active:GetModifierIncomingDamage_Percentage(params)
if params.inflictor and not Not_spell_damage[params.inflictor:GetName()] then return end
if params.damage < 2 then return end

if IsServer() then 
	local forward = self.parent:GetAbsOrigin() - params.attacker:GetAbsOrigin()
	forward.z = 0
	forward = forward:Normalized()

	local particle_2 = ParticleManager:CreateParticle("particles/items/crimson_guard_hit.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt(particle_2, 0, self.parent, PATTACH_POINT, "attach_hitloc", self.parent:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(particle_2, 1, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControlForward(particle_2, 1, forward)
	ParticleManager:SetParticleControlEnt(particle_2, 2, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), false)
	ParticleManager:ReleaseParticleIndex(particle_2)
	self.parent:EmitSound("Crimson.Damage")
end 

return self.reduce
end