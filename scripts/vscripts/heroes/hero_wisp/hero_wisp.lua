--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wisp_tether_lua", "heroes/hero_wisp/hero_wisp.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_tether_lua_ally", "heroes/hero_wisp/hero_wisp.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_tether_lua_latch", "heroes/hero_wisp/hero_wisp.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_tether_lua_ally_attack", "heroes/hero_wisp/hero_wisp.lua", LUA_MODIFIER_MOTION_NONE)

wisp_tether_lua = class({})

function wisp_tether_lua:GetCustomCastErrorTarget(target)
	if target == self:GetCaster() then
		return "dota_hud_error_cant_cast_on_self"
	elseif
		target:HasModifier("modifier_wisp_tether_lua") and self:GetCaster():HasModifier("modifier_wisp_tether_lua_ally")
	then
		return "WHY WOULD YOU DO THIS"
	end
end

function wisp_tether_lua:CastFilterResultTarget(target)
	if IsServer() then
		local caster = self:GetCaster()
		local casterID = caster:GetPlayerOwnerID()
		local targetID = target:GetPlayerOwnerID()

		if target == caster then
			return UF_FAIL_CUSTOM
		end

		if target:IsCourier() then
			return UF_FAIL_COURIER
		end

		if
			target:HasModifier("modifier_wisp_tether_lua")
			and self:GetCaster():HasModifier("modifier_wisp_tether_lua_ally")
		then
			return UF_FAIL_CUSTOM
		end

		local nResult = UnitFilter(
			target,
			self:GetAbilityTargetTeam(),
			self:GetAbilityTargetType(),
			self:GetAbilityTargetFlags(),
			caster:GetTeamNumber()
		)
		return nResult
	end
end

function wisp_tether_lua:OnSpellStart()
	local caster = self:GetCaster()
	self.target = self:GetCursorTarget()

	if self.target:HasModifier("modifier_wisp_tether_lua_ally") then
		return rules:DisplayError(self:GetCaster():GetPlayerID(), "No")
	end

	caster:AddNewModifier(self.target, self, "modifier_wisp_tether_lua", {})

	self.target:AddNewModifier(caster, self, "modifier_wisp_tether_lua_ally", {})

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_wisp_8")
	if talent and talent:GetLevel() > 0 then
		self.target:AddNewModifier(caster, self, "modifier_wisp_tether_lua_ally_attack", {})
	end

	if not caster:HasAbility("wisp_tether_break_lua") then
		caster:AddAbility("wisp_tether_break_lua")
	end

	caster:SwapAbilities("wisp_tether_lua", "wisp_tether_break_lua", false, true)
	caster:FindAbilityByName("wisp_tether_break_lua"):SetLevel(1)
	caster:FindAbilityByName("wisp_tether_break_lua"):StartCooldown(0.25)
end

function wisp_tether_lua:OnUnStolen()
	if self:GetCaster():HasAbility("wisp_tether_break_lua") then
		self:GetCaster():RemoveAbility("wisp_tether_break_lua")
	end
end

------------------------------------------------------------------

modifier_wisp_tether_lua = class({})

function modifier_wisp_tether_lua:IsHidden()
	return false
end
function modifier_wisp_tether_lua:IsPurgable()
	return false
end
function modifier_wisp_tether_lua:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_wisp_tether_lua:OnCreated(params)
	self.movespeed = self:GetAbility():GetSpecialValueFor("movespeed")
	self.target = self:GetCaster()
end

function modifier_wisp_tether_lua:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return decFuncs
end

function modifier_wisp_tether_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end

function modifier_wisp_tether_lua:OnRemoved()
	if IsServer() then
		if not self.target:IsNull() and self.target:HasModifier("modifier_wisp_tether_lua_ally") then
			self.target:RemoveModifierByName("modifier_wisp_tether_lua_ally")
		end
		self:GetCaster():EmitSound("Hero_Wisp.Tether.Stop")
		self:GetCaster():StopSound("Hero_Wisp.Tether")
		self:GetParent():SwapAbilities("wisp_tether_break_lua", "wisp_tether_lua", false, true)
	end
