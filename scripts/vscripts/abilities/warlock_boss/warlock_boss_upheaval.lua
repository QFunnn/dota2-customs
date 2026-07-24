--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_boss_upheaval_cd", "abilities/warlock_boss/warlock_boss_upheaval.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_boss_upheaval_thinker", "abilities/warlock_boss/warlock_boss_upheaval.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_boss_upheaval_slow", "abilities/warlock_boss/warlock_boss_upheaval.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_boss_upheaval_incoming", "abilities/warlock_boss/warlock_boss_upheaval.lua", LUA_MODIFIER_MOTION_NONE)

warlock_boss_upheaval = class({})


function warlock_boss_upheaval:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/econ/items/warlock/warlock_staff_hellborn/warlock_upheaval_hellborn.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_upheaval_debuff.vpcf", context )

end



function warlock_boss_upheaval:OnSpellStart()
if not IsServer() then return end

self:GetCaster():EmitSound("Warlock.Slow_cast")
self.thinker = CreateModifierThinker(self:GetCaster(), self, "modifier_warlock_boss_upheaval_thinker", {duration = self:GetChannelTime() + FrameTime()*3}, self:GetCursorPosition(), self:GetCaster():GetTeamNumber(), false)

self.mod = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_warlock_boss_upheaval_incoming", {duration = self:GetChannelTime() + FrameTime()*3})

self:GetCaster():EmitSound("Warlock.Slow_voice")
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_warlock_boss_upheaval_cd", {duration = self:GetCooldownTimeRemaining()})
end


function warlock_boss_upheaval:OnChannelFinish( bInterrupted )
if not IsServer() then return end

self:GetCaster():StopSound("Warlock.Slow_cast")

self:GetCaster():RemoveModifierByName("modifier_warlock_boss_upheaval_incoming")
self:GetCaster():RemoveModifierByName("modifier_generic_bkb")

if not self.thinker then return end

self.thinker:Destroy()
end



modifier_warlock_boss_upheaval_cd = class({})

function modifier_warlock_boss_upheaval_cd:IsHidden() return false end
function modifier_warlock_boss_upheaval_cd:IsPurgable() return false end





modifier_warlock_boss_upheaval_thinker = class({})


function modifier_warlock_boss_upheaval_thinker:IsHidden() return false end

function modifier_warlock_boss_upheaval_thinker:IsPurgable() return false end

function modifier_warlock_boss_upheaval_thinker:OnCreated(table)

self.radius = self:GetAbility():GetSpecialValueFor("radius")
self.duration = self:GetAbility():GetSpecialValueFor("duration")
self.damage = self:GetAbility():GetSpecialValueFor("damage")/100

if not IsServer() then return end

local particle = ParticleManager:CreateParticle( "particles/econ/items/warlock/warlock_staff_hellborn/warlock_upheaval_hellborn.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetAbsOrigin() )
ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, self.radius, self.radius))
self:AddParticle(particle, false, false, -1, false, false)

self.interval = self:GetAbility():GetSpecialValueFor("interval")

self.damageTable = {damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, attacker = self:GetCaster(), ability = self:GetAbility()}


self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end




function modifier_warlock_boss_upheaval_thinker:OnIntervalThink()
if not IsServer() then return end

local  enemy_for_ability = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0 , FIND_CLOSEST, false)

for _,enemy in pairs(enemy_for_ability) do 

	self.damageTable.victim = enemy
	self.damageTable.damage = enemy:GetMaxHealth()*self.damage

	SendOverheadEventMessage(enemy, 4, enemy, enemy:GetMaxHealth()*self.damage, nil)
	DoDamage(self.damageTable)

	enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_warlock_boss_upheaval_slow", {duration = self.duration})
end


end





modifier_warlock_boss_upheaval_slow = class({})
function modifier_warlock_boss_upheaval_slow:IsHidden() return false end
function modifier_warlock_boss_upheaval_slow:IsPurgable() return false end

function modifier_warlock_boss_upheaval_slow:GetEffectName()
return "particles/units/heroes/hero_warlock/warlock_upheaval_debuff.vpcf"
end
function modifier_warlock_boss_upheaval_slow:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_warlock_boss_upheaval_slow:OnCreated(table)
self.slow = self:GetAbility():GetSpecialValueFor("slow")
self.max = self:GetAbility():GetSpecialValueFor("max")

if not IsServer() then return end

self:SetStackCount(1)
end

function modifier_warlock_boss_upheaval_slow:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end


self:IncrementStackCount()
end


function modifier_warlock_boss_upheaval_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_warlock_boss_upheaval_slow:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*self.slow
end



modifier_warlock_boss_upheaval_incoming = class({})
function modifier_warlock_boss_upheaval_incoming:IsHidden() return true end
function modifier_warlock_boss_upheaval_incoming:IsPurgable() return false end
function modifier_warlock_boss_upheaval_incoming:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end
function modifier_warlock_boss_upheaval_incoming:OnCreated(table)
self.parent = self:GetParent()
self.incoming = self:GetAbility():GetSpecialValueFor("incoming")

if not IsServer() then return end

if self.parent:GetUpgradeStack("modifier_waveupgrade_boss") == 2 then 
	self.bkb = self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_generic_debuff_immune", {effect = 1})
end

end

function modifier_warlock_boss_upheaval_incoming:OnDestroy()
if not IsServer() then return end
if self.bkb and not self.bkb:IsNull() then
  self.bkb:Destroy()
end
end

function modifier_warlock_boss_upheaval_incoming:GetModifierIncomingDamage_Percentage()
return self.incoming
end




function modifier_warlock_boss_upheaval_incoming:GetEffectName() return "particles/items3_fx/star_emblem_friend_shield.vpcf" end
 
function modifier_warlock_boss_upheaval_incoming:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end