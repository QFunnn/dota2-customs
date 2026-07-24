--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_kunkka_tidebringer_custom_passive", "abilities/kunkka_tidebringer_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_kunkka_tidebringer_custom_slow", "abilities/kunkka_tidebringer_custom", LUA_MODIFIER_MOTION_NONE )

kunkka_tidebringer_custom = class({})

function kunkka_tidebringer_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_spell_tidebringer.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_weapon/kunkka_spell_tidebringer_fxset.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_weapon_tidebringer.vpcf", context )
end

function kunkka_tidebringer_custom:GetIntrinsicModifierName()
    return "modifier_kunkka_tidebringer_custom_passive"
end

function kunkka_tidebringer_custom:OnOrbImpact( params )
	local range = self:GetSpecialValueFor("cleave_distance")
	local radius_start = self:GetSpecialValueFor("cleave_starting_width")
	local radius_end = self:GetSpecialValueFor("cleave_ending_width")
    local damage_bonus = self:GetSpecialValueFor("damage_bonus")

    local MovespeedSlowDuration = self:GetSpecialValueFor("movespeed_slow_duration")

    local caster = self:GetCaster()

	local cleaveDamage = (params.damage + damage_bonus) * (self:GetSpecialValueFor("cleave_damage") / 100)
	caster:EmitSound("Hero_Kunkka.Tidebringer.Attack")
    local anchor = "particles/units/heroes/hero_kunkka/kunkka_spell_tidebringer.vpcf"
	DoCleaveAttack( params.attacker, params.target, self, cleaveDamage, radius_start, radius_end, range, anchor )

    if MovespeedSlowDuration > 0 then
        local Targets = FindUnitsInCone(
            caster:GetTeamNumber(), 
            CalculateDirection(params.target, caster), 
            caster:GetAbsOrigin(),
            radius_start,
            radius_end,
            range,
            nil, 
            DOTA_UNIT_TARGET_TEAM_ENEMY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, 
            FIND_ANY_ORDER, 
            false
        )
        for _, Target in pairs(Targets) do
            if Target ~= params.target then
                Target:AddNewModifier(caster, self, "modifier_kunkka_tidebringer_custom_slow", {duration=MovespeedSlowDuration})
            end
        end
    end
end

modifier_kunkka_tidebringer_custom_passive = class({})
function modifier_kunkka_tidebringer_custom_passive:IsPurgable() return false end
function modifier_kunkka_tidebringer_custom_passive:IsPurgeException() return false end
function modifier_kunkka_tidebringer_custom_passive:RemoveOnDeath() return false end
function modifier_kunkka_tidebringer_custom_passive:OnCreated()
    self.attack_count = self:GetAbility():GetSpecialValueFor("attack_count")
end
function modifier_kunkka_tidebringer_custom_passive:OnRefresh()
    self.attack_count = self:GetAbility():GetSpecialValueFor("attack_count")
end
function modifier_kunkka_tidebringer_custom_passive:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_kunkka_tidebringer_custom_passive:OnAttackLanded( params )
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target == nil then return end
    self:IncrementStackCount()
    if self:GetStackCount() == self.attack_count - 1 then
        self:CreateSwordParticle()
    end
    if self:GetStackCount() >= self.attack_count then
        self:GetAbility():OnOrbImpact( params )
        self:SetStackCount(0)

        self:DestroySwordParticle()
    end
end

function modifier_kunkka_tidebringer_custom_passive:CreateSwordParticle()
    if self.fx then
        return
    end
    self.fx = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_kunkka/kunkka_weapon_tidebringer.vpcf", 
        PATTACH_POINT_FOLLOW, 
        self:GetParent()
    )
    ParticleManager:SetParticleControlEnt(self.fx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_tidebringer", Vector(0, 0, 0), true)
    ParticleManager:SetParticleControlEnt(self.fx, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_sword", Vector(0, 0, 0), true)
end

function modifier_kunkka_tidebringer_custom_passive:DestroySwordParticle()
    if self.fx ~= nil then
        ParticleManager:DestroyParticle(self.fx, false)
        ParticleManager:ReleaseParticleIndex(self.fx)
        self.fx = nil
    end
end

modifier_kunkka_tidebringer_custom_slow = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        }
    end,

	GetModifierMoveSpeedBonus_Percentage	= function(self)
		return self.MovespeedSlow or 0
	end,
})

function modifier_kunkka_tidebringer_custom_slow:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.MovespeedSlow = ability:GetSpecialValueFor("movespeed_slow")
    end
end