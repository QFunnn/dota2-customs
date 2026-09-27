--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


bristleback_hairball_custom = class({})
bristleback_hairball_custom.talents = {}

function bristleback_hairball_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/units/heroes/hero_bristleback/bristleback_hairball.vpcf", context)
end

function bristleback_hairball_custom:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.projectile_speed = self:GetLevelSpecialValueFor("projectile_speed", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.quill_count = self:GetLevelSpecialValueFor("quill_count", 1)
	self.goo_count = self:GetLevelSpecialValueFor("goo_count", 1)
	self:UpdateTalents()
end

function bristleback_hairball_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			w2_radius = 0,
		}
	end

	if caster:HasTalent("modifier_bristle_spray_2") then
		self.talents.w2_radius = caster:GetTalentValue("modifier_bristle_spray_2", "radius")
	end
end

function bristleback_hairball_custom:GetAOERadius()
	return (self.radius or 0) + (self.talents.w2_radius or 0)
end

function bristleback_hairball_custom:OnSpellStart()
	local point = self:GetCursorPosition()
	local origin = self.caster:GetAbsOrigin()
	local vec = point - origin

	self.caster:EmitSound("Hero_Bristleback.Hairball.Cast")

	local projectile = {
		Ability = self,
		EffectName = "particles/units/heroes/hero_bristleback/bristleback_hairball.vpcf",
		vSpawnOrigin = self.caster:GetAttachmentOrigin(self.caster:ScriptLookupAttachment("attach_hitloc")),
		fDistance = vec:Length2D(),
		fStartRadius = 0,
		fEndRadius = 0,
		Source = self.caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_NONE,
		fExpireTime = GameRules:GetGameTime() + 5.0,
		bDeleteOnHit = false,
		vVelocity = vec:Normalized() * self.projectile_speed * (Vector(1, 1, 0)),
		bProvidesVision = false,
	}
	ProjectileManager:CreateLinearProjectile(projectile)
end

function bristleback_hairball_custom:OnProjectileHit(hTarget, vLocation)
	if not IsServer() then
		return
	end
	local radius = self:GetAOERadius()

	AddFOWViewer(self.caster:GetTeamNumber(), vLocation, radius, 2, false)

	local sound_name = wearables_system:GetSoundReplacement(self.caster, "Hero_Bristleback.ViscousGoo.Cast", self)
	EmitSoundOnLocationWithCaster(vLocation, sound_name, self.caster)

	local hit_type = 0
	for _, target in pairs(self.caster:FindTargets(radius, vLocation)) do
		if target:IsHero() then
			hit_type = 2
		elseif hit_type == 0 then
			hit_type = 1
		end
		if self.caster.goo_ability then
			for i = 1, self.goo_count do
				self.caster.goo_ability:AddStack(target)
			end
		end
	end

	if hit_type ~= 0 and self.caster.warpath_ability and self.caster.warpath_ability.tracker then
		self.caster.warpath_ability.tracker:AddStack(hit_type == 2)
	end

	if self.caster.spray_ability then
		for i = 1, self.quill_count do
			Timers:CreateTimer(0.2 * (i - 1), function()
				self.caster.spray_ability:MakeSpray(GetGroundPosition(vLocation, nil))
			end)
		end
	end
end

function bristleback_hairball_custom:OnInventoryContentsChanged()
	self:UpdateTalents()
end