--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_golden_dragon_blinding_lua_debuff",
	"abilities/addition_bosses/golden_dragon",
	LUA_MODIFIER_MOTION_NONE
)

golden_dragon_blinding_lua = class({})

function golden_dragon_blinding_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function golden_dragon_blinding_lua:Precache(context)
	PrecacheResource("particle", "particles/versus/compendium_2024_versus_light_burst.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_debuff.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf",
		context
	)
end

function golden_dragon_blinding_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	local particle = ParticleManager:CreateParticle(
		"particles/versus/compendium_2024_versus_light_burst.vpcf",
		PATTACH_ABSORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)

	caster:EmitSound("Hero_KeeperOfTheLight.BlindingLight")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_golden_dragon_blinding_lua_debuff", { duration = duration })
	end
end

--------------------------------------------------------------------------------

modifier_golden_dragon_blinding_lua_debuff = class({})

function modifier_golden_dragon_blinding_lua_debuff:IsPurgable()
	return true
end

function modifier_golden_dragon_blinding_lua_debuff:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.remaining_time = math.ceil(self:GetDuration())
	self:StartIntervalThink(1.0)
	self:ShowTimer()
end

function modifier_golden_dragon_blinding_lua_debuff:OnIntervalThink()
	self.remaining_time = self.remaining_time - 1
	if self.remaining_time > 0 then
		self:ShowTimer()
	end
end

function modifier_golden_dragon_blinding_lua_debuff:ShowTimer()
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(pfx, 1, Vector(0, self.remaining_time, 0))
	ParticleManager:SetParticleControl(pfx, 2, Vector(2, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
end

function modifier_golden_dragon_blinding_lua_debuff:CheckState()
	if not IsServer() then
		return
	end
	if self:GetParent():IsDebuffImmune() then
		self:Destroy()
	end
	return {}
end

function modifier_golden_dragon_blinding_lua_debuff:OnDestroy()
	if not IsServer() then
		return
	end

	local target = self:GetParent()

	if self:GetRemainingTime() > 0.1 then
		return
	end

	if target:IsDebuffImmune() then
		return
	end

	local caster = self:GetCaster()
	local ability = self:GetAbility()

	if not ability or ability:IsNull() then
		return
	end

	local damage = ability:GetSpecialValueFor("explosion_damage") + ability:GetSpecialValueFor("diff_boost_damage")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf",
		PATTACH_ABSORIGIN,
		target
	)
	ParticleManager:ReleaseParticleIndex(particle)
	target:EmitSound("Hero_Techies.RemoteMine.Detonate")

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = ability:GetAbilityDamageType(),
		ability = ability,
	})
end

function modifier_golden_dragon_blinding_lua_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_MISS_PERCENTAGE }
end

function modifier_golden_dragon_blinding_lua_debuff:GetModifierMiss_Percentage()
	return self:GetAbility():GetSpecialValueFor("blind_pct")
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_golden_dragon_greed_thinker",
	"abilities/addition_bosses/golden_dragon",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_golden_dragon_greed_buff",
	"abilities/addition_bosses/golden_dragon",
	LUA_MODIFIER_MOTION_NONE
)

golden_dragon_greed = class({})

function golden_dragon_blinding_lua:Precache(context)
	PrecacheResource("particle", "particles/golden_dragon_ring.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf", context)
end

function golden_dragon_greed:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster,
		self,
		"modifier_golden_dragon_greed_thinker",
		{ duration = duration },
		caster:GetAbsOrigin(),
		caster:GetTeamNumber(),
		false
	)
	caster:EmitSound("Hero_Alchemist.ChemicalRage.Cast")
end

--------------------------------------------------------------------------------

modifier_golden_dragon_greed_thinker = class({})

