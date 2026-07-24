--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_witch_doctor_auto_wodoo", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_auto_wodoo", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_witch_doctor_auto_wodoo_attack", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_auto_wodoo", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_witch_doctor_auto_wodoo_effect", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_auto_wodoo", LUA_MODIFIER_MOTION_NONE)

witch_doctor_auto_wodoo = class({})
witch_doctor_auto_wodoo.attacks_proj = {}
-- И в death ward
witch_doctor_auto_wodoo.modifier_witch_doctor_9_bounce = {1,2,3}

function witch_doctor_auto_wodoo:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_ward_attack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dark_willow/dark_willow_willowisp_ambient.vpcf", context )
end

function witch_doctor_auto_wodoo:GetIntrinsicModifierName()
	return "modifier_witch_doctor_auto_wodoo"
end

function witch_doctor_auto_wodoo:GetCastRange()
    return self:GetCaster():Script_GetAttackRange()
end

function witch_doctor_auto_wodoo:OnProjectileHitHandle(target, vLocation, iProjectileHandle)
	if target then
		self.attacks_proj[iProjectileHandle].targets[target:entindex()] = target

		target:EmitSound("Hero_WitchDoctor.Attack")

		local damage = self:GetSpecialValueFor("damage_no_ultimate")
		local ability = self:GetCaster():FindAbilityByName("witch_doctor_death_ward_custom")
		if ability then
			if ability:GetLevel() > 0 then
				damage = ability:GetSpecialValueFor("damage")
			end
		end

		if self:GetCaster():HasModifier("modifier_witch_doctor_14") then
			self:GetCaster():PerformAttack(target, true, true, true, false, false, false, false)
		else
			if RollPercentage(100 - (target:GetEvasion() * 100)) or RollPercentage(50) then
				ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_flags = DOTA_DAMAGE_FLAG_REFLECTION, damage_type = DAMAGE_TYPE_PURE})
			end
		end

		if self.attacks_proj[iProjectileHandle].bounce > 0 then
			self.attacks_proj[iProjectileHandle].bounce = self.attacks_proj[iProjectileHandle].bounce - 1
			local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, 650, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_CLOSEST, false)

			for count = #units, 1, -1 do
		        if units[count] and self.attacks_proj[iProjectileHandle].targets[units[count]:entindex()] ~= nil then
		            table.remove(units, count)
		        end
		    end

			if #units > 0 then
				local projectile =
				{
					Target = units[1],
					Source = target,
					Ability = self,
					EffectName = "particles/units/heroes/hero_witchdoctor/witchdoctor_ward_attack.vpcf",
					bDodgable = true,
					bProvidesVision = false,
					iMoveSpeed = 1000,
					iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
				}
				local proj_id = ProjectileManager:CreateTrackingProjectile(projectile)
				self.attacks_proj[proj_id] = {}
				self.attacks_proj[proj_id].targets = self.attacks_proj[iProjectileHandle].targets
				self.attacks_proj[proj_id].bounce = self.attacks_proj[iProjectileHandle].bounce 
			end
		end
	end
end

modifier_witch_doctor_auto_wodoo = class({})

function modifier_witch_doctor_auto_wodoo:IsHidden() return true end
function modifier_witch_doctor_auto_wodoo:IsPurgable() return false end

function modifier_witch_doctor_auto_wodoo:OnCreated( kv )
	self.parent = self:GetParent()
	self.zero = Vector(0,0,0)
	self.revolution = 1.5
	self.rotate_radius = 100
	if not IsServer() then return end
	self.interval = 0.03
	self.base_facing = Vector(0,1,0)
	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
	self.rotate_delta = 360/self.revolution * self.interval
	self.position = self.parent:GetOrigin() + self.relative_pos
	self.rotation = 0
	self.facing = self.base_facing
	self.wisp = CreateUnitByName( "npc_dota_dark_willow_creature", self.position, true, self.parent, self.parent:GetOwner(), self.parent:GetTeamNumber())
	self.wisp:SetForwardVector( self.facing )
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_witch_doctor_auto_wodoo_effect", {} )
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_witch_doctor_auto_wodoo_attack", {} )
	self.wisp:SetDayTimeVisionRange(0)
	self.wisp:SetNightTimeVisionRange(0)
	self:StartIntervalThink( self.interval )
end

function modifier_witch_doctor_auto_wodoo:OnRefresh( kv )
	self.revolution = 1.5
	self.rotate_radius = 100
	if not IsServer() then return end
	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
	self.rotate_delta = 360/self.revolution * self.interval
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_witch_doctor_auto_wodoo_attack", {} )
end

