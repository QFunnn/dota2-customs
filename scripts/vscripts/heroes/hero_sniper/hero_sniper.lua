--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_sniper_shrapnel_lua", "heroes/hero_sniper/hero_sniper", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_shrapnel_lua_charges", "heroes/hero_sniper/hero_sniper", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_shrapnel_lua_thinker", "heroes/hero_sniper/hero_sniper", LUA_MODIFIER_MOTION_NONE)

sniper_shrapnel_lua = class({})

function sniper_shrapnel_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_sniper/sniper_shrapnel.vpcf", context)
end

function sniper_shrapnel_lua:GetIntrinsicModifierName()
	return "modifier_sniper_shrapnel_lua_charges"
end

function sniper_shrapnel_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function sniper_shrapnel_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	CreateModifierThinker(
		caster,
		self,
		"modifier_sniper_shrapnel_lua_thinker",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)
	self:PlayEffects(point)
end

function sniper_shrapnel_lua:PlayEffects(point)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetCaster():GetOrigin(),
		false
	)
	ParticleManager:SetParticleControl(effect_cast, 1, point + Vector(0, 0, 2000))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Sniper.ShrapnelShoot", self:GetCaster())
end

-----------------------------------------------------------------------------

modifier_sniper_shrapnel_lua_thinker = class({})

function modifier_sniper_shrapnel_lua_thinker:IsHidden()
	return true
end

function modifier_sniper_shrapnel_lua_thinker:IsPurgable()
	return false
end

function modifier_sniper_shrapnel_lua_thinker:IsAura()
	return self.start
end
function modifier_sniper_shrapnel_lua_thinker:GetModifierAura()
	return "modifier_sniper_shrapnel_lua"
end
function modifier_sniper_shrapnel_lua_thinker:GetAuraRadius()
	return self.radius
end
function modifier_sniper_shrapnel_lua_thinker:GetAuraDuration()
	return 0.5
end
function modifier_sniper_shrapnel_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_sniper_shrapnel_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_sniper_shrapnel_lua_thinker:OnCreated(kv)
	self.delay = self:GetAbility():GetSpecialValueFor("damage_delay")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("shrapnel_damage")
	self.aura_stick = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.start = false

	if IsServer() then
		self.direction = (self:GetParent():GetOrigin() - self:GetCaster():GetOrigin()):Normalized()
		self:StartIntervalThink(self.delay)
		self.sound_cast = "Hero_Sniper.ShrapnelShatter"
		EmitSoundOn(self.sound_cast, self:GetParent())
	end
end

function modifier_sniper_shrapnel_lua_thinker:OnIntervalThink()
	if not self.start then
		self.start = true
		self:StartIntervalThink(self.duration)
		AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.radius, self.duration, false)
		self:PlayEffects()
	else
		self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

function modifier_sniper_shrapnel_lua_thinker:PlayEffects()
	self.effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sniper/sniper_shrapnel.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 1, 1))
	ParticleManager:SetParticleControlForward(self.effect_cast, 2, self.direction + Vector(0, 0, 0.1))
end

function modifier_sniper_shrapnel_lua_thinker:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
	StopSoundOn(self.sound_cast, self:GetParent())
end

-----------------------------------------------------------------------------

modifier_sniper_shrapnel_lua = class({})

function modifier_sniper_shrapnel_lua:IsHidden()
	return false
end

function modifier_sniper_shrapnel_lua:IsDebuff()
	return true
end

function modifier_sniper_shrapnel_lua:IsPurgable()
	return false
end

function modifier_sniper_shrapnel_lua:OnCreated(kv)
	self.caster = self:GetAbility():GetCaster()
	self.damage = self:GetAbility():GetSpecialValueFor("shrapnel_damage")
	self.ms_slow = self:GetAbility():GetSpecialValueFor("slow_movement_speed")

	local interval = 1

	if IsServer() then
		damage_type = DAMAGE_TYPE_PHYSICAL

		self.damageTable = {
			victim = self:GetParent(),
			attacker = self.caster,
			damage = self.damage,
			damage_type = damage_type,
			ability = self:GetAbility(),
		}

		self:StartIntervalThink(interval)
		self:OnIntervalThink()
	end
