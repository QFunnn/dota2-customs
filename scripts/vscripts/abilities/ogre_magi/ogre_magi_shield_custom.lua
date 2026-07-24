--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ogre_magi_shield_custom_buff", "abilities/ogre_magi/ogre_magi_smash", LUA_MODIFIER_MOTION_NONE )

ogre_magi_shield_custom = class({})

function ogre_magi_shield_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/ogre_magi/shard_shield.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_ogre_magi/ogre_magi_fire_shield_projectile.vpcf", context )
end

function ogre_magi_shield_custom:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.base = self:GetLevelSpecialValueFor("base", 1)
self.health = self:GetLevelSpecialValueFor("health", 1)/100
self.multicast_shield = self:GetLevelSpecialValueFor("multicast_shield", 1)/100
self.duration = self:GetLevelSpecialValueFor("duration", 1)
self.damage = self:GetLevelSpecialValueFor("damage", 1)
self.proc_cd = self:GetLevelSpecialValueFor("proc_cd", 1)
self.shield_mana = self:GetLevelSpecialValueFor("shield_mana", 1)/100
self.projectile_speed = self:GetLevelSpecialValueFor("projectile_speed", 1)
self.multicast_delay = self:GetLevelSpecialValueFor("multicast_delay", 1)
end

function ogre_magi_shield_custom:OnSpellStart(new_target)

local shield = self.base + self.caster:GetMaxHealth()*self.health
local max = (4 + 1) * self.multicast_shield * shield

if self.multicast_k then
	shield = shield * self.multicast_shield
else
	self.caster:Purge(false, true, false, false, false)
end

self.caster:EmitSound("Hero_OgreMagi.FireShield.Target")

if not IsValid(self.shield_mod) then
	self.shield_mod = self.caster:AddNewModifier(self.caster, self, "modifier_generic_shield",
	{
		duration = self.duration,
		max_shield = max,
		disable_ability = true,
	})

	if self.shield_mod then
		local particle = ParticleManager:CreateParticle( "particles/ogre_magi/shard_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
		ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
		ParticleManager:SetParticleControl( particle, 1, Vector( 3, 0, 0 ) )
		ParticleManager:SetParticleControl( particle, 9, Vector( 1, 0, 0 ) )
		ParticleManager:SetParticleControl( particle, 10, Vector( 1, 0, 0 ) )
		ParticleManager:SetParticleControl( particle, 11, Vector( 1, 0, 0 ) )
		self.shield_mod:AddParticle(particle,false, false, -1, false, false)
	end


	self.shield_mod:SetHitFunction(function(damage, attacker)
		local mana = damage*self.shield_mana
		self.parent:GiveMana(mana)

		if attacker:CheckCd("ogre_shard", self.proc_cd) then
			local info = {
				Target = attacker,
				Source = self.parent,
				Ability = self,	
				EffectName = "particles/units/heroes/hero_ogre_magi/ogre_magi_fire_shield_projectile.vpcf",
				iMoveSpeed = self.projectile_speed,
				bReplaceExisting = false,		
			}
			ProjectileManager:CreateTrackingProjectile(info)
		end
	end)
end

if IsValid(self.shield_mod) then
	self.shield_mod:AddShield(shield)
	self.shield_mod:SetDuration(self.duration, true)
end

end

function ogre_magi_shield_custom:OnProjectileHit(target, vLocation)
if not target then return end
target:EmitSound("Hero_OgreMagi.FireShield.Damage")
DoDamage({victim = target, attacker = self.caster, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
end