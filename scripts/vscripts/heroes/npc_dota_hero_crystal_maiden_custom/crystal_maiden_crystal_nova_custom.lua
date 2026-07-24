--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_crystal_maiden_crystal_nova_custom", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_crystal_nova_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_crystal_nova_custom_frostbite_talent", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_crystal_nova_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_crystal_nova_custom_debuff_regeneration", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_crystal_nova_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_crystal_nova_custom_buff_regeneration", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_crystal_nova_custom.lua", LUA_MODIFIER_MOTION_NONE )

crystal_maiden_crystal_nova_custom = class({})

function crystal_maiden_crystal_nova_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf', context )
    PrecacheResource( "particle", 'particles/crystal_maiden_2stack.vpcf', context )
    PrecacheResource( "particle", 'particles/generic_gameplay/generic_slowed_cold.vpcf', context )
end

-- Таланты
crystal_maiden_crystal_nova_custom.modifier_crystal_maiden_1 = {-1,-2,-3}
crystal_maiden_crystal_nova_custom.modifier_crystal_maiden_2_stack_duration = 15
crystal_maiden_crystal_nova_custom.modifier_crystal_maiden_2_stack_frostbite = 3
crystal_maiden_crystal_nova_custom.modifier_crystal_maiden_3_bonus_radius = {100, 200}
crystal_maiden_crystal_nova_custom.modifier_crystal_maiden_4_damage_from_max_health = 6
crystal_maiden_crystal_nova_custom.modifier_crystal_maiden_5_regeneration_reduce = {-10,-20,-30}
crystal_maiden_crystal_nova_custom.modifier_crystal_maiden_5_duration = 5
crystal_maiden_crystal_nova_custom.modifier_crystal_maiden_6_duration = 5
crystal_maiden_crystal_nova_custom.modifier_crystal_maiden_6_bonus_regeneration_per_effect = {10,15,20}


function crystal_maiden_crystal_nova_custom:GetCastRange( location , target)
    if self:GetCaster():HasModifier("modifier_crystal_maiden_3") then
        return self:GetSpecialValueFor("radius") + self.modifier_crystal_maiden_3_bonus_radius[self:GetCaster():GetTalentLevel("modifier_crystal_maiden_3")]
    end
    return self.BaseClass.GetCastRange(self, location, target)
end

-- AOE Radius
function crystal_maiden_crystal_nova_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function crystal_maiden_crystal_nova_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_crystal_maiden_1") then
	    bonus = self.modifier_crystal_maiden_1[self:GetCaster():GetTalentLevel("modifier_crystal_maiden_1")]
	end
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function crystal_maiden_crystal_nova_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_crystal_maiden_3") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end

function crystal_maiden_crystal_nova_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("nova_damage")
	local radius = self:GetSpecialValueFor("radius")

	if self:GetCaster():HasModifier("modifier_crystal_maiden_3") then
	    radius = radius + self.modifier_crystal_maiden_3_bonus_radius[self:GetCaster():GetTalentLevel("modifier_crystal_maiden_3")]
	    point = self:GetCaster():GetAbsOrigin()
	end

	local debuffDuration = self:GetSpecialValueFor("duration")
	local vision_radius = radius
	local vision_duration = self:GetSpecialValueFor("vision_duration")
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(),point,nil,radius,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,0,0,false)
	if self:GetCaster():HasModifier("modifier_crystal_maiden_4") then
		damage = damage + ( self:GetCaster():GetMaxHealth() / 100 * self.modifier_crystal_maiden_4_damage_from_max_health )
	end
    local damageTable = {attacker = caster,damage = damage,damage_type = DAMAGE_TYPE_MAGICAL,ability = self}
    local friendly = FindUnitsInRadius(self:GetCaster():GetTeamNumber(),point,nil,radius,DOTA_UNIT_TARGET_TEAM_FRIENDLY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,0,0,false)
    for _, friendly_target in pairs(friendly) do
        if friendly_target:HasModifier("modifier_crystal_maiden_crystal_clone_statue") then
            damageTable.victim = friendly_target
		    ApplyDamage(damageTable)
        end
    end

	for _,enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
		enemy:AddNewModifier(caster,self,"modifier_crystal_maiden_crystal_nova_custom",{duration = debuffDuration * ( 1 - enemy:GetStatusResistance() )})
		if self:GetCaster():HasModifier("modifier_crystal_maiden_2") then 
			enemy:AddNewModifier(self:GetCaster(), self, "modifier_crystal_maiden_crystal_nova_custom_frostbite_talent", {duration = self.modifier_crystal_maiden_2_stack_duration})
		end
		if self:GetCaster():HasModifier("modifier_crystal_maiden_5") then
			enemy:AddNewModifier(self:GetCaster(), self, "modifier_crystal_maiden_crystal_nova_custom_debuff_regeneration", {duration = self.modifier_crystal_maiden_5_duration * ( 1 - enemy:GetStatusResistance() )})
		end
	end

	if self:GetCaster():HasModifier("modifier_crystal_maiden_6") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_crystal_maiden_crystal_nova_custom_buff_regeneration", {duration = self.modifier_crystal_maiden_6_duration})
	end

	AddFOWViewer(self:GetCaster():GetTeamNumber(),point,vision_radius,vision_duration,true)
	self:PlayEffects(point,radius,debuffDuration)
