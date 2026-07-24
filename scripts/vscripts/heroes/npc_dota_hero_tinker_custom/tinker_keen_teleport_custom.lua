--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


tinker_keen_teleport_custom = class({})

function tinker_keen_teleport_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/econ/events/fall_2021/blink_dagger_fall_2021_start.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/fall_2021/blink_dagger_fall_2021_end.vpcf", context )
end

function tinker_keen_teleport_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("cast_range")
    end
end

function tinker_keen_teleport_custom:OnSpellStart()
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()
    end
    local start_pos = self:GetCaster():GetAbsOrigin()
    local cast_range = self:GetSpecialValueFor("cast_range") + self:GetCaster():GetCastRangeBonus()
    local direction = point - start_pos
    direction.z = 0
    local distance = direction:Length2D()
    direction = direction:Normalized()
    if distance > cast_range then
        point = start_pos + direction * cast_range
    end

    local particle_start = ParticleManager:CreateParticle( "particles/econ/events/fall_2021/blink_dagger_fall_2021_start.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( particle_start, 0, start_pos )
	ParticleManager:SetParticleControlForward( particle_start, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( particle_start )
    EmitSoundOnLocationWithCaster( start_pos, "DOTA_Item.BlinkDagger.Activate", self:GetCaster() )

    FindClearSpaceForUnit(self:GetCaster(), point, true)

    local particle_end = ParticleManager:CreateParticle( "particles/econ/events/fall_2021/blink_dagger_fall_2021_end.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( particle_end, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( particle_end, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( particle_end )
    EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "DOTA_Item.BlinkDagger.Activate", self:GetCaster() )

    local cooldown_item = self:GetSpecialValueFor("cooldown_item")

    for i = 0, 8 do
		local item = self:GetCaster():GetItemInSlot( i )
		if item then
			local cooldown = item:GetCooldownTimeRemaining()
            if cooldown > 0 then
                item:EndCooldown()
                cooldown = cooldown + cooldown_item
                if cooldown > 0 then
                    item:StartCooldown(cooldown)
                end
            end
		end
	end
end