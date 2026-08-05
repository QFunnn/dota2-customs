--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- VACUUM --------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_lua_dark_seer_vacuum",
	"heroes/hero_dark_seer/hero_dark_seer.lua",
	LUA_MODIFIER_MOTION_HORIZONTAL
)
LinkLuaModifier(
	"modifier_lua_dark_seer_vacuum_wormhole",
	"heroes/hero_dark_seer/hero_dark_seer.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_dark_seer_vacuum_refresh_tracker",
	"heroes/hero_dark_seer/hero_dark_seer.lua",
	LUA_MODIFIER_MOTION_NONE
)

lua_dark_seer_vacuum = class({})

function lua_dark_seer_vacuum:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function lua_dark_seer_vacuum:OnSpellStart()
	if not IsServer() then
		return
	end

	local position = self:GetCursorPosition()
	local sound_cast = "Hero_Dark_Seer.Vacuum"
	-- EmitSoundOnLocationWithCaster(self:GetCursorPosition(), sound_cast, self:GetCaster())
	EmitSoundOn(sound_cast, self:GetCaster())

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dark_seer/dark_seer_vacuum.vpcf",
		PATTACH_POINT,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(particle, 0, self:GetCursorPosition())
	ParticleManager:SetParticleControl(particle, 1, Vector(self:GetSpecialValueFor("radius"), 1, 1))
	ParticleManager:ReleaseParticleIndex(particle)

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		position,
		nil,
		self:GetSpecialValueFor("radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(
			enemy,
			self,
			"modifier_lua_dark_seer_vacuum",
			{ duration = self:GetSpecialValueFor("duration") }
		)
		ApplyDamage({
			victim = enemy,
			damage = self:GetSpecialValueFor("damage")
				+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage"),
			damage_type = DAMAGE_TYPE_MAGICAL,
			attacker = self:GetCaster(),
			ability = self,
		})
	end
	GridNav:DestroyTreesAroundPoint(self:GetCursorPosition(), self:GetSpecialValueFor("radius"), true)
end

------------------------------------------------------------------------------------------------------------------------

modifier_lua_dark_seer_vacuum = class({})

function modifier_lua_dark_seer_vacuum:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_debuff.vpcf"
end

function modifier_lua_dark_seer_vacuum:IsDebuff()
	return true
end
function modifier_lua_dark_seer_vacuum:IgnoreTenacity()
	return true
end

function modifier_lua_dark_seer_vacuum:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
	}
end

function modifier_lua_dark_seer_vacuum:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_lua_dark_seer_vacuum:GetModifierMiss_Percentage()
	return self:GetAbility():GetSpecialValueFor("miss")
end

------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- ION SHELL -----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_lua_dark_seer_ion_shell",
	"heroes/hero_dark_seer/hero_dark_seer.lua",
	LUA_MODIFIER_MOTION_NONE
)

lua_dark_seer_ion_shell = class({})

function lua_dark_seer_ion_shell:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/abaddon/abaddon_alliance/abaddon_aphotic_shield_alliance_explosion.vpcf",
		context
	)
end

function lua_dark_seer_ion_shell:GetBehavior()
	local special_bonus_unique_dark_seer_6 = self:GetCaster():FindAbilityByName("special_bonus_unique_dark_seer_6")
	if special_bonus_unique_dark_seer_6 and special_bonus_unique_dark_seer_6:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + DOTA_ABILITY_BEHAVIOR_AOE
	end
	return self.BaseClass.GetBehavior(self)
end

function lua_dark_seer_ion_shell:GetAOERadius()
	local special_bonus_unique_dark_seer_6 = self:GetCaster():FindAbilityByName("special_bonus_unique_dark_seer_6")
	if special_bonus_unique_dark_seer_6 and special_bonus_unique_dark_seer_6:GetLevel() > 0 then
		return 250
	end
end

function lua_dark_seer_ion_shell:OnSpellStart()
	if not IsServer() then
		return
	end
	local special_bonus_unique_dark_seer_6 = self:GetCaster():FindAbilityByName("special_bonus_unique_dark_seer_6")
	if special_bonus_unique_dark_seer_6 and special_bonus_unique_dark_seer_6:GetLevel() > 0 then
		local units = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetCursorPosition(),
			nil,
			250,
			DOTA_UNIT_TARGET_TEAM_BOTH,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, unit in pairs(units) do
			unit:AddNewModifier(
				self:GetCaster(),
				self,
				"modifier_lua_dark_seer_ion_shell",
				{ duration = self:GetSpecialValueFor("duration") }
			)
			unit:EmitSound("Hero_Dark_Seer.Ion_Shield_Start")
		end
	else
		self:GetCursorTarget():AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_lua_dark_seer_ion_shell",
			{ duration = self:GetSpecialValueFor("duration") }
		)
		self:GetCursorTarget():EmitSound("Hero_Dark_Seer.Ion_Shield_Start")
	end

	if self:GetCaster():GetName() == "npc_dota_hero_dark_seer" and RollPercentage(50) then
		self:GetCaster():EmitSound("dark_seer_dkseer_ability_surge_0" .. math.random(1, 2))
	end
