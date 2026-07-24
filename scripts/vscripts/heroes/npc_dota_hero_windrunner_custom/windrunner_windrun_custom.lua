--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_windrunner_windrun_custom", "heroes/npc_dota_hero_windrunner_custom/windrunner_windrun_custom" , LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_windrunner_windrun_custom_tooltip", "heroes/npc_dota_hero_windrunner_custom/windrunner_windrun_custom" , LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_windrunner_windrun_custom_debuff", "heroes/npc_dota_hero_windrunner_custom/windrunner_windrun_custom" , LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_windrunner_windrun_custom_tornado", "heroes/npc_dota_hero_windrunner_custom/windrunner_windrun_custom" , LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier( "modifier_windrunner_windrun_pull_buff", "heroes/npc_dota_hero_windrunner_custom/windrunner_windrun_custom" , LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_windrunner_windrun_pull_debuff", "heroes/npc_dota_hero_windrunner_custom/windrunner_windrun_custom" , LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_windrunner_windrun_pull_armor_debuff", "heroes/npc_dota_hero_windrunner_custom/windrunner_windrun_custom" , LUA_MODIFIER_MOTION_NONE )

windrunner_windrun_custom = class({})

function windrunner_windrun_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_windrun.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_windrun_slow.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/tornado_ambient.vpcf", context )
    PrecacheResource( "particle", "particles/windrunner_pull.vpcf", context )
end

windrunner_windrun_custom.modifier_windrunner_9_duration = 4
windrunner_windrun_custom.modifier_windrunner_9_damage = 75
windrunner_windrun_custom.modifier_windrunner_9_radius = 400
windrunner_windrun_custom.modifier_windrunner_10_agility_damage = {60,90,120}
windrunner_windrun_custom.modifier_windrunner_15_distance = 600
windrunner_windrun_custom.modifier_windrunner_14 = {-2, -4}
windrunner_windrun_custom.modifier_windrunner_11 = -1
windrunner_windrun_custom.modifier_windrunner_11_duration = {3,6,9}
windrunner_windrun_custom.modifier_windrunner_11_max = 20

function windrunner_windrun_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_windrunner_14") then
        bonus = self.modifier_windrunner_14[self:GetCaster():GetTalentLevel("modifier_windrunner_14")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function windrunner_windrun_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor( "duration" )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_windrunner_windrun_custom", { duration = duration } )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_windrunner_windrun_custom_tooltip", { duration = duration } )
	self:GetCaster():EmitSound("Ability.Windrun")
	self:CreateTornado()
end

function windrunner_windrun_custom:CreateTornado()
	if self:GetCaster():HasModifier("modifier_windrunner_9") then
		local tornado = CreateUnitByName("npc_dota_enraged_wildkin_tornado", self:GetCaster():GetAbsOrigin(), true, nil, nil, self:GetCaster():GetTeamNumber())
		tornado:SetOwner(self:GetCaster())
		tornado:AddNewModifier(self:GetCaster(), self, "modifier_windrunner_windrun_custom_tornado", { duration = self.modifier_windrunner_9_duration })
		if self:GetCaster():HasModifier("modifier_windrunner_11") then
			tornado:AddNewModifier( self:GetCaster(), self, "modifier_windrunner_windrun_pull_buff", {} )
		end
	end
end

modifier_windrunner_windrun_custom_tooltip = class({})

function modifier_windrunner_windrun_custom_tooltip:IsHidden() return true end
function modifier_windrunner_windrun_custom_tooltip:IsPurgable() return true end
function modifier_windrunner_windrun_custom_tooltip:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_windrunner_windrun_custom")
end

modifier_windrunner_windrun_custom = class({})

function modifier_windrunner_windrun_custom:IsPurgable()
	return true
end

function modifier_windrunner_windrun_custom:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.evasion = self:GetAbility():GetSpecialValueFor( "evasion_pct_tooltip" )
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "movespeed_bonus_pct" )
	self.aura_duration = 2.5
	self.distance_to_tornado = 0
	self.distance_to_update_skill = 0
	self.currentpos = self:GetParent():GetAbsOrigin()
	self:StartIntervalThink(FrameTime())
end

function modifier_windrunner_windrun_custom:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_windrunner_windrun_custom:OnIntervalThink()
	if not IsServer() then return end
	local pos = self:GetParent():GetOrigin()
	local dist = (pos - self.currentpos):Length2D()
	self.currentpos = pos
	if dist > 1000 then return end
	if self:GetCaster():HasModifier("modifier_windrunner_15") then
		self.distance_to_tornado = self.distance_to_tornado + dist
		if self.distance_to_tornado > self:GetAbility().modifier_windrunner_15_distance then
			self:GetAbility():CreateTornado()
			self.distance_to_tornado = 0
		end
	end
end

function modifier_windrunner_windrun_custom:OnDestroy()
	if not IsServer() then return end
end

