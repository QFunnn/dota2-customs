--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_tinker_defense_matrix_custom", "heroes/npc_dota_hero_tinker_custom/tinker_defense_matrix_custom", LUA_MODIFIER_MOTION_NONE )

tinker_defense_matrix_custom = class({})
tinker_defense_matrix_custom.modifier_tinker_17 = {150,300} 

function tinker_defense_matrix_custom:OnSpellStart()
    local target = self:GetCursorTarget()
    local caster = self:GetCaster()
    local barrier_duration = self:GetSpecialValueFor("barrier_duration")
    target:RemoveModifierByName("modifier_tinker_defense_matrix_custom")
    target:AddNewModifier(caster, self, "modifier_tinker_defense_matrix_custom", {duration = barrier_duration})
end

function tinker_defense_matrix_custom:TeleportParent(target)
    local start_pos = target:GetAbsOrigin()
    local direction = target:GetForwardVector()
    if self:GetAutoCastState() then
        direction = target:GetForwardVector() * -1
    end
    local random_angle = RandomFloat(-45, 45)
    local random_direction = RotatePosition(Vector(0,0,0), QAngle(0, random_angle, 0), direction)
    local position = target:GetAbsOrigin() + random_direction * 0

    local particle_start = ParticleManager:CreateParticle( "particles/items_fx/blink_dagger_start.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( particle_start, 0, start_pos )
	ParticleManager:SetParticleControlForward( particle_start, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( particle_start )
    EmitSoundOnLocationWithCaster( start_pos, "DOTA_Item.BlinkDagger.Activate", target )

    FindClearSpaceForUnit(target, position, true)

    local particle_end = ParticleManager:CreateParticle( "particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN, target )
	ParticleManager:SetParticleControl( particle_end, 0, target:GetOrigin() )
	ParticleManager:SetParticleControlForward( particle_end, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( particle_end )
    EmitSoundOnLocationWithCaster( target:GetOrigin(), "DOTA_Item.BlinkDagger.Activate", target )
end

modifier_tinker_defense_matrix_custom = class({})
function modifier_tinker_defense_matrix_custom:IsHidden() return false end

function modifier_tinker_defense_matrix_custom:OnCreated(params)
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.damage_absorb = self:GetAbility():GetSpecialValueFor("damage_absorb")
    if self:GetCaster():HasModifier("modifier_tinker_17") then
        self.damage_absorb = self.damage_absorb + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_tinker_17[self:GetCaster():GetTalentLevel("modifier_tinker_17")])
    end
    self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")
    if IsClient() then
        local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_defense_matrix.vpcf", PATTACH_POINT_FOLLOW, self.parent)
        ParticleManager:SetParticleControlEnt( particle2, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
        self:AddParticle(particle2, false, false, -1, false, false)
    end
    if not IsServer() then return end
    self.shield = self.damage_absorb
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_defense_matrix_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
    ParticleManager:SetParticleControlEnt(particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_attack1", self.caster:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    self.caster:EmitSound("Hero_Tinker.DefensiveMatrix.Cast")
    self.parent:EmitSound("Hero_Tinker.DefensiveMatrix.Target")
    self:SetHasCustomTransmitterData(true)
end

function modifier_tinker_defense_matrix_custom:OnDestroy()
    if not IsServer() then return end
    self.parent:StopSound("Hero_Tinker.DefensiveMatrix.Target")
end

function modifier_tinker_defense_matrix_custom:AddCustomTransmitterData() 
    return 
    { 
        shield = self.shield,
    }
end

function modifier_tinker_defense_matrix_custom:HandleCustomTransmitterData(data)
    self.shield = data.shield
end

function modifier_tinker_defense_matrix_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    }
end

function modifier_tinker_defense_matrix_custom:GetModifierStatusResistanceStacking()
    return self.status_resistance
end

function modifier_tinker_defense_matrix_custom:GetModifierIncomingDamageConstant(params)
    if IsClient() then 
        if params.report_max then 
            return self.damage_absorb
        else 
            return self.shield
        end 
    end
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_defense_matrix_pulse.vpcf", PATTACH_POINT_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt( particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    local damage = math.min(params.damage, self.shield)
    self.shield = math.max(0, self.shield - damage)
    if self.shield <= 0 then
        self:Destroy()
    end
    self:SendBuffRefreshToClients()
    return -damage
end