--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_forest_quest_lua", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_VERTICAL)

creep_forest_quest_lua = class({})

function creep_forest_quest_lua:GetIntrinsicModifierName()
	return "modifier_creep_forest_quest_lua"
end

--------------------------------------------------------------------------------

modifier_creep_forest_quest_lua = class({})

function modifier_creep_forest_quest_lua:IsHidden()
	return true
end

function modifier_creep_forest_quest_lua:IsPurgable()
	return false
end

function modifier_creep_forest_quest_lua:OnCreated(kv) end

function modifier_creep_forest_quest_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_creep_forest_quest_lua:OnDeath(params)
	if not IsServer() then
		return
	end
	if params.unit == self:GetParent() then
		self.damageTable = {
			attacker = self:GetCaster(),
			damage = self:GetAbility():GetSpecialValueFor("damage"),
			damage_type = DAMAGE_TYPE_PURE,
		}

		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetCaster():GetOrigin(),
			self:GetCaster(),
			self:GetAbility():GetSpecialValueFor("radius"),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			0,
			false
		)
		for _, enemy in pairs(enemies) do
			self.damageTable.victim = enemy
			ApplyDamage(self.damageTable)
		end

		EmitSoundOn("Hero_Techies.Suicide", self:GetCaster())

		local particle_explosion = "particles/units/heroes/hero_techies/techies_blast_off.vpcf"
		local particle_explosion_fx =
			ParticleManager:CreateParticle(particle_explosion, PATTACH_WORLDORIGIN, self:GetCaster())
		ParticleManager:SetParticleControl(particle_explosion_fx, 0, self:GetCaster():GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(particle_explosion_fx)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_untouchable_lua", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_untouchable_lua_debuff", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)

creep_untouchable_lua = class({})

function creep_untouchable_lua:GetIntrinsicModifierName()
	return "modifier_creep_untouchable_lua"
end

--------------------------------------------------------------------------------

modifier_creep_untouchable_lua = class({})

function modifier_creep_untouchable_lua:IsHidden()
	return true
end

function modifier_creep_untouchable_lua:IsPurgable()
	return false
end

function modifier_creep_untouchable_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_START,
	}
	return funcs
end

function modifier_creep_untouchable_lua:OnAttackStart(params)
	if IsServer() then
		if params.target ~= self:GetParent() then
			return
		end
		if params.attacker:IsMagicImmune() then
			return
		end
		if self:GetParent():PassivesDisabled() then
			return
		end
		params.attacker:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_creep_untouchable_lua_debuff", -- modifier name
			{} -- kv
		)
	end
end

--------------------------------------------------------------------------------

modifier_creep_untouchable_lua_debuff = class({})

function modifier_creep_untouchable_lua_debuff:IsHidden()
	return false
end

function modifier_creep_untouchable_lua_debuff:IsDebuff()
	return true
end

function modifier_creep_untouchable_lua_debuff:IsStunDebuff()
	return false
end

function modifier_creep_untouchable_lua_debuff:IsPurgable()
	return true
end

function modifier_creep_untouchable_lua_debuff:OnCreated(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("slow_attack_speed")
	self.duration = self:GetAbility():GetSpecialValueFor("slow_duration")
end

function modifier_creep_untouchable_lua_debuff:OnDestroy(kv) end

function modifier_creep_untouchable_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PRE_ATTACK,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FINISHED,

		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_creep_untouchable_lua_debuff:GetModifierPreAttack(params)
	if IsServer() then
		if not self.HasAttacked then
			self.record = params.record
		end
		if params.target ~= self:GetCaster() then
			self.attackOther = true
		end
	end
end

function modifier_creep_untouchable_lua_debuff:OnAttack(params)
	if IsServer() then
		if params.record ~= self.record then
			return
		end
		self:SetDuration(self.duration, true)
		self.HasAttacked = true
	end
end

function modifier_creep_untouchable_lua_debuff:OnAttackFinished(params)
	if IsServer() then
		if params.attacker ~= self:GetParent() then
			return
		end
		if not self.HasAttacked then
			self:Destroy()
		end
		if self.attackOther then
			self:Destroy()
		end
	end
end

function modifier_creep_untouchable_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	if IsServer() then
		if self:GetParent():GetAggroTarget() == self:GetCaster() then
			return -self.slow
		else
			return 0
		end
	end

	return -self.slow
end

function modifier_creep_untouchable_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_enchantress/enchantress_untouchable.vpcf"
end

function modifier_creep_untouchable_lua_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_enchant_lua_slow", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_enchant_lua_buff", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)

