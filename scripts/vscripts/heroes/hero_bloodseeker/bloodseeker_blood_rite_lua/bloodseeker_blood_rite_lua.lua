--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_bloodseeker_blood_rite_lua_thinker",
	"heroes/hero_bloodseeker/bloodseeker_blood_rite_lua/bloodseeker_blood_rite_lua",
	LUA_MODIFIER_MOTION_NONE
)

bloodseeker_blood_rite_lua = class({})

function bloodseeker_blood_rite_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function bloodseeker_blood_rite_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	CreateModifierThinker(
		caster,
		self,
		"modifier_bloodseeker_blood_rite_lua_thinker",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)

	-- effects
	local sound_cast = "Hero_Bloodseeker.BloodRite.Cast"
	EmitSoundOn(sound_cast, caster)
end

--------------------------------------------------------

modifier_bloodseeker_blood_rite_lua_thinker = class({})

function modifier_bloodseeker_blood_rite_lua_thinker:IsPurgable()
	return false
end

function modifier_bloodseeker_blood_rite_lua_thinker:OnCreated(kv)
	if IsServer() then
		local delay = self:GetAbility():GetSpecialValueFor("delay")
		self.damage = self:GetAbility():GetSpecialValueFor("damage")
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
		self.duration = self:GetAbility():GetSpecialValueFor("silence_duration")
		local vision = 200

		local abil = self:GetCaster():FindAbilityByName("special_bonus_bloodseeker_4")
		if abil ~= nil and abil:GetLevel() > 0 then
			self.damage = self.damage + 120
		end

		self:StartIntervalThink(delay)

		AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), vision, 3, true)
		self:PlayEffects1()
	end
end

function modifier_bloodseeker_blood_rite_lua_thinker:OnDestroy(kv)
	if IsServer() then
		UTIL_Remove(self:GetParent())
	end
end

function modifier_bloodseeker_blood_rite_lua_thinker:OnIntervalThink()
	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(), -- int, your team number
		self:GetParent():GetOrigin(), -- point, center point
		self:GetParent(), -- handle, cacheUnit. (not known)
		self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		0, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self:GetAbility(), --Optional.
	}
	for _, enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		-- silence
		enemy:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_silence", -- modifier name
			{ duration = self.duration } -- kv
		)

		-- effects
		self:PlayEffects3(enemy)
	end

	self:PlayEffects2()
	self:Destroy()
end

function modifier_bloodseeker_blood_rite_lua_thinker:PlayEffects1()
	local particle_cast = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_ring.vpcf"
	local sound_cast = "Hero_Bloodseeker.BloodRite"

	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, self.radius, self.radius))
	-- EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

function modifier_bloodseeker_blood_rite_lua_thinker:PlayEffects2()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

function modifier_bloodseeker_blood_rite_lua_thinker:PlayEffects3(target)
	local particle_cast = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact.vpcf"
	local sound_cast = "hero_bloodseeker.bloodRite.silence"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, target)
end