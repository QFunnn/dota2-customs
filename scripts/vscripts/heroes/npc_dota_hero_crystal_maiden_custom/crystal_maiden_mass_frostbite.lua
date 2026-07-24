--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_crystal_maiden_mass_frostbite", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_mass_frostbite", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_crystal_maiden_mass_frostbite_thinker", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_mass_frostbite", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )

crystal_maiden_mass_frostbite = class({})

function crystal_maiden_mass_frostbite:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/econ/items/ancient_apparition/ancient_apparation_ti8/ancient_ice_vortex_ti8.vpcf', context )
    PrecacheResource( "particle", 'particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_crystalmaiden_persona/cm_persona_nova.vpcf', context )
end

function crystal_maiden_mass_frostbite:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function crystal_maiden_mass_frostbite:OnSpellStart()
	if not IsServer() then return end
    local point = self:GetCursorPosition()
    local clone_duration = self:GetSpecialValueFor("clone_duration")
    local hop_duration_custom = self:GetSpecialValueFor("hop_duration_custom")
    local hop_distance_custom = self:GetSpecialValueFor("hop_distance_custom")
    local origin = self:GetCaster():GetAbsOrigin()

    local direction = point - self:GetCaster():GetAbsOrigin()
    direction.z = 0
    direction = direction:Normalized()

    local crystal_maiden_unit = CreateUnitByName("npc_dota_companion", origin, false, nil, nil, self:GetCaster():GetTeamNumber())
    if crystal_maiden_unit then
        crystal_maiden_unit:AddNewModifier(self:GetCaster(), self, "modifier_crystal_maiden_mass_frostbite", {duration = clone_duration-FrameTime()})
        --CreateModifierThinker(self:GetCaster(), self, "modifier_crystal_maiden_mass_frostbite_thinker", {duration = clone_duration-FrameTime()}, origin, self:GetCaster():GetTeamNumber(), false)
        crystal_maiden_unit:AddNewModifier(self:GetCaster(), self, "modifier_crystal_maiden_crystal_clone", {duration = clone_duration})
        crystal_maiden_unit:SetAbsOrigin(origin)
    end
    self:GetCaster():EmitSound("Hero_Crystal.CrystalClone.Cast")
    local knockback = self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = hop_duration_custom, distance = hop_distance_custom, height = 0, direction_x = direction.x, direction_y = direction.y})
    if knockback then
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_crystal_clone_movement.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        knockback:AddParticle(particle, false, false, -1, false, false)
    end
end

modifier_crystal_maiden_mass_frostbite = class({})

function modifier_crystal_maiden_mass_frostbite:IsHidden() return true end

function modifier_crystal_maiden_mass_frostbite:IsPurgable() return false end

function modifier_crystal_maiden_mass_frostbite:OnCreated()
	if not IsServer() then return end
    self:GetParent():RemoveGesture(ACT_DOTA_SPAWN)
    self:GetParent():StartGesture(ACT_DOTA_IDLE)
    self.crystal_maiden = nil
	self:StartIntervalThink(FrameTime())
end

function modifier_crystal_maiden_mass_frostbite:OnIntervalThink()
    if not IsServer() then return end
    if self.crystal_maiden then
        if not IsValidCustom(self.crystal_maiden) or not self.crystal_maiden:IsAlive() then
            self:StartIntervalThink(-1)
            self:Destroy()
        end
        return
    end
    local units = FindUnitsInRadius(self:GetParent():GetTeamNumber(),self:GetParent():GetAbsOrigin(),nil,300,DOTA_UNIT_TARGET_TEAM_BOTH,DOTA_UNIT_TARGET_HERO,DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,0,false)
    for _, unit in pairs(units) do
        print(unit:GetUnitName(), unit:HasModifier("modifier_crystal_maiden_crystal_clone_statue"))
        if unit:HasModifier("modifier_crystal_maiden_crystal_clone_statue") then
            self.crystal_maiden = unit
            break
        end
    end
end

function modifier_crystal_maiden_mass_frostbite:CheckState()
    return
    {
        [MODIFIER_STATE_FROZEN] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    }
end

function modifier_crystal_maiden_mass_frostbite:GetStatusEffectName()
    return "particles/status_fx/status_effect_frost_lich.vpcf"
end

function modifier_crystal_maiden_mass_frostbite:OnDestroy()
	if not IsServer() then return end
    local ability = self:GetCaster():FindAbilityByName("crystal_maiden_frostbite_custom")
	if ability then
		local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_nova.vpcf", PATTACH_WORLDORIGIN, self:GetParent() )
		ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetAbsOrigin() )
		ParticleManager:SetParticleControl( effect_cast, 1, Vector(self:GetAbility():GetSpecialValueFor("radius"), self:GetAbility():GetSpecialValueFor("radius"), self:GetAbility():GetSpecialValueFor("radius")) )
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(),self:GetParent():GetAbsOrigin(),nil,self:GetAbility():GetSpecialValueFor("radius"),DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,0,0,false)
		for _, enemy in pairs(enemies) do
			ability:OnSpellStart(enemy)
		end
	end
    self:GetParent():EmitSound("Hero_Crystal.CrystalClone.Destroy")
    self:GetParent():Destroy()
end

modifier_crystal_maiden_mass_frostbite_thinker = class({})
function modifier_crystal_maiden_mass_frostbite_thinker:IsHidden() return true end
function modifier_crystal_maiden_mass_frostbite_thinker:IsPurgable() return false end
function modifier_crystal_maiden_mass_frostbite_thinker:OnDestroy()
    if not IsServer() then return end
	EmitSoundOnLocationWithCaster( self:GetParent():GetAbsOrigin(), "Hero_Crystal.CrystalNova", self:GetCaster() )
	
end