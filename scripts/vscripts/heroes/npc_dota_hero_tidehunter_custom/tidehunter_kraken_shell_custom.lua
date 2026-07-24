--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_tidehunter_kraken_shell_custom", "heroes/npc_dota_hero_tidehunter_custom/tidehunter_kraken_shell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tidehunter_kraken_shell_custom_active", "heroes/npc_dota_hero_tidehunter_custom/tidehunter_kraken_shell_custom", LUA_MODIFIER_MOTION_NONE )

tidehunter_kraken_shell_custom = class({})

tidehunter_kraken_shell_custom.modifier_tidehunter_4 = {15,30}
tidehunter_kraken_shell_custom.modifier_tidehunter_18_movespeed = {5,10,15}
tidehunter_kraken_shell_custom.modifier_tidehunter_18_cooldown = {-3,-6,-9}

function tidehunter_kraken_shell_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge.vpcf", context )
end

function tidehunter_kraken_shell_custom:GetCooldown( nLevel )
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_tidehunter_18") then
        bonus = self.modifier_tidehunter_18_cooldown[self:GetCaster():GetTalentLevel("modifier_tidehunter_18")]
    end
    return self.BaseClass.GetCooldown( self, nLevel ) + bonus
end

function tidehunter_kraken_shell_custom:OnSpellStart()
	if not IsServer() then return end
    local active_duration = self:GetSpecialValueFor("active_duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_tidehunter_kraken_shell_custom_active", {duration = active_duration})
end

function tidehunter_kraken_shell_custom:GetIntrinsicModifierName()
	return "modifier_tidehunter_kraken_shell_custom"
end

modifier_tidehunter_kraken_shell_custom_active = class({})

function modifier_tidehunter_kraken_shell_custom_active:OnCreated()
    self.active_move_speed_penalty_pct = -self:GetAbility():GetSpecialValueFor("active_move_speed_penalty_pct")
    if self:GetParent():HasModifier("modifier_tidehunter_18") then
        self.active_move_speed_penalty_pct = self:GetAbility().modifier_tidehunter_18_movespeed[self:GetCaster():GetTalentLevel("modifier_tidehunter_18")]
    end
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tidehunter/tidehunter_shell.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_tidehunter_kraken_shell_custom_active:CheckState()
    if not self:GetParent():HasModifier("modifier_tidehunter_18") then return end
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_UNSLOWABLE] = true,
    }
end

function modifier_tidehunter_kraken_shell_custom_active:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_tidehunter_kraken_shell_custom_active:GetModifierMoveSpeedBonus_Percentage()
	return self.active_move_speed_penalty_pct
end

modifier_tidehunter_kraken_shell_custom = class({})
function modifier_tidehunter_kraken_shell_custom:IsHidden() return true end
function modifier_tidehunter_kraken_shell_custom:IsDebuff() return false end
function modifier_tidehunter_kraken_shell_custom:IsPurgable() return false end

function modifier_tidehunter_kraken_shell_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.damage_reduction = self:GetAbility():GetSpecialValueFor( "damage_reduction" )
	self.damage_cleanse = self:GetAbility():GetSpecialValueFor( "damage_cleanse" )
	self.damage_reset_interval = self:GetAbility():GetSpecialValueFor( "damage_reset_interval" )
    self.active_pct_effectiveness = self:GetAbility():GetSpecialValueFor("active_pct_effectiveness")
    self.creep_reduction_penalty_pct = self:GetAbility():GetSpecialValueFor("creep_reduction_penalty_pct")
	if not IsServer() then return end
	self.damage = 0
end

function modifier_tidehunter_kraken_shell_custom:OnRefresh( kv )
	self.damage_reduction = self:GetAbility():GetSpecialValueFor( "damage_reduction" )
	self.damage_cleanse = self:GetAbility():GetSpecialValueFor( "damage_cleanse" )
	self.damage_reset_interval = self:GetAbility():GetSpecialValueFor( "damage_reset_interval" )
    self.active_pct_effectiveness = self:GetAbility():GetSpecialValueFor("active_pct_effectiveness")
    self.creep_reduction_penalty_pct = self:GetAbility():GetSpecialValueFor("creep_reduction_penalty_pct")
end

function modifier_tidehunter_kraken_shell_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}
end

function modifier_tidehunter_kraken_shell_custom:OnTakeDamage( params )
	if not IsServer() then return end
	if params.unit~=self.parent then return end
	if self.parent:PassivesDisabled() then return end
	if not params.attacker:GetPlayerOwner() then return end
	self:StartIntervalThink( self.damage_reset_interval )
	self.damage = self.damage + params.damage
	if self.damage < self.damage_cleanse then return end
	self.damage = 0
	self.parent:Purge( false, true, false, true, true )
	self:PlayEffects()
end

function modifier_tidehunter_kraken_shell_custom:GetModifierPhysical_ConstantBlock()
	if self.parent:PassivesDisabled() then return 0 end
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_tidehunter_4") then
		bonus = self:GetAbility().modifier_tidehunter_4[self:GetCaster():GetTalentLevel("modifier_tidehunter_4")]
	end
    local value = self.damage_reduction + bonus
    if self:GetParent():HasModifier("modifier_tidehunter_kraken_shell_custom_active") then
        value = value * (self.active_pct_effectiveness / 100)
    end
    if not self:GetParent():IsHero() then
        value = value * (1 - self.creep_reduction_penalty_pct / 100)
    end
	return value
end

function modifier_tidehunter_kraken_shell_custom:OnIntervalThink()
	self:StartIntervalThink( -1 )
	self.damage = 0
end

function modifier_tidehunter_kraken_shell_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self.parent:EmitSound("Hero_Tidehunter.KrakenShell")
end