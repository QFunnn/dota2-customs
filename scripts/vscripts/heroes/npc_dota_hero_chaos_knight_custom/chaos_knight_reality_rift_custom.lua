--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_chaos_knight_reality_rift_custom", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_reality_rift_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_chaos_knight_reality_rift_custom_break", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_reality_rift_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_chaos_knight_reality_rift_custom_silence", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_reality_rift_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_chaos_knight_reality_rift_custom_disarmed", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_reality_rift_custom", LUA_MODIFIER_MOTION_NONE )

chaos_knight_reality_rift_custom = class({})
chaos_knight_reality_rift_custom.modifier_chaos_knight_8 = 450
chaos_knight_reality_rift_custom.modifier_chaos_knight_3 = {1,2,3}
chaos_knight_reality_rift_custom.modifier_chaos_knight_10 = {1,2,3}
chaos_knight_reality_rift_custom.modifier_chaos_knight_17 = {1,2,3}

function chaos_knight_reality_rift_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_oracle/oracle_fatesedict_disarm.vpcf", context)
end

function chaos_knight_reality_rift_custom:HasReality()
    if self:GetCaster():HasModifier("modifier_chaos_knight_8") and self:GetCaster():HasModifier("modifier_chaos_knight_3") and self:GetCaster():HasModifier("modifier_chaos_knight_10") and self:GetCaster():HasModifier("modifier_chaos_knight_17") then
        return true
    end
end

function chaos_knight_reality_rift_custom:GetBehavior()
    if self:HasReality() then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end

function chaos_knight_reality_rift_custom:GetAOERadius()
    if self:GetCaster():HasModifier("modifier_chaos_knight_8") then
        return self.modifier_chaos_knight_8
    end
end

