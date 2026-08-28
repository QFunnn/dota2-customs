--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_boss_slardar_slithereen_crush_lua_slow",
	"abilities/bosses/slardar/slardar",
	LUA_MODIFIER_MOTION_NONE
)

boss_slardar_slithereen_crush_lua = class({})

function boss_slardar_slithereen_crush_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_slardar/slardar_crush.vpcf", context)
end

function boss_slardar_slithereen_crush_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_slardar_slithereen_crush_lua:OnSpellStart()
	local radius = self:GetSpecialValueFor("crush_radius")
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	local duration = self:GetSpecialValueFor("duration")

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	local damageTable = {
		victim = nil,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self,
	}

	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
		enemy:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_boss_slardar_slithereen_crush_lua_slow",
			{ duration = duration }
		)
	end
	self:PlayEffects()
end

function boss_slardar_slithereen_crush_lua:PlayEffects()
	local radius = self:GetSpecialValueFor("crush_radius")
	local nFXIndex = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slardar/slardar_crush.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(nFXIndex, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(nFXIndex, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(nFXIndex)
	local sound_cast = "Hero_Slardar.Slithereen_Crush"
	-- EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

-------------------------------------------------------

modifier_boss_slardar_slithereen_crush_lua_slow = class({})

function modifier_boss_slardar_slithereen_crush_lua_slow:IsDebuff()
	return true
end

function modifier_boss_slardar_slithereen_crush_lua_slow:OnCreated(kv)
	self.slow_ms = self:GetAbility():GetSpecialValueFor("slow_ms")
	self.slow_as = self:GetAbility():GetSpecialValueFor("slow_as")
end

function modifier_boss_slardar_slithereen_crush_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_boss_slardar_slithereen_crush_lua_slow:GetModifierMoveSpeedBonus_Percentage(params)
	return -self.slow_ms
end

function modifier_boss_slardar_slithereen_crush_lua_slow:GetModifierAttackSpeedBonus_Constant(params)
	return -self.slow_as
end

-------------------------------------------------------
-------------------------------------------------------

LinkLuaModifier(
	"modifier_boss_slardar_torrential_waters",
	"abilities/bosses/slardar/slardar",
	LUA_MODIFIER_MOTION_VERTICAL
)

boss_slardar_torrential_waters = class({})

function boss_slardar_torrential_waters:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf",
		context
	)
	PrecacheResource("particle", "particles/ui_mouseactions/range_display.vpcf", context)
end

function boss_slardar_torrential_waters:OnSpellStart()
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster()
		:AddNewModifier(self:GetCaster(), self, "modifier_boss_slardar_torrential_waters", { duration = duration })
end

------------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_boss_slardar_torrential_waters = class({})

function modifier_boss_slardar_torrential_waters:IsHidden()
	return false
end
function modifier_boss_slardar_torrential_waters:IsPurgable()
	return false
end

function modifier_boss_slardar_torrential_waters:OnCreated(kv)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
	local interval = self:GetAbility():GetSpecialValueFor("interval")
	self:StartIntervalThink(interval)
end

function modifier_boss_slardar_torrential_waters:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
	}
end

function modifier_boss_slardar_torrential_waters:DeclareFunctions()
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end

function modifier_boss_slardar_torrential_waters:GetOverrideAnimation()
	return ACT_DOTA_TELEPORT
end

