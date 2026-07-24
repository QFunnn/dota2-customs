--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_shield = class(mod_visible)
function modifier_generic_shield:GetTexture() return "buffs/generic/shield" end
function modifier_generic_shield:GetStatusEffectName() return self.status_effect end
function modifier_generic_shield:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end
function modifier_generic_shield:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.hit_func = nil
self.end_func = nil
self.new_damage_func = nil
self.filter_func = nil
self.reduce_func = nil
self.can_destroy_func = nil
self.sound = nil

self.max_shield = table.max_shield
self.shield = 0
self.shield_k = 1
self.refresh_timer = nil
self.dont_destroy = false
self.min_shield = 0
self.health_regen = 0
self.buff_mod = nil

self.status_effect = table.status_effect and table.status_effect or nil
self.disable_ability = false

self.killer = nil

if table.disable_ability then
	self.disable_ability = true
	self.ability:EndCd()
end

if table.dont_destroy == 1 then
	self.dont_destroy = true
end

if table.buff_mod then
	self.buff_mod = self.parent:FindModifierByName(table.buff_mod)
end

if table.health_regen then
	self.health_regen = table.health_regen
end

if table.refresh_timer then
	self.refresh_timer = table.refresh_timer
end

if table.shield_k then
	self.shield_k = table.shield_k
end

if table.start_full == 1 then
	self.shield = self.max_shield 
end

self.RemoveForDuel = true
if table.sound then
	self.sound = table.sound
	self.parent:EmitSound(self.sound)
end

self.shield_talent = table.shield_talent
self:SetHasCustomTransmitterData(true)
end

function modifier_generic_shield:AddShield(shield, max_shield)
if not IsServer() then return end

if max_shield then
	self.max_shield = max_shield
end

self.shield = math.min(self.max_shield, self.shield + shield)
self:SendBuffRefreshToClients()

if self.refresh_timer then
	self:StartIntervalThink(self.refresh_timer)
end

end

function modifier_generic_shield:OnIntervalThink()
if not IsServer() then return end
self:AddShield(self.max_shield)
self:StartIntervalThink(-1)
end

function modifier_generic_shield:AddCustomTransmitterData() 
return 
{	
	shield = self.shield,
	max_shield = self.max_shield,
	status_effect = self.status_effect,
	health_regen = self.health_regen
}
end

function modifier_generic_shield:HandleCustomTransmitterData(data)
self.shield = data.shield
self.max_shield = data.max_shield
self.status_effect = data.status_effect
self.health_regen = data.health_regen
end

function modifier_generic_shield:SetHitFunction( func )
self.hit_func = func
end

function modifier_generic_shield:SetFilterFunction( func )
self.filter_func = func
end

function modifier_generic_shield:SetReduceDamage( func )
self.reduce_func = func
end

function modifier_generic_shield:SetCanDestoyFunc( func )
self.can_destroy_func = func
end

function modifier_generic_shield:SetEndFunction( func )
self.end_func = func
end

function modifier_generic_shield:NewDamageFunction( func )
self.new_damage_func = func
end

function modifier_generic_shield:OnDestroy()
if not IsServer() then return end

if self.disable_ability then
	self.ability:StartCd()
end

if self.sound then
	self.parent:StopSound(self.sound)
end

if IsValid(self.buff_mod) then
	self.buff_mod:Destroy()
end

if self.end_func then
	self.end_func(self.killer)
end

end

function modifier_generic_shield:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
}
end

function modifier_generic_shield:GetModifierHealthRegenPercentage()
return self.health_regen
end

function modifier_generic_shield:GetModifierIncomingDamageConstant( params )

if IsClient() then 
  if params.report_max then 
  	return self.max_shield
  else 
	  return self.shield
	end 
end

if not IsServer() then return end
if self.shield <= 0 then return end
if self.filter_func and not self.filter_func(params) then return end

params.caster = self.parent
local damage = math.min(params.damage*self.shield_k, self.shield)
local shield_damage = damage
local ignore_info = false

if self.reduce_func then
	local result = self.reduce_func(params)
	if result then
		damage = math.min(params.damage*self.shield_k, self.shield/result)
		shield_damage = damage*result
	end
end

if self.new_damage_func then
	params.shield = self.shield
	local result = self.new_damage_func(params)
	damage = result.damage and result.damage or damage
	shield_damage = result.shield_damage and result.shield_damage or shield_damage
	ignore_info = result.ignore_info
end

if not ignore_info then
	self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})
end

if self.hit_func then
	self.hit_func(damage, params.attacker)
end

self.shield = math.max(0, self.shield - shield_damage)
self:SendBuffRefreshToClients()

if self.refresh_timer then
	self:StartIntervalThink(self.refresh_timer)
end

if self.shield <= 0 and not self.dont_destroy and (not self.can_destroy_func or self.can_destroy_func()) then
	if params.attacker and params.attacker:IsUnit() then
		self.killer = params.attacker
	end
  self:Destroy()
end
return -damage
end


modifier_generic_shield_multiple = class(modifier_generic_shield)
function modifier_generic_shield_multiple:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end