creep_enchant_lua = class({})

function creep_enchant_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_enchantress/enchantress_enchant.vpcf", context)
end

function creep_enchant_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_enchant_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")

	if target:TriggerSpellAbsorb(self) then
		return
	end

	target:AddNewModifier(caster, self, "modifier_creep_enchant_lua_slow", { duration = duration })
	caster:AddNewModifier(caster, self, "modifier_creep_enchant_lua_buff", { duration = duration })

	target:EmitSound("Hero_Enchantress.EnchantCast")
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_enchantress/enchantress_enchant.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end

--------------------------------------------------------------------------------

modifier_creep_enchant_lua_slow = class({})

function modifier_creep_enchant_lua_slow:OnCreated()
	self.slow = self:GetAbility():GetSpecialValueFor("slow_movement_speed")
end

function modifier_creep_enchant_lua_slow:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_creep_enchant_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_creep_enchant_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_enchantress/enchantress_enchant_slow.vpcf"
end

--------------------------------------------------------------------------------

modifier_creep_enchant_lua_buff = class({})

function modifier_creep_enchant_lua_buff:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.range = ability:GetSpecialValueFor("bonus_attack_range")
	self.damage = ability:GetSpecialValueFor("bonus_damage") + ability:GetSpecialValueFor("diff_boost_damage")

	if IsServer() then
		self:SetHasCustomTransmitterData(true)
	end
end

function modifier_creep_enchant_lua_buff:AddCustomTransmitterData()
	return { range = self.range, damage = self.damage }
end

function modifier_creep_enchant_lua_buff:HandleCustomTransmitterData(data)
	self.range = data.range
	self.damage = data.damage
end

function modifier_creep_enchant_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_creep_enchant_lua_buff:GetModifierAttackRangeBonus()
	return self.range
end

function modifier_creep_enchant_lua_buff:GetModifierPreAttack_BonusDamage()
	return self.damage
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_land_mines_lua_thinker", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)

creep_land_mines_lua = class({})

function creep_land_mines_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context)
end

function creep_land_mines_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_land_mines_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local mine =
		CreateUnitByName("npc_zone_8_creep_land_mines", point, true, caster, caster:GetOwner(), caster:GetTeamNumber())

	if caster.solo_event_player_id then
		mine.solo_event_player_id = caster.solo_event_player_id
	end

	mine:AddNewModifier(caster, self, "modifier_creep_land_mines_lua_thinker", {})
end

--------------------------------------------------------------------------------

modifier_creep_land_mines_lua_thinker = class({})

function modifier_creep_land_mines_lua_thinker:IsHidden()
	return true
end

function modifier_creep_land_mines_lua_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.damage = self.ability:GetSpecialValueFor("damage") + self.ability:GetSpecialValueFor("diff_boost_damage")
	self.radius = self.ability:GetSpecialValueFor("damage_radius")
	self.threshold = self.ability:GetSpecialValueFor("proximity_threshold")
	self.activation_delay = self.ability:GetSpecialValueFor("activation_delay")
	self.tick_interval = self.ability:GetSpecialValueFor("tick_interval")
	self.fow_radius = self.ability:GetSpecialValueFor("fow_radius")
	self.fow_duration = self.ability:GetSpecialValueFor("fow_duration")

	self.active = false
	self.triggered = false
	self.timer = 0

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_land_mine.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	self:AddParticle(pfx, false, false, -1, false, false)
	self:StartIntervalThink(self.activation_delay)
	self:OnIntervalThink()
end

function modifier_creep_land_mines_lua_thinker:OnIntervalThink()
	if not self.active then
		self.active = true
		self:StartIntervalThink(self.tick_interval)
		return
	end

	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	local has_target = false
	for _, enemy in pairs(enemies) do
		has_target = true
		break
	end

	if has_target then
		if not self.triggered then
			self.triggered = true
			local sound_cast = "Hero_Techies.RemoteMine.Priming"
			-- EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), sound_cast, self.parent)
			EmitSoundOn(sound_cast, self.parent)
		end
		self.timer = self.timer + self.tick_interval
		if self.timer >= self.threshold then
			self:Explode()
		end
	else
		self.triggered = false
		self.timer = 0
	end