function modifier_golden_dragon_greed_thinker:OnCreated()
	if not IsServer() then
		return
	end
	local radius = self:GetAbility():GetSpecialValueFor("radius")

	self.pfx = ParticleManager:CreateParticle("particles/golden_dragon_ring.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.pfx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.pfx, 1, Vector(radius, radius, radius))
end

function modifier_golden_dragon_greed_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
end

function modifier_golden_dragon_greed_thinker:IsAura()
	return true
end
function modifier_golden_dragon_greed_thinker:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end
function modifier_golden_dragon_greed_thinker:GetModifierAura()
	return "modifier_golden_dragon_greed_buff"
end
function modifier_golden_dragon_greed_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_golden_dragon_greed_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end
function modifier_golden_dragon_greed_thinker:GetAuraEntityReject(target)
	return target ~= self:GetCaster()
end

--------------------------------------------------------------------------------

modifier_golden_dragon_greed_buff = class({})

function modifier_golden_dragon_greed_buff:IsPurgable()
	return false
end

function modifier_golden_dragon_greed_buff:OnCreated()
	if not IsServer() then
		return
	end
end

function modifier_golden_dragon_greed_buff:OnDestroy()
	if not IsServer() then
		return
	end
end

function modifier_golden_dragon_greed_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_golden_dragon_greed_buff:GetAbsoluteNoDamageMagical()
	return 1
end
function modifier_golden_dragon_greed_buff:GetAbsoluteNoDamagePhysical()
	return 1
end
function modifier_golden_dragon_greed_buff:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_golden_dragon_greed_buff:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end

	local heal_amount = params.original_damage
	self:GetParent():Heal(heal_amount, self:GetAbility())

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), heal_amount, nil)
end

function modifier_golden_dragon_greed_buff:GetEffectName()
	return "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf"
end

function modifier_golden_dragon_greed_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LinkLuaModifier(
	"modifier_golden_dragon_solar_wind_burn",
	"abilities/addition_bosses/golden_dragon",
	LUA_MODIFIER_MOTION_NONE
)

golden_dragon_solar_wind = class({})

function golden_dragon_solar_wind:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function golden_dragon_solar_wind:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf", context)
end

function golden_dragon_solar_wind:OnSpellStart()
	local caster = self:GetCaster()
	local caster_pos = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()

	local distance = self:GetSpecialValueFor("distance")
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	local burn_duration = self:GetSpecialValueFor("burn_duration")

	local projectile_info = {
		EffectName = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf",
		Ability = self,
		vSpawnOrigin = caster_pos,
		vVelocity = forward * (distance / duration),
		fDistance = distance,
		fStartRadius = radius,
		fEndRadius = radius,
		Source = caster,
		bHasFrontalCone = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
	}
	ProjectileManager:CreateLinearProjectile(projectile_info)

	caster:EmitSound("Hero_Invoker.DeafeningBlast")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster_pos,
		caster,
		distance,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		local enemy_direction = (enemy:GetOrigin() - caster_pos):Normalized()
		local dot = enemy_direction:Dot(forward)

		if dot > 0.5 then
			local knockbackProperties = {
				center_x = caster_pos.x,
				center_y = caster_pos.y,
				center_z = caster_pos.z,
				duration = duration,
				knockback_duration = duration,
				knockback_distance = distance,
				knockback_height = 35,
				should_stun = 1,
			}
			enemy:AddNewModifier(caster, self, "modifier_knockback", knockbackProperties)
			enemy:AddNewModifier(caster, self, "modifier_golden_dragon_solar_wind_burn", { duration = burn_duration })
		end
	end
end

--------------------------------------------------------------------------------

modifier_golden_dragon_solar_wind_burn = class({})

function modifier_golden_dragon_solar_wind_burn:IsPurgable()
	return true
end

function modifier_golden_dragon_solar_wind_burn:OnCreated()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1.0)
end

function modifier_golden_dragon_solar_wind_burn:OnIntervalThink()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end

	local damage = ability:GetSpecialValueFor("burn_damage") + ability:GetSpecialValueFor("diff_boost_damage")

	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = ability,
	})
end

function modifier_golden_dragon_solar_wind_burn:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_golden_dragon_solar_wind_burn:GetModifierMoveSpeedBonus_Percentage()
	if not self:GetAbility() then
		return 0
	end
	return -self:GetAbility():GetSpecialValueFor("slow_pct")
end

function modifier_golden_dragon_solar_wind_burn:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_golden_dragon_solar_wind_burn:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_golden_dragon_vacuum_dash_motion",
	"abilities/addition_bosses/golden_dragon",
	LUA_MODIFIER_MOTION_HORIZONTAL
)

golden_dragon_vacuum_dash = class({})