end

------------------------------------------------------------------------------------------------------------------------

modifier_lua_dark_seer_ion_shell = class({})

function modifier_lua_dark_seer_ion_shell:OnCreated()
	if not IsServer() then
		return
	end
	self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")
	self.proton_explosion_radius = self:GetAbility():GetSpecialValueFor("proton_explosion_radius")
	self.proton_damage_pct = self:GetAbility():GetSpecialValueFor("proton_damage_pct")

	self.interval = 0.25

	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	self:GetParent():EmitSound("Hero_Dark_Seer.Ion_Shield_lp")

	self.particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dark_seer/dark_seer_ion_shell.vpcf",
		PATTACH_POINT_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		self.particle,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.particle, 1, Vector(50, 50, 50)) -- Arbitrary
	self:AddParticle(self.particle, false, false, -1, false, false)

	self:StartIntervalThink(self.interval)
end

function modifier_lua_dark_seer_ion_shell:OnRefresh()
	if not IsServer() then
		return
	end

	self:GetParent():EmitSound("Hero_Dark_Seer.Ion_Shield_end")
	self:GetParent():EmitSound("Hero_Abaddon.AphoticShield.Destroy")

	local particle = ParticleManager:CreateParticle(
		"particles/econ/items/abaddon/abaddon_alliance/abaddon_aphotic_shield_alliance_explosion.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(particle)

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		nil,
		self.proton_explosion_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		if enemy ~= self:GetParent() then
			ApplyDamage({
				victim = enemy,
				damage = self.damage_per_second * self.proton_damage_pct / 100,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				attacker = self:GetCaster(),
				ability = self:GetAbility(),
			})
		end
	end
end

function modifier_lua_dark_seer_ion_shell:OnIntervalThink()
	if not IsServer() then
		return
	end

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		self:GetParent(),
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, enemy in pairs(enemies) do
		if enemy ~= self:GetParent() then
			local particle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_dark_seer/dark_seer_ion_shell_damage.vpcf",
				PATTACH_POINT,
				self:GetParent()
			)
			ParticleManager:SetParticleControlEnt(
				particle,
				0,
				self:GetParent(),
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				self:GetParent():GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				particle,
				1,
				enemy,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				enemy:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(particle)

			ApplyDamage({
				victim = enemy,
				damage = self.damage_per_second * self.interval,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				attacker = self:GetCaster(),
				ability = self:GetAbility(),
			})
		end
	end
end

function modifier_lua_dark_seer_ion_shell:OnDestroy()
	if not IsServer() then
		return
	end

	self:GetParent():StopSound("Hero_Dark_Seer.Ion_Shield_lp")

	self:GetParent():EmitSound("Hero_Dark_Seer.Ion_Shield_end")

	if self:GetRemainingTime() <= 0 then
		self:GetParent():EmitSound("Hero_Abaddon.AphoticShield.Destroy")

		local particle = ParticleManager:CreateParticle(
			"particles/econ/items/abaddon/abaddon_alliance/abaddon_aphotic_shield_alliance_explosion.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:ReleaseParticleIndex(particle)

		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			nil,
			self.proton_explosion_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(enemies) do
			if enemy ~= self:GetParent() then
				ApplyDamage({
					victim = enemy,
					damage = self.damage_per_second * self.proton_damage_pct / 100,
					damage_type = DAMAGE_TYPE_MAGICAL,
					damage_flags = DOTA_DAMAGE_FLAG_NONE,
					attacker = self:GetCaster(),
					ability = self:GetAbility(),
				})
			end
		end
	end
end

------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------SURGE ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_lua_dark_seer_surge", "heroes/hero_dark_seer/hero_dark_seer.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_lua_dark_seer_surge_slow",
	"heroes/hero_dark_seer/hero_dark_seer.lua",
	LUA_MODIFIER_MOTION_NONE
)

lua_dark_seer_surge = class({})

function lua_dark_seer_surge:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function lua_dark_seer_surge:OnSpellStart()
	if not IsServer() then
		return
	end

	local position = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	local damage = self:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")

	local allies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		position,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	if #allies > 0 then
		local sound_cast = "Hero_Dark_Seer.Surge"
		-- EmitSoundOnLocationWithCaster(self:GetCursorPosition(), sound_cast, self:GetCaster())
		EmitSoundOn(sound_cast, self:GetCaster())
	end

	for _, ally in pairs(allies) do
		ally:AddNewModifier(self:GetCaster(), self, "modifier_lua_dark_seer_surge", { duration = duration })
	end

	for _, enemy in
		pairs(
			FindUnitsInRadius(
				self:GetCaster():GetTeamNumber(),
				position,
				nil,
				radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
		)
	do
		enemy:EmitSound("Hero_Dark_Seer.Surge_Sonic_Boom")

		enemy:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_lua_dark_seer_surge_slow",
			{ duration = duration * (1 - enemy:GetStatusResistance()) }
		)

		ApplyDamage({
			victim = enemy,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			attacker = self:GetCaster(),
			ability = self,
		})
	end
end

------------------------------------------------------------------------------------------------------------------------

modifier_lua_dark_seer_surge = class({})

function modifier_lua_dark_seer_surge:GetEffectName()
	return "particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf"
end

function modifier_lua_dark_seer_surge:OnCreated()
	self.speed_boost = self:GetAbility():GetSpecialValueFor("speed_boost")
end

function modifier_lua_dark_seer_surge:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_lua_dark_seer_surge:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}
end

