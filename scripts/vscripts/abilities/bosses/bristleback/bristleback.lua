--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_boss_bristleback_sand_shell_lua",
	"abilities/bosses/bristleback/bristleback",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_creep_sand_shell_debuff_lua",
	"abilities/bosses/bristleback/bristleback",
	LUA_MODIFIER_MOTION_NONE
)

boss_bristleback_sand_shell_lua = class({})

function boss_bristleback_sand_shell_lua:GetIntrinsicModifierName()
	return "modifier_boss_bristleback_sand_shell_lua"
end

--------------------------------------------------------------------------------

modifier_boss_bristleback_sand_shell_lua = class({})

function modifier_boss_bristleback_sand_shell_lua:IsHidden()
	return self:GetStackCount() == 0
end

function modifier_boss_bristleback_sand_shell_lua:IsPurgable()
	return false
end

function modifier_boss_bristleback_sand_shell_lua:OnCreated()
	self:OnRefresh()
end

function modifier_boss_bristleback_sand_shell_lua:OnRefresh()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.armor_per_stack = ability:GetSpecialValueFor("armor_per_stack")
		+ ability:GetSpecialValueFor("diff_boost_additional")
	self.max_stacks = ability:GetSpecialValueFor("max_stacks")
	self.reset_time = ability:GetSpecialValueFor("duration")
	self.radius = ability:GetSpecialValueFor("radius")
	self.base_damage = ability:GetSpecialValueFor("nova_damage") + ability:GetSpecialValueFor("diff_boost_damage")

	if not IsServer() then
		return
	end

	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()

	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, ability, "modifier_boss_damage_boost", {})
	end
end

function modifier_boss_bristleback_sand_shell_lua:AddCustomTransmitterData()
	return {
		armor_per_stack = self.armor_per_stack,
		base_damage = self.base_damage,
		max_stacks = self.max_stacks,
		reset_time = self.reset_time,
		radius = self.radius,
	}
end

function modifier_boss_bristleback_sand_shell_lua:HandleCustomTransmitterData(data)
	self.armor_per_stack = data.armor_per_stack
	self.base_damage = data.base_damage
	self.max_stacks = data.max_stacks
	self.reset_time = data.reset_time
	self.radius = data.radius
end
--------------------------------------------------------------------------------

function modifier_boss_bristleback_sand_shell_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_boss_bristleback_sand_shell_lua:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * (self.armor_per_stack or 0)
end

function modifier_boss_bristleback_sand_shell_lua:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if params.attacker == params.unit then
		return
	end

	if self:GetStackCount() < self.max_stacks then
		self:IncrementStackCount()
	end

	if self:GetStackCount() >= self.max_stacks then
		local stack = self:GetStackCount()
		self:SetStackCount(0)
		self:StartIntervalThink(-1)
		self:TriggerNova(stack * self.armor_per_stack)
	else
		self:StartIntervalThink(self.reset_time)
	end
end

function modifier_boss_bristleback_sand_shell_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self:StartIntervalThink(-1)
end

function modifier_boss_bristleback_sand_shell_lua:TriggerNova(dis_arm)
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	local debuff_duration = self.reset_time

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_bristleback/bristleback_quill_spray.vpcf",
		PATTACH_ABSORIGIN,
		caster
	)
	ParticleManager:ReleaseParticleIndex(pfx)
	caster:EmitSound("Hero_Bristleback.QuillSpray.Cast")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = self.base_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = ability,
		})

		enemy:AddNewModifier(caster, ability, "modifier_creep_sand_shell_debuff_lua", {
			duration = debuff_duration,
			armor_red = dis_arm,
		})
	end
end

--------------------------------------------------------------------------------

modifier_creep_sand_shell_debuff_lua = class({})

function modifier_creep_sand_shell_debuff_lua:IsDebuff()
	return true
end
function modifier_creep_sand_shell_debuff_lua:IsPurgable()
	return true
end

function modifier_creep_sand_shell_debuff_lua:OnCreated(params)
	if not IsServer() then
		return
	end
	self.armor_reduction = params.armor_red
	self:SetHasCustomTransmitterData(true)
end

function modifier_creep_sand_shell_debuff_lua:AddCustomTransmitterData()
	return { armor_reduction = self.armor_reduction }
end