end

function modifier_sniper_shrapnel_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_sniper_shrapnel_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.ms_slow
end

function modifier_sniper_shrapnel_lua:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

-------------------------------------------------------------------------------------

modifier_sniper_shrapnel_lua_charges = class({})

function modifier_sniper_shrapnel_lua_charges:IsHidden()
	return false
end

function modifier_sniper_shrapnel_lua_charges:IsDebuff()
	return false
end

function modifier_sniper_shrapnel_lua_charges:IsPurgable()
	return false
end

function modifier_sniper_shrapnel_lua_charges:DestroyOnExpire()
	return false
end

function modifier_sniper_shrapnel_lua_charges:OnCreated(kv)
	self.max_charges = self:GetAbility():GetSpecialValueFor("max_charges")
	self.charge_restore_time = self:GetAbility():GetSpecialValueFor("charge_restore_time")
	if IsServer() then
		self:SetStackCount(self.max_charges)
		self:CalculateCharge()
	end
end

function modifier_sniper_shrapnel_lua_charges:OnRefresh(kv)
	self.max_charges = self:GetAbility():GetSpecialValueFor("max_charges")
	self.charge_restore_time = self:GetAbility():GetSpecialValueFor("charge_restore_time")
	if IsServer() then
		self:CalculateCharge()
	end
end

function modifier_sniper_shrapnel_lua_charges:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
	return funcs
end

function modifier_sniper_shrapnel_lua_charges:OnAbilityFullyCast(params)
	if IsServer() then
		if params.unit ~= self:GetParent() or params.ability ~= self:GetAbility() then
			return
		end
		self:DecrementStackCount()
		self:CalculateCharge()
	end
end

function modifier_sniper_shrapnel_lua_charges:OnIntervalThink()
	self:IncrementStackCount()
	self:StartIntervalThink(-1)
	self:CalculateCharge()
end

function modifier_sniper_shrapnel_lua_charges:CalculateCharge()
	self:GetAbility():EndCooldown()
	if self:GetStackCount() >= self.max_charges then
		self:SetDuration(-1, false)
		self:StartIntervalThink(-1)
	else
		if self:GetRemainingTime() <= 0.05 then
			self:StartIntervalThink(self.charge_restore_time)
			self:SetDuration(self.charge_restore_time, true)
		end
		if self:GetStackCount() == 0 then
			self:GetAbility():StartCooldown(self:GetRemainingTime())
		end
	end
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

LinkLuaModifier("modifier_sniper_granade_debuff", "heroes/hero_sniper/hero_sniper", LUA_MODIFIER_MOTION_NONE)

sniper_granade = class({})

function sniper_granade:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_gob_squad/rocket_blast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_gob_squad/rocket_blast_explosion.vpcf", context)
end

function sniper_granade:GetCastRange(location, target)
	return self.BaseClass.GetCastRange(self, location, target)
end

function sniper_granade:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function sniper_granade:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition() + 5
	local caster_loc = self:GetCaster():GetAttachmentOrigin(DOTA_PROJECTILE_ATTACHMENT_ATTACK_1)
	local cast_direction = (point - self:GetCaster():GetOrigin()):Normalized()

	local info = {
		Source = self:GetCaster(),
		Ability = self,
		vSpawnOrigin = self:GetCaster():GetOrigin(),
		bDeleteOnHit = true,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		EffectName = "particles/units/heroes/hero_gob_squad/rocket_blast.vpcf",
		fDistance = 1500,
		fStartRadius = 100,
		fEndRadius = 150,
		vVelocity = cast_direction * 2500,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		fExpireTime = GameRules:GetGameTime() + 10.0,
		bProvidesVision = true,
		iVisionRadius = 400,
		iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
	}
	self:GetCaster():EmitSound("Ability.Assassinate")
	ProjectileManager:CreateLinearProjectile(info)
end

