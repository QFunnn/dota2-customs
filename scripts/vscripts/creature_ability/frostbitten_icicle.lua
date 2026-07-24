--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


frostbitten_icicle = class({})
LinkLuaModifier( "modifier_frostbitten_icicle", "creature_ability/modifier/modifier_frostbitten_icicle", LUA_MODIFIER_MOTION_NONE )

------------------------------------------------------------------

function frostbitten_icicle:Precache(context)
	PrecacheResource("particle", "particles/test_particle/dungeon_generic_blast_ovr_pre.vpcf", context)
	PrecacheResource("particle", "particles/act_2/frostbitten_icicle.vpcf", context)
end

function frostbitten_icicle:ProcsMagicStick()
	return false
end

--------------------------------------------------------------------------------

function frostbitten_icicle:OnSpellStart()
	if IsServer() then
       
        local delay = self:GetSpecialValueFor( "delay" )
	    local damage = self:GetSpecialValueFor( "damage" )
	    local radius = self:GetSpecialValueFor( "radius" )
	    local freeze_duration = self:GetSpecialValueFor( "freeze_duration" )
	    local hAbility = self
        local vOrigin = self:GetCursorPosition()
        local hCaster = self:GetCaster()

        local nFXIndex = ParticleManager:CreateParticle( "particles/test_particle/dungeon_generic_blast_ovr_pre.vpcf", PATTACH_CUSTOMORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCursorPosition() )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( radius, delay, 1.0 ) )
		ParticleManager:SetParticleControl( nFXIndex, 15, Vector( 255, 10, 100 ) )
		ParticleManager:SetParticleControl( nFXIndex, 16, Vector( 1, 0, 0 ) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )

		self:GetCaster():EmitSound("Hero_Tusk.IceShards.Projectile")

	    Timers:CreateTimer(delay, function()
	    	hCaster:EmitSound("Hero_Tusk.IceShards")
		    local nFXIndex = ParticleManager:CreateParticle( "particles/act_2/frostbitten_icicle.vpcf", PATTACH_WORLDORIGIN, nil )
			ParticleManager:SetParticleControl( nFXIndex, 0, vOrigin + Vector( 0, 0, 40 ) )
			ParticleManager:ReleaseParticleIndex( nFXIndex )

			local enemies = FindUnitsInRadius( hCaster:GetTeamNumber(), vOrigin, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
			for _,enemy in pairs( enemies ) do
				if enemy ~= nil and enemy:IsMagicImmune() == false and enemy:IsInvulnerable() == false then
					local damageInfo =
					{
						victim = enemy,
						attacker = hCaster or enemy,
						damage = damage,
						damage_type = DAMAGE_TYPE_MAGICAL,
						ability = ability,
					}

					ApplyDamage( damageInfo )
					enemy:AddNewModifier( hCaster, hAbility, "modifier_frostbitten_icicle", { duration = freeze_duration * (1-enemy:GetStatusResistance()) } )
				end
			end
	    end)

	end
end

------------------------------------------------------------------