function modifier_creep_sand_shell_debuff_lua:HandleCustomTransmitterData(data)
	self.armor_reduction = data.armor_reduction
end

function modifier_creep_sand_shell_debuff_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_creep_sand_shell_debuff_lua:GetModifierPhysicalArmorBonus()
	return -(self.armor_reduction or 0)
end

function modifier_creep_sand_shell_debuff_lua:GetEffectName()
	return "particles/units/heroes/hero_bristleback/bristleback_quill_spray_hit.vpcf"
end

function modifier_creep_sand_shell_debuff_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_boss_bristleback_sand_mirage_lua",
	"abilities/bosses/bristleback/bristleback",
	LUA_MODIFIER_MOTION_NONE
)

boss_bristleback_sand_mirage_lua = class({})

function boss_bristleback_sand_mirage_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_blur.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_medusa.vsndevts", context)
end

function boss_bristleback_sand_mirage_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	caster:AddNewModifier(caster, self, "modifier_boss_bristleback_sand_mirage_lua", { duration = duration })
	caster:EmitSound("Hero_BountyHunter.WindWalk")
end

function boss_bristleback_sand_mirage_lua:OnProjectileHit_ExtraData(target, location, extraData)
	if not target or target:IsNull() then
		return
	end
	local attacker = EntIndexToHScript(extraData.attacker_index)
	if attacker and not attacker:IsNull() then
		attacker:PerformAttack(target, true, true, true, false, false, false, true)
	end
end

--------------------------------------------------------------------------------

modifier_boss_bristleback_sand_mirage_lua = class({})

function modifier_boss_bristleback_sand_mirage_lua:IsBuff()
	return true
end

function modifier_boss_bristleback_sand_mirage_lua:OnCreated()
	if not IsServer() then
		return
	end
	self.evasion = self:GetAbility():GetSpecialValueFor("evasion_chance")
	self.radius = self:GetAbility():GetSpecialValueFor("reflect_radius")
	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_blur.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
end

function modifier_boss_bristleback_sand_mirage_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
end

function modifier_boss_bristleback_sand_mirage_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
	}
end

function modifier_boss_bristleback_sand_mirage_lua:GetModifierEvasion_Constant()
	return self.evasion
end

function modifier_boss_bristleback_sand_mirage_lua:OnAttackFail(params)
	if not IsServer() then
		return
	end
	if params.target ~= self:GetParent() then
		return
	end
	local attacker = params.attacker
	local caster = self:GetParent()
	if attacker:IsRangedAttacker() then
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			nil,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		local redirect_target = nil

		if #enemies > 1 then
			for _, enemy in pairs(enemies) do
				if enemy ~= attacker then
					redirect_target = enemy
					break
				end
			end
		end

		if not redirect_target then
			redirect_target = attacker
		end

		if redirect_target then
			local info = {
				Target = redirect_target,
				Source = caster,
				Ability = self:GetAbility(),
				EffectName = attacker:GetRangedProjectileName(),
				iMoveSpeed = attacker:GetProjectileSpeed(),
				ExtraData = { attacker_index = attacker:entindex() },
			}
			ProjectileManager:CreateTrackingProjectile(info)

			caster:EmitSound("Hero_Medusa.ManaShield.Proc")
		end
	end
end

----------------------------------------------------------------
----------------------------------------------------------------

LinkLuaModifier(
	"modifier_boss_bristleback_goo_lua_thinker",
	"abilities/bosses/bristleback/bristleback",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_boss_bristleback_goo_lua_debuff",
	"abilities/bosses/bristleback/bristleback",
	LUA_MODIFIER_MOTION_NONE
)

boss_bristleback_goo_lua = class({})

function boss_bristleback_goo_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_bristleback_goo_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo.vpcf", context)
end