function golden_dragon_vacuum_dash:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function golden_dragon_vacuum_dash:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_dark_seer/dark_seer_vacuum.vpcf", context)
	PrecacheResource("particle", "particles/golden_dragon/golden_dragon_move.vpcf", context)
end

function golden_dragon_vacuum_dash:OnSpellStart()
	local caster = self:GetCaster()
	local cursor_position = self:GetCursorPosition()

	local radius = self:GetSpecialValueFor("radius")
	local pull_duration = self:GetSpecialValueFor("pull_duration")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dark_seer/dark_seer_vacuum.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, cursor_position)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(particle)

	local sound_cast = "Hero_DarkSeer.Vacuum"
	-- EmitSoundOnLocationWithCaster(cursor_position, sound_cast, caster)
	EmitSoundOn(sound_cast, caster)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		cursor_position,
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		local enemy_pos = enemy:GetAbsOrigin()
		local knockbackProperties = {
			center_x = cursor_position.x,
			center_y = cursor_position.y,
			center_z = cursor_position.z,
			duration = pull_duration,
			knockback_duration = pull_duration,
			knockback_distance = -(enemy_pos - cursor_position):Length2D(),
			knockback_height = 0,
			should_stun = 1,
		}
		enemy:AddNewModifier(caster, self, "modifier_knockback", knockbackProperties)
	end

	local direction = (cursor_position - caster:GetAbsOrigin()):Normalized()
	local target_pos = cursor_position + direction * 300

	caster:AddNewModifier(caster, self, "modifier_golden_dragon_vacuum_dash_motion", {
		x = target_pos.x,
		y = target_pos.y,
		z = target_pos.z,
	})
end

--------------------------------------------------------------------------------

modifier_golden_dragon_vacuum_dash_motion = class({})

function modifier_golden_dragon_vacuum_dash_motion:IsHidden()
	return true
end
function modifier_golden_dragon_vacuum_dash_motion:IsPurgable()
	return false
end

function modifier_golden_dragon_vacuum_dash_motion:OnCreated(kv)
	if not IsServer() then
		return
	end

	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.pos = Vector(kv.x, kv.y, kv.z)
	self.speed = 800
	self.width = 200

	local damage = self.ability:GetSpecialValueFor("damage")
	local boost = self.ability:GetSpecialValueFor("diff_boost_damage")
	self.total_damage = damage + boost

	self.hit_targets = {}

	EmitSoundOn("Hero_DragonKnight.BreathFire", self:GetCaster())

	self.effect_cast = ParticleManager:CreateParticle(
		"particles/golden_dragon/golden_dragon_move.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		0,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.parent:GetOrigin(),
		true
	)

	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end

function modifier_golden_dragon_vacuum_dash_motion:UpdateHorizontalMotion(me, dt)
	if not IsServer() then
		return
	end

	local my_pos = me:GetAbsOrigin()
	local distance_vec = self.pos - my_pos
	local distance = distance_vec:Length2D()
	local direction = distance_vec:Normalized()

	if distance < (self.speed * dt) then
		me:SetOrigin(self.pos)
		self:Destroy()
		return
	end

	local next_pos = my_pos + direction * self.speed * dt
	next_pos.z = GetGroundHeight(next_pos, me)

	me:SetOrigin(next_pos)
	me:FaceTowards(self.pos)

	ParticleManager:SetParticleControl(self.effect_cast, 1, direction * self.speed)

	local enemies = FindUnitsInRadius(
		me:GetTeamNumber(),
		next_pos,
		nil,
		self.width,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		if not self.hit_targets[enemy:GetEntityIndex()] then
			self.hit_targets[enemy:GetEntityIndex()] = true

			ApplyDamage({
				victim = enemy,
				attacker = me,
				damage = self.total_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self.ability,
			})
		end
	end
end

function modifier_golden_dragon_vacuum_dash_motion:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:RemoveHorizontalMotionController(self)

	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, false)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end

	FindClearSpaceForUnit(self.parent, self.parent:GetOrigin(), true)
end

function modifier_golden_dragon_vacuum_dash_motion:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_golden_dragon_vacuum_dash_motion:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_golden_dragon_vacuum_dash_motion:GetModifierModelChange()
	return "models/development/invisiblebox.vmdl"
end

function modifier_golden_dragon_vacuum_dash_motion:OnHorizontalMotionInterrupted()
	self:Destroy()
end