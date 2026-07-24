--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_windrunner_shackleshot_custom_status_resistance", "heroes/npc_dota_hero_windrunner_custom/windrunner_shackleshot_custom", LUA_MODIFIER_MOTION_NONE)

windrunner_shackleshot_custom = class({})

windrunner_shackleshot_custom.modifier_windrunner_17_duration = 10
windrunner_shackleshot_custom.modifier_windrunner_17_debuff = {-8,-16,-24}

function windrunner_shackleshot_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_shackleshot.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_shackleshot_pair.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_shackleshot_pair_tree.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_shackleshot_single.vpcf", context )
end

function windrunner_shackleshot_custom:OnSpellStart(target)
	if not IsServer() then return end
	local caster = self:GetCaster()

	if target == nil then
		target = self:GetCursorTarget()
	end

	local projectile_speed = self:GetSpecialValueFor( "arrow_speed" )
	local location = caster:GetOrigin()

	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		EffectName = "particles/units/heroes/hero_windrunner/windrunner_shackleshot.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		ExtraData = {
			location_x = location.x,
			location_y = location.y,
			location_z = location.z,
		}
	}
	ProjectileManager:CreateTrackingProjectile(info)
	caster:EmitSound("Hero_Windrunner.ShackleshotCast")
end

function windrunner_shackleshot_custom:OnProjectileHit_ExtraData( target, location, ExtraData )
	if not target then return end
	if target:TriggerSpellAbsorb( self ) then return end
	if target:IsMagicImmune() then return end
	local search_radius = self:GetSpecialValueFor( "shackle_distance" )
	local stun_duration = self:GetSpecialValueFor( "stun_duration" )
	local fail_duration = self:GetSpecialValueFor( "fail_stun_duration" )
	local search_angle = self:GetSpecialValueFor( "shackle_angle" )
	local search_count = self:GetSpecialValueFor( "shackle_count" )

	if self:GetCaster():HasModifier("modifier_windrunner_18") then
		fail_duration = stun_duration
	end

	local shackled = 0
	local location = Vector( ExtraData.location_x, ExtraData.location_y, ExtraData.location_z )
	local target_origin = target:GetOrigin()
	local target_angle = VectorToAngles( target_origin-location ).y

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, search_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )

	for _,enemy in pairs(enemies) do
		if enemy~=target then
			local enemy_angle = VectorToAngles( enemy:GetOrigin()-target_origin ).y
			if math.abs( AngleDiff( target_angle, enemy_angle ) ) <= search_angle then
				shackled = shackled + 1
				if self:GetCaster():HasModifier("modifier_windrunner_17") then
					target:AddNewModifier(self:GetCaster(), self, "modifier_windrunner_shackleshot_custom_status_resistance", {duration = self.modifier_windrunner_17_duration })
					enemy:AddNewModifier(self:GetCaster(), self, "modifier_windrunner_shackleshot_custom_status_resistance", {duration = self.modifier_windrunner_17_duration })
				end
				target:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = stun_duration * (1 - target:GetStatusResistance()) } )
				enemy:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = stun_duration * (1 - enemy:GetStatusResistance()) } )
				self:PlayEffects1( target, enemy, stun_duration )
			end
			if shackled>=search_count then break end
		end
	end

	if shackled>=search_count then return end

	local trees = GridNav:GetAllTreesAroundPoint( target_origin, search_radius, false )
	for _,tree in pairs(trees) do
		local tree_angle = VectorToAngles( tree:GetOrigin()-target_origin ).y
		if math.abs( AngleDiff( target_angle, tree_angle ) ) <= search_angle then
			shackled = shackled + 1
			if self:GetCaster():HasModifier("modifier_windrunner_17") then
				target:AddNewModifier(self:GetCaster(), self, "modifier_windrunner_shackleshot_custom_status_resistance", {duration = self.modifier_windrunner_17_duration })
			end
			target:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = stun_duration * (1 - target:GetStatusResistance()) } )
			self:PlayEffects2( target, tree:GetOrigin(), stun_duration )
			break
		end
	end

	if shackled>=search_count then return end
	if self:GetCaster():HasModifier("modifier_windrunner_17") then
		target:AddNewModifier(self:GetCaster(), self, "modifier_windrunner_shackleshot_custom_status_resistance", {duration = self.modifier_windrunner_17_duration })
	end
	target:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = fail_duration * (1 - target:GetStatusResistance()) } )
	local point = target_origin-location
	point.z = 0
	point = target_origin + point:Normalized()*search_radius
	self:PlayEffects3( target, point )
end

function windrunner_shackleshot_custom:PlayEffects1( target1, target2, duration )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_windrunner/windrunner_shackleshot_pair.vpcf", PATTACH_ABSORIGIN_FOLLOW, target1 )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, target2, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target1:EmitSound("Hero_Windrunner.ShackleshotBind")
	target2:EmitSound("Hero_Windrunner.ShackleshotStun")
	target2:EmitSound("Hero_Windrunner.ShackleshotStun")
end

function windrunner_shackleshot_custom:PlayEffects2( target, tree, duration )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_windrunner/windrunner_shackleshot_pair_tree.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, tree )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Hero_Windrunner.ShackleshotBind")
	target:EmitSound("Hero_Windrunner.ShackleshotStun")
end

function windrunner_shackleshot_custom:PlayEffects3( target, point )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_windrunner/windrunner_shackleshot_single.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlForward( effect_cast, 2, (point-target:GetOrigin()):Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Hero_Windrunner.ShackleshotStun")
end

modifier_windrunner_shackleshot_custom_status_resistance = class({})

function modifier_windrunner_shackleshot_custom_status_resistance:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
	}
end

function modifier_windrunner_shackleshot_custom_status_resistance:GetModifierStatusResistanceStacking()
	return self:GetAbility().modifier_windrunner_17_debuff[self:GetCaster():GetTalentLevel("modifier_windrunner_17")]
end

function modifier_windrunner_shackleshot_custom_status_resistance:GetTexture()
	return "windrunner_17"
end