function modifier_windrunner_windrun_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return funcs
end

function modifier_windrunner_windrun_custom:GetActivityTranslationModifiers()
	return "windrun"
end

function modifier_windrunner_windrun_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end

function modifier_windrunner_windrun_custom:GetModifierEvasion_Constant()
	return self.evasion
end

function modifier_windrunner_windrun_custom:GetEffectName()
	return "particles/units/heroes/hero_windrunner/windrunner_windrun.vpcf"
end

function modifier_windrunner_windrun_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_windrunner_windrun_custom_tornado = class({})

function modifier_windrunner_windrun_custom_tornado:OnCreated()
	if not IsServer() then return end
	self.radius = self:GetAbility().modifier_windrunner_9_radius
	self.damage = self:GetAbility().modifier_windrunner_9_damage

	if self:GetCaster():HasModifier("modifier_windrunner_10") then
		self.damage = self.damage + ( self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_windrunner_10_agility_damage[self:GetCaster():GetTalentLevel("modifier_windrunner_10")])
	end

	local particle = ParticleManager:CreateParticle("particles/neutral_fx/tornado_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
	self:GetParent():EmitSound("n_creep_Wildkin.Tornado")
	self:StartIntervalThink(0.5)
end

function modifier_windrunner_windrun_custom_tornado:OnIntervalThink()
	if not IsServer() then return end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _, enemy in pairs(enemies) do
		ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = self.damage / 2, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility()})
	end
end

function modifier_windrunner_windrun_custom_tornado:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end

function modifier_windrunner_windrun_custom_tornado:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("n_creep_Wildkin.Tornado")
    self:GetParent():Destroy()
end

modifier_windrunner_windrun_pull_buff = class({})
function modifier_windrunner_windrun_pull_buff:IsHidden() return true end
function modifier_windrunner_windrun_pull_buff:IsPurgable() return false end
function modifier_windrunner_windrun_pull_buff:IsAura() return true end

function modifier_windrunner_windrun_pull_buff:GetModifierAura()
	return "modifier_windrunner_windrun_pull_debuff"
end

function modifier_windrunner_windrun_pull_buff:GetAuraRadius()
	return 400
end

function modifier_windrunner_windrun_pull_buff:GetAuraDuration()
	return 0.1
end

function modifier_windrunner_windrun_pull_buff:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_windrunner_windrun_pull_buff:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_windrunner_windrun_pull_debuff = class({})
function modifier_windrunner_windrun_pull_debuff:IsPurgable() return false end
function modifier_windrunner_windrun_pull_debuff:IsHidden() return true end
function modifier_windrunner_windrun_pull_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_windrunner_windrun_pull_debuff:OnCreated()
	if not IsServer() then return end
	self.effect_cast = ParticleManager:CreateParticle( "particles/windrunner_pull.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( self.effect_cast, 1, self:GetAuraOwner():GetAbsOrigin() )
	self:AddParticle(self.effect_cast, false, false, -1, false, false)
	self:StartIntervalThink(1)
end

function modifier_windrunner_windrun_pull_debuff:OnIntervalThink()
	if not IsServer() then return end
    local modifier_windrunner_11_duration = self:GetAbility().modifier_windrunner_11_duration[self:GetCaster():GetTalentLevel("modifier_windrunner_11")]
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_windrunner_windrun_pull_armor_debuff", {duration = modifier_windrunner_11_duration * (1 - self:GetParent():GetStatusResistance())})
end

function modifier_windrunner_windrun_pull_debuff:OnDestroy()
	if not IsServer() then return end
	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, true)
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end

modifier_windrunner_windrun_pull_armor_debuff = class({})

function modifier_windrunner_windrun_pull_armor_debuff:IsDebuff() return true end

function modifier_windrunner_windrun_pull_armor_debuff:OnCreated()
    if not IsServer() then return end
    if self:GetStackCount() >= self:GetAbility().modifier_windrunner_11_max then return end
    self:IncrementStackCount()
    local modifier_windrunner_11_duration = self:GetAbility().modifier_windrunner_11_duration[self:GetCaster():GetTalentLevel("modifier_windrunner_11")]
    Timers:CreateTimer(modifier_windrunner_11_duration, function()
        if self and not self:IsNull() then
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_windrunner_windrun_pull_armor_debuff:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() >= self:GetAbility().modifier_windrunner_11_max then return end
    self:IncrementStackCount()
    local modifier_windrunner_11_duration = self:GetAbility().modifier_windrunner_11_duration[self:GetCaster():GetTalentLevel("modifier_windrunner_11")]
    Timers:CreateTimer(modifier_windrunner_11_duration, function()
        if self and not self:IsNull() then
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_windrunner_windrun_pull_armor_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_windrunner_windrun_pull_armor_debuff:GetModifierPhysicalArmorBonus()
    return self:GetStackCount() * self:GetAbility().modifier_windrunner_11
end