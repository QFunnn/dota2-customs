--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


lion_finger_of_death_lua = class({})
LinkLuaModifier(
	"modifier_lion_finger_of_death_lua",
	"heroes/hero_lion/lion_finger_of_death_lua/modifier_lion_finger_of_death_lua",
	LUA_MODIFIER_MOTION_NONE
)

function lion_finger_of_death_lua:GetAOERadius()
	if self:GetCaster():FindAbilityByName("special_bonus_lion_int11") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_lion_int11"):GetLevel() > 0 then
			return self:GetSpecialValueFor("splash_radius_scepter")
		end
	end
	return 0
end

function lion_finger_of_death_lua:GetCooldown(level)
	if self:GetCaster():FindAbilityByName("special_bonus_lion_int11") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_lion_int11"):GetLevel() > 0 then
			return self:GetSpecialValueFor("cooldown_scepter")
		end
	end
	return self.BaseClass.GetCooldown(self, level)
end

function lion_finger_of_death_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	EmitSoundOn("Hero_Lion.FingerOfDeath", caster)

	if target:TriggerSpellAbsorb(self) then
		self:PlayEffects(target)
		return
	end

	local delay = self:GetSpecialValueFor("damage_delay")
	local search = self:GetSpecialValueFor("splash_radius_scepter")

	local targets = {}
	local ability = self:GetCaster():FindAbilityByName("special_bonus_lion_int11")
	if ability ~= nil and ability:GetLevel() > 0 then
		targets = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target:GetOrigin(),
			target,
			search,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
	else
		table.insert(targets, target)
	end

	for _, enemy in pairs(targets) do
		enemy:AddNewModifier(caster, self, "modifier_lion_finger_of_death_lua", { duration = delay })
		self:PlayEffects(enemy)
	end
end

function lion_finger_of_death_lua:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_lion/lion_spell_finger_of_death.vpcf"
	local sound_cast = "Hero_Lion.FingerOfDeathImpact"

	local caster = self:GetCaster()
	local direction = (caster:GetOrigin() - target:GetOrigin()):Normalized()

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, caster)
	local attach = "attach_attack1"
	if caster:ScriptLookupAttachment("attach_attack2") ~= 0 then
		attach = "attach_attack2"
	end
	ParticleManager:SetParticleControlEnt(effect_cast, 0, caster, PATTACH_POINT_FOLLOW, attach, Vector(0, 0, 0), true)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControl(effect_cast, 2, target:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 3, target:GetOrigin() + direction)
	ParticleManager:SetParticleControlForward(effect_cast, 3, -direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, target)
end