function chaos_knight_reality_rift_custom:OnAbilityPhaseStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
    local position_point = self:GetCursorPosition()
    local direction = position_point - caster:GetOrigin()
    direction.z = 0
    direction = direction:Normalized()
	local min_loc = 50
	local max_loc = 55
    self.particles = {}
    if target then
        self.point = SplineVectors( caster:GetOrigin(), target:GetOrigin(), RandomInt(min_loc,max_loc)/100 )
    end

    self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_chaos_knight/chaos_knight_reality_rift.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
    if target then
        ParticleManager:SetParticleControlEnt( self.effect_cast, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
        ParticleManager:SetParticleControlEnt( self.effect_cast, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
        ParticleManager:SetParticleControl( self.effect_cast, 2, self.point )
        ParticleManager:SetParticleControlForward( self.effect_cast, 2, (target:GetOrigin()-caster:GetOrigin()):Normalized() )
    else
        ParticleManager:SetParticleControlEnt( self.effect_cast, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
        ParticleManager:SetParticleControlEnt( self.effect_cast, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
        ParticleManager:SetParticleControl( self.effect_cast, 2, position_point )
        ParticleManager:SetParticleControlForward( self.effect_cast, 2, direction)
    end

    table.insert(self.particles, self.effect_cast)

	caster:EmitSound("Hero_ChaosKnight.RealityRift")

    local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), caster:GetOrigin(), nil, 1375, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
	local illusions = {}
	for _,hero in pairs(heroes) do
		if hero:IsIllusion() and hero:GetPlayerOwnerID()==caster:GetPlayerOwnerID() then
			table.insert( illusions, hero )
		end
	end
    for _, illusion in pairs(illusions) do
        local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_chaos_knight/chaos_knight_reality_rift.vpcf", PATTACH_ABSORIGIN_FOLLOW, illusion )
        if target then
            ParticleManager:SetParticleControlEnt( pfx, 0, illusion, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", illusion:GetOrigin(), true )
            ParticleManager:SetParticleControlEnt( pfx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
            ParticleManager:SetParticleControl( pfx, 2, self.point )
            ParticleManager:SetParticleControlForward( pfx, 2, (target:GetOrigin()-illusion:GetOrigin()):Normalized() )
        else
            ParticleManager:SetParticleControlEnt( pfx, 0, illusion, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", illusion:GetOrigin(), true )
            ParticleManager:SetParticleControlEnt( pfx, 1, illusion, PATTACH_POINT_FOLLOW, "attach_hitloc", illusion:GetOrigin(), true )
            ParticleManager:SetParticleControl( pfx, 2, position_point )
            ParticleManager:SetParticleControlForward( pfx, 2, direction)
        end
        table.insert(self.particles, pfx)
    end
	return true
end

function chaos_knight_reality_rift_custom:OnAbilityPhaseInterrupted()
    if not IsServer() then return end
    for _,particle in pairs(self.particles) do
        ParticleManager:DestroyParticle(particle, true)
    end
end

function chaos_knight_reality_rift_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
    local position_point = self:GetCursorPosition()
    local direction = position_point - caster:GetOrigin()
    direction.z = 0
    direction = direction:Normalized()
    for _,particle in pairs(self.particles) do
        ParticleManager:DestroyParticle(particle, false)
    end
    if target then
	    if target:TriggerSpellAbsorb( self ) then return end
    end
	local point = self.point
    if not target then
        point = position_point
    end
	local search_radius = 1375
	local distance = 64
	self.point = nil
	local relative = (point - caster:GetOrigin()):Normalized() * distance
	selfLoc = point + relative

	local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), caster:GetOrigin(), nil, search_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
	local illusions = {}
	for _,hero in pairs(heroes) do
		if hero:IsIllusion() and hero:GetPlayerOwnerID()==caster:GetPlayerOwnerID() then
			table.insert( illusions, hero )
		end
	end

    if target then
	    target:SetOrigin( selfLoc )
	    FindClearSpaceForUnit( target, selfLoc, true )
    end

    if target then
        caster:SetOrigin( point )
        FindClearSpaceForUnit( caster, point, true )
        caster:SetForwardVector( (target:GetOrigin()-caster:GetOrigin()):Normalized() )
        caster:MoveToTargetToAttack( target )
        for _,illusion in pairs(illusions) do
            illusion:SetOrigin( selfLoc )
            FindClearSpaceForUnit( illusion, selfLoc, false )
            illusion:SetForwardVector( (target:GetOrigin()-illusion:GetOrigin()):Normalized() )
            illusion:MoveToTargetToAttack( target )
        end
    else
        caster:SetOrigin( position_point )
        FindClearSpaceForUnit( caster, position_point, true )
        caster:SetForwardVector( direction )
        for _,illusion in pairs(illusions) do
            illusion:SetOrigin( position_point )
            FindClearSpaceForUnit( illusion, position_point, false )
            illusion:SetForwardVector( direction )
        end
    end

    local search_position = position_point

    if target then
        self:ApplyEffects(target)
        target:EmitSound("Hero_ChaosKnight.RealityRift.Target")
        search_position = target:GetOrigin()
    end

    if self:GetCaster():HasModifier("modifier_chaos_knight_8") then
        local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), search_position, nil, self.modifier_chaos_knight_8, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
        for _, enemy in pairs(enemies) do
            self:ApplyEffects(enemy)
        end
    end
end

function chaos_knight_reality_rift_custom:ApplyEffects(target)
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    target:AddNewModifier( caster, self, "modifier_chaos_knight_reality_rift_custom", { duration = duration * ( 1 - target:GetStatusResistance() ) } )

    if caster:HasModifier("modifier_chaos_knight_3") then
        target:AddNewModifier(caster, self, "modifier_chaos_knight_reality_rift_custom_break", {duration = self.modifier_chaos_knight_3[caster:GetTalentLevel("modifier_chaos_knight_3")] * ( 1 - target:GetStatusResistance() )})
    end

    if caster:HasModifier("modifier_chaos_knight_10") then
        target:AddNewModifier(caster, self, "modifier_chaos_knight_reality_rift_custom_silence", {duration = self.modifier_chaos_knight_10[caster:GetTalentLevel("modifier_chaos_knight_10")] * ( 1 - target:GetStatusResistance() )})
    end

    if caster:HasModifier("modifier_chaos_knight_17") then
        target:AddNewModifier(caster, self, "modifier_chaos_knight_reality_rift_custom_disarmed", {duration = self.modifier_chaos_knight_17[caster:GetTalentLevel("modifier_chaos_knight_17")] * ( 1 - target:GetStatusResistance() )})
    end
end

modifier_chaos_knight_reality_rift_custom = class({})

function modifier_chaos_knight_reality_rift_custom:OnCreated( kv )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
end

function modifier_chaos_knight_reality_rift_custom:OnRefresh( kv )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
end

function modifier_chaos_knight_reality_rift_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_chaos_knight_reality_rift_custom:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end


modifier_chaos_knight_reality_rift_custom_break = class({})
function modifier_chaos_knight_reality_rift_custom_break:GetTexture() return "chaos_3" end

function modifier_chaos_knight_reality_rift_custom_break:CheckState()
    return
    {
        [MODIFIER_STATE_PASSIVES_DISABLED] = true,
    }
end

function modifier_chaos_knight_reality_rift_custom_break:GetEffectName()
    return "particles/generic_gameplay/generic_break.vpcf"
end

function modifier_chaos_knight_reality_rift_custom_break:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

modifier_chaos_knight_reality_rift_custom_silence = class({})
function modifier_chaos_knight_reality_rift_custom_silence:GetTexture() return "chaos_10" end

function modifier_chaos_knight_reality_rift_custom_silence:CheckState()
    return
    {
        [MODIFIER_STATE_SILENCED] = true,
    }
end

function modifier_chaos_knight_reality_rift_custom_silence:GetEffectName()
    return "particles/items2_fx/bloodthorn_silenced.vpcf"
end

function modifier_chaos_knight_reality_rift_custom_silence:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

modifier_chaos_knight_reality_rift_custom_disarmed = class({})
function modifier_chaos_knight_reality_rift_custom_disarmed:GetTexture() return "chaos_17" end

function modifier_chaos_knight_reality_rift_custom_disarmed:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_chaos_knight_reality_rift_custom_disarmed:GetEffectName()
    return "particles/units/heroes/hero_oracle/oracle_fatesedict_disarm.vpcf"
end

function modifier_chaos_knight_reality_rift_custom_disarmed:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end