function boss_bristleback_goo_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target_pos = self:GetCursorPosition()

	local dummy = CreateUnitByName("npc_dota_companion", target_pos, false, nil, nil, caster:GetTeamNumber())
	dummy:AddNewModifier(caster, nil, "modifier_dummy", {})
	dummy:AddNewModifier(caster, self, "modifier_kill", { duration = 5 })

	caster:EmitSound("Hero_Bristleback.ViscousGoo.Cast")

	local info = {
		Target = dummy,
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo.vpcf",
		iMoveSpeed = 1200,
		bReplaceExisting = false,
		bHasSideProjectiles = false,
		ExtraData = { dummy_index = dummy:entindex() },
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

function boss_bristleback_goo_lua:OnProjectileHit_ExtraData(target, location, ExtraData)
	if not IsServer() then
		return
	end

	if ExtraData.dummy_index then
		local dummy = EntIndexToHScript(ExtraData.dummy_index)
		if dummy and not dummy:IsNull() then
			dummy:ForceKill(false)
			dummy:AddEffects(EF_NODRAW)
		end
	end

	local duration = self:GetSpecialValueFor("duration")
	CreateModifierThinker(
		self:GetCaster(),
		self,
		"modifier_boss_bristleback_goo_lua_thinker",
		{ duration = duration },
		location,
		self:GetCaster():GetTeamNumber(),
		false
	)

	local sound_cast = "Hero_Bristleback.ViscousGoo.Target"
	-- EmitSoundOnLocationWithCaster(location, sound_cast, self:GetCaster())
	EmitSoundOn(sound_cast, self:GetCaster())
	return true
end

--------------------------------------------------------------------------------

modifier_boss_bristleback_goo_lua_thinker = class({})

function modifier_boss_bristleback_goo_lua_thinker:OnCreated()
	-- Кеш до серверной проверки: GetAuraRadius зовётся и на клиенте.
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	if not IsServer() then
		return
	end
	local radius = self.radius

	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self.pfx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.pfx, 1, Vector(radius, 1, 1))
	ParticleManager:SetParticleControl(self.pfx, 15, Vector(255, 255, 0))
	ParticleManager:SetParticleControl(self.pfx, 16, Vector(1, 0, 0))
end

function modifier_boss_bristleback_goo_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
end

function modifier_boss_bristleback_goo_lua_thinker:OnRefresh()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_boss_bristleback_goo_lua_thinker:IsAura()
	return true
end
function modifier_boss_bristleback_goo_lua_thinker:GetModifierAura()
	return "modifier_boss_bristleback_goo_lua_debuff"
end
function modifier_boss_bristleback_goo_lua_thinker:GetAuraRadius()
	return self.radius
end
function modifier_boss_bristleback_goo_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_boss_bristleback_goo_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_boss_bristleback_goo_lua_thinker:GetAuraDuration()
	return 0.5
end

--------------------------------------------------------------------------------

modifier_boss_bristleback_goo_lua_debuff = class({})

function modifier_boss_bristleback_goo_lua_debuff:OnCreated()
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
	self.armor_loss = self:GetAbility():GetSpecialValueFor("dis_arm")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_additional")

	if not IsServer() then
		return
	end
	self:StartIntervalThink(1.0)
end

function modifier_boss_bristleback_goo_lua_debuff:OnIntervalThink()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end

function modifier_boss_bristleback_goo_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_boss_bristleback_goo_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_boss_bristleback_goo_lua_debuff:GetModifierPhysicalArmorBonus()
	return -(self:GetStackCount() * self.armor_loss)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_boss_bristleback_summon_swarm_debuff",
	"abilities/bosses/bristleback/bristleback",
	LUA_MODIFIER_MOTION_NONE
)

boss_bristleback_summon_swarm = class({})

function boss_bristleback_summon_swarm:Precache(context) end

function boss_bristleback_summon_swarm:OnSpellStart()
	local caster = self:GetCaster()
	local beetle_count = self:GetSpecialValueFor("beetle_count")
	local duration = self:GetSpecialValueFor("duration")

	caster:EmitSound("Hero_NyxAssassin.SpikedCarapace.Cast")

	for i = 1, beetle_count do
		local beetle = CreateUnitByName(
			"npc_dota_boss_bristleback_minion",
			caster:GetAbsOrigin() + RandomVector(500),
			true,
			caster,
			caster,
			caster:GetTeamNumber()
		)
		beetle:AddNewModifier(beetle, nil, "modifier_kill", { duration = duration })
		ExecuteOrderFromTable({
			UnitIndex = beetle:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
			Position = beetle:GetAbsOrigin() + RandomVector(1000),
		})
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_boss_bristleback_summon_swarm_passive",
	"abilities/bosses/bristleback/bristleback",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_boss_bristleback_summon_swarm_debuff",
	"abilities/bosses/bristleback/bristleback",
	LUA_MODIFIER_MOTION_NONE
)

