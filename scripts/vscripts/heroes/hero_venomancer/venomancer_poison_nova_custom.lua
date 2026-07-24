--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_venomancer_poison_nova_custom", "heroes/hero_venomancer/venomancer_poison_nova_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_venomancer_poison_nova_custom_ring", "heroes/hero_venomancer/venomancer_poison_nova_custom", LUA_MODIFIER_MOTION_NONE )

venomancer_poison_nova_custom = class({})

function venomancer_poison_nova_custom:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_poison_venomancer.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_poison_debuff_nova.vpcf", context )
end

function venomancer_poison_nova_custom:GetCastRange( pos, target )
	return self:GetSpecialValueFor( "radius" )
end

function venomancer_poison_nova_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor( "duration" )
	local speed = self:GetSpecialValueFor( "speed" )
	local start_radius = self:GetSpecialValueFor( "start_radius" )
	local end_radius = self:GetSpecialValueFor( "radius" )

	local ring = self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_venomancer_poison_nova_custom_ring",
		{
			start_radius = 0,
			end_radius = end_radius,
			speed = speed,
			target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			target_flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			IsCircle = 0,
		}
	)

	ring:SetCallback( function( enemy )
		local mod = enemy:AddNewModifier( self:GetCaster(), self, "modifier_venomancer_poison_nova_custom", { duration = duration } )
		if mod then
			print("[DEBUG STATUS_RES] Poison Nova | requested: " .. duration .. " | actual: " .. mod:GetDuration() .. " | target SR: " .. enemy:GetStatusResistance())
		end
		enemy:EmitSound("Hero_Venomancer.PoisonNovaImpact")
	end)


	self:PlayEffects( ring, speed )
end

function venomancer_poison_nova_custom:PlayEffects( modifier, speed )
	local sound_cast = "Hero_Venomancer.PoisonNova"
	local duration = 1
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( speed, duration, speed ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound("Hero_Venomancer.PoisonNova")
end

modifier_venomancer_poison_nova_custom = class({})

function modifier_venomancer_poison_nova_custom:IsDebuff()
	return true
end

function modifier_venomancer_poison_nova_custom:IsStunDebuff()
	return false
end

function modifier_venomancer_poison_nova_custom:IsPurgable()
	return false
end

function modifier_venomancer_poison_nova_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	if self:GetCaster():HasScepter() then
		self.damage = self:GetAbility():GetSpecialValueFor( "damage_scepter" )
	end
	if not IsServer() then return end
	local interval = 1
	self:StartIntervalThink( interval )
	self:OnIntervalThink()
end

function modifier_venomancer_poison_nova_custom:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_venomancer_poison_nova_custom:OnIntervalThink()
	if not IsServer() then return end
	if self.parent:IsMagicImmune() then return end
	local damageTable = 
	{
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = (self.damage * self:GetParent():GetMaxHealth() / 100) + self:GetAbility():GetSpecialValueFor("base_damage"),
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
		damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL,
	}
	ApplyDamage( damageTable )
end

function modifier_venomancer_poison_nova_custom:GetEffectName()
	return "particles/units/heroes/hero_venomancer/venomancer_poison_debuff_nova.vpcf"
end

function modifier_venomancer_poison_nova_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_venomancer_poison_nova_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_venomancer.vpcf"
end

function modifier_venomancer_poison_nova_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

-- Created by Elfansoer
modifier_venomancer_poison_nova_custom_ring = class({})

function modifier_venomancer_poison_nova_custom_ring:IsHidden()
	return true
end

function modifier_venomancer_poison_nova_custom_ring:IsDebuff()
	return false
end

function modifier_venomancer_poison_nova_custom_ring:IsStunDebuff()
	return false
end

function modifier_venomancer_poison_nova_custom_ring:IsPurgable()
	return false
end

function modifier_venomancer_poison_nova_custom_ring:RemoveOnDeath()
	return false
end

function modifier_venomancer_poison_nova_custom_ring:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_venomancer_poison_nova_custom_ring:OnCreated( kv )

	if not IsServer() then return end

	-- references
	self.start_radius = kv.start_radius or 0
	self.end_radius = kv.end_radius or 0
	self.width = kv.width or 100
	self.speed = kv.speed or 0
	self.outward = self.end_radius>=self.start_radius
	if not self.outward then
		self.speed = -self.speed
	end

	self.target_team = kv.target_team or 0
	self.target_type = kv.target_type or 0
	self.target_flags = kv.target_flags or 0

	self.IsCircle = kv.IsCircle or 1

	self.targets = {}
end

function modifier_venomancer_poison_nova_custom_ring:OnRemoved()
end

function modifier_venomancer_poison_nova_custom_ring:OnDestroy()
	if self.EndCallback then
		self.EndCallback()
	end
	if not IsServer() then return end

	-- kill if thinker
	if self:GetParent():GetClassname()=="npc_dota_thinker" then
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_venomancer_poison_nova_custom_ring:SetCallback( callback )
	self.Callback = callback

	-- Start interval
	self:StartIntervalThink( 0.03 )
	self:OnIntervalThink()
end

function modifier_venomancer_poison_nova_custom_ring:SetEndCallback( callback )
	self.EndCallback = callback
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_venomancer_poison_nova_custom_ring:OnIntervalThink()
	local radius = self.start_radius + self.speed * self:GetElapsedTime()
	if not self.outward and radius<self.end_radius then
		self:Destroy()
		return
	elseif self.outward and radius>self.end_radius then
		self:Destroy()
		return
	end

	-- Find targets in ring
	local targets = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		self.target_team,	-- int, team filter
		self.target_type,	-- int, type filter
		self.target_flags,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,target in pairs(targets) do

		-- only unaffected unit
		if not self.targets[target] then

			-- check if it is within circle/chakram
			if (not self.IsCircle) or (target:GetOrigin()-self:GetParent():GetOrigin()):Length2D()>(radius-self.width) then

				self.targets[target] = true

				-- do something
				self.Callback( target )
			end
		end

	end
end