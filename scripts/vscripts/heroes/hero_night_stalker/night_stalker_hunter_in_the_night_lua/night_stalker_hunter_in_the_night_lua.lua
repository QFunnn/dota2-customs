--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


night_stalker_hunter_in_the_night_lua = class({})
LinkLuaModifier(
	"modifier_night_stalker_hunter_in_the_night_lua_thinker",
	"heroes/hero_night_stalker/night_stalker_hunter_in_the_night_lua/night_stalker_hunter_in_the_night_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_night_stalker_hunter_in_the_night_lua",
	"heroes/hero_night_stalker/night_stalker_hunter_in_the_night_lua/night_stalker_hunter_in_the_night_lua",
	LUA_MODIFIER_MOTION_NONE
)

function night_stalker_hunter_in_the_night_lua:GetIntrinsicModifierName()
	return "modifier_night_stalker_hunter_in_the_night_lua_thinker"
end

function night_stalker_hunter_in_the_night_lua:OnUpgrade()
	local caster = self:GetCaster()
	local modifier_hunter = "modifier_night_stalker_hunter_in_the_night_lua"

	if caster:HasModifier(modifier_hunter) then
		local modifier_hunter_handler = caster:FindModifierByName(modifier_hunter)
		if modifier_hunter_handler then
			modifier_hunter_handler:ForceRefresh()
		end
	end
end

function night_stalker_hunter_in_the_night_lua:GetManaCost(level)
	if self.nightTime then
		return self.BaseClass.GetManaCost(self, level)
	else
		return 0
	end
end

modifier_night_stalker_hunter_in_the_night_lua_thinker = modifier_night_stalker_hunter_in_the_night_lua_thinker
	or class({})
function modifier_night_stalker_hunter_in_the_night_lua_thinker:IsHidden()
	return true
end
function modifier_night_stalker_hunter_in_the_night_lua_thinker:IsPurgable()
	return false
end
function modifier_night_stalker_hunter_in_the_night_lua_thinker:IsDebuff()
	return false
end

function modifier_night_stalker_hunter_in_the_night_lua_thinker:OnCreated()
	self.ability = self:GetAbility()
	self.ability.nightTime = false

	if IsServer() then
		-- Ability properties
		self.caster = self:GetCaster()
		self.modifier_hunter = "modifier_night_stalker_hunter_in_the_night_lua"
		self.modifier_day = "modifier_night_stalker_hunter_in_the_night_lua_day_model"
		self.night_transform_response = {
			"night_stalker_nstalk_ability_dark_01",
			"night_stalker_nstalk_ability_dark_02",
			"night_stalker_nstalk_ability_dark_04",
			"night_stalker_nstalk_ability_dark_05",
			"night_stalker_nstalk_ability_dark_06",
		}
		self.night_rare_transform_response = "night_stalker_nstalk_ability_dark_03"
		self.night_rarest_transform_response = "night_stalker_nstalk_ability_dark_07"
		self.day_transform_response =
			{ "night_stalker_nstalk_dayrise_01", "night_stalker_nstalk_dayrise_02", "night_stalker_nstalk_dayrise_03" }
		self.day_rare_transform_response = "night_stalker_nstalk_dayrise_05"
		self.day_rarest_transform_response = "night_stalker_nstalk_dayrise_04"

		-- Start thinking
		self:StartIntervalThink(1)
	end
end

function modifier_night_stalker_hunter_in_the_night_lua_thinker:OnStackCountChanged(oldStacks)
	if self:GetStackCount() == 1 then
		self.ability.nightTime = false
	else
		self.ability.nightTime = true
	end
end

