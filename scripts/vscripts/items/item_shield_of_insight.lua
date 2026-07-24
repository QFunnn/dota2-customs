--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_shield_of_insight_active", "items/item_shield_of_insight", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_shield_of_insight", "items/item_shield_of_insight", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_shield_of_insight_aura", "items/item_shield_of_insight", LUA_MODIFIER_MOTION_NONE)

item_shield_of_insight = class({})

function item_shield_of_insight:GetIntrinsicModifierName()
	return "modifier_item_shield_of_insight"
end

function item_shield_of_insight:OnSpellStart()
	if not IsServer() then return end
	local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("active_radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
	for _, target in pairs(targets) do
		target:AddNewModifier(self:GetCaster(), self, "modifier_item_shield_of_insight_active", {duration = self:GetSpecialValueFor("active_duration")})
	end
	self:GetCaster():EmitSound("Item.Pavise.Target")
end

modifier_item_shield_of_insight_active = class({})

function modifier_item_shield_of_insight_active:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/pavise_effect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin(), true )
	ParticleManager:SetParticleControlEnt( particle, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin(), true )
	ParticleManager:SetParticleControl(particle, 3, Vector(90,90,90))
	self:AddParticle(particle, false, false, -1, false, false)
    self.has_shield = true
    self.barrier = self:GetAbility():GetSpecialValueFor("active_block")
    self.max_shield = self.barrier
    self.current_shield = self.barrier
    self:SetHasCustomTransmitterData( true )
end
function modifier_item_shield_of_insight_active:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    }
    return funcs
end

function modifier_item_shield_of_insight_active:AddCustomTransmitterData()
    local data = 
    {
        max_shield = self.max_shield,
        current_shield = self.current_shield,
        has_shield = self.has_shield
    }
    return data
end

function modifier_item_shield_of_insight_active:HandleCustomTransmitterData( data )
    self.max_shield = data.max_shield
    self.current_shield = data.current_shield
    self.has_shield = data.has_shield
end

function modifier_item_shield_of_insight_active:GetModifierIncomingDamageConstant( params )
    if not self.has_shield then return end
    if not IsServer() then
        if params.report_max then
            return self.max_shield
        else
            return self.current_shield
        end
    end
    if params.damage >= self.current_shield then
        local dodge = self.current_shield
        self.current_shield = 0
        self:SendBuffRefreshToClients()
        self:Destroy()
        return -dodge
    else
        self.current_shield = self.current_shield-params.damage
        self:SendBuffRefreshToClients()
        return -params.damage
    end
end

modifier_item_shield_of_insight = class({})

function modifier_item_shield_of_insight:AllowIllusionDuplicate()	return false end
function modifier_item_shield_of_insight:IsPurgable()	return false end
function modifier_item_shield_of_insight:RemoveOnDeath() return false end
function modifier_item_shield_of_insight:IsHidden() return true end
function modifier_item_shield_of_insight:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_shield_of_insight:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
	}
end

function modifier_item_shield_of_insight:GetModifierPhysicalArmorBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_shield_of_insight:GetModifierHealthBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_shield_of_insight:GetModifierManaBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_item_shield_of_insight:IsAura()
	return true
end

function modifier_item_shield_of_insight:GetModifierAura()
	return "modifier_item_shield_of_insight_aura"
end

function modifier_item_shield_of_insight:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("active_radius")
end

function modifier_item_shield_of_insight:GetAuraDuration()
	return 0.5
end

function modifier_item_shield_of_insight:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_shield_of_insight:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_item_shield_of_insight_aura = class({})

function modifier_item_shield_of_insight_aura:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_item_shield_of_insight_aura:GetModifierConstantHealthRegen()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("aura_health_regen")
end

function modifier_item_shield_of_insight_aura:GetModifierMagicalResistanceBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("magical_resist")
end