function sniper_granade:OnProjectileHit(target, vLocation)
	if not IsServer() then
		return
	end
	if target ~= nil then
		local point = target:GetOrigin()
		local damage = self:GetSpecialValueFor("damage")
		local radius = self:GetSpecialValueFor("radius")
		local duration = self:GetSpecialValueFor("duration")

		local particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_gob_squad/rocket_blast_explosion.vpcf",
			PATTACH_CUSTOMORIGIN_FOLLOW,
			target
		)
		ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin() + Vector(0, 0, 75))
		ParticleManager:SetParticleControl(particle, 1, Vector(300, 0, 0))
		target:EmitSound("Hero_Techies.RemoteMine.Detonate")
		AddFOWViewer(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), 300, 1, false)
		local units = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			target:GetAbsOrigin(),
			target,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			0,
			false
		)
		for i, unit in ipairs(units) do
			ApplyDamage({
				victim = unit,
				attacker = self:GetCaster(),
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			})
			unit:AddNewModifier(self:GetCaster(), self, "modifier_sniper_granade_debuff", { duration = duration })
		end
	end
	return true
end

--------------------------------------------------------------------------------

modifier_sniper_granade_debuff = class({})

function modifier_sniper_granade_debuff:IsHidden()
	return true
end

function modifier_sniper_granade_debuff:OnCreated(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.movespeed_slow = self:GetAbility():GetSpecialValueFor("movespeed_slow")
	self.burn_interval = 0.5

	if IsServer() then
		self:StartIntervalThink(self.burn_interval)
	end
end

function modifier_sniper_granade_debuff:OnIntervalThink()
	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
	})
end

function modifier_sniper_granade_debuff:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_sniper_granade_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_sniper_granade_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_sniper_granade_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.movespeed_slow
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_sniper_headshot_lua", "heroes/hero_sniper/hero_sniper", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_headshot_lua_slow", "heroes/hero_sniper/hero_sniper", LUA_MODIFIER_MOTION_NONE)

sniper_headshot_lua = class({})

function sniper_headshot_lua:GetIntrinsicModifierName()
	return "modifier_sniper_headshot_lua"
end

-------------------------------------------------------------------------------

modifier_sniper_headshot_lua = class({})

function modifier_sniper_headshot_lua:IsHidden()
	return true
end

function modifier_sniper_headshot_lua:IsPurgable()
	return false
end

function modifier_sniper_headshot_lua:OnCreated(kv)
	self.proc_chance = self:GetAbility():GetSpecialValueFor("proc_chance")
	self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_sniper_headshot_lua:OnRefresh(kv)
	self.proc_chance = self:GetAbility():GetSpecialValueFor("proc_chance")
	self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_sniper_headshot_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_sniper_headshot_lua:GetModifierProcAttack_BonusDamage_Physical(params)
	if IsServer() then
		if RandomInt(1, 100) <= self.proc_chance then
			params.target:AddNewModifier(
				self:GetParent(),
				self,
				"modifier_sniper_headshot_lua_slow",
				{ duration = self.slow_duration, slow = self.slow }
			)
			return self.damage
		end
	end
end

function modifier_sniper_headshot_lua:OnTakeDamage(keys)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_sniper_6")
	if talent ~= nil and talent:GetLevel() > 0 and RandomInt(1, 100) <= 50 then
		if
			keys.attacker == self:GetParent()
			and not self:GetParent():PassivesDisabled()
			and keys.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
			and not keys.unit:IsBuilding()
			and (not keys.unit:IsOther() or (keys.unit:IsOther() and keys.damage > 0))
		then
			for _, enemy in
				pairs(
					FindUnitsInLine(
						self:GetCaster():GetTeamNumber(),
						keys.unit:GetAbsOrigin(),
						keys.unit:GetAbsOrigin()
							+ ((keys.unit:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized() * 300),
						nil,
						90,
						DOTA_UNIT_TARGET_TEAM_ENEMY,
						DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
						DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
					)
				)
			do
				if enemy ~= keys.unit then
					enemy:EmitSound("Hero_TemplarAssassin.PsiBlade")

					self.psi_particle = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_templar_assassin/templar_assassin_psi_blade.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						keys.unit
					)
					ParticleManager:SetParticleControlEnt(
						self.psi_particle,
						0,
						keys.unit,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						keys.unit:GetAbsOrigin(),
						true
					)
					ParticleManager:SetParticleControlEnt(
						self.psi_particle,
						1,
						enemy,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						enemy:GetAbsOrigin(),
						true
					)
					ParticleManager:ReleaseParticleIndex(self.psi_particle)

					ApplyDamage({
						victim = enemy,
						damage = keys.damage,
						damage_type = DAMAGE_TYPE_PURE,
						damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
							+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
						attacker = self:GetParent(),
						ability = self:GetAbility(),
					})
					break
				end
			end
		end
	end
