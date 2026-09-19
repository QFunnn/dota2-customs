--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if invoker_deafening_blast_ad == nil then
	invoker_deafening_blast_ad = class({}) ---@class invoker_deafening_blast_ad : CDOTA_Ability_Lua
end

LinkLuaModifier(
	"modifier_invoker_deafening_blast_ad_knockback",
	"heroes/hero_invoker/invoker_deafening_blast_ad",
	LUA_MODIFIER_MOTION_HORIZONTAL
)

function invoker_deafening_blast_ad:GetAOERadius()
	return self:GetSpecialValueFor("radius_end")
end

function invoker_deafening_blast_ad:GetCastAnimation()
	return ACT_DOTA_CAST_DEAFENING_BLAST
end

function invoker_deafening_blast_ad:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = self:GetCursorPosition()
	local direction = point - origin
	direction.z = 0

	if direction:Length2D() < 1 then
		point = origin + caster:GetForwardVector() * self:GetSpecialValueFor("travel_distance")
	end

	self.caster = caster
	self.caster_origin = origin
	self.hit_targets = {}
	self.radius_start = self:GetSpecialValueFor("radius_start")
	self.radius_end = self:GetSpecialValueFor("radius_end")
	self.speed = self:GetSpecialValueFor("travel_speed")
	self.distance = self:GetSpecialValueFor("travel_distance")
	self.damage = self:GetSpecialValueFor("damage")
	self.knockback_duration = self:GetSpecialValueFor("knockback_duration")
	self.disarm_duration = self:GetSpecialValueFor("disarm_duration")
	self.end_vision_duration = self:GetSpecialValueFor("end_vision_duration")

	caster:EmitSound("Hero_Invoker.DeafeningBlast")

	local talent = caster:FindAbilityByName("special_bonus_unique_invoker_2")
	if talent and talent:GetLevel() > 0 then
		for i = 1, 12 do
			local radial_direction = RotatePosition(Vector(0, 0, 0), QAngle(0, 30 * i, 0), caster:GetForwardVector())
			self:CastDeafeningBlast(origin + radial_direction)
		end
	else
		self:CastDeafeningBlast(point)
	end
end

function invoker_deafening_blast_ad:CastDeafeningBlast(point)
	local direction = point - self.caster_origin
	direction.z = 0
	direction = direction:Normalized()

	ProjectileManager:CreateLinearProjectile({
		Ability = self,
		EffectName = "particles/units/heroes/hero_invoker/invoker_deafening_blast.vpcf",
		vSpawnOrigin = self.caster_origin,
		fDistance = self.distance,
		fStartRadius = self.radius_start,
		fEndRadius = self.radius_end,
		Source = self.caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		bDeleteOnHit = false,
		vVelocity = direction * self.speed,
		fExpireTime = GameRules:GetGameTime() + 10,
	})
end

function invoker_deafening_blast_ad:OnProjectileHit(target, location)
	if not IsServer() then
		return nil
	end

	if not target then
		AddFOWViewer(self.caster:GetTeamNumber(), location, self.radius_end, self.end_vision_duration, false)
		return nil
	end

	local target_index = target:entindex()
	if self.hit_targets[target_index] then
		return false
	end

	self.hit_targets[target_index] = true

	ApplyDamage({
		victim = target,
		attacker = self.caster,
		damage = self.damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	})

	local status_resist = target:GetStatusResistanceFactor(self.caster)
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_invoker_deafening_blast_disarm",
		{ duration = self.disarm_duration * status_resist }
	)
	target:AddNewModifier(self.caster, self, "modifier_invoker_deafening_blast_ad_knockback", {
		duration = self.knockback_duration * status_resist,
		x = (target:GetAbsOrigin() - self.caster_origin).x,
		y = (target:GetAbsOrigin() - self.caster_origin).y,
	})

	return false
end

if modifier_invoker_deafening_blast_ad_knockback == nil then
	modifier_invoker_deafening_blast_ad_knockback = class({}) ---@class modifier_invoker_deafening_blast_ad_knockback : CDOTA_Modifier_Lua
end

function modifier_invoker_deafening_blast_ad_knockback:IsHidden()
	return false
end

function modifier_invoker_deafening_blast_ad_knockback:IsDebuff()
	return true
end

function modifier_invoker_deafening_blast_ad_knockback:IsPurgable()
	return true
end

function modifier_invoker_deafening_blast_ad_knockback:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_deafening_blast_knockback_debuff.vpcf"
end

function modifier_invoker_deafening_blast_ad_knockback:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_invoker_deafening_blast_ad_knockback:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_invoker_deafening_blast_ad_knockback:OnCreated(params)
	if not IsServer() then
		return
	end

	self.direction = Vector(params.x or 0, params.y or 0, 0)
	if self.direction:Length2D() < 1 then
		self.direction = self:GetCaster():GetForwardVector()
	end
	self.direction = self.direction:Normalized()
	self.speed = 110

	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end

function modifier_invoker_deafening_blast_ad_knockback:OnDestroy()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	parent:RemoveHorizontalMotionController(self)
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
end

function modifier_invoker_deafening_blast_ad_knockback:UpdateHorizontalMotion(parent, dt)
	if not IsServer() then
		return
	end

	local position = parent:GetAbsOrigin() + self.direction * self.speed * dt
	parent:SetAbsOrigin(GetGroundPosition(position, parent))
end

function modifier_invoker_deafening_blast_ad_knockback:OnHorizontalMotionInterrupted()
	if not IsServer() then
		return
	end

	self:Destroy()
end