function modifier_night_stalker_hunter_in_the_night_lua_thinker:OnIntervalThink()
	if IsServer() then
		-- If the daycycle is a night and Nightstalker doesn't have the buff yet, give it to him
		if
			(not GameRules:IsDaytime())
			and (not self.caster:HasModifier(self.modifier_hunter))
			and self.caster:IsAlive()
		then
			-- Night transform responses
			-- Roll for rarest transform response
			if RollPercentage(5) then
				-- EmitSoundOnLocationForAllies(self.caster:GetAbsOrigin(), self.night_rarest_transform_response, self.caster)
				EmitSoundOn(self.night_rarest_transform_response, self.caster)

			-- Roll for rare transform response
			elseif RollPercentage(15) then
				-- EmitSoundOnLocationForAllies(self.caster:GetAbsOrigin(), self.night_rare_transform_response, self.caster)
				EmitSoundOn(self.night_rare_transform_response, self.caster)

			-- Roll for normal transform response
			elseif RollPercentage(75) then
				-- EmitSoundOnLocationForAllies(self.caster:GetAbsOrigin(), self.night_transform_response[math.random(1, #self.night_transform_response)], self.caster)
				EmitSoundOn(self.night_transform_response[math.random(1, #self.night_transform_response)], self.caster)
			end

			-- Grant night buff
			self.caster:AddNewModifier(self.caster, self.ability, self.modifier_hunter, {})

			-- Set stack count to 2, used to tell the ability its night time
			self:SetStackCount(2)
		end

		-- If the daycycle is a morning and Nightstalker has the buff, remove it from him
		if GameRules:IsDaytime() and self.caster:HasModifier(self.modifier_hunter) and self.caster:IsAlive() then
			-- Day transformation responses
			-- Roll for rarest transform response
			if RollPercentage(5) then
				-- EmitSoundOnLocationForAllies(self.caster:GetAbsOrigin(), self.day_rarest_transform_response, self.caster)
				EmitSoundOn(self.day_rarest_transform_response, self.caster)

			-- Roll for rare transform response
			elseif RollPercentage(15) then
				-- EmitSoundOnLocationForAllies(self.caster:GetAbsOrigin(), self.day_rare_transform_response, self.caster)
				EmitSoundOn(self.day_rare_transform_response, self.caster)

			-- Play normal transform response
			else
				-- EmitSoundOnLocationForAllies(self.caster:GetAbsOrigin(), self.day_transform_response[math.random(1,#self.day_transform_response)], self.caster)
				EmitSoundOn(self.day_transform_response[math.random(1, #self.day_transform_response)], self.caster)
			end

			-- Remove night buff
			self.caster:RemoveModifierByName(self.modifier_hunter)

			-- Set stack count to 1, used to tell the ability its day time
			self:SetStackCount(1)
		end
	end
end

modifier_night_stalker_hunter_in_the_night_lua = modifier_night_stalker_hunter_in_the_night_lua or class({})

function modifier_night_stalker_hunter_in_the_night_lua:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.particle_change = "particles/units/heroes/hero_night_stalker/nightstalker_change.vpcf"
	self.particle_buff = "particles/units/heroes/hero_night_stalker/nightstalker_night_buff.vpcf"
	self.modifier_stalker = "modifier_imba_stalker_in_the_night"
	-- self.normal_model = "models/heroes/nightstalker/nightstalker.vmdl"
	-- self.night_model = "models/heroes/nightstalker/nightstalker_night.vmdl"

	-- Ability specials
	self.base_bonus_ms_pct = self.ability:GetSpecialValueFor("base_bonus_ms_pct")
	self.base_bonus_as = self.ability:GetSpecialValueFor("base_bonus_as")
	self.night_vision_bonus = self.ability:GetSpecialValueFor("night_vision_bonus")

	if IsServer() then
		-- Since illusion getting the buff can actually show who the real one is, don't give them the change particle
		Timers:CreateTimer(FrameTime(), function()
			if self.caster:IsRealHero() then
				-- Apply change particle
				self.particle_change_fx =
					ParticleManager:CreateParticle(self.particle_change, PATTACH_ABSORIGIN_FOLLOW, self.caster)
				ParticleManager:SetParticleControl(self.particle_change_fx, 0, self.caster:GetAbsOrigin())
				ParticleManager:SetParticleControl(self.particle_change_fx, 1, self.caster:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(self.particle_change_fx)
			end
		end)

		-- Apply buff particle
		self.particle_buff_fx =
			ParticleManager:CreateParticle(self.particle_buff, PATTACH_CUSTOMORIGIN_FOLLOW, self.caster)
		ParticleManager:SetParticleControl(self.particle_buff_fx, 0, self.caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(self.particle_buff_fx, 1, Vector(1, 0, 0))
		self:AddParticle(self.particle_buff_fx, false, false, -1, false, false)

		if not self:GetAbility():IsStolen() then
			-- Apply night model
			-- self.caster:SetModel(self.night_model)
			-- self.caster:SetOriginalModel(self.night_model)

			if self.wings then
				-- Remove old wearables
				UTIL_Remove(self.wings)
				UTIL_Remove(self.legs)
				UTIL_Remove(self.tail)
			end
			-- Set new wearables
			self.wings = SpawnEntityFromTableSynchronous(
				"prop_dynamic",
				{ model = "models/heroes/nightstalker/nightstalker_wings_night.vmdl" }
			)
			self.legs = SpawnEntityFromTableSynchronous(
				"prop_dynamic",
				{ model = "models/heroes/nightstalker/nightstalker_legarmor_night.vmdl" }
			)
			self.tail = SpawnEntityFromTableSynchronous(
				"prop_dynamic",
				{ model = "models/heroes/nightstalker/nightstalker_tail_night.vmdl" }
			)
			-- lock to bone
			self.wings:FollowEntity(self:GetCaster(), true)
			self.legs:FollowEntity(self:GetCaster(), true)
			self.tail:FollowEntity(self:GetCaster(), true)
		end

		self:StartIntervalThink(0.5)
	end
end

function modifier_night_stalker_hunter_in_the_night_lua:OnRefresh()
	self:OnCreated()
end

function modifier_night_stalker_hunter_in_the_night_lua:IsHidden()
	return false
end
function modifier_night_stalker_hunter_in_the_night_lua:IsPurgable()
	return false
end
function modifier_night_stalker_hunter_in_the_night_lua:IsDebuff()
	return false
end

function modifier_night_stalker_hunter_in_the_night_lua:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
	}
	return decFuncs
end

function modifier_night_stalker_hunter_in_the_night_lua:GetModifierMoveSpeedBonus_Percentage()
	if self.caster:PassivesDisabled() then
		return nil
	end
	return self.base_bonus_ms_pct
end

function modifier_night_stalker_hunter_in_the_night_lua:GetModifierAttackSpeedBonus_Constant()
	if self.caster:PassivesDisabled() then
		return nil
	end
	return self.base_bonus_as
end

function modifier_night_stalker_hunter_in_the_night_lua:GetBonusNightVision()
	if self.caster:PassivesDisabled() then
		return nil
	end
	return self.night_vision_bonus
end

function modifier_night_stalker_hunter_in_the_night_lua:OnDestroy()
	if IsServer() then
		-- Apply change particle
		self.particle_change_fx =
			ParticleManager:CreateParticle(self.particle_change, PATTACH_ABSORIGIN_FOLLOW, self.caster)
		ParticleManager:SetParticleControl(self.particle_change_fx, 0, self.caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(self.particle_change_fx, 1, self.caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(self.particle_change_fx)

		if not self:GetAbility():IsStolen() then
			-- Revert Models
			-- self.caster:SetModel(self.normal_model)
			-- self.caster:SetOriginalModel(self.normal_model)

			if self.wings then
				-- Remove old wearables
				UTIL_Remove(self.wings)
				UTIL_Remove(self.legs)
				UTIL_Remove(self.tail)
			end
		end
	end
end