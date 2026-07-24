--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_live_spirits", "heroes/npc_dota_hero_phoenix_custom/phoenix_live_spirits", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_live_spirits_attack", "heroes/npc_dota_hero_phoenix_custom/phoenix_live_spirits", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_live_spirits_effect", "heroes/npc_dota_hero_phoenix_custom/phoenix_live_spirits", LUA_MODIFIER_MOTION_NONE)

phoenix_live_spirits = class({})
phoenix_live_spirits.attacks_proj = {}

function phoenix_live_spirits:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_ward_attack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_base_attack.vpcf", context )
    PrecacheResource( "particle", "particles/ice_phoenix/phoenix_life_spirits_bid.vpcf", context )
end

function phoenix_live_spirits:GetCastRange()
    return self:GetCaster():Script_GetAttackRange()
end

function phoenix_live_spirits:OnProjectileHitHandle(target, vLocation, iProjectileHandle)
	if target then
		self.attacks_proj[iProjectileHandle].targets[target:entindex()] = target
        target:HealWithParams(self:GetSpecialValueFor("heal"), self, false, true, self:GetCaster(), false)
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, self:GetSpecialValueFor("heal"), nil)	
	end
end

modifier_phoenix_live_spirits = class({})
function modifier_phoenix_live_spirits:IsHidden() return true end
function modifier_phoenix_live_spirits:IsPurgable() return false end
function modifier_phoenix_live_spirits:RemoveOnDeath() return false end
function modifier_phoenix_live_spirits:IsPurgeException() return false end
function modifier_phoenix_live_spirits:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_phoenix_live_spirits:OnCreated( kv )
	self.parent = self:GetParent()
	self.zero = Vector(0,0,0)
	self.revolution = 6
	self.rotate_radius = 150
	if not IsServer() then return end
	self.interval = 0.03
	self.base_facing = Vector(0,1,0)
	self.relative_pos = Vector( -self.rotate_radius, 0, 200 )
	self.rotate_delta = 360/self.revolution * self.interval
	self.position = self.parent:GetOrigin() + self.relative_pos
	self.rotation = 0
	self.facing = self.base_facing
	self.wisp = CreateUnitByName( "npc_dota_dark_willow_creature", self.position, true, self.parent, self.parent:GetOwner(), self.parent:GetTeamNumber())
	self.wisp:SetForwardVector( self.facing )
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_phoenix_live_spirits_effect", {} )
    self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_phoenix_live_spirits_attack", {} )
	self.wisp:SetDayTimeVisionRange(0)
	self.wisp:SetNightTimeVisionRange(0)
	self:StartIntervalThink( self.interval )
end

function modifier_phoenix_live_spirits:OnRefresh( kv )
	self.revolution = 6
	self.rotate_radius = 100
	if not IsServer() then return end
	self.relative_pos = Vector( -self.rotate_radius, 0, 200 )
	self.rotate_delta = 360/self.revolution * self.interval
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_phoenix_live_spirits_attack", {} )
end

function modifier_phoenix_live_spirits:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self.wisp )
end 

function modifier_phoenix_live_spirits:OnIntervalThink()
	self.rotation = self.rotation - self.rotate_delta
	local origin = self.parent:GetOrigin()
	self.position = RotatePosition( origin, QAngle( 0, -self.rotation, 0 ), origin + self.relative_pos )
	self.facing = RotatePosition( self.zero, QAngle( 0, -self.rotation, 0 ), self.base_facing )
	self.wisp:SetOrigin( self.position + Vector(0,0,25) )
	self.wisp:SetForwardVector( self.facing )
end

modifier_phoenix_live_spirits_effect = class({})

function modifier_phoenix_live_spirits_effect:IsHidden()
	return true
end

function modifier_phoenix_live_spirits_effect:IsPurgable()
	return false
end

function modifier_phoenix_live_spirits_effect:OnCreated( kv )
	if not IsServer() then return end
    self:GetParent():SetModel( "models/development/invisiblebox.vmdl" )
	self:GetParent():SetOriginalModel( "models/development/invisiblebox.vmdl" )
	self:PlayEffects()
end

function modifier_phoenix_live_spirits_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}
	return funcs
end

function modifier_phoenix_live_spirits_effect:GetModifierBaseAttack_BonusDamage()
	if not IsServer() then return end
	local target = self:GetParent():GetOrigin() + self:GetParent():GetForwardVector()
	local forward = self:GetParent():GetForwardVector()
	if self:GetCaster():IsAlive() and not self:GetCaster():HasModifier("modifier_wodawisp") and not self:GetCaster():HasModifier("modifier_smoke_of_deceit") then
		self:GetParent():RemoveNoDraw()
		if self.effect_cast == nil then
			self:PlayEffects()
		end
	else
		self:GetParent():AddNoDraw()
        print("self.effect_cast")
		if self.effect_cast then
            print(self.effect_cast, "  self.effect_cast")
			ParticleManager:DestroyParticle(self.effect_cast, true)
			self.effect_cast = nil
		end
	end
end

function modifier_phoenix_live_spirits_effect:CheckState()
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

function modifier_phoenix_live_spirits_effect:PlayEffects()
	self.effect_cast = ParticleManager:CreateParticle( "particles/ice_phoenix/phoenix_life_spirits_bid.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(1, 0, 0) )
	self:AddParticle( self.effect_cast, false, false, -1, false, false )
end

modifier_phoenix_live_spirits_attack = class({})

function modifier_phoenix_live_spirits_attack:IsHidden()
	return false
end

function modifier_phoenix_live_spirits_attack:IsDebuff()
	return false
end

function modifier_phoenix_live_spirits_attack:IsStunDebuff()
	return false
end

function modifier_phoenix_live_spirits_attack:IsPurgable()
	return false
end

function modifier_phoenix_live_spirits_attack:OnCreated( kv )
	if not IsServer() then return end
    self.cooldown = 0
	self.info = 
	{
		Source = self:GetParent(),
		Ability = self:GetAbility(),	
		EffectName = "particles/units/heroes/hero_oracle/oracle_base_attack.vpcf",
		iMoveSpeed = 1000,
		bDodgeable = true,
	}
	self:StartIntervalThink(FrameTime())
end

function modifier_phoenix_live_spirits_attack:OnIntervalThink()
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self:GetCaster():Script_GetAttackRange(), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_FARTHEST, false )
	if self.cooldown <= 0 and #enemies > 0 and self:GetCaster():IsAlive() and not self:GetCaster():HasModifier("modifier_wodawisp") then
		self.info.Target = enemies[1]
		local proj_id = ProjectileManager:CreateTrackingProjectile(self.info)
		self:GetAbility().attacks_proj[proj_id] = {}
		self:GetAbility().attacks_proj[proj_id].targets = {}
		self.cooldown = 3
	end
    self.cooldown = self.cooldown - FrameTime()
end