end

-- Sound and Particle
function crystal_maiden_crystal_nova_custom:PlayEffects(point,radius,duration)
	local particle_cast = "particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf"
	local sound_cast = "Hero_Crystal.CrystalNova"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, duration, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
end


modifier_crystal_maiden_crystal_nova_custom_debuff_regeneration = class({})

function modifier_crystal_maiden_crystal_nova_custom_debuff_regeneration:IsPurgable() return true end

function modifier_crystal_maiden_crystal_nova_custom_debuff_regeneration:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_crystal_maiden_crystal_nova_custom_debuff_regeneration:GetModifierHPRegenAmplify_Percentage()
	return self:GetAbility().modifier_crystal_maiden_5_regeneration_reduce[self:GetCaster():GetTalentLevel("modifier_crystal_maiden_5")]
end

modifier_crystal_maiden_crystal_nova_custom_buff_regeneration = class({})

function modifier_crystal_maiden_crystal_nova_custom_buff_regeneration:IsPurgable() return true end

function modifier_crystal_maiden_crystal_nova_custom_buff_regeneration:OnCreated()
	if not IsServer() then return end
	self:IncrementStackCount()
    Timers:CreateTimer(self:GetDuration(), function()
        if self and not self:IsNull() then
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_crystal_maiden_crystal_nova_custom_buff_regeneration:OnRefresh()
	if not IsServer() then return end
    self:OnCreated()
end

function modifier_crystal_maiden_crystal_nova_custom_buff_regeneration:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_crystal_maiden_crystal_nova_custom_buff_regeneration:GetModifierConstantHealthRegen()
	return self:GetAbility().modifier_crystal_maiden_6_bonus_regeneration_per_effect[self:GetCaster():GetTalentLevel("modifier_crystal_maiden_6")] * self:GetStackCount()
end

modifier_crystal_maiden_crystal_nova_custom_frostbite_talent = class({})

function modifier_crystal_maiden_crystal_nova_custom_frostbite_talent:IsPurgable() return false end
function modifier_crystal_maiden_crystal_nova_custom_frostbite_talent:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self.particle = ParticleManager:CreateParticle( "particles/crystal_maiden_2stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.particle, 1, Vector( 0, self:GetStackCount(), 0 ) )
	self:AddParticle(self.particle,false, false, -1, false, false)
end
function modifier_crystal_maiden_crystal_nova_custom_frostbite_talent:OnRefresh()
	if not IsServer() then return end
	self:IncrementStackCount()
	ParticleManager:SetParticleControl( self.particle, 1, Vector( 0, self:GetStackCount(), 0 ) )
	if self:GetStackCount() >= self:GetAbility().modifier_crystal_maiden_2_stack_frostbite then
		local ability = self:GetCaster():FindAbilityByName("crystal_maiden_frostbite_custom")
		if ability then 
			ability:OnSpellStart(self:GetParent())
		end
		self:Destroy()
	end
end

function modifier_crystal_maiden_crystal_nova_custom_buff_regeneration:GetTexture()
	return "crystal_maiden_6"
end

-- Modifier
modifier_crystal_maiden_crystal_nova_custom = class({})

function modifier_crystal_maiden_crystal_nova_custom:IsHidden()
	return false
end

function modifier_crystal_maiden_crystal_nova_custom:IsDebuff()
	return true
end

function modifier_crystal_maiden_crystal_nova_custom:IsPurgable()
	return true
end

function modifier_crystal_maiden_crystal_nova_custom:OnCreated( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attackspeed_slow" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "movespeed_slow" )
end

function modifier_crystal_maiden_crystal_nova_custom:OnRefresh( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attackspeed_slow" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "movespeed_slow" )
end

function modifier_crystal_maiden_crystal_nova_custom:DeclareFunctions()
	local funcs = {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT}
	return funcs
end

function modifier_crystal_maiden_crystal_nova_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_crystal_maiden_crystal_nova_custom:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

-- Graphics & Animations
function modifier_crystal_maiden_crystal_nova_custom:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_crystal_maiden_crystal_nova_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end