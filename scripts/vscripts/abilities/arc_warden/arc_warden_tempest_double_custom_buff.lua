--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_arc_warden_tempest_double_custom_buff", "abilities/arc_warden/arc_warden_tempest_double_custom_buff", LUA_MODIFIER_MOTION_NONE )


arc_warden_tempest_double_custom_buff = class({})
function arc_warden_tempest_double_custom_buff:OnSpellStart()

local caster = self:GetCaster()
local tempest = caster:GetTempest()

caster:EmitSound("Arc.Tempest_rune")
local base = dota1x6:GetBase(caster:GetTeamNumber())
local effect = IsRadiant(tostring(base)) and "particles/rare_orb_patrol.vpcf" or "particles/brist_lowhp_.vpcf"

local duration = self:GetSpecialValueFor("duration")
caster:AddNewModifier(caster, self, "modifier_arc_warden_tempest_double_custom_buff", {duration = duration})
caster:GenericParticle(effect)

if IsValid(tempest) and tempest:IsAlive() then
	tempest:GenericParticle(effect)
	tempest:AddNewModifier(tempest, self, "modifier_arc_warden_tempest_double_custom_buff", {duration = duration})
end

end 


modifier_arc_warden_tempest_double_custom_buff = class(mod_visible)
function modifier_arc_warden_tempest_double_custom_buff:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability:GetSpecialValueFor("max")
self.shield = self.ability:GetSpecialValueFor("shield")*self.parent:GetMaxHealth()/100

self.active_shield = self.shield
self.max_shield = self.max*self.shield

if not IsServer() then return end
self.parent:GenericParticle("particles/generic_gameplay/rune_arcane_owner.vpcf", self)
self.RemoveForDuel = true
self.shield_talent = "Shard"
self:SetHasCustomTransmitterData(true)
self:SetStackCount(1)
end

function modifier_arc_warden_tempest_double_custom_buff:OnRefresh()
if not IsServer() then return end
self.active_shield = (math.min(self.max_shield, self.active_shield + self.shield))

if self:GetStackCount() < self.max then
	self:IncrementStackCount()
end 

self:SendBuffRefreshToClients()
end

function modifier_arc_warden_tempest_double_custom_buff:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_arc_warden_tempest_double_custom_buff:AddCustomTransmitterData() 
return 
{
  active_shield = self.active_shield,
} 
end

function modifier_arc_warden_tempest_double_custom_buff:HandleCustomTransmitterData(data)
self.active_shield = data.active_shield
end

function modifier_arc_warden_tempest_double_custom_buff:GetModifierIncomingDamageConstant( params )
if self.active_shield <= 0 then return end

if IsClient() then 
	if params.report_max then 
		return self.max_shield
	else 
    	return self.active_shield
    end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self.active_shield)
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})
self.active_shield = self.active_shield - damage
self:SendBuffRefreshToClients()
return -damage
end
