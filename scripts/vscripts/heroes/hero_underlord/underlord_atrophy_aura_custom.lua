--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_underlord_atrophy_aura_custom", "heroes/hero_underlord/underlord_atrophy_aura_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_underlord_atrophy_aura_custom_aura", "heroes/hero_underlord/underlord_atrophy_aura_custom.lua", LUA_MODIFIER_MOTION_NONE )

if underlord_atrophy_aura_custom == nil then
	underlord_atrophy_aura_custom = class({})
end

function underlord_atrophy_aura_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/heroes_underlord/atrophy_aura_cleave.vpcf", context)
end

function underlord_atrophy_aura_custom:GetIntrinsicModifierName()
	return "modifier_underlord_atrophy_aura_custom"
end

modifier_underlord_atrophy_aura_custom = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    RemoveOnDeath           = function(self) return false end,

	IsAura					= function(self) 
		local parent = self:GetParent()
		if parent and parent:PassivesDisabled() then
			return false
		end
		return true
	end,
	IsAuraActiveOnDeath		= function(self) return false end,
	GetModifierAura			= function(self) return "modifier_underlord_atrophy_aura_custom_aura" end,
	GetAuraDuration			= function(self) return 0.5 end,
	GetAuraRadius			= function(self) return self.Radius or 0 end,
	GetAuraSearchFlags		= function (self) return DOTA_UNIT_TARGET_FLAG_NONE end,
	GetAuraSearchTeam		= function(self) return DOTA_UNIT_TARGET_TEAM_ENEMY end,
	GetAuraSearchType		= function(self) return DOTA_UNIT_TARGET_HEROES_AND_CREEPS end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        }
    end,

    GetModifierPreAttack_BonusDamage    = function (self, params)
        local bonus = self:GetStackCount()
        if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
            _G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "underlord_atrophy_aura", DAMAGE_TYPE_PHYSICAL)
        end
        return bonus
    end,
})

function modifier_underlord_atrophy_aura_custom:OnCreated()
	local ability = self:GetAbility()

	if ability then
		self.Radius = ability:GetSpecialValueFor("radius")
		self.BonusDamagePerKill = ability:GetSpecialValueFor("bonus_damage_per_kill")
		self.CleaveDamage = ability:GetSpecialValueFor("cleave_damage_pct")
        self.CleaveWidth = ability:GetSpecialValueFor("cleave_starting_width")
        self.CleaveAngle = ability:GetSpecialValueFor("cleave_angle")
        self.CleaveDistance = ability:GetSpecialValueFor("cleave_distance_base")
	end
end

function modifier_underlord_atrophy_aura_custom:OnDeathEvent(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not params.unit:IsHero() and not self:GetParent():PassivesDisabled() then
        self:SetStackCount(self:GetStackCount() + self.BonusDamagePerKill)
    end
end

function modifier_underlord_atrophy_aura_custom:AttackLandedModifier(event)
    if not IsServer() then return end

    local attacker = event.attacker
    local target = event.target
    local parent = self:GetParent()

    if target and parent == attacker and parent:GetHeroFacetID() == 1 then
        local fxName = "particles/units/heroes/heroes_underlord/atrophy_aura_cleave.vpcf"
        local fx = ParticleManager:CreateParticle(fxName, PATTACH_ABSORIGIN, parent)
        ParticleManager:SetParticleControl(fx, 2, Vector(self.CleaveDistance, 0, 0))
        ParticleManager:SetParticleControlTransformForward(fx, 0, parent:GetAbsOrigin(), parent:GetForwardVector())
        ParticleManager:DestroyParticle(fx, false)
        ParticleManager:ReleaseParticleIndex(fx)
	    DoCleaveAttack( attacker, target, self:GetAbility(), self.CleaveDamage, self.CleaveAngle, self.CleaveWidth, self.CleaveDistance, "" )
    end
end

modifier_underlord_atrophy_aura_custom.OnRefresh = modifier_underlord_atrophy_aura_custom.OnCreated

modifier_underlord_atrophy_aura_custom_aura = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return true end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        }
    end,

    GetModifierBaseDamageOutgoing_Percentage    = function (self)
        return -(self.DamageReduction or 0)
    end,
})

function modifier_underlord_atrophy_aura_custom_aura:OnCreated()
	local ability = self:GetAbility()

	if ability then
		self.DamageReduction = ability:GetSpecialValueFor("damage_reduction_pct")
	end
end

modifier_underlord_atrophy_aura_custom.OnRefresh = modifier_underlord_atrophy_aura_custom.OnCreated