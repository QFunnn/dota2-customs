--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dazzle_good_juju_custom", "heroes/npc_dota_hero_dazzle_custom/dazzle_good_juju_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dazzle_good_juju_custom_debuff", "heroes/npc_dota_hero_dazzle_custom/dazzle_good_juju_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dazzle_good_juju_custom_handler", "heroes/npc_dota_hero_dazzle_custom/dazzle_good_juju_custom", LUA_MODIFIER_MOTION_NONE )

dazzle_good_juju_custom = class({})

dazzle_good_juju_custom.modifier_dazzle_4 = {75,150}
dazzle_good_juju_custom.modifier_dazzle_6 = {-12,-24}

function dazzle_good_juju_custom:GetIntrinsicModifierName()
    return "modifier_dazzle_good_juju_custom_handler"
end

function dazzle_good_juju_custom:Precache( context )
    PrecacheResource( "particle", "particles/dazzle_effect.vpcf", context )
end

modifier_dazzle_good_juju_custom_handler = class({})

function modifier_dazzle_good_juju_custom_handler:IsHidden() return true end
function modifier_dazzle_good_juju_custom_handler:IsPurgeException() return false end
function modifier_dazzle_good_juju_custom_handler:IsPurgable() return false end
function modifier_dazzle_good_juju_custom_handler:RemoveOnDeath() return false end
function modifier_dazzle_good_juju_custom_handler:OnCreated()
    if not IsServer() then return end
    self.exceptions = 
    {
        ["item_clarity"] = true,
        ["item_enchanted_mango"] = true,
        ["item_bottle"] = true,
        ["item_smoke_of_deceit"] = true,
        ["item_flask"] = true,
        ["item_tango"] = true,
        ["item_faerie_fire"] = true,
        ["item_dust_custom"] = true,
        ["item_book_str"] = true,
        ["item_book_agi"] = true,
        ["item_book_int"] = true,
        ["item_power_treads"] = true,
        ["item_aghanims_treads"] = true,
        ["item_aghanims_shard_custom"] = true,
        ["item_health_radiance"] = true,
        ["item_mana_radiance"] = true,
        ["item_radiance_custom"] = true,
        ["item_spear_of_mordiggian"] = true,
        ["item_vambrace"] = true,
        ["item_ward_dispenser_custom"] = true,
        ["item_moon_aghanim"] = true,
        ["item_moon_kaya"] = true,
        ["item_moon_yasha"] = true,
        ["item_moon_sange"] = true,
        ["item_moon_aghanim"] = true,
        ["item_moon_shard"] = true,      
        ["item_royale_with_cheese"] = true,  
        ["item_talant_book"] = true,  
    }
end
function modifier_dazzle_good_juju_custom_handler:DeclareFunctions()
    return
    {
         
    }
end
function modifier_dazzle_good_juju_custom_handler:OnAbilityFullyCast( params )
	if IsServer() then
		local hAbility = params.ability
		if hAbility == nil or not ( hAbility:GetCaster() == self:GetParent() ) then
			return 0
		end
		if hAbility:IsToggle() then
			return 0
		end
		if not hAbility:IsItem() then 
			return 0
		end
        if self.exceptions[hAbility:GetAbilityName()] ~= nil then return end
        Timers:CreateTimer(self:GetAbility():GetSpecialValueFor("delay"), function()
            CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_dazzle_good_juju_custom", {duration = self:GetAbility():GetSpecialValueFor("duration")}, self:GetParent():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
        end)
	end
end

modifier_dazzle_good_juju_custom = class({})
function modifier_dazzle_good_juju_custom:IsHidden() return true end
function modifier_dazzle_good_juju_custom:IsPurgable() return false end
function modifier_dazzle_good_juju_custom:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    if self:GetCaster():HasModifier("modifier_dazzle_4") then
        self.radius = self.radius + self:GetAbility().modifier_dazzle_4[self:GetCaster():GetTalentLevel("modifier_dazzle_4")]
    end
    self.radius = self:GetCaster():GetAoeBonus(self.radius)
    local duration = self:GetAbility():GetSpecialValueFor( "duration" )
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/dazzle_effect.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl( particle, 1, Vector( self.radius, 0, 1 ) )
	self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():EmitSound("Hero_ArcWarden.MagneticField.Cast")
end

function modifier_dazzle_good_juju_custom:IsAura()
    return true
end

function modifier_dazzle_good_juju_custom:GetModifierAura()
    return "modifier_dazzle_good_juju_custom_debuff"
end

function modifier_dazzle_good_juju_custom:GetAuraRadius()
    return self.radius
end

function modifier_dazzle_good_juju_custom:GetAuraDuration()
    return 0
end

function modifier_dazzle_good_juju_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_dazzle_good_juju_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_dazzle_good_juju_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_dazzle_good_juju_custom_debuff = class({})

function modifier_dazzle_good_juju_custom_debuff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(1)
    self:OnIntervalThink()
end

function modifier_dazzle_good_juju_custom_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
end

function modifier_dazzle_good_juju_custom_debuff:GetModifierPropertyRestorationAmplification()
    if not self:GetCaster():HasModifier("modifier_dazzle_6") then return end
    return self:GetAbility().modifier_dazzle_6[self:GetCaster():GetTalentLevel("modifier_dazzle_6")]
end

function modifier_dazzle_good_juju_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetAbility():GetSpecialValueFor("damage") + (self:GetCaster():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("damage_percent"))
    ApplyDamage( { victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility() })
end