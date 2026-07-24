--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_force_boots_custom", "items/item_force_boots", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_force_boots_custom_barrier", "items/item_force_boots", LUA_MODIFIER_MOTION_NONE )

item_force_boots_custom = class({})

function item_force_boots_custom:OnSpellStart()
    if not IsServer() then return end
    local heal_restore = self:GetSpecialValueFor("heal_restore")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, 'modifier_force_boots_active', {push_length = self:GetSpecialValueFor("push_length"), duration = self:GetSpecialValueFor("push_duration")})
    self:GetCaster():RemoveGesture(ACT_DOTA_DISABLED)
    self:GetCaster():Purge(false, true, false, false, false)
    self:GetCaster():Heal(heal_restore, self)

    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetCaster(), heal_restore, nil)
    local particle = ParticleManager:CreateParticle("particles/items3_fx/warmage_recipient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)

    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_force_boots_custom_barrier", {duration = self:GetSpecialValueFor("duration")})

    EmitSoundOn('DOTA_Item.ForceStaff.Activate', self:GetCaster())
end

function item_force_boots_custom:GetIntrinsicModifierName() 
    return "modifier_item_force_boots_custom"
end

modifier_item_force_boots_custom = class({})

function modifier_item_force_boots_custom:IsHidden()
    return true
end

function modifier_item_force_boots_custom:IsPurgable()
    return false
end

function modifier_item_force_boots_custom:DeclareFunctions()

    return  
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_MAX,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
    }
end

function modifier_item_force_boots_custom:GetModifierConstantHealthRegen()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor('hp_regen')
    end
end

function modifier_item_force_boots_custom:GetModifierMoveSpeedBonus_Special_Boots()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
    end
end

function modifier_item_force_boots_custom:GetModifierMoveSpeed_Max( params )
    return 30000
end

function modifier_item_force_boots_custom:GetModifierMoveSpeed_Limit( params )
    return 30000
end

function modifier_item_force_boots_custom:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

modifier_item_force_boots_custom_barrier = class({})

function modifier_item_force_boots_custom_barrier:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = self:GetAbility():GetSpecialValueFor( "barrier" )
	if not IsServer() then return end
	self.max_shield = self.barrier
	self.current_shield = self.barrier
	self:SetHasCustomTransmitterData( true )
end

function modifier_item_force_boots_custom_barrier:AddCustomTransmitterData()
    self.TransmitterTable = self.TransmitterTable or {}

    self.TransmitterTable.max_shield = self.max_shield
    self.TransmitterTable.current_shield = self.current_shield

	return self.TransmitterTable
end

function modifier_item_force_boots_custom_barrier:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_item_force_boots_custom_barrier:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_item_force_boots_custom_barrier:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end

	if params.damage >= self.current_shield then
		self:Destroy()
		return -self.current_shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end