function modifier_lua_dark_seer_surge:GetModifierMoveSpeedBonus_Percentage()
	return self.speed_boost
end

function modifier_lua_dark_seer_surge:GetModifierIgnoreMovespeedLimit()
	return 1
end

------------------------------------------------------------------------------------------------------------------------

modifier_lua_dark_seer_surge_slow = class({})

function modifier_lua_dark_seer_surge_slow:OnCreated()
	self.speed_boost = self:GetAbility():GetSpecialValueFor("speed_boost")
end

function modifier_lua_dark_seer_surge_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_lua_dark_seer_surge_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self.speed_boost
end

---------------------
-- WALL OF REPLICA --
---------------------
------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------SURGE ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

lua_dark_seer_wall_of_replica = class({})

function lua_dark_seer_wall_of_replica:GetCooldown(level)
	local abil = self:GetCaster():FindAbilityByName("special_bonus_unique_dark_seer_8")
	if abil ~= nil and abil:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 40
	end
	return self.BaseClass.GetCooldown(self, level)
end

LinkLuaModifier(
	"modifier_lua_dark_seer_wall_of_replica",
	"heroes/hero_dark_seer/hero_dark_seer.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_dark_seer_wall_of_replica_pw",
	"heroes/hero_dark_seer/hero_dark_seer.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_stop_move_lua", "heroes/hero_dark_seer/hero_dark_seer.lua", LUA_MODIFIER_MOTION_NONE)

function lua_dark_seer_wall_of_replica:OnSpellStart()
	local caster = self:GetCaster()
	local front = self:GetCaster():GetForwardVector():Normalized()
	local pos = self:GetCaster():GetOrigin() + front * 100

	local duration = self:GetSpecialValueFor("duration")
	self.damage = self:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")

	EmitSoundOn("Hero_Dark_Seer.Wall_of_Replica_Start", caster)

	CreateModifierThinker(
		caster,
		self,
		"modifier_lua_dark_seer_wall_of_replica",
		{ duration = duration },
		pos,
		caster:GetTeamNumber(),
		false
	)
	CreateModifierThinker(
		caster,
		self,
		"modifier_lua_dark_seer_wall_of_replica_pw",
		{ duration = duration },
		pos,
		caster:GetTeamNumber(),
		false
	)
end

function lua_dark_seer_wall_of_replica:OnProjectileHit_ExtraData(target, location, kv)
	if target == nil then
		return
	end
	local caster = self:GetCaster()
	if not target:IsMagicImmune() then
		ApplyDamage({
			victim = target,
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			attacker = self:GetCaster(),
			ability = self,
		})
	end
end

--------------------------------------------------------------------------

modifier_lua_dark_seer_wall_of_replica = class({})

function modifier_lua_dark_seer_wall_of_replica:IsHidden()
	return true
end

function modifier_lua_dark_seer_wall_of_replica:IsPurgable()
	return false
