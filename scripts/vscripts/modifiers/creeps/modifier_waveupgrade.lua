--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_waveupgrade = class({})
function modifier_waveupgrade:IsHidden() return true end
function modifier_waveupgrade:IsPurgable() return false end
function modifier_waveupgrade:CheckState() 
if self.parent.mkb == 1 then 
  return {[MODIFIER_STATE_CANNOT_MISS]  = true } 
else 
  return
end

end

function modifier_waveupgrade:DeclareFunctions()
 return   
 {
  MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
  MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,

  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
}
end


function modifier_waveupgrade:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_waveupgrade:GetModifierMagicalResistanceBonus()
return self.magic
end

function modifier_waveupgrade:GetModifierBaseAttack_BonusDamage()
return self.change_damage
end

function modifier_waveupgrade:GetModifierExtraHealthBonus()
return self.change_health
end

function modifier_waveupgrade:GetModifierPhysicalArmorBonus()
return self.armor
end

function modifier_waveupgrade:GetModifierSpellAmplify_Percentage() 
return self.amp
end

function modifier_waveupgrade:NoDamage(attacker)
if not IsServer() then return end
if not attacker then return 0 end
if (attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 2000 then return 1 end
if self.no_damage == 0 then return 0 end
if not self.parent.host_team then return 0 end
if attacker:GetTeamNumber() == self.parent.host_team then return 0 end
return 1
end

function modifier_waveupgrade:GetAbsoluteNoDamagePhysical(params)
return self:NoDamage(params.attacker)
end

function modifier_waveupgrade:GetAbsoluteNoDamagePure(params)
return self:NoDamage(params.attacker)
end

function modifier_waveupgrade:GetAbsoluteNoDamageMagical(params)
return self:NoDamage(params.attacker)
end

function modifier_waveupgrade:GetModifierIncomingDamage_Percentage(params)
if params.damage_type ~= DAMAGE_TYPE_PURE then return end
return self.pure
end

function modifier_waveupgrade:GetModifierTotalDamageOutgoing_Percentage( params ) 
if params.attacker ~= self.parent then return end
if not params.target or not params.target:IsBuilding() then return end
return -65
end


function modifier_waveupgrade:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()

if not self.parent.host_team then return end

self.no_damage = 1

for abilitySlot = 0,8 do
  local ability = self.parent:GetAbilityByIndex(abilitySlot)
  if ability ~= nil then
    ability:SetLevel(1)
  end
end

self.exception = 
{
  ["npc_warlock_golem_custom"] = true,
  ["npc_enigma_eidolon_custom"] = true
}

if self.exception[self.parent:GetUnitName()] then return end



self.health = self.parent:GetBaseMaxHealth()
self.damage = self.parent:GetBaseDamageMin()
self.gold = self.parent:GetMinimumGoldBounty()*1.15
self.exp = self.parent:GetDeathXP()*0.85

self.armor = 0
self.magic = 10
self.amp = 0
self.speed = 0
self.pure = 0

self.change_health = 0
self.change_damage = 0

for i = 2, dota1x6.current_wave do
  self.up_health = 1.30
  self.up_damage = 1.23
  self.up_gold = 1.00
  self.up_exp = 1.04
 
  if i >= 10 then self.up_damage = 1.18 self.up_health = 1.21 self.armor = 4 self.speed = 20 self.magic = 0 end 
  if i >= 15 then self.up_damage = 1.17 self.up_health = 1.20 self.armor = 6 self.speed = 40 self.magic = -10 self.pure = 10 end 
  if i >= 20 then self.up_damage = 1.18 self.up_health = 1.23 self.armor = 8 self.speed = 80 self.magic = -20 self.pure = 20 end 

  self.health = self.health*self.up_health
  self.damage = self.damage*self.up_damage
  self.gold = self.gold*self.up_gold
  self.exp = self.exp*self.up_exp
  self.amp = self.amp + 33

  if i == 11 then 
    self.health = self.health*1.3
    self.damage = self.damage*1.3
  end
end

local ids = dota1x6:FindPlayers(self.parent.host_team)
if ids then
  if #ids == 2 then
    self.health = self.health*creeps_team_health
    self.damage = self.damage*creeps_team_damage
  end
end

self.change_health = self.health - self.parent:GetBaseMaxHealth()
self.change_damage = self.damage - self.parent:GetBaseDamageMin()

self.parent:SetMinimumGoldBounty(self.gold)
self.parent:SetMaximumGoldBounty(self.gold)

self.parent:SetDeathXP(self.exp)

self:SetHasCustomTransmitterData(true)
self:SendBuffRefreshToClients()
end


function modifier_waveupgrade:AddCustomTransmitterData() 
return 
{
  amp = self.amp,
  armor = self.armor,
  magic = self.magic,
  speed = self.speed
} 
end

function modifier_waveupgrade:HandleCustomTransmitterData(data)
self.amp  = data.amp
self.armor = data.armor
self.magic = data.magic
self.speed = data.speed
end