function modifier_witch_doctor_auto_wodoo:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self.wisp )
end

function modifier_witch_doctor_auto_wodoo:OnIntervalThink()
	self.rotation = self.rotation + self.rotate_delta
	local origin = self.parent:GetOrigin()
	self.position = RotatePosition( origin, QAngle( 0, -self.rotation, 0 ), origin + self.relative_pos )
	self.facing = RotatePosition( self.zero, QAngle( 0, -self.rotation, 0 ), self.base_facing )
	self.wisp:SetOrigin( self.position )
	self.wisp:SetForwardVector( self.facing )
end

modifier_witch_doctor_auto_wodoo_effect = class({})

function modifier_witch_doctor_auto_wodoo_effect:IsHidden()
	return true
end

function modifier_witch_doctor_auto_wodoo_effect:IsPurgable()
	return false
end

function modifier_witch_doctor_auto_wodoo_effect:OnCreated( kv )
	if not IsServer() then return end
	self:GetParent():SetModel( "models/heroes/witchdoctor/witchdoctor_skull.vmdl" )
	self:GetParent():SetOriginalModel( "models/heroes/witchdoctor/witchdoctor_skull.vmdl" )
	self:GetParent():SetModelScale(1.5)
	self:PlayEffects()
end

function modifier_witch_doctor_auto_wodoo_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}
	return funcs
end

function modifier_witch_doctor_auto_wodoo_effect:GetModifierBaseAttack_BonusDamage()
	if not IsServer() then return end
	local target = self:GetParent():GetOrigin() + self:GetParent():GetForwardVector()
	local forward = self:GetParent():GetForwardVector()
	if self.effect_cast then
		ParticleManager:SetParticleControl( self.effect_cast, 2, target )
	end
	if self:GetCaster():IsAlive() and not self:GetCaster():HasModifier("modifier_wodawisp") and not self:GetCaster():HasModifier("modifier_smoke_of_deceit") then
		self:GetParent():RemoveNoDraw()
		if self.effect_cast == nil then
			self:PlayEffects()
		end
	else
		self:GetParent():AddNoDraw()
		if self.effect_cast then
			ParticleManager:DestroyParticle(self.effect_cast, true)
			self.effect_cast = nil
		end
	end
end

function modifier_witch_doctor_auto_wodoo_effect:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
	return state
end

function modifier_witch_doctor_auto_wodoo_effect:PlayEffects()
	self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dark_willow/dark_willow_willowisp_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	self:AddParticle( self.effect_cast, false, false, -1, false, false )
end

modifier_witch_doctor_auto_wodoo_attack = class({})

function modifier_witch_doctor_auto_wodoo_attack:IsHidden()
	return false
end

function modifier_witch_doctor_auto_wodoo_attack:IsDebuff()
	return false
end

function modifier_witch_doctor_auto_wodoo_attack:IsStunDebuff()
	return false
end

function modifier_witch_doctor_auto_wodoo_attack:IsPurgable()
	return false
end

function modifier_witch_doctor_auto_wodoo_attack:OnCreated( kv )
	if not IsServer() then return end
	self.info = 
	{
		Source = self:GetParent(),
		Ability = self:GetAbility(),	
		EffectName = "particles/units/heroes/hero_witchdoctor/witchdoctor_ward_attack.vpcf",
		iMoveSpeed = 1000,
		bDodgeable = true,
	}
	self:StartIntervalThink( FrameTime() )
end

function modifier_witch_doctor_auto_wodoo_attack:OnIntervalThink()
    if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then
        return
    end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self:GetCaster():Script_GetAttackRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_FARTHEST, false )
	if self:GetAbility():IsFullyCastable() and #enemies > 0 and self:GetCaster():IsAlive() and not self:GetCaster():HasModifier("modifier_wodawisp") then
		self.info.Target = enemies[1]

		local bounce = 0

		if self:GetCaster():HasModifier("modifier_witch_doctor_9") then
			bounce = self:GetAbility().modifier_witch_doctor_9_bounce[self:GetCaster():GetTalentLevel("modifier_witch_doctor_9")]
		end 

		local proj_id = ProjectileManager:CreateTrackingProjectile(self.info)
		self:GetAbility().attacks_proj[proj_id] = {}
		self:GetAbility().attacks_proj[proj_id].targets = {}
		self:GetAbility().attacks_proj[proj_id].bounce = bounce 

		self:GetParent():EmitSound("Hero_WitchDoctor_Ward.Attack")
		self:GetAbility():StartCooldown(self:GetAbility():GetSpecialValueFor("interval"))
	end
end