boss_bristleback_summon_swarm_passive = class({})

function boss_bristleback_summon_swarm_passive:GetIntrinsicModifierName()
	return "modifier_boss_bristleback_summon_swarm_passive"
end

--------------------------------------------------------------------------------

modifier_boss_bristleback_summon_swarm_passive = class({})

function modifier_boss_bristleback_summon_swarm_passive:IsHidden()
	return true
end

function modifier_boss_bristleback_summon_swarm_passive:CheckState()
	return {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_boss_bristleback_summon_swarm_passive:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT,
	}
end

function modifier_boss_bristleback_summon_swarm_passive:GetModifierMagicalResistanceDirect()
	return 100
end

function modifier_boss_bristleback_summon_swarm_passive:OnAttackLanded(params)
	if not IsServer() then
		return
	end

	if params.attacker == self:GetParent() then
		self.target = params.target
		local modifier = self.target:AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_boss_bristleback_summon_swarm_debuff",
			{ duration = 2 }
		)
		modifier:IncrementStackCount()
	end
end

function modifier_boss_bristleback_summon_swarm_passive:OnDeath(params)
	if not IsServer() then
		return
	end
	if params.unit == self:GetParent() and self.target ~= nil then
		local modifier = self.target:FindModifierByName("modifier_boss_bristleback_summon_swarm_debuff")
		if modifier then
			modifier:DecrementStackCount()
			if modifier:GetStackCount() <= 0 then
				modifier:Destroy()
			end
		end
	end
end

--------------------------------------------------------------------------------

modifier_boss_bristleback_summon_swarm_debuff = class({})

function modifier_boss_bristleback_summon_swarm_debuff:IsHidden()
	return false
end

function modifier_boss_bristleback_summon_swarm_debuff:IsPurgable()
	return false
end

function modifier_boss_bristleback_summon_swarm_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_boss_bristleback_summon_swarm_debuff:GetModifierPhysicalArmorBonus()
	return -(self:GetStackCount() * self:GetAbility():GetSpecialValueFor("armor_reduction"))
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

boss_bristleback_hairball_lua = class({})

function boss_bristleback_hairball_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_bristleback_hairball_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_bristleback/bristleback_hairball.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_bristleback/bristleback_quill_spray.vpcf", context)
end

function boss_bristleback_hairball_lua:OnSpellStart()
	local caster = self:GetCaster()
	local caster_pos = caster:GetAbsOrigin()
	local forward_vector = caster:GetForwardVector()
	local cast_distance = 700
	local target_point = caster_pos + forward_vector * cast_distance
	local speed = self:GetSpecialValueFor("projectile_speed")
	local base_distance = cast_distance

	local angles = {
		QAngle(0, 30, 0),
		QAngle(0, 0, 0),
		QAngle(0, -30, 0),
	}

	for _, angle in pairs(angles) do
		local spawn_point = RotatePosition(caster_pos, angle, target_point)
		local direction = (spawn_point - caster_pos):Normalized()

		local random_distance = base_distance + RandomInt(-500, 250)

		random_distance = math.max(100, random_distance)

		local info = {
			EffectName = "particles/units/heroes/hero_bristleback/bristleback_hairball.vpcf",
			Ability = self,
			vSpawnOrigin = caster_pos,
			fDistance = random_distance,
			vVelocity = direction * speed,
			Source = caster,
			bHasFrontalCone = false,
			bReplaceExisting = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
		}
		ProjectileManager:CreateLinearProjectile(info)
	end

	caster:EmitSound("Hero_Bristleback.Hairball.Cast")
end

function boss_bristleback_hairball_lua:OnProjectileHit(target, location)
	if not target then
		local caster = self:GetCaster()
		local radius = self:GetSpecialValueFor("radius")
		local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			location,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
		for _, unit in pairs(units) do
			ApplyDamage({
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self,
			})
		end
		self:PlayEffects(caster, location)
		return true
	end
end

function boss_bristleback_hairball_lua:PlayEffects(caster, location)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_bristleback/bristleback_quill_spray.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, location)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast = "Hero_Bristleback.QuillSpray.Cast"
	-- EmitSoundOnLocationWithCaster(location, sound_cast, caster)
	EmitSoundOn(sound_cast, caster)
end