end

function modifier_creep_land_mines_lua_thinker:Explode()
	if not IsServer() then
		return
	end

	local origin = self.parent:GetAbsOrigin()
	self.parent:EmitSound("Hero_Techies.RemoteMine.Detonate")

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 2, Vector(self.radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(pfx)

	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		origin,
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})
	end

	AddFOWViewer(self.parent:GetTeamNumber(), origin, self.fow_radius, self.fow_duration, false)

	self:Destroy()
	UTIL_Remove(self.parent)
end

function modifier_creep_land_mines_lua_thinker:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = (self.active and not self.triggered),
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = (self.active and not self.triggered),
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_stasis_lua_thinker", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_stasis_lua_effect", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)

creep_stasis_lua = class({})

function creep_stasis_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_stasis_trap_explode.vpcf", context)
end

function creep_stasis_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local mine =
		CreateUnitByName("npc_zone_8_creep_stasis", point, true, caster, caster:GetOwner(), caster:GetTeamNumber())

	if caster.solo_event_player_id then
		mine.solo_event_player_id = caster.solo_event_player_id
	end

	mine:AddNewModifier(caster, self, "modifier_creep_stasis_lua_thinker", {})
end

--------------------------------------------------------------------------------

modifier_creep_stasis_lua_thinker = class({})

function modifier_creep_stasis_lua_thinker:IsHidden()
	return true
end

function modifier_creep_stasis_lua_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.radius = self.ability:GetSpecialValueFor("damage_radius")
	self.threshold = self.ability:GetSpecialValueFor("proximity_threshold")
	self.activation_delay = self.ability:GetSpecialValueFor("activation_delay")
	self.tick_interval = self.ability:GetSpecialValueFor("tick_interval")
	self.fow_radius = self.ability:GetSpecialValueFor("fow_radius")
	self.fow_duration = self.ability:GetSpecialValueFor("fow_duration")
	self.duration = self.ability:GetSpecialValueFor("stasis_duration")

	self.active = false
	self.triggered = false
	self.timer = 0

	self:StartIntervalThink(self.activation_delay)
	self:OnIntervalThink()
end

function modifier_creep_stasis_lua_thinker:OnIntervalThink()
	if not self.active then
		self.active = true
		self:StartIntervalThink(self.tick_interval)
		return
	end

	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	local has_target = false
	for _, enemy in pairs(enemies) do
		has_target = true
		break
	end

	if has_target then
		if not self.triggered then
			self.triggered = true
			local sound_cast = "Hero_Techies.RemoteMine.Priming"
			-- EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), sound_cast, self.parent)
			EmitSoundOn(sound_cast, self.parent)
		end
		self.timer = self.timer + self.tick_interval
		if self.timer >= self.threshold then
			self:Explode()
		end
	else
		self.triggered = false
		self.timer = 0
	end
end

function modifier_creep_stasis_lua_thinker:Explode()
	local origin = self.parent:GetAbsOrigin()
	self.parent:EmitSound("Hero_Techies.ReactiveTazer.Detonate")

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_stasis_trap_explode.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 2, Vector(self.radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(pfx)

	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		origin,
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		if not enemy:HasFlyMovementCapability() then
			enemy:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_creep_stasis_lua_effect",
				{ duration = self.duration }
			)
		end
	end

	AddFOWViewer(self.parent:GetTeamNumber(), origin, self.fow_radius, self.fow_duration, false)

	self:Destroy()
	UTIL_Remove(self.parent)
end

function modifier_creep_stasis_lua_thinker:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = (self.active and not self.triggered),
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = (self.active and not self.triggered),
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
end

--------------------------------------------------------------------------------

modifier_creep_stasis_lua_effect = class({})

function modifier_creep_stasis_lua_effect:CheckState()
	local state = { [MODIFIER_STATE_ROOTED] = true }
	return state
end

function modifier_creep_stasis_lua_effect:IsHidden()
	return false
end

function modifier_creep_stasis_lua_effect:IsPurgable()
	return true
end

function modifier_creep_stasis_lua_effect:IsDebuff()
	return true
end

function modifier_creep_stasis_lua_effect:GetStatusEffectName()
	return "particles/status_fx/status_effect_techies_stasis.vpcf"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_suicide_lua_passive", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_suicide_lua_movement", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_BOTH)

creep_suicide_lua = class({})

function creep_suicide_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_blast_off.vpcf", context)
end

