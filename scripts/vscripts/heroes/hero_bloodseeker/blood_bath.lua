--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_bloodseeker_blood_bath_lua_thinker",
	"heroes/hero_bloodseeker/blood_bath",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_bloodseeker_blood_bath_lua", "heroes/hero_bloodseeker/blood_bath", LUA_MODIFIER_MOTION_NONE)

if bloodseeker_blood_bath_lua == nil then
	bloodseeker_blood_bath_lua = class({})
end

--------------------------------------------------------------------------------

function bloodseeker_blood_bath_lua:OnSpellStart()
	local caster = self:GetCaster()
	local position = self:GetCursorPosition()

	local delay = self:GetSpecialValueFor("delay")
	local radius = self:GetSpecialValueFor("radius")

	caster:EmitSound("Hero_Bloodseeker.BloodRite.Cast")

	AddFOWViewer(caster:GetTeamNumber(), position, radius, 6, true)

	CreateModifierThinker(
		caster,
		self,
		"modifier_bloodseeker_blood_bath_lua_thinker",
		{ duration = delay },
		position,
		caster:GetTeam(),
		false
	)
end

function bloodseeker_blood_bath_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

--------------------------------------------------------------------------------

modifier_bloodseeker_blood_bath_lua_thinker = class({
	IsHidden = function(self)
		return true
	end,
	IsPurgable = function(self)
		return false
	end,
	IsDebuff = function(self)
		return false
	end,
	IsBuff = function(self)
		return true
	end,
	RemoveOnDeath = function(self)
		return true
	end,
})

--------------------------------------------------------------------------------

if IsServer() then
	function modifier_bloodseeker_blood_bath_lua_thinker:OnCreated()
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
		self.silence_duration = self:GetAbility():GetSpecialValueFor("silence_duration")
		self.damage = self:GetAbility():GetSpecialValueFor("damage")
		EmitSoundOn("hero_bloodseeker.bloodRite", self:GetCaster())

		self.bloodriteFX = ParticleManager:CreateParticle(
			"effect/bs_bloodbath/bloodritual_ring.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(self.bloodriteFX, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(self.bloodriteFX, 1, Vector(self.radius, self.radius, self.radius))
		ParticleManager:SetParticleControl(self.bloodriteFX, 3, self:GetParent():GetAbsOrigin())
	end

	function modifier_bloodseeker_blood_bath_lua_thinker:OnDestroy()
		local caster = self:GetCaster()
		local parent = self:GetParent()

		ParticleManager:DestroyParticle(self.bloodriteFX, false)
		ParticleManager:ReleaseParticleIndex(self.bloodriteFX)

		local all = FindUnitsInRadius(
			parent:GetTeam(),
			parent:GetOrigin(),
			nil,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		EmitSoundOn("hero_bloodseeker.bloodRite.silence", caster)

		for _, unit in ipairs(all) do
			ApplyDamage({
				victim = unit,
				attacker = self:GetCaster(),
				damage = self.damage,
				damage_type = self:GetAbility():GetAbilityDamageType(),
				ability = self:GetAbility(),
			})

			unit:AddNewModifier(
				caster,
				self:GetAbility(),
				"modifier_bloodseeker_blood_bath_lua",
				{ duration = self.silence_duration }
			)

			local fx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact.vpcf",
				PATTACH_CUSTOMORIGIN,
				unit
			)
			ParticleManager:SetParticleControl(fx, 0, unit:GetAbsOrigin())
			ParticleManager:SetParticleControl(fx, 1, parent:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(fx)
		end
	end
end

--------------------------------------------------------------------------------

modifier_bloodseeker_blood_bath_lua = class({
	IsHidden = function(self)
		return false
	end,
	IsPurgable = function(self)
		return true
	end,
	IsDebuff = function(self)
		return true
	end,
	IsBuff = function(self)
		return false
	end,
	RemoveOnDeath = function(self)
		return true
	end,
	CheckState = function(self)
		return {
			[MODIFIER_STATE_SILENCED] = true,
		}
	end,
	GetEffectName = function(self)
		return "particles/generic_gameplay/generic_silenced.vpcf"
	end,
	GetEffectAttachType = function(self)
		return PATTACH_OVERHEAD_FOLLOW
	end,
})

--------------------------------------------------------------------------------