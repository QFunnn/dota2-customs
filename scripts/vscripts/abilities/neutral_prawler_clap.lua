--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_prawler_clap", "abilities/neutral_prawler_clap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_prawler_root_custom", "abilities/neutral_prawler_clap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_prawler_armor_custom", "abilities/neutral_prawler_clap", LUA_MODIFIER_MOTION_NONE)


neutral_prawler_clap = class({})

function neutral_prawler_clap:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end
return "modifier_prawler_clap" 
end

function neutral_prawler_clap:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/neutral_fx/prowler_shaman_shamanistic_ward.vpcf", context )
PrecacheResource( "particle", "particles/neutral_fx/neutral_prowler_shaman_stomp.vpcf", context )
PrecacheResource( "particle", "particles/enigma/summon_spell_damage.vpcf", context )

end



modifier_prawler_clap = class({})

function modifier_prawler_clap:IsPurgable() return false end

function modifier_prawler_clap:IsHidden() return true end


function modifier_prawler_clap:OnCreated(table)
if not IsServer() then return end
self:GetAbility():SetLevel(1)

self.ability  = self:GetAbility()
self.parent = self:GetParent()
self.root = self.ability:GetSpecialValueFor("root")
self.aoe = self.ability:GetSpecialValueFor("aoe")
self.duration = self.ability:GetSpecialValueFor("duration")

end


function modifier_prawler_clap:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()

  if target:IsStunned() then 
  	return
  end 
end

self.parent:EmitSound("n_creep_Spawnlord.Stomp")
self.parent:AddNewModifier(self.parent, self.ability, "modifier_neutral_cast", {target = array_target, duration = 0.6, anim = ACT_DOTA_CAST_ABILITY_1, effect = 1, parent_mod = self:GetName()})
end


function modifier_prawler_clap:EndCast()
if not IsServer() then return end

local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/neutral_prowler_shaman_stomp.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(trail_pfx, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl(trail_pfx, 1, Vector(self.aoe , 0 , 0 ) )
ParticleManager:ReleaseParticleIndex(trail_pfx)  

self.parent:EmitSound("n_creep_Spawnlord.Freeze")

for _,target in pairs(self.parent:FindTargets(self.aoe)) do
	target:AddNewModifier(self.parent, self.ability, "modifier_prawler_root_custom", { duration = self.root * (1 - target:GetStatusResistance()) })
	target:AddNewModifier(self.parent, self.ability, "modifier_prawler_armor_custom", {duration = self.duration})
end
      
end


modifier_prawler_root_custom = class({})
function modifier_prawler_root_custom:IsHidden() return true end
function modifier_prawler_root_custom:IsPurgable() return true end
function modifier_prawler_root_custom:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true
}
end

function modifier_prawler_root_custom:GetEffectName()
return "particles/neutral_fx/prowler_shaman_shamanistic_ward.vpcf"
end

modifier_prawler_armor_custom = class({})
function modifier_prawler_armor_custom:IsHidden() return false end
function modifier_prawler_armor_custom:IsPurgable() return true end
function modifier_prawler_armor_custom:OnCreated()
self.parent = self:GetParent()

self.armor = self:GetAbility():GetSpecialValueFor("armor")*self.parent:GetPhysicalArmorValue(false)/100
if not IsServer() then return end
self.parent:GenericParticle("particles/enigma/summon_spell_damage.vpcf", self, true)
end

function modifier_prawler_armor_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_prawler_armor_custom:GetModifierPhysicalArmorBonus()
return self.armor
end