end

-------------------------------------------------------------------------------

modifier_sniper_headshot_lua_slow = class({})

function modifier_sniper_headshot_lua_slow:IsHidden()
	return true
end

function modifier_sniper_headshot_lua_slow:IsDebuff()
	return true
end

function modifier_sniper_headshot_lua_slow:IsPurgable()
	return true
end

function modifier_sniper_headshot_lua_slow:OnCreated(kv)
	if IsServer() then
		self.slow = kv.slow
		EmitSoundOn("Hero_Sniper.HeadShot", self:GetParent())
	end
end

function modifier_sniper_headshot_lua_slow:OnRefresh(kv)
	if IsServer() then
		self.slow = kv.slow
		EmitSoundOn("Hero_Sniper.HeadShot", self:GetParent())
	end
end

function modifier_sniper_headshot_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_sniper_headshot_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	if IsServer() then
		return -self.slow
	end
end

function modifier_sniper_headshot_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf"
end

function modifier_sniper_headshot_lua_slow:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

-----------------------------------------------------------------
-----------------------------------------------------------------

LinkLuaModifier("modifier_sniper_ult", "heroes/hero_sniper/hero_sniper", LUA_MODIFIER_MOTION_NONE)

sniper_ult = class({})

function sniper_ult:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_cast.vpcf",
		context
	)
end

function sniper_ult:GetAbilityTextureName()
	return "sniper_assassinate"
end

function sniper_ult:OnSpellStart()
	if IsServer() then
		local duration = self:GetSpecialValueFor("duration")
		self:GetCaster():EmitSound("Hero_TrollWarlord.BattleTrance.Cast")
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sniper_ult", { duration = duration })
		local cast_pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_cast.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetCaster()
		)
		ParticleManager:SetParticleControlEnt(
			cast_pfx,
			0,
			self:GetCaster(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetCaster():GetOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(cast_pfx)
	end
end

-------------------------------------------

modifier_sniper_ult = class({})

function modifier_sniper_ult:IsHidden()
	return false
end

function modifier_sniper_ult:IsPurgable()
	return false
end

function modifier_sniper_ult:IsPurgeException()
	return false
end

function modifier_sniper_ult:OnCreated()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	self.base_attack_time = ability:GetSpecialValueFor("base_attack_time")
	self.less = ability:GetSpecialValueFor("less")
	self.bonus_range = ability:GetSpecialValueFor("bonus_range")
	self.bonus_attack_damage = ability:GetSpecialValueFor("bonus_attack_damage")
	self:StartIntervalThink(0.1)
end

function modifier_sniper_ult:OnRefresh()
	self:OnCreated()
end

function modifier_sniper_ult:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
end

function modifier_sniper_ult:GetPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_sniper_ult:OnIntervalThink()
	if IsServer() then
		self:GetParent()
			:SetHealth(math.max(self:GetParent():GetHealth() - (self:GetParent():GetHealth() / 100 * self.less), 1))
	end
end

function modifier_sniper_ult:GetModifierBaseAttackTimeConstant()
	local bat = self.base_attack_time
	local parent = self:GetParent()
	if parent and parent.dms_bat_factor then
		bat = bat * parent.dms_bat_factor
	end
	return bat
end

function modifier_sniper_ult:GetModifierMoveSpeed_Limit()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_sniper_8")
	if talent ~= nil and talent:GetLevel() > 0 then
		return
	end
	return 100
end

function modifier_sniper_ult:GetModifierAttackRangeBonus()
	return self.bonus_range
end

function modifier_sniper_ult:GetModifierDamageOutgoing_Percentage()
	return -self.bonus_attack_damage
end

function modifier_sniper_ult:GetEffectName()
	return "particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf"
end

function modifier_sniper_ult:GetEffectAttachType()
	return PATTACH_POINT_FOLLOW
end