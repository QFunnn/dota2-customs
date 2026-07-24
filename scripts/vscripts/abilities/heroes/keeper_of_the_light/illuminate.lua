--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Original code ported from Dota IMBA
-- Creator: AltiV
-- Editor: EarthSalamander

LinkLuaModifier("modifier_keeper_of_the_light_illuminate_custom_self_thinker", "abilities/heroes/keeper_of_the_light/illuminate.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_illuminate_custom", "abilities/heroes/keeper_of_the_light/illuminate.lua", LUA_MODIFIER_MOTION_NONE)

keeper_of_the_light_illuminate_custom = keeper_of_the_light_illuminate_custom or class({})

function keeper_of_the_light_illuminate_custom:GetAssociatedSecondaryAbilities()
	return "keeper_of_the_light_illuminate_end_custom"
end

-- Level-up of Illuminate also levels up the Illuminate End ability
function keeper_of_the_light_illuminate_custom:OnUpgrade()
	if not IsServer() then return end

	local illuminate_end = self:GetCaster():FindAbilityByName("keeper_of_the_light_illuminate_end_custom")

	if illuminate_end then
		illuminate_end:SetLevel(self:GetLevel())
	end
end

function keeper_of_the_light_illuminate_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_keeper_of_the_light_spirit_form") then
		return DOTA_ABILITY_BEHAVIOR_POINT
	else
		return self.BaseClass.GetBehavior(self)
	end
end

function keeper_of_the_light_illuminate_custom:GetAbilityTextureName()
	if not self:GetCaster():HasModifier("modifier_keeper_of_the_light_spirit_form") then
		return "keeper_of_the_light_illuminate"
	else
		return "keeper_of_the_light_spirit_form_illuminate"
	end
end

function keeper_of_the_light_illuminate_custom:GetChannelTime()
	if self:GetCaster():HasModifier("modifier_keeper_of_the_light_spirit_form") then
		return -1
	else
		return self:GetSpecialValueFor("max_channel_time")
	end
end

