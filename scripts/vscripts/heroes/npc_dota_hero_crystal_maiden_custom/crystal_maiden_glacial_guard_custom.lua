--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_crystal_maiden_glacial_guard_custom", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_glacial_guard_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_crystal_maiden_glacial_guard_custom_buff", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_glacial_guard_custom", LUA_MODIFIER_MOTION_NONE)

crystal_maiden_glacial_guard_custom = class({})
crystal_maiden_glacial_guard_custom.modifier_crystal_maiden_19 = {5,10,15}

function crystal_maiden_glacial_guard_custom:GetIntrinsicModifierName()
    return "modifier_crystal_maiden_glacial_guard_custom"
end

modifier_crystal_maiden_glacial_guard_custom = class({})
function modifier_crystal_maiden_glacial_guard_custom:IsHidden() return true end
function modifier_crystal_maiden_glacial_guard_custom:IsPurgable() return false end
function modifier_crystal_maiden_glacial_guard_custom:IsPurgeException() return false end
function modifier_crystal_maiden_glacial_guard_custom:RemoveOnDeath() return false end
function modifier_crystal_maiden_glacial_guard_custom:IsPurgeException() return false end
function modifier_crystal_maiden_glacial_guard_custom:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_SPENT_MANA,
    }
end

function modifier_crystal_maiden_glacial_guard_custom:OnSpentMana(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    local mana_multiplier = self:GetAbility():GetSpecialValueFor("mana_multiplier")
    if self:GetParent():HasModifier("modifier_crystal_maiden_19") then
        mana_multiplier = mana_multiplier + self:GetAbility().modifier_crystal_maiden_19[self:GetParent():GetTalentLevel("modifier_crystal_maiden_19")]
    end
    if params.cost > 0 and not params.ability:IsItem() then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_crystal_maiden_glacial_guard_custom_buff", {duration = self:GetAbility():GetSpecialValueFor("barrier_duration"), barrier = params.cost / 100 * mana_multiplier})
    end
end

modifier_crystal_maiden_glacial_guard_custom_buff = class({})

function modifier_crystal_maiden_glacial_guard_custom_buff:OnCreated(params)
    if not IsServer() then return end
    self.max_shield = (self.max_shield or 0) + params.barrier
	self.current_shield = (self.current_shield or 0) + params.barrier
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
end

function modifier_crystal_maiden_glacial_guard_custom_buff:OnRefresh(params)
    if not IsServer() then return end
    self.max_shield = (self.max_shield or 0) + params.barrier
	self.current_shield = (self.current_shield or 0) + params.barrier
    self:SendBuffRefreshToClients()
end

function modifier_crystal_maiden_glacial_guard_custom_buff:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_crystal_maiden_glacial_guard_custom_buff:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_crystal_maiden_glacial_guard_custom_buff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
        MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT
	}
end

function modifier_crystal_maiden_glacial_guard_custom_buff:ShieldFunction(params)
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

function modifier_crystal_maiden_glacial_guard_custom_buff:GetModifierIncomingDamageConstant( params )
    if not self:GetParent():HasModifier("modifier_crystal_maiden_19") then return end
    return self:ShieldFunction(params)
end

function modifier_crystal_maiden_glacial_guard_custom_buff:GetModifierIncomingPhysicalDamageConstant( params )
    if self:GetParent():HasModifier("modifier_crystal_maiden_19") then return end
    return self:ShieldFunction(params)
end