end

------------------------------------------------------------------

modifier_wisp_tether_lua_ally = class({})

function modifier_wisp_tether_lua_ally:IsHidden()
	return false
end
function modifier_wisp_tether_lua_ally:IsPurgable()
	return false
end

function modifier_wisp_tether_lua_ally:OnCreated()
	self.regen = self:GetAbility():GetSpecialValueFor("tether_heal_amp")

	if IsServer() then
		self.pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_wisp/wisp_tether.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetCaster()
		)
		ParticleManager:SetParticleControlEnt(
			self.pfx,
			0,
			self:GetCaster(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetCaster():GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			self.pfx,
			1,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetAbsOrigin(),
			true
		)

		EmitSoundOn("Hero_Wisp.Tether.Target", self:GetParent())
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_wisp_tether_lua_ally:OnIntervalThink()
	if IsServer() then
		if (self:GetCaster():GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D() > 900 then
			self:GetCaster():RemoveModifierByName("modifier_wisp_tether_lua")
		end
	end
end

function modifier_wisp_tether_lua_ally:OnRemoved()
	if IsServer() then
		self:GetParent():StopSound("Hero_Wisp.Tether.Target")
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)

		if self:GetAbility() then
			self:GetAbility().target = nil
		end

		self:GetParent():RemoveModifierByName("modifier_wisp_tether_lua_ally_attack")
		self:GetCaster():RemoveModifierByName("modifier_wisp_tether_lua")
	end
end

function modifier_wisp_tether_lua_ally:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}
	return decFuncs
end

function modifier_wisp_tether_lua_ally:GetModifierBaseDamageOutgoing_Percentage()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("damage")
	end
end

function modifier_wisp_tether_lua_ally:GetModifierConstantHealthRegen()
	if self:GetAbility() then
		return self:GetCaster():GetMaxHealth() / 100 * self.regen
	end
end

function modifier_wisp_tether_lua_ally:GetModifierMoveSpeedBonus_Percentage()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("movespeed")
	end
end

------------------------------------------------------------------

modifier_wisp_tether_lua_ally_attack = class({})

function modifier_wisp_tether_lua_ally_attack:IsHidden()
	return true
end
function modifier_wisp_tether_lua_ally_attack:IsPurgable()
	return false
end
function modifier_wisp_tether_lua_ally_attack:DeclareFunctions()
	local decFuncs = {
		MODIFIER_EVENT_ON_ATTACK,
	}
	return decFuncs
end

function modifier_wisp_tether_lua_ally_attack:OnAttack(params)
	if IsServer() then
		if params.attacker == self:GetParent() then
			self:GetCaster():PerformAttack(params.target, true, true, true, false, true, false, false)
		end
	end
end

------------------------------------------------------------------

wisp_tether_break_lua = class({})

function wisp_tether_break_lua:IsInnateAbility()
	return true
end
function wisp_tether_break_lua:IsStealable()
	return false
end
function wisp_tether_break_lua:ProcsMagicStick()
	return false
end

function wisp_tether_break_lua:OnSpellStart()
	if not self:GetCaster():HasAbility("wisp_tether_lua") then
		local stolenAbility = self:GetCaster():AddAbility("wisp_tether_lua")
		stolenAbility:SetLevel(min((self:GetCaster():GetLevel() / 2) - 1, 4))
		self:GetCaster():SwapAbilities("wisp_tether_break_lua", "wisp_tether_lua", false, true)
	end

	self:GetCaster():RemoveModifierByName("modifier_wisp_tether_lua")
	local target = self:GetCaster():FindAbilityByName("wisp_tether_lua").target
end

function wisp_tether_break_lua:OnUnStolen()
	if self:GetCaster():HasAbility("wisp_tether_lua") then
		self:GetCaster():RemoveAbility("wisp_tether_lua")
	end
