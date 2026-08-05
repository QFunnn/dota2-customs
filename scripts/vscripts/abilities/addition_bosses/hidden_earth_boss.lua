--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_hidden_earth_boss_split_earth",
	"abilities/addition_bosses/hidden_earth_boss",
	LUA_MODIFIER_MOTION_NONE
)

hidden_earth_boss_split_earth = class({})

function hidden_earth_boss_split_earth:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function hidden_earth_boss_split_earth:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_leshrac/leshrac_split_earth.vpcf", context)
end

function hidden_earth_boss_split_earth:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local delay = self:GetSpecialValueFor("delay")
	CreateModifierThinker(
		caster,
		self,
		"modifier_hidden_earth_boss_split_earth",
		{ duration = delay },
		point,
		caster:GetTeamNumber(),
		false
	)
end

----------------------------------------------------------------------------

modifier_hidden_earth_boss_split_earth = class({})

function modifier_hidden_earth_boss_split_earth:IsHidden()
	return true
end

function modifier_hidden_earth_boss_split_earth:IsPurgable()
	return false
end

function modifier_hidden_earth_boss_split_earth:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.damageTable = {
		attacker = self:GetCaster(),
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
		damage = self.damage,
	}
end

function modifier_hidden_earth_boss_split_earth:OnDestroy()
	if not IsServer() then
		return
	end
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_stunned",
			{ duration = self.duration * (1 - enemy:GetStatusResistance()) }
		)
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)
	end

	self:PlayEffects()
	UTIL_Remove(self:GetParent())
end

function modifier_hidden_earth_boss_split_earth:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_leshrac/leshrac_split_earth.vpcf"
	local sound_cast = "Hero_Leshrac.Split_Earth"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	-- EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

----------------------------------------------------------------------------
----------------------------------------------------------------------------

hidden_earth_boss_create_stone = class({})

function hidden_earth_boss_create_stone:OnSpellStart()
	local caster = self:GetCaster()
	local player_id = caster:GetPlayerOwnerID()

	local count = self:GetSpecialValueFor("count")
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("spawn_radius")

	caster:EmitSound("Hero_Brewmaster.ThunderClap")

	for i = 1, count do
		local spawn_pos = caster:GetAbsOrigin() + RandomVector(RandomFloat(300, radius))

		CreateUnitByNameAsync("npc_hidden_earth_minion_boss", spawn_pos, true, caster, caster, caster:GetTeamNumber(), function(
			unit
		)
			unit:SetOwner(caster)
			unit:AddNewModifier(caster, self, "modifier_kill", { duration = duration })

			local particle = ParticleManager:CreateParticle(
				"particles/econ/items/earth_spirit/earth_spirit_ti6_boulder/espirit_ti6_rollingboulder_stone_wave.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				unit
			)

			ParticleManager:SetParticleControl(particle, 0, unit:GetAbsOrigin())
			ParticleManager:SetParticleControl(particle, 1, Vector(50, 100, 0))
			ParticleManager:SetParticleControl(particle, 2, Vector(4, 10, 0.5))
			ParticleManager:SetParticleControl(particle, 3, Vector(20, 200, 0))
			ParticleManager:ReleaseParticleIndex(particle)
		end)
	end
end

----------------------------------------------------------------------------
----------------------------------------------------------------------------
LinkLuaModifier(
	"modifier_hidden_earth_boss_fissure_lua_thinker",
	"abilities/addition_bosses/hidden_earth_boss",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_hidden_earth_boss_fissure_pass",
	"abilities/addition_bosses/hidden_earth_boss",
	LUA_MODIFIER_MOTION_NONE
)

hidden_earth_boss_fissure_lua = class({})

function hidden_earth_boss_fissure_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function hidden_earth_boss_fissure_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	local distance = self:GetSpecialValueFor("distance")
	local duration = self:GetSpecialValueFor("fissure_duration")
	local radius = self:GetSpecialValueFor("fissure_radius")
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	local block_width = 24
	local block_delta = 8.25

	local direction = point - caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()
	local wall_vector = direction * distance

	local block_spacing = (block_delta + 2 * block_width)
	local blocks = distance / block_spacing
	local block_pos = caster:GetHullRadius() + block_delta + block_width
	local start_pos = caster:GetOrigin() + direction * block_pos

	for i = 1, blocks do
		local block_vec = caster:GetOrigin() + direction * block_pos
		local blocker = CreateModifierThinker(
			caster,
			self,
			"modifier_hidden_earth_boss_fissure_lua_thinker",
			{ duration = duration },
			block_vec,
			caster:GetTeamNumber(),
			true
		)
		blocker:SetHullRadius(block_width)
		block_pos = block_pos + block_spacing
	end

	local end_pos = start_pos + wall_vector
	local units = FindUnitsInLine(
		caster:GetTeamNumber(),
		start_pos,
		end_pos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0
	)

	local damageTable = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	for _, unit in pairs(units) do
		FindClearSpaceForUnit(unit, unit:GetOrigin(), true)
		if unit:GetTeamNumber() ~= caster:GetTeamNumber() then
			damageTable.victim = unit
			ApplyDamage(damageTable)
			unit:AddNewModifier(caster, self, "modifier_stunned", { duration = stun_duration })
		end
	end

	self:PlayEffects(start_pos, end_pos, duration)
