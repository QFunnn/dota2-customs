--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_ogre_magi_multicast_lua",
	"heroes/hero_ogre_mage/ogre_magi_multicast_lua/ogre_magi_multicast_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_ogre_magi_multicast_lua_proc",
	"heroes/hero_ogre_mage/ogre_magi_multicast_lua/ogre_magi_multicast_lua",
	LUA_MODIFIER_MOTION_NONE
)

ogre_magi_multicast_lua = class({})

function ogre_magi_multicast_lua:GetIntrinsicModifierName()
	return "modifier_ogre_magi_multicast_lua"
end

------------------------------------------------------------------------------

modifier_ogre_magi_multicast_lua = class({})

modifier_ogre_magi_multicast_lua.singles = {
	["ogre_magi_fireblast_lua"] = true,
}

function modifier_ogre_magi_multicast_lua:IsHidden()
	return false
end

function modifier_ogre_magi_multicast_lua:IsDebuff()
	return false
end

function modifier_ogre_magi_multicast_lua:IsPurgable()
	return false
end

function modifier_ogre_magi_multicast_lua:OnCreated(kv)
	self.chance_2 = self:GetAbility():GetSpecialValueFor("multicast_2_times") * 100
	self.chance_3 = self:GetAbility():GetSpecialValueFor("multicast_3_times") * 100
	self.chance_4 = self:GetAbility():GetSpecialValueFor("multicast_4_times") * 100
	self.buffer_range = 300
end

function modifier_ogre_magi_multicast_lua:OnRefresh(kv)
	self.chance_2 = self:GetAbility():GetSpecialValueFor("multicast_2_times") * 100
	self.chance_3 = self:GetAbility():GetSpecialValueFor("multicast_3_times") * 100
	self.chance_4 = self:GetAbility():GetSpecialValueFor("multicast_4_times") * 100
end

function modifier_ogre_magi_multicast_lua:OnRemoved() end

function modifier_ogre_magi_multicast_lua:OnDestroy() end

function modifier_ogre_magi_multicast_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_ogre_magi_multicast_lua:OnAbilityFullyCast(params)
	if params.unit ~= self:GetCaster() then
		return
	end
	if params.ability == self:GetAbility() then
		return
	end

	if self:GetCaster():PassivesDisabled() then
		return
	end
	if not params.target then
		return
	end

	if bit.band(params.ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
		return
	end
	if bit.band(params.ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_OPTIONAL_UNIT_TARGET) ~= 0 then
		return
	end

	local casts = 1
	if RandomInt(0, 100) < self.chance_2 then
		casts = 2
	end
	if RandomInt(0, 100) < self.chance_3 then
		casts = 3
	end
	if RandomInt(0, 100) < self.chance_4 then
		casts = 4
	end

	if params.ability:GetName() == "hero_pangolier_blade_of_the_exile" then
		return
	end

	local delay = params.ability:GetSpecialValueFor("multicast_delay") or 0.5

	local single = self.singles[params.ability:GetAbilityName()] or false

	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ogre_magi_multicast_lua_proc", {
		ability = params.ability:entindex(),
		target = params.target:entindex(),
		multicast = casts,
		delay = delay,
		single = single,
	})
end

------------------------------------------------------------------

modifier_ogre_magi_multicast_lua_proc = class({})

function modifier_ogre_magi_multicast_lua_proc:IsHidden()
	return false
end

function modifier_ogre_magi_multicast_lua_proc:IsDebuff()
	return false
end

function modifier_ogre_magi_multicast_lua_proc:IsStunDebuff()
	return false
end

function modifier_ogre_magi_multicast_lua_proc:IsPurgable()
	return true
end

function modifier_ogre_magi_multicast_lua_proc:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_ogre_magi_multicast_lua_proc:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.caster = self:GetParent()
	self.ability = EntIndexToHScript(kv.ability)
	self.target = EntIndexToHScript(kv.target)
	self.multicast = kv.multicast
	self.delay = kv.delay
	self.single = kv.single == 1
	self.buffer_range = 300
	self:SetStackCount(self.multicast)

	self.casts = 0
	if self.multicast == 1 then
		self:Destroy()
		return
	end

	self.targets = {}
	self.targets[self.target] = true

	self.radius = self.ability:GetCastRange(self.target:GetOrigin(), self.target) + self.buffer_range

	self.target_team = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	if self.target:GetTeamNumber() ~= self.caster:GetTeamNumber() then
		self.target_team = DOTA_UNIT_TARGET_TEAM_ENEMY
	end

	self.target_type = self.ability:GetAbilityTargetType()
	if self.target_type == DOTA_UNIT_TARGET_CUSTOM then
		self.target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	end

	self.target_flags = DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
	if bit.band(self.ability:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
		self.target_flags = self.target_flags + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	end

	self:PlayEffects(self.casts)
	self:StartIntervalThink(self.delay)
end

function modifier_ogre_magi_multicast_lua_proc:OnIntervalThink()
	local current_target = nil
	if self.single then
		current_target = self.target
	else
		local units = FindUnitsInRadius(
			self.caster:GetTeamNumber(), -- int, your team number
			self.caster:GetOrigin(), -- point, center point
			self.caster, -- handle, cacheUnit. (not known)
			self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
			self.target_team, -- int, team filter
			self.target_type, -- int, type filter
			self.target_flags, -- int, flag filter
			FIND_CLOSEST, -- int, order filter
			false -- bool, can grow cache
		)
		for _, unit in pairs(units) do
			if not self.targets[unit] then
				local filter = false
				if self.ability.CastFilterResultTarget then -- for customs
					filter = self.ability:CastFilterResultTarget(unit) == UF_SUCCESS
				else
					filter = true
				end
				if filter then
					self.targets[unit] = true
					current_target = unit
					break
				end
			end
		end
		if not current_target then
			self:StartIntervalThink(-1)
			self:Destroy()
			return
		end
	end

	self.caster:SetCursorCastTarget(current_target)
	self.ability:OnSpellStart()

	self.casts = self.casts + 1
	if self.casts >= (self.multicast - 1) then
		self:StartIntervalThink(-1)
		self:Destroy()
	end
	self:PlayEffects(self.casts)
end

function modifier_ogre_magi_multicast_lua_proc:PlayEffects(value)
	value = value + 1
	local particle_cast = "particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf"
	local counter_speed = 2
	if value == self.multicast then
		counter_speed = 1
	end

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_OVERHEAD_FOLLOW, self.caster)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(value, counter_speed, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	-- Create Sound
	local sound = math.min(value - 1, 3)
	local sound_cast = "Hero_OgreMagi.Fireblast.x" .. sound
	if sound > 0 then
		EmitSoundOn(sound_cast, self.caster)
	end
end