end

------------------------------------------------------------------
------------------------------------------------------------------

LinkLuaModifier("modifier_wisp_spirits_lua", "heroes/hero_wisp/hero_wisp.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_spirits_lua_creep_hit", "heroes/hero_wisp/hero_wisp.lua", LUA_MODIFIER_MOTION_NONE)

wisp_spirits_lua = class({})

function wisp_spirits_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_guardian.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_guardian_explosion_small.vpcf", context)
end

function wisp_spirits_lua:GetIntrinsicModifierName()
	return "modifier_wisp_spirits_lua"
end

------------------------------------------------------------------

modifier_wisp_spirits_lua = class({})

function modifier_wisp_spirits_lua:IsHidden()
	return true
end
function modifier_wisp_spirits_lua:IsPurgable()
	return false
end

function modifier_wisp_spirits_lua:OnCreated(params)
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	self.spirit_particles = {}
	self.start_time = GameRules:GetGameTime()

	-- Переиспользуемые буферы под живые цели и их позиции: снимаем позицию
	-- один раз за тик, а не заново для каждого спирита.
	self.targets = {}
	self.live_units = {}
	self.live_pos = {}
	self.targets_time = nil

	self:OnRefresh(params)

	EmitSoundOn("Hero_Wisp.Spirits.Loop", self.caster)
	self:StartIntervalThink(0.03)
end

function modifier_wisp_spirits_lua:OnRefresh(params)
	if not IsServer() then
		return
	end

	self.max_spirits = self.ability:GetSpecialValueFor("num_spirits")
	self.spirit_turn_rate = self.ability:GetSpecialValueFor("spirit_turn_rate")
	self.collision_radius = self.ability:GetSpecialValueFor("collision_radius") or 100
	self.creep_damage = self.ability:GetSpecialValueFor("creep_damage")

	local current_count = #self.spirit_particles
	if self.max_spirits > current_count then
		for i = current_count + 1, self.max_spirits do
			local pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_wisp/wisp_guardian.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			table.insert(self.spirit_particles, pfx)
		end
	end
end

function modifier_wisp_spirits_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	local caster = self:GetParent()
	if not caster or caster:IsNull() or not caster:IsAlive() then
		self:Destroy()
		return
	end

	local caster_pos = caster:GetAbsOrigin()
	local elapsed_time = GameRules:GetGameTime() - self.start_time

	local base_attack_range = caster:Script_GetAttackRange()
	local target_radius = base_attack_range

	local attack_target = caster:GetAttackTarget()
	if attack_target and attack_target:IsAlive() then
		local distance = (attack_target:GetAbsOrigin() - caster_pos):Length2D()
		target_radius = math.max(150, math.min(distance, base_attack_range))
	end

	self.current_radius = self.current_radius or target_radius
	self.current_radius = self.current_radius + (target_radius - self.current_radius) * 0.1

	-- Поиск целей — раз в 0.15с, а не каждый кадр: за это время цель смещается
	-- заметно меньше collision_radius, так что попадания не теряются.
	local now = GameRules:GetGameTime()
	if self.targets_time == nil or (now - self.targets_time) >= 0.15 then
		self.targets_time = now
		self.targets = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster_pos,
			caster,
			self.current_radius + self.collision_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
	end

	local spirit_count = #self.spirit_particles
	if spirit_count == 0 then
		return
	end

	-- Отсеиваем мёртвых и снимаем позиции один раз за тик.
	local live_units, live_pos = self.live_units, self.live_pos
	local live_count = 0
	for i = 1, #self.targets do
		local enemy = self.targets[i]
		if enemy and not enemy:IsNull() and enemy:IsAlive() then
			live_count = live_count + 1
			live_units[live_count] = enemy
			live_pos[live_count] = enemy:GetAbsOrigin()
		end
	end

	local angle_offset = 360 / spirit_count
	local current_rotation = elapsed_time * self.spirit_turn_rate
	local collision_sq = self.collision_radius * self.collision_radius

	for i, pfx in ipairs(self.spirit_particles) do
		local rotation_angle = current_rotation - angle_offset * (i - 1)
		local rel_pos =
			RotatePosition(Vector(0, 0, 0), QAngle(0, -rotation_angle, 0), Vector(0, self.current_radius, 0))

		local ground_pos = GetGroundPosition(caster_pos + rel_pos, caster)
		local abs_pos = ground_pos + Vector(0, 0, 120)

		if pfx then
			ParticleManager:SetParticleControl(pfx, 0, abs_pos)
			ParticleManager:SetParticleControl(pfx, 1, abs_pos)
		end

		-- Сравниваем квадраты расстояний: тот же результат без sqrt.
		for j = 1, live_count do
			local epos = live_pos[j]
			local dx = epos.x - abs_pos.x
			local dy = epos.y - abs_pos.y
			if (dx * dx + dy * dy) < collision_sq then
				local enemy = live_units[j]
				if not enemy:HasModifier("modifier_wisp_spirits_lua_creep_hit") then
					self:HitEnemy(enemy)
				end
			end
		end
	end
