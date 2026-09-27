--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_hoodwink_hunters_boomerang_custom_target",
	"abilities/hoodwink/hoodwink_hunters_boomerang_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_hoodwink_hunters_boomerang_custom_thinker",
	"abilities/hoodwink/hoodwink_hunters_boomerang_custom",
	LUA_MODIFIER_MOTION_NONE
)

hoodwink_hunters_boomerang_custom = class({})
function hoodwink_hunters_boomerang_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/hoodwink/hoodwink_boomerang_custom.vpcf", context)
	PrecacheResource("particle", "particles/hoodwink/hoodwink_boomerang_custom_2.vpcf", context)
	PrecacheResource("particle", "particles/hoodwink/hoodwink_boomerang_custom_hit.vpcf", context)
end

function hoodwink_hunters_boomerang_custom:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.speed = self:GetLevelSpecialValueFor("speed", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.range = self:GetLevelSpecialValueFor("AbilityCastRange", 1)
	self.damageTable =
		{ attacker = self.caster, ability = self, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL }
end

function hoodwink_hunters_boomerang_custom:GetCastRange(location, target)
	return self.BaseClass.GetCastRange(self, location, target) - self.caster:GetCastRangeBonus()
end

function hoodwink_hunters_boomerang_custom:OnSpellStart()
	local origin = self.caster:GetAbsOrigin()
	local point = self:GetCursorPosition()
	if origin == point then
		point = origin + self.caster:GetForwardVector() * 10
	end

	local vec = point - origin
	local max_range = self.range
	local cast_point = GetGroundPosition((origin + vec:Normalized() * max_range), nil) + Vector(0, 0, 100)

	local target = CreateModifierThinker(
		self.caster,
		self,
		"modifier_hoodwink_hunters_boomerang_custom_target",
		{ duration = 10 },
		cast_point,
		self.caster:GetTeamNumber(),
		false
	)
	local thinker = CreateModifierThinker(
		self.caster,
		self,
		"modifier_hoodwink_hunters_boomerang_custom_thinker",
		{},
		origin,
		self.caster:GetTeamNumber(),
		false
	)

	self.info = {
		Ability = self,
		Target = target,
		Source = self.caster,
		EffectName = "particles/hoodwink/hoodwink_boomerang_custom.vpcf",
		iMoveSpeed = self.speed,
		bDodgeable = true,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = 200,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
		iVisionTeamNumber = self.caster:GetTeamNumber(),
		ExtraData = {
			target = target:entindex(),
			thinker = thinker:entindex(),
			x = origin.x,
			y = origin.y,
		},
	}
	self.caster:EmitSound("Hero_Hoodwink.Boomerang.Cast")
	ProjectileManager:CreateTrackingProjectile(self.info)
end

function hoodwink_hunters_boomerang_custom:OnProjectileThink_ExtraData(location, table)
	if not IsServer() then
		return
	end
	local thinker = EntIndexToHScript(table.thinker)
	if not IsValid(thinker) then
		return
	end

	local mod = thinker:FindModifierByName("modifier_hoodwink_hunters_boomerang_custom_thinker")
	if not mod then
		return
	end

	local targets = self.caster:FindTargets(self.radius, location)
	for _, target in pairs(targets) do
		if not mod.targets[target] then
			mod.targets[target] = true
			self.damageTable.victim = target
			DoDamage(self.damageTable)

			local particle = ParticleManager:CreateParticle(
				"particles/hoodwink/hoodwink_boomerang_custom_hit.vpcf",
				PATTACH_CUSTOMORIGIN,
				target
			)
			ParticleManager:SetParticleControlEnt(
				particle,
				0,
				target,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				target:GetOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(particle)

			target:EmitSound(
				target:IsCreep() and "Hero_Hoodwink.Boomerang.Slow.Creep" or "Hero_Hoodwink.Boomerang.Slow"
			)

			if IsValid(self.caster.sharp_ability) then
				target:RemoveModifierByName("modifier_hoodwink_sharpshooter_custom_debuff")
				local origin = Vector(table.x, table.y, 0)
				local dir = (target:GetAbsOrigin() - origin):Normalized()
				target:AddNewModifier(
					self.caster,
					self.caster.sharp_ability,
					"modifier_hoodwink_sharpshooter_custom_debuff",
					{ duration = self.duration * (1 - target:GetStatusResistance()), x = dir.x, y = dir.y }
				)
			end
		end
	end

	thinker:SetAbsOrigin(location)
end

function hoodwink_hunters_boomerang_custom:OnProjectileHit_ExtraData(target, location, table)
	if not target then
		return
	end
	local thinker = EntIndexToHScript(table.thinker)
	if not IsValid(thinker) then
		return
	end

	local mod = thinker:FindModifierByName("modifier_hoodwink_hunters_boomerang_custom_thinker")
	if not mod then
		return
	end

	if not table.target then
		mod:Destroy()
		return
	end

	local dummy = EntIndexToHScript(table.target)
	if not IsValid(dummy) then
		return
	end

	self.info.Source = dummy
	self.info.Target = self.caster
	self.info.iSourceAttachment = nil
	self.info.EffectName = "particles/hoodwink/hoodwink_boomerang_custom_2.vpcf"
	self.info.ExtraData = {
		thinker = table.thinker,
		x = location.x,
		y = location.y,
	}
	ProjectileManager:CreateTrackingProjectile(self.info)

	mod.targets = {}

	EmitSoundOnLocationWithCaster(location, "Hero_Hoodwink.Boomerang.Return", self.caster)
	dummy:Destroy()
end

modifier_hoodwink_hunters_boomerang_custom_target = class(mod_hidden)
function modifier_hoodwink_hunters_boomerang_custom_target:OnCreated(table)
	self.parent = self:GetParent()
end

function modifier_hoodwink_hunters_boomerang_custom_target:OnDestroy()
	if not IsServer() then
		return
	end
	UTIL_Remove(self.parent)
end

modifier_hoodwink_hunters_boomerang_custom_thinker = class(mod_hidden)
function modifier_hoodwink_hunters_boomerang_custom_thinker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.targets = {}
	if not IsServer() then
		return
	end
	EmitSoundOn("Hoodwink.Shard_projectile", self.parent)
end

function modifier_hoodwink_hunters_boomerang_custom_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	StopSoundOn("Hoodwink.Shard_projectile", self.parent)
	UTIL_Remove(self.parent)
end