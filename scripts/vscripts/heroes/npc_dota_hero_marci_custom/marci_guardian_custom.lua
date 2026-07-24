--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_marci_guardian_custom", "heroes/npc_dota_hero_marci_custom/marci_guardian_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_guardian_custom_buff", "heroes/npc_dota_hero_marci_custom/marci_guardian_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_guardian_custom_timer", "heroes/npc_dota_hero_marci_custom/marci_guardian_custom", LUA_MODIFIER_MOTION_NONE)

marci_guardian_custom = class({})
marci_guardian_custom.modifier_marci_4 = 5
marci_guardian_custom.modifier_marci_4_heal_barrier = {10,20}
marci_guardian_custom.modifier_marci_4_max_barrier = {100,200}

function marci_guardian_custom:CastFilterResultTarget( target )
    if target == self:GetCaster() then
        return UF_FAIL_OTHER
    end
    if not self:GetCaster():HasModifier("modifier_marci_19") then
        if target:IsIllusion() then
            return UF_FAIL_ILLUSION 
        end
    end

    local target_type = DOTA_UNIT_TARGET_HERO
    if self:GetCaster():HasModifier("modifier_marci_19") then
        target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
    end

    if not IsServer() then return UF_SUCCESS end
    local nResult = UnitFilter(
        target,
        self:GetAbilityTargetTeam(),
        target_type,
        self:GetAbilityTargetFlags(),
        self:GetCaster():GetTeamNumber()
    )

    if nResult ~= UF_SUCCESS then
        return nResult
    end

    return UF_SUCCESS
end

function marci_guardian_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_sidekick_self_buff.vpcf", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_marci_sidekick.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_sidekick_buff.vpcf", context )
end

function marci_guardian_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_marci_7") and self:GetCaster():HasModifier("modifier_marci_unleash_custom") then
        local marci_unleash_custom = self:GetCaster():FindAbilityByName("marci_unleash_custom")
        if marci_unleash_custom then
            marci_unleash_custom:Pulse( self:GetCaster():GetOrigin() )
        end
    end
    if self:GetCaster():HasModifier("modifier_marci_4") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_marci_guardian_custom_buff", {duration = self:GetSpecialValueFor("bodyguard_duration")})
        self:GetCaster():EmitSound("Hero_Marci.Guardian.Applied")
        --self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_marci_guardian_custom_timer", {duration = self.modifier_marci_4})
        return
    end
    local target = self:GetCursorTarget()
    local modifier_marci_guardian_custom = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_marci_guardian_custom_buff", {duration = self:GetSpecialValueFor("bodyguard_duration")})
    if modifier_marci_guardian_custom then
        modifier_marci_guardian_custom:SetTarget(target)
    end
    local modifier_marci_guardian_custom_buff = target:AddNewModifier(self:GetCaster(), self, "modifier_marci_guardian_custom_buff", {duration = self:GetSpecialValueFor("bodyguard_duration")})
    if modifier_marci_guardian_custom_buff then
        modifier_marci_guardian_custom_buff:SetTarget(self:GetCaster())
    end
    target:EmitSound("Hero_Marci.Guardian.Applied")
end

function marci_guardian_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_marci_4") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function marci_guardian_custom:GetIntrinsicModifierName()
    if self:GetCaster():IsIllusion() then return end
    return "modifier_marci_guardian_custom"
end

modifier_marci_guardian_custom = class({})
function modifier_marci_guardian_custom:IsHidden() return true end
function modifier_marci_guardian_custom:IsPurgable() return false end
function modifier_marci_guardian_custom:IsPurgeException() return false end
function modifier_marci_guardian_custom:RemoveOnDeath() return false end
function modifier_marci_guardian_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL
	}
end

function modifier_marci_guardian_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_marci_sidekick.vpcf"
end

function modifier_marci_guardian_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_marci_guardian_custom:GetModifierBaseDamageOutgoing_Percentage()
    local mult = 1
    return self:GetAbility():GetSpecialValueFor("bonus_damage") * mult
end

function modifier_marci_guardian_custom:GetModifierProperty_PhysicalLifesteal( params )
	if not IsServer() then return end
    local lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal_pct")
    local mult = 1
	if params.target and not params.target:IsHero() then
        lifesteal = lifesteal * (1 - (self:GetAbility():GetSpecialValueFor("creep_lifesteal_reduction_pct") / 100))
    end
    return lifesteal * mult