end

function modifier_wisp_spirits_lua:HitEnemy(enemy)
	enemy:AddNewModifier(self.caster, self.ability, "modifier_wisp_spirits_lua_creep_hit", { duration = 0.25 })
	ApplyDamage({
		victim = enemy,
		attacker = self.caster,
		damage = self.creep_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})
end

function modifier_wisp_spirits_lua:OnRemoved()
	if not IsServer() then
		return
	end
	for _, pfx in pairs(self.spirit_particles) do
		if pfx then
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
		end
	end
	self:GetParent():StopSound("Hero_Wisp.Spirits.Loop")
end

------------------------------------------------------------------

modifier_wisp_spirits_lua_creep_hit = class({})

function modifier_wisp_spirits_lua_creep_hit:IsHidden()
	return true
end

function modifier_wisp_spirits_lua_creep_hit:OnCreated()
	if not IsServer() then
		return
	end
	local target = self:GetParent()
	EmitSoundOn("Hero_Wisp.Spirits.TargetCreep", target)

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_wisp/wisp_guardian_explosion_small.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end

------------------------------------------------------------------
------------------------------------------------------------------

LinkLuaModifier("modifier_wisp_overcharge_lua", "heroes/hero_wisp/hero_wisp.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_overcharge_lua_heal", "heroes/hero_wisp/hero_wisp.lua", LUA_MODIFIER_MOTION_NONE)

wisp_overcharge_lua = class({})

function wisp_overcharge_lua:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
end

function wisp_overcharge_lua:OnToggle()
	if self:GetToggleState() then
		EmitSoundOn("Hero_Wisp.Overcharge", self:GetCaster())
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_wisp_overcharge_lua", {})
	else
		StopSoundEvent("Hero_Wisp.Overcharge", self:GetCaster())
		self:GetCaster():RemoveModifierByName("modifier_wisp_overcharge_lua")
	end
end

------------------------------------------------------------------

modifier_wisp_overcharge_lua = class({})

function modifier_wisp_overcharge_lua:OnCreated()
	if IsServer() then
		local ability = self:GetAbility()
		self.interval = ability:GetSpecialValueFor("interval")
		self.manacost = ability:GetSpecialValueFor("mp_loss") * self.interval
		self.radius = ability:GetSpecialValueFor("radius")
		self.mainParticle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_wisp/wisp_overcharge.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetCaster()
		)
		self:StartIntervalThink(self.interval)
	end
end

function modifier_wisp_overcharge_lua:OnDestroy()
	if IsServer() then
		self:StartIntervalThink(-1)
		if self.mainParticle then
			ParticleManager:DestroyParticle(self.mainParticle, false)
			ParticleManager:ReleaseParticleIndex(self.mainParticle)
		end
	end
