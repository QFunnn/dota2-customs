--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_panzer_custom", "items/item_panzer_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_panzer_custom_active", "items/item_panzer_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_panzer_custom_shield", "items/item_panzer_custom", LUA_MODIFIER_MOTION_NONE )

item_panzer_custom = class({})

function item_panzer_custom:GetIntrinsicModifierName()
    return "modifier_item_panzer_custom"
end

function item_panzer_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration_shield")
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_item_panzer_custom_active", {duration = duration} )
end

modifier_item_panzer_custom = class({})
function modifier_item_panzer_custom:IsHidden() return true end
function modifier_item_panzer_custom:IsPurgable() return false end
function modifier_item_panzer_custom:IsPurgeException() return false end
function modifier_item_panzer_custom:RemoveOnDeath() return false end
function modifier_item_panzer_custom:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.bonus_health = self:GetAbility():GetSpecialValueFor("bonus_health")
    self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
    self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
    self.chance_block = self:GetAbility():GetSpecialValueFor("chance_block")
    self.block_damage = self:GetAbility():GetSpecialValueFor("block_damage")
    self.health_regen_perc = self:GetAbility():GetSpecialValueFor("health_regen_perc")
end

function modifier_item_panzer_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK_SPECIAL,
    }
end

function modifier_item_panzer_custom:GetModifierHealthRegenPercentage()
    if self:GetParent():PassivesDisabled() then return end
    return self.health_regen_perc
end

function modifier_item_panzer_custom:GetModifierBonusStats_Strength()
    return self.bonus_strength
end

function modifier_item_panzer_custom:GetModifierHealthBonus()
    return self.bonus_health
end

function modifier_item_panzer_custom:GetModifierPhysicalArmorBonus()
    return self.bonus_armor
end

function modifier_item_panzer_custom:AttackLandedModifier(params)
	if not IsServer() then return end
	local attacker = params.attacker
	local target = params.target
	local original_damage = params.original_damage
	local damage_type = params.damage_type
	local damage_flags = params.damage_flags
	if params.target == self:GetParent() and not params.attacker:IsBuilding() and params.attacker:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
		if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS ) then return end
        if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then return end
		ApplyDamage({ victim = params.attacker, damage = (params.original_damage / 100 * self:GetAbility():GetSpecialValueFor("passive_reflection_pct")) + self:GetAbility():GetSpecialValueFor("passive_reflection_constant"), damage_type = params.damage_type, damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, attacker = self:GetParent(), ability = self:GetAbility() })
	end
end
function modifier_item_panzer_custom:FlagExist(a,b)
    local p,c,d=1,0,b
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c==d
end

function modifier_item_panzer_custom:GetModifierPhysical_ConstantBlockSpecial()
	if not self:GetAbility() then return end
	if RollPercentage(self.chance_block) then
   		return self.block_damage
   	end
end

modifier_item_panzer_custom_active = class({})

function modifier_item_panzer_custom_active:IsPurgable()
	return false
end

function modifier_item_panzer_custom_active:GetEffectName()
	return "particles/items_fx/blademail.vpcf"
end

function modifier_item_panzer_custom_active:GetStatusEffectName()
	return "particles/status_fx/status_effect_blademail.vpcf"
end

function modifier_item_panzer_custom_active:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_item_panzer_custom_active:OnCreated()
    if not IsServer() then return end
    self.block_active = self:GetAbility():GetSpecialValueFor("block_active")
    self.return_damage = self:GetAbility():GetSpecialValueFor("return_damage")
    self:GetParent():EmitSound("DOTA_Item.BladeMail.Activate")
end

function modifier_item_panzer_custom_active:GetModifierIncomingDamage_Percentage( event )
    if not IsServer() then return end
    local attacker = event.attacker
    if attacker and attacker:IsRealHero() then
        return 0
    end
    
    return self.block_active
end

function modifier_item_panzer_custom_active:OnDestroy()
	if not IsServer() then return end
	self:GetParent():EmitSound("DOTA_Item.BladeMail.Deactivate")
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_panzer_custom_shield", {duration = self:GetAbility():GetSpecialValueFor("phys_shield_duration")})
end

function modifier_item_panzer_custom_active:TakeDamageScriptModifier(params)
	if not IsServer() then return end
	local attacker = params.attacker
	local target = params.unit
	local original_damage = params.original_damage
	local damage_type = params.damage_type
	local damage_flags = params.damage_flags
	if target == self:GetParent() and not attacker:IsBuilding() and attacker:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then	
		if self:FlagExist( damage_flags, DOTA_DAMAGE_FLAG_HPLOSS ) then return end
        if self:FlagExist( damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then return end
        EmitSoundOnClient("DOTA_Item.BladeMail.Damage", attacker:GetPlayerOwner())
		ApplyDamage({ victim = attacker, damage = original_damage / 100 * self.return_damage, damage_type = damage_type, damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, attacker = target, ability = self:GetAbility() })
	end
end

function modifier_item_panzer_custom_active:FlagExist(a,b)
    local p,c,d=1,0,b
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c==d
end

modifier_item_panzer_custom_shield = class({})

function modifier_item_panzer_custom_shield:OnCreated(data)
    if not IsServer() then return end
    self.max_hp_shield = self:GetParent():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("phys_shield")
    self.current_hp_shield = self:GetParent():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("phys_shield")
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
end
function modifier_item_panzer_custom_shield:AddCustomTransmitterData()
    self.TransmitterTable = self.TransmitterTable or {}

    self.TransmitterTable.max_hp_shield = self.max_hp_shield
    self.TransmitterTable.current_hp_shield = self.current_hp_shield

    return self.TransmitterTable
end

function modifier_item_panzer_custom_shield:HandleCustomTransmitterData( data )
    self.max_hp_shield = data.max_hp_shield
    self.current_hp_shield = data.current_hp_shield
end

function modifier_item_panzer_custom_shield:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
    }
end

function modifier_item_panzer_custom_shield:GetModifierIncomingPhysicalDamageConstant(data)
    if IsClient() then
        if data.report_max then
            return self.max_hp_shield
        else
            return self.current_hp_shield
        end
    end
    local remain = self.current_hp_shield - data.damage
    if remain > 0 then
        self.current_hp_shield = self.current_hp_shield - data.damage
        self:SendBuffRefreshToClients()
        return -data.damage
    else
        self.current_hp_shield = 0
        self:Destroy()
        self:SendBuffRefreshToClients()
        return (remain + data.damage) * -1
    end
end