--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skywrath_mage_shield_of_the_scion_custom", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_shield_of_the_scion_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_shield_of_the_scion_custom_buff", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_shield_of_the_scion_custom", LUA_MODIFIER_MOTION_NONE)

skywrath_mage_shield_of_the_scion_custom = class({})
skywrath_mage_shield_of_the_scion_custom.modifier_skywrath_mage_15 = 0

function skywrath_mage_shield_of_the_scion_custom:GetIntrinsicModifierName()
    return "modifier_skywrath_mage_shield_of_the_scion_custom"
end

modifier_skywrath_mage_shield_of_the_scion_custom = class({})
function modifier_skywrath_mage_shield_of_the_scion_custom:IsHidden() return self:GetStackCount() <= 0 end
function modifier_skywrath_mage_shield_of_the_scion_custom:IsPurgable() return false end
function modifier_skywrath_mage_shield_of_the_scion_custom:IsPurgeException() return false end
function modifier_skywrath_mage_shield_of_the_scion_custom:RemoveOnDeath() return false end
function modifier_skywrath_mage_shield_of_the_scion_custom:DestroyOnExpire() return false end
function modifier_skywrath_mage_shield_of_the_scion_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.unit == self:GetParent() then return end
    if params.inflictor == nil then return end
    if params.inflictor:IsItem() then return end
    if params.damage_type ~= DAMAGE_TYPE_MAGICAL then return end
    local damage_barrier = self:GetAbility():GetSpecialValueFor("damage_barrier")
    local barrier_duration = self:GetAbility():GetSpecialValueFor("barrier_duration")
    if self:GetCaster():HasModifier("modifier_skywrath_mage_15") then
        damage_barrier = damage_barrier + self:GetAbility().modifier_skywrath_mage_15
    end
    if params.damage > 0 then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_skywrath_mage_shield_of_the_scion_custom_buff", {duration = barrier_duration, barrier = params.damage / 100 * damage_barrier})
        self:SetDuration(barrier_duration, true)
    end
end

modifier_skywrath_mage_shield_of_the_scion_custom_buff = class({})
function modifier_skywrath_mage_shield_of_the_scion_custom_buff:IsHidden() return true end
function modifier_skywrath_mage_shield_of_the_scion_custom_buff:IsPurgable() return false end
function modifier_skywrath_mage_shield_of_the_scion_custom_buff:IsPurgeException() return false end
function modifier_skywrath_mage_shield_of_the_scion_custom_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_skywrath_mage_shield_of_the_scion_custom_buff:OnCreated(params)
    if not IsServer() then return end
    self.max_shield = (self.max_shield or 0) + params.barrier
	self.current_shield = (self.current_shield or 0) + params.barrier
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
    self.modifier_skywrath_mage_shield_of_the_scion_custom = self:GetCaster():FindModifierByName("modifier_skywrath_mage_shield_of_the_scion_custom")
    if self.modifier_skywrath_mage_shield_of_the_scion_custom then
        self.modifier_skywrath_mage_shield_of_the_scion_custom:IncrementStackCount()
    end
end

function modifier_skywrath_mage_shield_of_the_scion_custom_buff:OnDestroy()
    if not IsServer() then return end
    if self.modifier_skywrath_mage_shield_of_the_scion_custom then
        self.modifier_skywrath_mage_shield_of_the_scion_custom:DecrementStackCount()
    end
end

function modifier_skywrath_mage_shield_of_the_scion_custom_buff:OnRefresh(params)
    if not IsServer() then return end
    self.max_shield = (self.max_shield or 0) + params.barrier
	self.current_shield = (self.current_shield or 0) + params.barrier
    self:SendBuffRefreshToClients()
end

function modifier_skywrath_mage_shield_of_the_scion_custom_buff:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_skywrath_mage_shield_of_the_scion_custom_buff:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_skywrath_mage_shield_of_the_scion_custom_buff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
        MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT
	}
end

function modifier_skywrath_mage_shield_of_the_scion_custom_buff:ShieldFunction(params)
    if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        local ignore_damage = self.current_shield
        self.current_shield = 0
        self:SendBuffRefreshToClients()
        self:Destroy()
		return -ignore_damage
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end

function modifier_skywrath_mage_shield_of_the_scion_custom_buff:GetModifierIncomingDamageConstant( params )
    if not self:GetParent():HasModifier("modifier_skywrath_mage_15") then return end
    return self:ShieldFunction(params)
end

function modifier_skywrath_mage_shield_of_the_scion_custom_buff:GetModifierIncomingSpellDamageConstant( params )
    if self:GetParent():HasModifier("modifier_skywrath_mage_15") then return end
    return self:ShieldFunction(params)
end