end

function modifier_lua_dark_seer_wall_of_replica:OnCreated()
	self.caster = self:GetCaster()
	self.rg = self:GetAbility():GetSpecialValueFor("rg") / 2
	self.wh = self:GetAbility():GetSpecialValueFor("wh") - 50
	if IsServer() then
		self.pos = self:GetParent():GetAbsOrigin()
		self.team = self.caster:GetTeam()
		self.start_pos = self.pos + self.caster:GetRightVector() * self.rg
		self.end_pos = self.pos + self.caster:GetRightVector() * -self.rg
		local P = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(P, 0, self.start_pos)
		ParticleManager:SetParticleControl(P, 1, self.end_pos)
		ParticleManager:SetParticleControl(P, 2, Vector(1, 1, 0))
		ParticleManager:SetParticleControl(P, 60, Vector(255, 0, 0))
		ParticleManager:SetParticleControl(P, 61, Vector(1, 0, 0))
		self:AddParticle(P, false, false, -1, false, false)
		self:OnIntervalThink()
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_lua_dark_seer_wall_of_replica:OnIntervalThink()
	local enemies = FindUnitsInLine(
		self.team,
		self.start_pos,
		self.end_pos,
		self.caster,
		self.wh,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	if #enemies > 0 then
		for _, tar in pairs(enemies) do
			if not tar:IsMagicImmune() then
				local front = tar:GetForwardVector():Normalized()
				local pos = tar:GetOrigin() - front * 15
				tar:SetAbsOrigin(pos)
				if not tar:HasModifier("modifier_stop_move_lua") then
					tar:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stop_move_lua", { duration = 1 })
				end
			end
		end
	end
end

function modifier_lua_dark_seer_wall_of_replica:OnDestroy()
	if not IsServer() then
		return
	end
	UTIL_Remove(self:GetParent())
end

function GetDirection2D(endpos, startpos)
	local dir = (endpos - startpos):Normalized()
	dir.z = 0
	return dir
end

--------------------------------------------------------------------------------

modifier_stop_move_lua = class({})

function modifier_stop_move_lua:IsHidden()
	return false
end

function modifier_stop_move_lua:IsPurgable()
	return false
end

function modifier_stop_move_lua:OnCreated()
	ApplyDamage({
		victim = self:GetParent(),
		damage = self:GetAbility():GetSpecialValueFor("damage") + self:GetCaster():ExtraIntelligenceDamage() * self
			:GetAbility()
			:GetSpecialValueFor("ExtraIntelligenceDamage"),
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self,
	})
end

--------------------------------------------------------------------------------

modifier_lua_dark_seer_wall_of_replica_pw = class({})

function modifier_lua_dark_seer_wall_of_replica_pw:IsHidden()
	return true
end

function modifier_lua_dark_seer_wall_of_replica_pw:IsPurgable()
	return false
end

function modifier_lua_dark_seer_wall_of_replica_pw:OnCreated()
	self.caster = self:GetCaster()
	self.interval = self:GetAbility():GetSpecialValueFor("interval")
	self.dis = self:GetAbility():GetSpecialValueFor("dis")
	self.wh2 = self:GetAbility():GetSpecialValueFor("wh2")
	if IsServer() then
		self.pos = self:GetParent():GetAbsOrigin()
		self.dir = GetDirection2D(self.pos, self.caster:GetAbsOrigin())
		self.team = self.caster:GetTeam()
		self:StartIntervalThink(self.interval)
	end
end

function modifier_lua_dark_seer_wall_of_replica_pw:OnIntervalThink()
	Timers:CreateTimer(0.3, function()
		if self:GetCaster() ~= nil then
			EmitSoundOn("Hero_Dark_Seer.NormalPunch.Lv1", self:GetCaster())
		end
	end)
	local projectileTable = {
		EffectName = "particles/units/heroes/hero_dark_seer/dark_seer_punch_glove_attack.vpcf",
		Ability = self:GetAbility(),
		vSpawnOrigin = self.pos,
		vVelocity = self.dir * 1000,
		fDistance = self.dis,
		fStartRadius = self.wh2,
		fEndRadius = self.wh2,
		Source = self.caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		fExpireTime = GameRules:GetGameTime() + 10.0,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		bProvidesVision = false,
	}
	ProjectileManager:CreateLinearProjectile(projectileTable)
end

function modifier_lua_dark_seer_wall_of_replica_pw:OnDestroy()
	if not IsServer() then
		return
	end
	UTIL_Remove(self:GetParent())
end