function creep_suicide_lua:GetIntrinsicModifierName()
	return "modifier_creep_suicide_lua_passive"
end

--------------------------------------------------------------------------------

modifier_creep_suicide_lua_passive = class({})

function modifier_creep_suicide_lua_passive:IsHidden()
	return true
end

function modifier_creep_suicide_lua_passive:OnCreated()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
end

function modifier_creep_suicide_lua_passive:DeclareFunctions()
	return { MODIFIER_EVENT_ON_TAKEDAMAGE }
end

function modifier_creep_suicide_lua_passive:OnTakeDamage(keys)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if keys.unit ~= parent or not self:GetAbility():IsCooldownReady() then
		return
	end

	local threshold = self:GetAbility():GetSpecialValueFor("hp_threshold")

	if parent:GetHealthPercent() <= threshold and parent:IsAlive() then
		local enemies = FindUnitsInRadius(
			parent:GetTeamNumber(),
			parent:GetAbsOrigin(),
			parent,
			self:GetAbility():GetCastRange(parent:GetAbsOrigin(), nil),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			FIND_CLOSEST,
			false
		)

		local target_pos = parent:GetAbsOrigin() + parent:GetForwardVector() * 100
		if #enemies > 0 then
			target_pos = enemies[1]:GetAbsOrigin()
		end

		parent:AddNewModifier(parent, self:GetAbility(), "modifier_creep_suicide_lua_movement", {
			duration = 0.7,
			x = target_pos.x,
			y = target_pos.y,
			z = target_pos.z,
		})
	end
end

--------------------------------------------------------------------------------

modifier_creep_suicide_lua_movement = class({})

function modifier_creep_suicide_lua_movement:OnCreated(kv)
	if IsServer() then
		self.ability = self:GetAbility()
		self.elapsedTime = 0
		self.vStartPos = GetGroundPosition(self:GetParent():GetOrigin(), self:GetParent())
		self.duration = self:GetDuration()
		self.position = Vector(kv.x, kv.y, kv.z)
		self.maxHeight = 200
		self.parent = self:GetParent()
		self.frametime = 0.03

		self.radius = self.ability:GetSpecialValueFor("radius")
		self.damage = self.ability:GetSpecialValueFor("damage") + self.ability:GetSpecialValueFor("diff_boost_damage")
		self.silence_duration = self.ability:GetSpecialValueFor("silence_duration")

		self:StartIntervalThink(self.frametime)
	end
end

function modifier_creep_suicide_lua_movement:OnIntervalThink()
	if IsServer() then
		self:HorizontalMotion(self.parent, self.frametime)
		self:VerticalMotion(self.parent, self.frametime)
	end
end

function modifier_creep_suicide_lua_movement:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end

function modifier_creep_suicide_lua_movement:HorizontalMotion(me, dt)
	if IsServer() then
		self.elapsedTime = self.elapsedTime + dt
		local pct = self.elapsedTime / self.duration

		if pct >= 1 then
			self.parent:SetAbsOrigin(self.position)
			self:Destroy()
			return
		end

		local currentPos = LerpVectors(self.vStartPos, self.position, pct)

		local height = 4 * self.maxHeight * pct * (1 - pct)
		local groundHeight = GetGroundHeight(currentPos, self.parent)
		currentPos.z = groundHeight + height

		self.parent:SetOrigin(currentPos)
	end
end

function modifier_creep_suicide_lua_movement:VerticalMotion(me, dt) end

function modifier_creep_suicide_lua_movement:OnDestroy()
	if not IsServer() then
		return
	end
	FindClearSpaceForUnit(self.parent, self.position, true)
	self:BlastOffLanded()
end

function modifier_creep_suicide_lua_movement:BlastOffLanded()
	EmitSoundOn("Hero_Techies.Suicide", self.parent)
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_blast_off.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, self.parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(pfx)

	GridNav:DestroyTreesAroundPoint(self.parent:GetAbsOrigin(), self.radius, true)

	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = self.parent,
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})
		enemy:AddNewModifier(self.parent, self.ability, "modifier_silence", { duration = self.silence_duration })
	end
	self.parent:Kill(self.ability, self.parent)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_cast_damage_immune_lua", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)

creep_cast_damage_immune_lua = class({})

