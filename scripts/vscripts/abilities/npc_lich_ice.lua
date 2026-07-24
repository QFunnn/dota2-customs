--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_ice_cd", "abilities/npc_lich_ice.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_ice", "abilities/npc_lich_ice.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_ice_resist", "abilities/npc_lich_ice.lua", LUA_MODIFIER_MOTION_NONE)

npc_lich_ice = class({})


function npc_lich_ice:GetCooldown(iLevel)

 return self.BaseClass.GetCooldown(self, iLevel) - (self:GetCaster():GetUpgradeStack("modifier_waveupgrade_boss") - 1)*self:GetSpecialValueFor("cd_inc")
 
end

function npc_lich_ice:OnSpellStart()
if not IsServer() then return end
self:EndCd(0)
  
self.radius = self:GetSpecialValueFor("radius")

self:GetCaster():EmitSound("Lich.Ice_voice")

self:GetCaster():EmitSound("Hero_Lich.IceSpire")

local pilar = CreateUnitByName("npc_lich_ice_unit", self:GetAbsOrigin()+RandomVector(RandomInt(-1, 1)+self.radius), true, nil, nil, DOTA_TEAM_CUSTOM_5)

self:GetCaster():AddNewModifier(pilar, self, "modifier_lich_ice_resist", {})

pilar:AddNewModifier(self:GetCaster(), self, "modifier_lich_ice", {})

pilar:SetBaseMaxHealth(12)
pilar:SetHealth(12)
pilar.lich_caster = self:GetCaster()
  
end


modifier_lich_ice_resist = class({})
function modifier_lich_ice_resist:IsHidden() return true end
function modifier_lich_ice_resist:IsPurgable() return false end
function modifier_lich_ice_resist:GetAttributes() return  MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_lich_ice_resist:GetEffectName() return "particles/units/heroes/hero_lich/lich_frost_armor.vpcf" end
function modifier_lich_ice_resist:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_lich_ice_resist:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
self.parent:AddAttackEvent_inc(self, true)

self.particle = ParticleManager:CreateParticle("particles/items_fx/glyph.vpcf" , PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(170,1,1))
self:AddParticle(self.particle, false, false, -1, false, false)

end


function modifier_lich_ice_resist:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
}
end

function modifier_lich_ice_resist:GetAbsoluteNoDamageMagical() return 1 end
function modifier_lich_ice_resist:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_lich_ice_resist:GetAbsoluteNoDamagePure() return 1 end

function modifier_lich_ice_resist:AttackEvent_inc(params)
if not IsServer() then return end
if not params.attacker:IsRealHero() then return end
if self:GetParent() ~= params.target then return end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(params.attacker:GetPlayerID()), "CreateIngameErrorMessage", {message = "#lich_invun"})
end

function modifier_lich_ice_resist:DeathEvent(params)
if not IsServer() then return end
if self:GetCaster() == params.unit or self:GetCaster().lich_caster == params.unit then 

  self:GetCaster():EmitSound("Hero_Lich.IceSpire.Destroy")
  self:Destroy()

  if self:GetCaster().lich_caster == params.unit then 
      self:GetCaster():Kill(nil,params.attacker)
  end

end

end



modifier_lich_ice = class({})
function modifier_lich_ice:IsHidden() return true end
function modifier_lich_ice:IsPurgable() return false end
function modifier_lich_ice:OnCreated(table)
if not IsServer() then return end

self.ability = self:GetAbility()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.parent:AddDeathEvent(self)

self.health_hits = self.ability:GetSpecialValueFor("hits")
self.health_hits_inc = self.ability:GetSpecialValueFor("hits_inc")

self.parent:AddAttackEvent_inc(self, true)

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_ice_spire.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 2, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 3, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 4, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 5, Vector(550,550,550))  

self:AddParticle(self.particle, false, false, -1, true, false)

local abs = self.parent:GetAbsOrigin()
abs.z = abs.z + 400
self.sign = ParticleManager:CreateParticle("particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.sign, 0, abs)

self:AddParticle(self.sign, false, false, -1, true, false)

self.hits = 12 
self.health = 12

self:StartIntervalThink(0.2)
end


function modifier_lich_ice:OnIntervalThink()
if not IsServer() then return end

local targets = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, 1200, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD  + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_ANY_ORDER, false)
    
for _,target in pairs(targets) do
  AddFOWViewer(target:GetTeamNumber(), self.parent:GetAbsOrigin(), 300, 0.2, false)
end

end

function modifier_lich_ice:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
} 
end

function modifier_lich_ice:GetAbsoluteNoDamageMagical() return 1 end
function modifier_lich_ice:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_lich_ice:GetAbsoluteNoDamagePure() return 1 end


function modifier_lich_ice:AttackEvent_inc( param )
if not IsServer() then return end
if self.parent ~= param.target then return end

local damage = self.hits/self.health_hits

if self.caster:GetUpgradeStack("modifier_waveupgrade_boss") == 2 then 
  damage = self.hits/self.health_hits_inc
end

self.health = self.health - damage

if self.health <= 0 then 
  self.parent:Kill(nil, param.attacker)
else 
  self.parent:SetHealth(self.health)
end

end



function modifier_lich_ice:DeathEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end

if not self:GetCaster() or self:GetCaster():IsNull() then return end
if not self:GetAbility() then return end

self:GetAbility():UseResources(false, false, false, true)


self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lich_ice_cd", {duration = self:GetAbility():GetSpecialValueFor("cd") - (self:GetCaster():GetUpgradeStack("modifier_waveupgrade_boss") - 1)*self:GetAbility():GetSpecialValueFor("cd_inc")})

end





modifier_lich_ice_cd = class({})

function modifier_lich_ice_cd:IsHidden() return false end
function modifier_lich_ice_cd:IsPurgable() return false end