--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_lina_light_strike_array_lua",
	"heroes/hero_lina/lina_stun/lina_stun",
	LUA_MODIFIER_MOTION_NONE
)

lina_stun = class({})

function lina_stun:OnSpellStart()
	local caster = self:GetCaster()
	local caster_pos = caster:GetAbsOrigin()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	if target then
		point = target:GetOrigin()
	end

	local direction = (point - caster_pos):Normalized()
	local delay = self:GetSpecialValueFor("delay")
	local points = self:GetSpecialValueFor("points")
	local distance = self:GetSpecialValueFor("distance")
	local tal = false

	talent = self:GetCaster():FindAbilityByName("special_bonus_lina_6")
	if talent and talent:GetLevel() > 0 then
		tal = true
		points = points + 2
	end

	local spacing = distance / points
	local range = 0

	Timers:CreateTimer(function()
		if tal then
			range = range + spacing
			point_loc = caster_pos + direction * range
		else
			point_loc = point
		end
		CreateModifierThinker(
			caster,
			self,
			"modifier_lina_light_strike_array_lua",
			{ duration = delay },
			point_loc,
			caster:GetTeamNumber(),
			false
		)
		points = points - 1
		if points > 0 then
			return delay
		else
			return nil
		end
	end)
end

------------------------------------------------------------------

modifier_lina_light_strike_array_lua = class({})

function modifier_lina_light_strike_array_lua:IsHidden()
	return true
end

function modifier_lina_light_strike_array_lua:IsPurgable()
	return false
end

function modifier_lina_light_strike_array_lua:OnCreated(kv)
	self.points = self:GetAbility():GetSpecialValueFor("points")

	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.caster_point = self:GetCaster():GetAbsOrigin()
	if not IsServer() then
		return
	end
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")
	local talent = self:GetCaster():FindAbilityByName("special_bonus_lina_2")
	if talent and talent:GetLevel() > 0 then
		self.damage = self.damage + 80
	end
end

function modifier_lina_light_strike_array_lua:OnDestroy()
	if not IsServer() then
		return
	end
	GridNav:DestroyTreesAroundPoint(self:GetParent():GetOrigin(), self.radius, false)
	local damageTable = {
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self, --Optional.
	}
	-- ApplyDamage(damageTable)

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

	for _, enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		-- stun
		enemy:AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_stunned", -- modifier name
			{ duration = self.duration } -- kv
		)
	end

	self:PlayEffects2()
	UTIL_Remove(self:GetParent())
end

function modifier_lina_light_strike_array_lua:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast = "Ability.LightStrikeArray"
	-- EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end