end

function hidden_earth_boss_fissure_lua:PlayEffects(start_pos, end_pos, duration)
	local caster = self:GetCaster()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf",
		PATTACH_WORLDORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(effect_cast, 0, start_pos)
	ParticleManager:SetParticleControl(effect_cast, 1, end_pos)
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(duration, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast_fissure = "Hero_EarthShaker.Fissure"
	-- EmitSoundOnLocationWithCaster( start_pos, sound_cast_fissure, caster )
	EmitSoundOn(sound_cast_fissure, caster)
end

--------------------------------------------------------------------------------

modifier_hidden_earth_boss_fissure_lua_thinker = class({})

function modifier_hidden_earth_boss_fissure_lua_thinker:IsAura()
	return true
end
function modifier_hidden_earth_boss_fissure_lua_thinker:GetModifierAura()
	return "modifier_hidden_earth_boss_fissure_pass"
end
function modifier_hidden_earth_boss_fissure_lua_thinker:GetAuraRadius()
	return 120
end
function modifier_hidden_earth_boss_fissure_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_hidden_earth_boss_fissure_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_hidden_earth_boss_fissure_lua_thinker:GetAuraEntityReject(target)
	if target == self:GetCaster() then
		return false
	end

	if target:GetUnitName() == "npc_hidden_earth_boss" then
		return false
	end

	return true
end

--------------------------------------------------------------------------------

modifier_hidden_earth_boss_fissure_pass = class({})

function modifier_hidden_earth_boss_fissure_pass:IsHidden()
	return true
end

function modifier_hidden_earth_boss_fissure_pass:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	}
end

function modifier_hidden_earth_boss_fissure_pass:DeclareFunctions()
	return { MODIFIER_PROPERTY_IGNORE_CAST_MOVE_CONFIRMATION }
end

function modifier_hidden_earth_boss_fissure_pass:GetModifierIgnoreCastMoveConfirmation()
	return 1
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_hidden_earth_boss_magnetize_lua",
	"abilities/addition_bosses/hidden_earth_boss",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_hidden_earth_boss_minion_root",
	"abilities/addition_bosses/hidden_earth_boss",
	LUA_MODIFIER_MOTION_NONE
)

hidden_earth_boss_magnetize_lua = class({})

function hidden_earth_boss_magnetize_lua:GetIntrinsicModifierName()
	return "modifier_hidden_earth_boss_minion_root"
end

function hidden_earth_boss_magnetize_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_earth_spirit/espirit_magnetize_target.vpcf", context)
end

function hidden_earth_boss_magnetize_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("cast_radius")
	local duration = self:GetSpecialValueFor("damage_duration")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_hidden_earth_boss_magnetize_lua", { duration = duration })
	end

	caster:EmitSound("Hero_EarthSpirit.Magnetize.Cast")
end

--------------------------------------------------------------------------------

modifier_hidden_earth_boss_magnetize_lua = class({})

function modifier_hidden_earth_boss_magnetize_lua:IsPurgable()
	return true
end

function modifier_hidden_earth_boss_magnetize_lua:OnCreated()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end

	local interval = self:GetAbility():GetSpecialValueFor("damage_interval")
	self.damage = (
		self:GetAbility():GetSpecialValueFor("damage_per_second")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	) * interval
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	self:StartIntervalThink(interval)
end

function modifier_hidden_earth_boss_magnetize_lua:OnIntervalThink()
	local target = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local duration = ability:GetSpecialValueFor("damage_duration")

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = ability,
	})

	if target:IsHero() then
		EmitSoundOn("Hero_EarthSpirit.Magnetize.Target.Tick", target)
	end

	local tickParticle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_earth_spirit/espirit_magnetize_target.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControl(tickParticle, 1, Vector(self.radius, self.radius, self.radius))
	ParticleManager:SetParticleControl(tickParticle, 2, Vector(self.radius, self.radius, self.radius))
	ParticleManager:ReleaseParticleIndex(tickParticle)

	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target:GetOrigin(),
		target,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_ANY_ORDER,
		false
	)

	for _, unit in pairs(units) do
		if unit:GetUnitName() == "npc_hidden_earth_minion_boss" and unit ~= caster then
			target:EmitSound("Hero_EarthSpirit.Magnetize.Stone")
			target:AddNewModifier(unit, ability, "modifier_hidden_earth_boss_magnetize_lua", { duration = duration })
			break
		end
	end
end

--------------------------------------------------------------------------------

modifier_hidden_earth_boss_minion_root = class({})

function modifier_hidden_earth_boss_minion_root:IsPurgable()
	return false
end

function modifier_hidden_earth_boss_minion_root:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
	}
end