end

modifier_marci_guardian_custom_buff = class({})
function modifier_marci_guardian_custom_buff:IsPurgable() return false end
function modifier_marci_guardian_custom_buff:IsPurgeException() return false end
function modifier_marci_guardian_custom_buff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
end

function modifier_marci_guardian_custom_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_marci_sidekick.vpcf"
end

function modifier_marci_guardian_custom_buff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_marci_guardian_custom_buff:GetModifierBaseDamageOutgoing_Percentage()
    if self:GetParent() == self:GetCaster() then return end
    return self:GetAbility():GetSpecialValueFor("bonus_damage") / 100 * self:GetAbility():GetSpecialValueFor("max_partner_penalty")
end

function modifier_marci_guardian_custom_buff:GetModifierProperty_PhysicalLifesteal( params )
	if not IsServer() then return end
    if self:GetParent() == self:GetCaster() then return end
    local lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal_pct") / 100 * self:GetAbility():GetSpecialValueFor("max_partner_penalty")
	if params.target and not params.target:IsHero() then
        lifesteal = lifesteal * (1 - (self:GetAbility():GetSpecialValueFor("creep_lifesteal_reduction_pct") / 100))
    end
    return lifesteal
end

function modifier_marci_guardian_custom_buff:OnCreated()
    if not IsServer() then return end
    self.barrier = self:GetAbility():GetSpecialValueFor( "shared_barrier" )
    if self:GetCaster():HasModifier("modifier_marci_4") then
        self.barrier = self.barrier + self:GetAbility().modifier_marci_4_max_barrier[self:GetCaster():GetTalentLevel("modifier_marci_4")]
    end
    self.max_shield = self.barrier
	self.current_shield = self.barrier
	self:SetHasCustomTransmitterData( true )
    local particle_name = "particles/units/heroes/hero_marci/marci_sidekick_self_buff.vpcf"
    if self:GetParent() ~= self:GetCaster() then
        particle_name = "particles/units/heroes/hero_marci/marci_sidekick_buff.vpcf"
    end
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_sidekick_self_buff.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( particle, 1, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( particle, 2, Vector(1,1,1))
	self:AddParticle( particle, false, false, 1, false, true )
end

function modifier_marci_guardian_custom_buff:SetTarget(target)
    if not IsServer() then return end
    self.target = target
end

function modifier_marci_guardian_custom_buff:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_marci_guardian_custom_buff:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_marci_guardian_custom_buff:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        if self.target then
            local modifier_marci_guardian_custom_buff = self.target:FindModifierByName("modifier_marci_guardian_custom_buff")
            if modifier_marci_guardian_custom_buff then
                modifier_marci_guardian_custom_buff:Destroy()
            end
        end
		self:Destroy()
		return -self.current_shield
	else
		self.current_shield = self.current_shield-params.damage
        if self.target then
            local modifier_marci_guardian_custom_buff = self.target:FindModifierByName("modifier_marci_guardian_custom_buff")
            if modifier_marci_guardian_custom_buff then
                modifier_marci_guardian_custom_buff:UpdateShield(self.current_shield)
            end
        end
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end

function modifier_marci_guardian_custom_buff:UpdateShield(current_shield)
    self.current_shield = current_shield
    self:SendBuffRefreshToClients()
end

function modifier_marci_guardian_custom_buff:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
    local shared_barrier_replenish_amount = self:GetAbility():GetSpecialValueFor("shared_barrier_replenish_amount")
    if self:GetCaster():HasModifier("modifier_marci_4") then
        shared_barrier_replenish_amount = shared_barrier_replenish_amount + self:GetAbility().modifier_marci_4_heal_barrier[self:GetCaster():GetTalentLevel("modifier_marci_4")]
    end
    self.current_shield = math.min(self.current_shield + (params.damage / 100 * shared_barrier_replenish_amount), self.max_shield)
    if self.target then
        local modifier_marci_guardian_custom_buff = self.target:FindModifierByName("modifier_marci_guardian_custom_buff")
        if modifier_marci_guardian_custom_buff then
            modifier_marci_guardian_custom_buff:UpdateShield(self.current_shield)
        end
    end
    self:SendBuffRefreshToClients()
end

modifier_marci_guardian_custom_timer = class({})
function modifier_marci_guardian_custom_timer:GetTexture() return "marci_4" end