function keeper_of_the_light_illuminate_custom:OnSpellStart()
	self.caster = self:GetCaster()
	if not self.caster or self.caster:IsNull() then return end
	self.caster_location	= self.caster:GetAbsOrigin()		-- Save the position of the caster into variable (since caster might move before wave is fired)
	self.position = self:GetCursorPosition()					-- Get the position of where Illuminate was cast towards

	-- Preventing projectiles getting stuck in one spot due to potential 0 length vector
	if self.position == self.caster_location then
		self.caster:SetCursorPosition(self.position + self.caster:GetForwardVector())
		self.position = self:GetCursorPosition()
	end

	-- AbilityValues
	self.max_channel_time				= self:GetSpecialValueFor("max_channel_time")
	self.range							= self:GetSpecialValueFor("range") + self:GetCastRangeBonus(nil, 0)
	self.speed							= self:GetSpecialValueFor("speed")
	self.vision_radius					= self:GetSpecialValueFor("vision_radius")
	self.vision_duration				= self:GetSpecialValueFor("vision_duration")
	self.channel_vision_radius			= self:GetSpecialValueFor("channel_vision_radius")
	self.channel_vision_interval		= self:GetSpecialValueFor("channel_vision_interval")
	self.channel_vision_duration		= self:GetSpecialValueFor("channel_vision_duration")
	self.channel_vision_step			= self:GetSpecialValueFor("channel_vision_step")
	self.vision_node_distance			= self.channel_vision_radius * 0.5		-- Distance between vision nodes (vanilla is 150 but this has better vision spread)

	if not IsServer() then return end

	self.caster:EmitSound("Hero_KeeperOfTheLight.Illuminate.Charge")
	self.direction	= (self.position - self.caster_location):Normalized()	-- Calculate direction for which Illuminate is going to travel
	self.game_time_start = GameRules:GetGameTime()					-- Get the time that the channel starts
	self.vision_time_count = self.game_time_start					-- Initialize counter time
	self.vision_counter = 1											-- Keep a counter for the vision spots that slowly build as channeling continues
	self.caster:SwapAbilities("keeper_of_the_light_illuminate_custom", "keeper_of_the_light_illuminate_end_custom", false, true)

	if self.caster:HasModifier("modifier_keeper_of_the_light_spirit_form") then
		self.spirit_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_illuminate_charge_spirit_form.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleAlwaysSimulate(self.spirit_particle)
		ParticleManager:SetParticleControl(self.spirit_particle, 0, self.caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(self.spirit_particle, 1, self.caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(self.spirit_particle, 3, self.caster:GetAbsOrigin())
		ParticleManager:SetParticleControlForward(self.spirit_particle, 3, self.direction)
		ParticleManager:SetParticleControlEnt(self.spirit_particle, 6, self.caster, PATTACH_CUSTOMORIGIN, nil, self.caster:GetAbsOrigin(), true )

		self.caster:AddNewModifier(self.caster, self, "modifier_keeper_of_the_light_illuminate_custom_self_thinker", {duration = self:GetSpecialValueFor("max_channel_time")})
	else
		-- Emit glowing staff particle
		self.weapon_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/kotl_illuminate_cast.vpcf", PATTACH_POINT_FOLLOW, self.caster)
		ParticleManager:SetParticleControlEnt(self.weapon_particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_attack1", self.caster:GetAbsOrigin(), true)
	end
end

function keeper_of_the_light_illuminate_custom:OnChannelThink()
	if not self:GetCaster():HasModifier("modifier_keeper_of_the_light_spirit_form") then
		self:HandleVisibilityNode()
	end
end

function keeper_of_the_light_illuminate_custom:HandleVisibilityNode()
	-- Every 0.5 seconds, create a visibility node further ahead
	if GameRules:GetGameTime() - self.vision_time_count >= self.channel_vision_interval then
		self.vision_time_count = GameRules:GetGameTime()
		self:CreateVisibilityNode(self.caster_location + (self.direction * self.channel_vision_step * self.vision_counter), self.channel_vision_radius, self.channel_vision_duration)
		self.vision_counter = self.vision_counter + 1
	end
end

function keeper_of_the_light_illuminate_custom:OnChannelFinish()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_keeper_of_the_light_spirit_form") then return end

	self:EndIlluminate()
end

function keeper_of_the_light_illuminate_custom:EndIlluminate()
	self.game_time_end				= GameRules:GetGameTime()
	self.caster:EmitSound("Hero_KeeperOfTheLight.Illuminate.Discharge")

	if self.spirit_particle then
		ParticleManager:DestroyParticle(self.spirit_particle, true)
		ParticleManager:ReleaseParticleIndex(self.spirit_particle)
	else
		self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
	end

	CreateModifierThinker(self.caster, self, "modifier_keeper_of_the_light_illuminate_custom", {
		duration		= self.range / self.speed,
		direction_x 	= self.direction.x,	-- x direction of where Illuminate will travel
		direction_y 	= self.direction.y,	-- y direction of where Illuminate will travel
		channel_time 	= self.game_time_end - self.game_time_start	-- total time Illuminate was channeled for
	},
	self.caster_location, self.caster:GetTeamNumber(), false)

	-- Swap the main ability back in
	self.caster:SwapAbilities("keeper_of_the_light_illuminate_end_custom", "keeper_of_the_light_illuminate_custom", false, true)

	-- Voice response
	if self.caster:GetName() == "npc_dota_hero_keeper_of_the_light" then
		if RollPercentage(5) then
			self.caster:EmitSound("keeper_of_the_light_keep_illuminate_06")
		elseif RollPercentage(50) then
			if RollPercentage(50) then
				self.caster:EmitSound("keeper_of_the_light_keep_illuminate_05")
			else
				self.caster:EmitSound("keeper_of_the_light_keep_illuminate_07")
			end
		end
	end

	if self.weapon_particle then
		ParticleManager:DestroyParticle(self.weapon_particle, false)
		ParticleManager:ReleaseParticleIndex(self.weapon_particle)
	end
end

-----------------------------
-- ILLUMINATE SELF THINKER --
-----------------------------

modifier_keeper_of_the_light_illuminate_custom_self_thinker = modifier_keeper_of_the_light_illuminate_custom_self_thinker or class({}) -- Custom class for attempting non-channel logic

function modifier_keeper_of_the_light_illuminate_custom_self_thinker:IsPurgable()	return false end

function modifier_keeper_of_the_light_illuminate_custom_self_thinker:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_spirit_form_ambient.vpcf"
end

function modifier_keeper_of_the_light_illuminate_custom_self_thinker:GetStatusEffectName()
	return "particles/status_fx/status_effect_keeper_spirit_form.vpcf"
end

function modifier_keeper_of_the_light_illuminate_custom_self_thinker:OnCreated()
	if not IsServer() then return end

	self:StartIntervalThink(FrameTime())
end

function modifier_keeper_of_the_light_illuminate_custom_self_thinker:OnIntervalThink()
	if not IsServer() then return end

	self:GetAbility():HandleVisibilityNode()
end

function modifier_keeper_of_the_light_illuminate_custom_self_thinker:OnDestroy()
	if not IsServer() then return end

	self:GetAbility():EndIlluminate()
end

-----------------------------
-- ILLUMINATE WAVE THINKER --
-----------------------------

modifier_keeper_of_the_light_illuminate_custom = modifier_keeper_of_the_light_illuminate_custom or class({})

function modifier_keeper_of_the_light_illuminate_custom:IsPurgable() return false end

function modifier_keeper_of_the_light_illuminate_custom:OnCreated( params )
	if not IsServer() then return end

	self.caster		= self:GetCaster()
	self.parent		= self:GetParent()
	self.ability	= self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.parent or self.parent:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	-- AbilitySpecials
	self.max_channel_time			= self.ability:GetSpecialValueFor("max_channel_time")
	self.radius						= self.ability:GetSpecialValueFor("radius")
	self.speed						= self.ability:GetSpecialValueFor("speed")
	self.total_damage				= self.ability:GetSpecialValueFor("total_damage")

	self.direction = Vector(params.direction_x, params.direction_y, 0)
	self.direction_angle = math.deg(math.atan2(self.direction.x, self.direction.y))
	self.damage = params.channel_time / self.max_channel_time * self.total_damage

	-- Create the Illuminate particle with CP1 being the velocity and CP3 being the origin
	-- Why is the circle particle so bright
	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/kotl_illuminate.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(self.particle, 1, self.direction * self.speed)
	ParticleManager:SetParticleControl(self.particle, 3, self.parent:GetAbsOrigin())

	self:AddParticle(self.particle, false, false, -1, false, false)

	-- Initialize table of enemies hit so we don't hit things more than once
	self.hit_targets = {}

	self.damage_table = {
		damage			= self.damage,
		damage_type		= DAMAGE_TYPE_MAGICAL,
		damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
		attacker 		= self.caster,
		ability 		= self.ability
	}

	self:OnIntervalThink()
	self:StartIntervalThink(FrameTime())
end

function modifier_keeper_of_the_light_illuminate_custom:OnIntervalThink()
	if not IsServer() then return end

	local targets = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	--print(self.channel_time, self.max_channel_time, self.total_damage, self.channel_time / self.max_channel_time, damage)

	local valid_targets	= {}

	-- Borrowed from Bristleback logic which I still don't fully understand, but essentially this checks to make sure the target is within the "front" of the wave, because the local targets table returns everything in a circle
	for _, target in pairs(targets) do
		local target_pos 	= target:GetAbsOrigin()
		local target_angle	= math.deg(math.atan2((target_pos.x - self.parent:GetAbsOrigin().x), target_pos.y - self.parent:GetAbsOrigin().y))

		local difference = math.abs(self.direction_angle - target_angle)

		-- If the enemy's position is not within the front semi-circle, remove them from the table
		if difference <= 90 or difference >= 270 then
			table.insert(valid_targets, target)
		end
	end

	-- By the end, the valid_targets table SHOULD have every unit that's actually in the "front" (semi-circle) of the wave, aka they should actually be hit by the wave
	for _, target in pairs(valid_targets) do
		local hit_already = false

		for _, hit_target in pairs(self.hit_targets) do
			if hit_target == target then
				hit_already = true
				break
			end
		end

		if not hit_already then
			-- Deal damage to enemies...
			if target:GetTeam() ~= self.caster:GetTeam() then
				self.damage_table.victim = target
				ApplyDamage(self.damage_table)
			--...and heal allies
			else
				if self.caster:HasModifier("modifier_keeper_of_the_light_spirit_form") then
					local spirit_form = self.caster:FindAbilityByName("keeper_of_the_light_spirit_form")
					local heal = self.damage * spirit_form:GetSpecialValueFor("illuminate_heal") / 100
					target:HealWithParams(heal, self.ability, false, true, self.caster, false)

					-- Apparently the vanilla skill only shows the heal number if it's a hero?...
					if target:IsHero() then
						SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, heal, nil)
					end
				end
			end

			-- Apply sounds (wave sound + horse sounds)
			target:EmitSound("Hero_KeeperOfTheLight.Illuminate.Target")
			target:EmitSound("Hero_KeeperOfTheLight.Illuminate.Target.Secondary")

			-- Apply the "hit by Illuminate" particle
			local particle_name = "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_illuminate_impact_small.vpcf"

			-- Heroes get a larger particle (supposedly)
			if target:IsHero() then
				particle_name = "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_illuminate_impact.vpcf"
			end

			local particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, target)
			ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(particle)

			-- Add the target to the list of targets hit so they can't get hit again
			table.insert(self.hit_targets, target)
		end
	end

	-- Move the wave forward by a frame
	self.parent:SetOrigin(self.parent:GetAbsOrigin() + (self.direction * self.speed * FrameTime()))
end

-- Safety destructor?
function modifier_keeper_of_the_light_illuminate_custom:OnDestroy()
	if not IsServer() then return end

	self.parent:RemoveSelf()
end

--------------------
-- ILLUMINATE END --
--------------------

keeper_of_the_light_illuminate_end_custom = keeper_of_the_light_illuminate_end_custom or class({})

function keeper_of_the_light_illuminate_end_custom:GetAssociatedPrimaryAbilities()
	return "keeper_of_the_light_illuminate_custom"
end

function keeper_of_the_light_illuminate_end_custom:ProcsMagicStick() return false end

function keeper_of_the_light_illuminate_end_custom:GetAbilityTextureName()
	if not self:GetCaster():HasModifier("modifier_keeper_of_the_light_spirit_form") then
		return "keeper_of_the_light_illuminate_end"
	else
		return "keeper_of_the_light_spirit_form_illuminate_end"
	end
end

function keeper_of_the_light_illuminate_end_custom:OnSpellStart()
	if not IsServer() then return end

	self.caster	= self:GetCaster()

	-- Check if the caster has the Illuminate ability
	local illuminate = self.caster:FindAbilityByName("keeper_of_the_light_illuminate_custom")

	if illuminate then
		-- Then check if the caster is currently "channeling" the illuminate (which they should be if this end ability is castable in the first place)
		local illuminate_self_thinker = self.caster:FindModifierByName("modifier_keeper_of_the_light_illuminate_custom_self_thinker")

		-- If so, destroy it (which will release the wave)
		if illuminate_self_thinker then
			illuminate_self_thinker:Destroy()
		end
	end
end