function modifier_boss_slardar_torrential_waters:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local caster_pos = caster:GetAbsOrigin()
	local ability = self:GetAbility()

	local range = ability:GetSpecialValueFor("range")
	local delay = ability:GetSpecialValueFor("delay")
	local damage = ability:GetSpecialValueFor("damage") + ability:GetSpecialValueFor("diff_boost_damage")
	local damage_radius = ability:GetSpecialValueFor("damage_radius")

	local angle = math.rad(RandomInt(0, 360))
	local variance = RandomInt(0, range)
	local dx = math.cos(angle) * variance
	local dy = math.sin(angle) * variance
	local target_pos = Vector(caster_pos.x + dx, caster_pos.y + dy, caster_pos.z)

	local indicator_pfx =
		ParticleManager:CreateParticle("particles/ui_mouseactions/range_display.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(indicator_pfx, 0, target_pos)
	ParticleManager:SetParticleControl(indicator_pfx, 1, Vector(damage_radius, 0, 0))
	ParticleManager:SetParticleControl(indicator_pfx, 2, Vector(delay, 0, 0))
	ParticleManager:SetParticleControl(indicator_pfx, 3, Vector(255, 0, 0))

	Timers:CreateTimer(delay, function()
		ParticleManager:DestroyParticle(indicator_pfx, false)
		ParticleManager:ReleaseParticleIndex(indicator_pfx)

		local particle_blast_fx = ParticleManager:CreateParticle(
			"particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(particle_blast_fx, 0, target_pos)
		ParticleManager:SetParticleControl(particle_blast_fx, 1, Vector(damage_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle_blast_fx)

		local sound_cast = "Ability.Torrent"
		-- EmitSoundOnLocationWithCaster(target_pos, sound_cast, caster)
		EmitSoundOn(sound_cast, caster)

		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target_pos,
			caster,
			damage_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
		for _, unit in ipairs(units) do
			ApplyDamage({
				attacker = caster,
				victim = unit,
				ability = ability,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage = damage,
			})
		end
	end)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_slardar_sprint_buff", "abilities/bosses/slardar/slardar", LUA_MODIFIER_MOTION_NONE)

boss_slardar_sprint_buff = class({})

function boss_slardar_sprint_buff:GetIntrinsicModifierName()
	return "modifier_boss_slardar_sprint_buff"
end

--------------------------------------------------------------------------------

modifier_boss_slardar_sprint_buff = class({})

function modifier_boss_slardar_sprint_buff:IsHidden()
	return true
end
function modifier_boss_slardar_sprint_buff:IsPurgable()
	return false
end

function modifier_boss_slardar_sprint_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function modifier_boss_slardar_sprint_buff:GetActivityTranslationModifiers()
	return "sprint"
end

function modifier_boss_slardar_sprint_buff:GetModifierMoveSpeed_Absolute()
	return 800
end

function modifier_boss_slardar_sprint_buff:GetModifierIgnoreMovespeedLimit()
	return 1
end

function modifier_boss_slardar_sprint_buff:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_water_blast_push", "abilities/bosses/slardar/slardar", LUA_MODIFIER_MOTION_HORIZONTAL)

boss_slardar_water_blast = class({})

function boss_slardar_water_blast:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_slardar_water_blast:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf", context)
end

function boss_slardar_water_blast:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local ability = self

	local radius = ability:GetSpecialValueFor("radius")
	local speed = ability:GetSpecialValueFor("speed")
	local wave_width = ability:GetSpecialValueFor("wave_width")
	local wave_count = 8

	caster:EmitSound("Hero_Tidehunter.Gush.Aghanim")

	local angle_step = 360 / wave_count

	for i = 0, (wave_count - 1) do
		local angle = i * angle_step
		local direction = QAngle(0, angle, 0)
		local forward = AnglesToVector(direction)

		ProjectileManager:CreateLinearProjectile({
			Ability = ability,
			EffectName = "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf",
			vSpawnOrigin = caster:GetAbsOrigin(),
			fDistance = radius,
			fStartRadius = wave_width,
			fEndRadius = wave_width,
			Source = caster,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			vVelocity = forward * speed,
			bHasFrontalCone = false,
			bReplaceExisting = false,
			fExpireTime = GameRules:GetGameTime() + 10.0,
		})
	end

	local sound_cast = "Ability.GushCast"
	EmitSoundOn(sound_cast, self:GetCaster())
end

function boss_slardar_water_blast:OnProjectileHit(target, location)
	if not target or target:IsBuilding() then
		return
	end

	local caster = self:GetCaster()
	local ability = self
	local radius = ability:GetSpecialValueFor("radius")

	local direction = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()
	direction.z = 0

	local final_wave_pos = caster:GetAbsOrigin() + direction * radius

	target:AddNewModifier(caster, ability, "modifier_water_blast_push", {
		duration = 2.0,
		target_x = final_wave_pos.x,
		target_y = final_wave_pos.y,
	})

	target:EmitSound("Hero_Tidehunter.Gush.Impact")
	return false
end

----------------------------------------------------------------

modifier_water_blast_push = class({})

function modifier_water_blast_push:OnCreated(kv)
	if not IsServer() then
		return
	end

	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if kv.target_x and kv.target_y then
		self.target_pos = Vector(kv.target_x, kv.target_y, 0)
	else
		self:Destroy()
		return
	end

	self.push_speed = self.ability:GetSpecialValueFor("speed")
	self.last_pos = self.parent:GetAbsOrigin()

	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end

function modifier_water_blast_push:UpdateHorizontalMotion(me, dt)
	if not IsServer() then
		return
	end

	local current_pos = me:GetAbsOrigin()
	local direction = (self.target_pos - current_pos):Normalized()
	local distance_to_target = (self.target_pos - current_pos):Length2D()

	if distance_to_target < (self.push_speed * dt) then
		me:SetOrigin(self.target_pos)
		self:Destroy()
		return
	end

	local next_pos = current_pos + direction * self.push_speed * dt

	if GridNav:IsTraversable(next_pos) and not GridNav:IsBlocked(next_pos) then
		me:SetOrigin(next_pos)

		local dist_moved = (next_pos - self.last_pos):Length2D()
		self.last_pos = next_pos

		local max_damage = self.ability:GetSpecialValueFor("damage")
			+ self.ability:GetSpecialValueFor("diff_boost_damage")

		local damage_to_deal = dist_moved * (max_damage * 0.001)

		if damage_to_deal > 0 then
			ApplyDamage({
				victim = self.parent,
				attacker = self.caster,
				damage = damage_to_deal,
				damage_type = self.ability:GetAbilityDamageType(),
				ability = self.ability,
			})
		end
	else
		self:Destroy()
	end
end

function modifier_water_blast_push:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:RemoveHorizontalMotionController(self)
	FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)
end

function modifier_water_blast_push:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_water_blast_push:DeclareFunctions()
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end

function modifier_water_blast_push:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

----------------------------------------------------------------

LinkLuaModifier("modifier_boss_slardar_bubble_debuff", "abilities/bosses/slardar/slardar", LUA_MODIFIER_MOTION_NONE)

boss_slardar_bubble = class({})

function boss_slardar_bubble:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_creeps.vsndevts", context)
	PrecacheResource("particle", "particles/econ/taunts/snapfire/snapfire_taunt_bubble.vpcf", context)
end

function boss_slardar_bubble:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")

	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, unit in pairs(units) do
		self:GetCaster():EmitSound("n_frogs.WaterBubble.Target")
		unit:AddNewModifier(self:GetCaster(), self, "modifier_boss_slardar_bubble_debuff", { duration = duration })
	end
end

----------------------------------------------------------------

modifier_boss_slardar_bubble_debuff = class({})

function modifier_boss_slardar_bubble_debuff:OnCreated()
	if not IsServer() then
		return
	end
	local particle = ParticleManager:CreateParticle(
		"particles/econ/taunts/snapfire/snapfire_taunt_bubble.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(),
		true
	)
	self:AddParticle(particle, false, false, -1, false, false)
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ice_slide", {})
	self.lop_damage = self:GetAbility():GetSpecialValueFor("damage") / 100
end

function modifier_boss_slardar_bubble_debuff:OnDestroy()
	if not IsServer() then
		return
	end
	local damage_to_deal = self.lop_damage * self:GetParent():GetMaxHealth()
	ApplyDamage({
		attacker = self:GetCaster(),
		victim = self:GetParent(),
		ability = self:GetAbility(),
		damage = damage_to_deal,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
	})
	self:GetParent():Script_ReduceMana(self:GetParent():GetMaxMana() * self.lop_damage, nil)
	self:GetParent():RemoveModifierByName("modifier_ice_slide")
	self:GetParent():EmitSound("n_frogs.WaterBubble.Destroy")
end

function modifier_boss_slardar_bubble_debuff:CheckState()
	return {
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_boss_slardar_bubble_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_boss_slardar_bubble_debuff:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end