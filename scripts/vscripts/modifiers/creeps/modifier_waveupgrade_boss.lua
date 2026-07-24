--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_waveupgrade_boss = class(mod_hidden)
function modifier_waveupgrade_boss:DeclareFunctions()
return   
{
  MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
  MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
}
end

function modifier_waveupgrade_boss:GetAbsoluteNoDamagePhysical(params)
if not IsServer() then return end
if (params.attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 2000 then return 1 end
return 0
end

function modifier_waveupgrade_boss:GetAbsoluteNoDamagePure(params)
if not IsServer() then return end
if (params.attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 2000 then return 1 end
return 0
end

function modifier_waveupgrade_boss:GetAbsoluteNoDamageMagical(params)
if not IsServer() then return end
if (params.attacker:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > 2000 then return 1 end
return 0
end


function modifier_waveupgrade_boss:GetModifierIncomingDamage_Percentage(params)
if params.attacker and params.attacker:IsBuilding() then 
  return -40
end

if params.damage_type == DAMAGE_TYPE_PURE then 
  return self.pure
end

end




function modifier_waveupgrade_boss:GetModifierTotalDamageOutgoing_Percentage( params ) 
if params.attacker ~= self.parent then return end
if not params.target or not params.target:IsBuilding() then return end

if self.wave == 1 then 
  return 150
else 
  return -20
end

end


function modifier_waveupgrade_boss:OnCreated(table)
self.parent = self:GetParent()
self.wave = table.wave

--self.wave = 2

self.amp = 0
self.magic = 35
self.armor = 5
self.speed = 0
self.pure = 0

self.health = 1800
self.damage = 80
self.gold = 250
self.exp = 250

if self.wave ~= 1 then 
  self.magic = -90
  self.armor = 12
  self.amp = 0--150
  self.pure = 65

  self.health = 60000
  self.damage = 450
  self.gold = 1000
  self.exp = 3000
  self.speed = 130
end

if not IsServer() then return end
self:SetStackCount(self.wave)

if self.parent.host_team then
  local ids = dota1x6:FindPlayers(self.parent.host_team)
  if ids then
    if #ids == 2 then
      self.health = self.health*creeps_team_health
      self.damage = self.damage*creeps_team_damage
    end
  end
end

self.parent:SetBaseDamageMin(self.damage)
self.parent:SetBaseDamageMax(self.damage)

self.change_health = self.health - self.parent:GetBaseMaxHealth()

--self.parent:SetBaseMaxHealth(self.health)
--self.parent:SetHealth(self.health)

self.parent:SetMinimumGoldBounty(self.gold)
self.parent:SetMaximumGoldBounty(self.gold)

self.parent:SetBaseMagicalResistanceValue(self.magic)

self.parent:SetDeathXP(self.exp)
self.parent:SetPhysicalArmorBaseValue(self.armor)
end

function modifier_waveupgrade_boss:GetModifierExtraHealthBonus()
return self.change_health
end

function modifier_waveupgrade_boss:GetModifierSpellAmplify_Percentage() 
return self.amp 
end

function modifier_waveupgrade_boss:GetModifierAttackSpeedBonus_Constant() 
return self.speed
end