end

function modifier_wisp_overcharge_lua:OnIntervalThink()
	if not self:GetAbility() or self:GetAbility():IsNull() then
		StopSoundEvent("Hero_Wisp.Overcharge", self:GetCaster())
		self:Destroy()
		return
	end

	local hp_loss = self:GetAbility():GetSpecialValueFor("hp_loss")
	local hAbility = self:GetAbility()
	if not self:GetCaster():IsAlive() then
		return
	end

	if self:GetCaster():GetMana() >= hAbility:GetManaCost(-1) then
		local current_health = self:GetCaster():GetHealth()
		local health_drain = current_health * hp_loss * 0.01

		if current_health - health_drain > 1 then
			self:GetCaster():ModifyHealth(current_health - health_drain, hAbility, false, 0)
		else
			hAbility:ToggleAbility()
		end
		self:GetCaster():Script_ReduceMana(self.manacost, nil)
	else
		hAbility:ToggleAbility()
	end
end

function modifier_wisp_overcharge_lua:IsAura()
	return true
end

function modifier_wisp_overcharge_lua:IsAuraActiveOnDeath()
	return false
end

function modifier_wisp_overcharge_lua:GetAuraRadius()
	return FIND_UNITS_EVERYWHERE
end

function modifier_wisp_overcharge_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_wisp_overcharge_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_wisp_overcharge_lua:GetModifierAura()
	return "modifier_wisp_overcharge_lua_heal"
end

function modifier_wisp_overcharge_lua:IsHidden()
	return false
end

------------------------------------------------------------------

modifier_wisp_overcharge_lua_heal = class({})

function modifier_wisp_overcharge_lua_heal:IsDebuff()
	return false
end
function modifier_wisp_overcharge_lua_heal:IsHidden()
	return false
end

function modifier_wisp_overcharge_lua_heal:RemoveOnDeath()
	return true
end

function modifier_wisp_overcharge_lua_heal:OnCreated()
	self.heal = self:GetAbility():GetSpecialValueFor("hp_ampl")
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	self.bonus_move_speed = self:GetAbility():GetSpecialValueFor("bonus_move_speed")
end

function modifier_wisp_overcharge_lua_heal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_wisp_overcharge_lua_heal:GetModifierHealthRegenPercentage()
	return self.heal
end

function modifier_wisp_overcharge_lua_heal:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end

function modifier_wisp_overcharge_lua_heal:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_move_speed
end

------------------------------------------------------------------
------------------------------------------------------------------

wisp_event_horizon = class({})

function wisp_event_horizon:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/keeper_of_the_light/kotl_ti10_immortal/kotl_ti10_blinding_light.vpcf",
		context
	)
end

function wisp_event_horizon:OnSpellStart()
	local caster = self:GetCaster()
	local cast_time = 0.5
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")
	local hp_damage = self:GetSpecialValueFor("hp_damage")

	local max_health = caster:GetMaxHealth()
	local bonus_damage_from_hp = (max_health / 100) * hp_damage

	local total_final_damage = damage + bonus_damage_from_hp

	ApplyDamage({
		victim = caster,
		attacker = caster,
		damage = bonus_damage_from_hp,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self,
	})

	caster:EmitSound("Hero_Invoker.DeafeningBlast.Immortal")

	local particle = ParticleManager:CreateParticle(
		"particles/econ/items/keeper_of_the_light/kotl_ti10_immortal/kotl_ti10_blinding_light.vpcf",
		PATTACH_POINT_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(particle, 0, caster:GetOrigin())
	ParticleManager:SetParticleControl(particle, 1, caster:GetOrigin())
	ParticleManager:SetParticleControl(particle, 2, Vector(radius + 100, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = total_final_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})

		local hit_pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_wisp/wisp_relocate_teleport_flash.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			enemy
		)
		ParticleManager:ReleaseParticleIndex(hit_pfx)

		enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = duration })
	end
end