function creep_cast_damage_immune_lua:Precache(context)
	PrecacheResource("particle", "particles/items2_fx/veil_of_discord.vpcf", context)
	PrecacheResource("particle", "particles/nyx_phisical.vpcf", context)
	PrecacheResource("particle", "particles/nyx_magical.vpcf", context)
end

function creep_cast_damage_immune_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target_loc = self:GetCursorPosition()
	caster:EmitSound("DOTA_Item.VeilofDiscord.Activate")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target_loc,
		nil,
		1000,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_ALL,
		0,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_creep_cast_damage_immune_lua", { duration = 6 })
	end
end

--------------------------------------------------------------------------------

modifier_creep_cast_damage_immune_lua = class({})

function modifier_creep_cast_damage_immune_lua:IsHidden()
	return true
end

function modifier_creep_cast_damage_immune_lua:OnCreated()
	self.phis = 0
	self.mag = 1
	if not IsServer() then
		return
	end
	self:StartIntervalThink(2)
end

function modifier_creep_cast_damage_immune_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	self:GetCaster():EmitSound("Hero_Necrolyte.SpiritForm.Cast")
	if self.mag == 1 then
		self.mag = 0
		self.phis = 1
		self:PlayEffects()
		if self.particle2 then
			ParticleManager:DestroyParticle(self.particle2, true)
			ParticleManager:ReleaseParticleIndex(self.particle2)
		end
	else
		self.mag = 1
		self.phis = 0
		self:PlayEffects2()
		if self.particle1 then
			ParticleManager:DestroyParticle(self.particle1, true)
			ParticleManager:ReleaseParticleIndex(self.particle1)
		end
	end
end

function modifier_creep_cast_damage_immune_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	}
	return funcs
end

function modifier_creep_cast_damage_immune_lua:GetAbsoluteNoDamagePhysical()
	return self.phis
end

function modifier_creep_cast_damage_immune_lua:GetAbsoluteNoDamageMagical()
	return self.mag
end

