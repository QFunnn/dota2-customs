--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_necrolyte_death_custom", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_death_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necrolyte_death_custom_buff", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_death_custom", LUA_MODIFIER_MOTION_NONE)

necrolyte_death_custom = class({})

function necrolyte_death_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/econ/items/necrolyte/necro_sullen_harvest/necro_ti7_immortal_scythe_start.vpcf", context )
end

function necrolyte_death_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("Hero_Necrolyte.ReapersScythe.Cast")
	self:GetCaster():EmitSound("Hero_Necrolyte.ReapersScythe.Target")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_necrolyte_death_custom", {duration = 1.5})
end

modifier_necrolyte_death_custom = class({})
function modifier_necrolyte_death_custom:IsPurgable() return false end
function modifier_necrolyte_death_custom:IsPurgeException() return false end

function modifier_necrolyte_death_custom:OnCreated()
	if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/econ/items/necrolyte/necro_sullen_harvest/necro_ti7_immortal_scythe_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_necrolyte_death_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_necrolyte_death_custom:GetPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_necrolyte_death_custom:OnRemoved()
	if not IsServer() then return end
    local health = self:GetCaster():GetHealth() / 100 * self:GetAbility():GetSpecialValueFor("health_cost")
    local mana = self:GetCaster():GetMana() / 100 * self:GetAbility():GetSpecialValueFor("mana_cost")
    local set_health = self:GetCaster():GetHealth() - health
    local set_mana = self:GetCaster():GetMana() - mana
    self:GetCaster():SetHealth(math.max(1, set_health))
    self:GetCaster():SetMana(math.max(1, set_mana))
    local shield = (health + mana) / 100 * self:GetAbility():GetSpecialValueFor("shield")
    self:GetCaster():RemoveModifierByName("modifier_necrolyte_death_custom_buff")
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_necrolyte_death_custom_buff", {duration = self:GetAbility():GetSpecialValueFor("duration"), shield = shield})
end

modifier_necrolyte_death_custom_buff = class({})
function modifier_necrolyte_death_custom_buff:IsPurgable() return false end
function modifier_necrolyte_death_custom_buff:IsPurgeException() return false end
function modifier_necrolyte_death_custom_buff:RemoveOnDeath() return false end

function modifier_necrolyte_death_custom_buff:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = kv.shield
	if not IsServer() then return end
	self.max_shield = self.barrier
	self.current_shield = self.barrier
	self:SetHasCustomTransmitterData( true )
end

function modifier_necrolyte_death_custom_buff:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_necrolyte_death_custom_buff:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_necrolyte_death_custom_buff:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_necrolyte_death_custom_buff:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        local shield = self.current_shield
		self:Destroy()
		return -shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end