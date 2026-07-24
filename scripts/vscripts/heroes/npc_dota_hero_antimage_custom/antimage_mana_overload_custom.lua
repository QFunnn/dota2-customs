--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_antimage_mana_overload_custom_illusion", "heroes/npc_dota_hero_antimage_custom/antimage_mana_overload_custom", LUA_MODIFIER_MOTION_NONE)

antimage_mana_overload_custom = class({})

function antimage_mana_overload_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_antimage/antimage_blink_start.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_antimage/antimage_blink_end.vpcf', context )
end

function antimage_mana_overload_custom:OnSpellStart()
	if not IsServer() then return end

	local point = self:GetCursorPosition()

	local duration = self:GetSpecialValueFor("duration")

	local outgoing_damage = self:GetSpecialValueFor("outgoing_damage") - 100

	local incoming_damage = self:GetSpecialValueFor("incoming_damage") - 100	

	local illusion = CreateIllusions( self:GetCaster(), self:GetCaster(), {duration=duration,outgoing_damage=outgoing_damage,incoming_damage=incoming_damage}, 1, 0, false, false )  

	for k, v in pairs(illusion) do
		v:AddNewModifier(self:GetCaster(), self, "modifier_antimage_mana_overload_custom_illusion", {})

		local direction = (point - v:GetAbsOrigin())
		direction.z = 0
		direction = direction:Normalized()
	      
		local particle_start = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_blink_start.vpcf", PATTACH_ABSORIGIN, v )
		ParticleManager:SetParticleControl( particle_start, 0, v:GetAbsOrigin() )
		ParticleManager:SetParticleControlForward( particle_start, 0, direction:Normalized() )
		ParticleManager:ReleaseParticleIndex( particle_start )
		EmitSoundOnLocationWithCaster( v:GetAbsOrigin(), "Hero_Antimage.Blink_out", v )

    	FindClearSpaceForUnit(v, point, true)

    	v:StartGesture(ACT_DOTA_CAST_ABILITY_2)

		local particle_end = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_blink_end.vpcf", PATTACH_ABSORIGIN, v )
		ParticleManager:SetParticleControl( particle_end, 0, v:GetOrigin() )
		ParticleManager:SetParticleControlForward( particle_end, 0, direction:Normalized() )
		ParticleManager:ReleaseParticleIndex( particle_end )
		EmitSoundOnLocationWithCaster( v:GetOrigin(), "Hero_Antimage.Blink_in", v )

    	Timers:CreateTimer(0.1, function()
    		v:MoveToPositionAggressive(point)
    	end)
    end
end

modifier_antimage_mana_overload_custom_illusion = class({})
function modifier_antimage_mana_overload_custom_illusion:IsHidden() return false end
function modifier_antimage_mana_overload_custom_illusion:IsPurgable() return false end