function modifier_creep_cast_damage_immune_lua:PlayEffects()
	self.particle1 =
		ParticleManager:CreateParticle("particles/nyx_phisical.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.particle1, 1, Vector(150, 150, 150))
end

function modifier_creep_cast_damage_immune_lua:PlayEffects2()
	self.particle2 =
		ParticleManager:CreateParticle("particles/nyx_magical.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.particle2, 1, Vector(150, 150, 150))
end

function modifier_creep_cast_damage_immune_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if self.particle1 then
		ParticleManager:DestroyParticle(self.particle1, true)
		ParticleManager:ReleaseParticleIndex(self.particle1)
		self.particle1 = nil
	end
	if self.particle2 then
		ParticleManager:DestroyParticle(self.particle2, true)
		ParticleManager:ReleaseParticleIndex(self.particle2)
		self.particle2 = nil
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_treant_seed_lua", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)

creep_treant_seed_lua = class({})

function creep_treant_seed_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_overgrowth_vines.vpcf", context)
end

function creep_treant_seed_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_treant_seed_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")

	if target:TriggerSpellAbsorb(self) then
		return
	end

	target:AddNewModifier(caster, self, "modifier_creep_treant_seed_lua", { duration = duration })
	target:AddNewModifier(caster, self, "modifier_silenced", { duration = duration })

	caster:EmitSound("Hero_Treant.LeechSeed.Cast")
end

function creep_treant_seed_lua:OnProjectileHit_ExtraData(target, location, ExtraData)
	if target then
		ApplyDamage({
			victim = target,
			attacker = self:GetCaster(),
			damage = ExtraData.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
		target:EmitSound("Hero_Treant.LeechSeed.Target")
	end
end

--------------------------------------------------------------------------------

modifier_creep_treant_seed_lua = class({})

function modifier_creep_treant_seed_lua:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.damage_interval = self.ability:GetSpecialValueFor("tick")
	self.leech_damage = self.ability:GetSpecialValueFor("damage") + self.ability:GetSpecialValueFor("diff_boost_damage")
	self.radius = self.ability:GetSpecialValueFor("radius")
	self.projectile_speed = 700

	if not IsServer() then
		return
	end
	self:StartIntervalThink(self.damage_interval)
	self:OnIntervalThink()
end

function modifier_creep_treant_seed_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local caster = self:GetCaster()

	parent:EmitSound("Hero_Treant.LeechSeed.Tick")

	ApplyDamage({
		victim = parent,
		attacker = caster,
		damage = self.leech_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:ReleaseParticleIndex(pfx)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		parent:GetAbsOrigin(),
		parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		if enemy ~= parent then
			ProjectileManager:CreateTrackingProjectile({
				EffectName = "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf",
				Ability = self.ability,
				Source = parent,
				vSourceLoc = parent:GetAbsOrigin(),
				Target = enemy,
				iMoveSpeed = self.projectile_speed,
				bDodgeable = true,
				bVisibleToEnemies = true,
				bProvidesVision = false,
				ExtraData = { damage = self.leech_damage },
			})
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_overgrowth_lua", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)

creep_overgrowth_lua = class({})

function creep_overgrowth_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_overgrowth_lua:OnAbilityPhaseStart()
	self:GetCaster():EmitSound("Hero_Treant.Overgrowth.CastAnim")
	return true
end

function creep_overgrowth_lua:OnSpellStart()
	self:GetCaster():EmitSound("Hero_Treant.Overgrowth.Cast")

	local cast_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_treant/treant_overgrowth_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:ReleaseParticleIndex(cast_particle)

	local overgrowth_primary_enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetAbsOrigin(),
		self:GetCaster(),
		self:GetSpecialValueFor("radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(overgrowth_primary_enemies) do
		enemy:Stop()
		enemy:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_creep_overgrowth_lua",
			{ duration = self:GetSpecialValueFor("duration") * (1 - enemy:GetStatusResistance()) }
		)
	end
end

--------------------------------------------------------------------------------

modifier_creep_overgrowth_lua = class({})

function modifier_creep_overgrowth_lua:GetEffectName()
	return "particles/units/heroes/hero_treant/treant_overgrowth_vines.vpcf"
end

function modifier_creep_overgrowth_lua:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
	self:OnIntervalThink()
end

function modifier_creep_overgrowth_lua:OnIntervalThink()
	ApplyDamage({
		victim = self:GetParent(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self:GetAbility(),
	})
end

function modifier_creep_overgrowth_lua:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_INVISIBLE] = false,
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_treant_invis", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_treant_invis_effect", "abilities/creeps/zone_8/zone_8", LUA_MODIFIER_MOTION_NONE)

treant_invis = class({})

function treant_invis:GetIntrinsicModifierName()
	return "modifier_treant_invis"
end

--------------------------------------------------------------------------------

modifier_treant_invis = class({})

function modifier_treant_invis:IsHidden()
	return true
end
function modifier_treant_invis:IsPermanent()
	return true
end

function modifier_treant_invis:OnCreated()
	if not IsServer() then
		return
	end
	self.invis_delay = 5
	self.last_action_time = GameRules:GetGameTime()
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treant_invis_effect", {})
	self:StartIntervalThink(0.1)
end

function modifier_treant_invis:OnIntervalThink()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local now = GameRules:GetGameTime()
	local has_invis = parent:HasModifier("modifier_treant_invis_effect")

	local aggro_range = parent:GetAcquisitionRange()
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		parent,
		aggro_range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	if #enemies > 0 then
		self.last_action_time = now
		if not parent:IsAttacking() then
			ExecuteOrderFromTable({
				UnitIndex = parent:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				TargetIndex = enemies[1]:entindex(),
			})
		end
	end

	if not parent:IsAttacking() and (now - self.last_action_time) >= self.invis_delay then
		if not has_invis then
			parent:AddNewModifier(parent, self:GetAbility(), "modifier_treant_invis_effect", {})
		end
	end
end

function modifier_treant_invis:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
end

function modifier_treant_invis:OnAttackStart(keys)
	if keys.attacker == self:GetParent() then
		self:GetParent():RemoveModifierByName("modifier_treant_invis_effect")
		self.last_action_time = GameRules:GetGameTime()
	end
end

function modifier_treant_invis:OnAbilityExecuted(keys)
	if keys.unit == self:GetParent() then
		self:GetParent():RemoveModifierByName("modifier_treant_invis_effect")
		self.last_action_time = GameRules:GetGameTime()
	end
end

-------------------------------------------

modifier_treant_invis_effect = class({})

function modifier_treant_invis_effect:IsHidden()
	return false
end
function modifier_treant_invis_effect:IsPurgable()
	return false
end

function modifier_treant_invis_effect:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
	}
end

function modifier_treant_invis_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}
end

function modifier_treant_invis_effect:GetModifierInvisibilityLevel()
	return 1
end