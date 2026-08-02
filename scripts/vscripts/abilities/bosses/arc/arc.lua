--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_arc_flux", "abilities/bosses/arc/arc", LUA_MODIFIER_MOTION_NONE)

boss_arc_flux = class({})

function boss_arc_flux:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf", context)
end

function boss_arc_flux:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_arc_flux:OnSpellStart()
	if not IsServer() then
		return
	end
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		nil,
		1000,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)
	if #enemies > 0 then
		for _, enemy in pairs(enemies) do
			if not enemy:TriggerSpellAbsorb(self) then
				self:GetCaster():EmitSound("Hero_ArcWarden.Flux.Cast")
				enemy:EmitSound("Hero_ArcWarden.Flux.Target")
				local cast_particle = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_arc_warden/arc_warden_flux_cast.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self:GetCaster()
				)
				ParticleManager:SetParticleControlEnt(
					cast_particle,
					0,
					self:GetCaster(),
					PATTACH_POINT_FOLLOW,
					"attach_attack1",
					self:GetCaster():GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(
					cast_particle,
					1,
					enemy,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					enemy:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(
					cast_particle,
					2,
					self:GetCaster(),
					PATTACH_POINT_FOLLOW,
					"attach_attack2",
					self:GetCaster():GetAbsOrigin(),
					true
				)
				enemy:AddNewModifier(
					self:GetCaster(),
					self,
					"modifier_boss_arc_flux",
					{ duration = self:GetSpecialValueFor("duration") }
				)
			end
		end
	end
end

--------------------------------------------------------------------------

modifier_boss_arc_flux = class({})

function modifier_boss_arc_flux:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_boss_arc_flux:IgnoreTenacity()
	return true
end

function modifier_boss_arc_flux:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
	self.move_speed_slow_pct = self:GetAbility():GetSpecialValueFor("move_speed_slow_pct")

	if not IsServer() then
		return
	end

	self.damage_per_interval = self.damage_per_second * self.think_interval
	self.damage_type = self:GetAbility():GetAbilityDamageType()

	self.flux_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		self.flux_particle,
		2,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:AddParticle(self.flux_particle, false, false, -1, false, false)

	self:OnIntervalThink()
	self:StartIntervalThink(self.think_interval)
end

function modifier_boss_arc_flux:OnIntervalThink()
	ParticleManager:SetParticleControl(self.flux_particle, 4, Vector(1, 0, 0))

	ApplyDamage({
		victim = self:GetParent(),
		damage = self.damage_per_interval,
		damage_type = self.damage_type,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self:GetAbility(),
	})
end

function modifier_boss_arc_flux:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_boss_arc_flux:GetModifierMoveSpeedBonus_Percentage()
	return -self.move_speed_slow_pct
end

--------------------------------------------------------------------------
--------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_boss_arc_magnetic_field_thinker_evasion",
	"abilities/bosses/arc/arc",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_boss_arc_magnetic_field_evasion", "abilities/bosses/arc/arc", LUA_MODIFIER_MOTION_NONE)

boss_arc_magnetic_field = class({})

function boss_arc_magnetic_field:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_magnetic_cast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf", context)
end

function boss_arc_magnetic_field:OnSpellStart()
	self:GetCaster():EmitSound("Hero_ArcWarden.MagneticField.Cast")

	local cast_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_arc_warden/arc_warden_magnetic_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		cast_particle,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetCaster():GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(cast_particle)

	CreateModifierThinker(self:GetCaster(), self, "modifier_boss_arc_magnetic_field_thinker_evasion", {
		duration = self:GetSpecialValueFor("duration"),
	}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
end

--------------------------------------------------------------------------

modifier_boss_arc_magnetic_field_thinker_evasion = class({})

function modifier_boss_arc_magnetic_field_thinker_evasion:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	self.magnetic_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.magnetic_particle, 1, Vector(self.radius, 1, 1))
	self:AddParticle(self.magnetic_particle, false, false, 1, false, false)
end

function modifier_boss_arc_magnetic_field_thinker_evasion:IsAura()
	return true
end
function modifier_boss_arc_magnetic_field_thinker_evasion:IsAuraActiveOnDeath()
	return false
end
function modifier_boss_arc_magnetic_field_thinker_evasion:GetAuraDuration()
	return 0.1
end
function modifier_boss_arc_magnetic_field_thinker_evasion:GetAuraRadius()
	return self.radius
end
function modifier_boss_arc_magnetic_field_thinker_evasion:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_boss_arc_magnetic_field_thinker_evasion:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_boss_arc_magnetic_field_thinker_evasion:GetAuraSearchType()
	return DOTA_UNIT_TARGET_ALL
end
function modifier_boss_arc_magnetic_field_thinker_evasion:GetModifierAura()
	return "modifier_boss_arc_magnetic_field_evasion"
end

-------------------------------------------------------------------------------------

modifier_boss_arc_magnetic_field_evasion = class({})

function modifier_boss_arc_magnetic_field_evasion:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_boss_arc_magnetic_field_evasion:DeclareFunctions()
	return { MODIFIER_PROPERTY_EVASION_CONSTANT }
end

function modifier_boss_arc_magnetic_field_evasion:GetModifierEvasion_Constant(keys)
	if
		keys.attacker
		and self:GetAuraOwner()
		and self:GetAuraOwner():HasModifier("modifier_boss_arc_magnetic_field_thinker_evasion")
		and self:GetAuraOwner():FindModifierByName("modifier_boss_arc_magnetic_field_thinker_evasion").radius
		and (keys.attacker:GetAbsOrigin() - self:GetAuraOwner():GetAbsOrigin()):Length2D()
			> self:GetAuraOwner():FindModifierByName("modifier_boss_arc_magnetic_field_thinker_evasion").radius
	then
		return 100
	end
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_arc_spark_wraith_thinker", "abilities/bosses/arc/arc", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_arc_spark_wraith_purge", "abilities/bosses/arc/arc", LUA_MODIFIER_MOTION_NONE)

boss_arc_spark_wraith = class({})

function boss_arc_spark_wraith:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_wraith_prj.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_prj_burst.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_wraith.vpcf", context)
end

function boss_arc_spark_wraith:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_arc_spark_wraith:OnSpellStart()
	self:GetCaster():EmitSound("Hero_ArcWarden.SparkWraith.Cast")
	for i = 1, self:GetSpecialValueFor("count") do
		local point = self:GetCaster():GetAbsOrigin()
			+ RandomVector(RandomInt(RandomInt(500, 500), RandomInt(500, 500)))
		local sound_cast = "Hero_ArcWarden.SparkWraith.Appear"
		-- EmitSoundOnLocationWithCaster(point, sound_cast, self:GetCaster())
		EmitSoundOn(sound_cast, self:GetCaster())

		CreateModifierThinker(self:GetCaster(), self, "modifier_boss_arc_spark_wraith_thinker", {
			duration = self:GetSpecialValueFor("duration"),
		}, point, self:GetCaster():GetTeamNumber(), false)
	end
end

function boss_arc_spark_wraith:OnProjectileHit_ExtraData(target, location, ExtraData)
	if target then
		if not target:IsMagicImmune() then
			target:EmitSound("Hero_ArcWarden.SparkWraith.Damage")

			if ExtraData.auto_cast == 1 then
				local burst_particle = ParticleManager:CreateParticle(
					"particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_prj_burst.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					target
				)
				ParticleManager:ReleaseParticleIndex(burst_particle)
			end

			ApplyDamage({
				victim = target,
				damage = ExtraData.spark_damage,
				damage_type = self:GetAbilityDamageType(),
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				attacker = self:GetCaster(),
				ability = self,
			})

			target:AddNewModifier(
				self:GetCaster(),
				self,
				"modifier_boss_arc_spark_wraith_purge",
				{ duration = self:GetSpecialValueFor("tick") * (1 - target:GetStatusResistance()) }
			)
		end
		return true
	end
end

-------------------------------------------------------------------------------------

modifier_boss_arc_spark_wraith_thinker = class({})

function modifier_boss_arc_spark_wraith_thinker:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.activation_delay = self:GetAbility():GetSpecialValueFor("activation_delay")
	self.wraith_speed = self:GetAbility():GetSpecialValueFor("wraith_speed")
	self.spark_damage = self:GetAbility():GetSpecialValueFor("spark_damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.think_interval = self:GetAbility():GetSpecialValueFor("tick")

	if not IsServer() then
		return
	end

	self:GetParent():EmitSound("Hero_ArcWarden.SparkWraith.Loop")

	self.wraith_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_arc_warden/arc_warden_wraith.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.wraith_particle, 1, Vector(self.radius, 1, 1))
	self:AddParticle(self.wraith_particle, false, false, -1, false, false)

	self:GetCaster():SetContextThink(DoUniqueString(self:GetName()), function()
		self:StartIntervalThink(self.think_interval)
		return nil
	end, self.activation_delay - self.think_interval)
end

function modifier_boss_arc_spark_wraith_thinker:OnIntervalThink()
	for _, enemy in
		pairs(
			FindUnitsInRadius(
				self:GetCaster():GetTeamNumber(),
				self:GetParent():GetAbsOrigin(),
				self:GetParent(),
				self.radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_CLOSEST,
				false
			)
		)
	do
		self:GetParent():EmitSound("Hero_ArcWarden.SparkWraith.Activate")

		ProjectileManager:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_arc_warden/arc_warden_wraith_prj.vpcf",
			Ability = self:GetAbility(),
			Source = self:GetParent(),
			vSourceLoc = self:GetParent():GetAbsOrigin(),
			Target = enemy,
			iMoveSpeed = self.wraith_speed,
			flExpireTime = nil,
			bDodgeable = false,
			bIsAttack = false,
			bReplaceExisting = false,
			iSourceAttachment = nil,
			bDrawsOnMinimap = nil,
			ExtraData = {
				spark_damage = self.spark_damage,
				thinker_time = self:GetElapsedTime(),
				thinker_duration = self:GetDuration(),
			},
		})

		self:Destroy()
		break
	end
end

function modifier_boss_arc_spark_wraith_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():StopSound("Hero_ArcWarden.SparkWraith.Loop")
end

-------------------------------------------------------------------------------------

modifier_boss_arc_spark_wraith_purge = class({})

function modifier_boss_arc_spark_wraith_purge:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.move_speed_slow_pct = self:GetAbility():GetSpecialValueFor("move_speed_slow_pct")
end

function modifier_boss_arc_spark_wraith_purge:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_boss_arc_spark_wraith_purge:GetModifierMoveSpeedBonus_Percentage()
	return -self.move_speed_slow_pct
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_arc_hide_lua", "abilities/bosses/arc/arc", LUA_MODIFIER_MOTION_NONE)

boss_arc_hide_lua = class({})

function boss_arc_hide_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_arc_hide_lua:Precache(context)
	PrecacheResource("particle", "particles/heroes/nue/ability_nue_04_light_ufo.vpcf", context)
	PrecacheResource("particle", "particles/ui_mouseactions/range_display.vpcf", context)
	PrecacheResource("particle", "particles/heroes/nue/ability_nue_04.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_arc_warden.vsndevts", context)
end

function boss_arc_hide_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local delay_before_jump = 1.0

	local effectIndex =
		ParticleManager:CreateParticle("particles/heroes/nue/ability_nue_04_light_ufo.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(effectIndex, 0, caster:GetAbsOrigin())

	caster:EmitSound("Hero_ArcWarden.Flux.Cast")
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.0)

	caster:SetContextThink(DoUniqueString("HideStart"), function()
		ParticleManager:DestroyParticle(effectIndex, true)
		ParticleManager:ReleaseParticleIndex(effectIndex)

		self:JumpToTarget()
		return nil
	end, delay_before_jump)
end

function boss_arc_hide_lua:JumpToTarget()
	local caster = self:GetCaster()
	local search_radius = 1200
	local impact_radius = self:GetSpecialValueFor("radius")
	local stun_duration = self:GetSpecialValueFor("duration")
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	local jump_delay = 1.5

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		search_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_CLOSEST,
		false
	)

	local targetPoint = #enemies > 0 and enemies[RandomInt(1, #enemies)]:GetAbsOrigin() or caster:GetAbsOrigin()

	local ufoMoveIndex =
		ParticleManager:CreateParticle("particles/ui_mouseactions/range_display.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(ufoMoveIndex, 0, targetPoint)
	ParticleManager:SetParticleControl(ufoMoveIndex, 1, Vector(impact_radius, 0, 0))
	ParticleManager:SetParticleControl(ufoMoveIndex, 2, Vector(jump_delay, 0, 0))
	ParticleManager:SetParticleControl(ufoMoveIndex, 3, Vector(255, 0, 0))

	caster:AddNewModifier(caster, self, "modifier_boss_arc_hide_lua", { duration = jump_delay })

	local elapsed = 0
	caster:SetContextThink(DoUniqueString("MoveUfo"), function()
		if elapsed >= jump_delay then
			ParticleManager:DestroyParticle(ufoMoveIndex, true)
			ParticleManager:ReleaseParticleIndex(ufoMoveIndex)
			return nil
		end

		elapsed = elapsed + 0.05

		ParticleManager:SetParticleControl(ufoMoveIndex, 0, targetPoint)
		ParticleManager:SetParticleControl(ufoMoveIndex, 1, Vector(impact_radius, 0, 0))
		ParticleManager:SetParticleControl(ufoMoveIndex, 2, Vector(jump_delay, 0, 0))
		ParticleManager:SetParticleControl(ufoMoveIndex, 3, Vector(255, 0, 0))

		return 0.05
	end, 0.05)

	caster:SetContextThink(DoUniqueString("Impact"), function()
		FindClearSpaceForUnit(caster, targetPoint, true)

		local expFX =
			ParticleManager:CreateParticle("particles/heroes/nue/ability_nue_04.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(expFX, 0, targetPoint)
		ParticleManager:SetParticleControl(expFX, 2, Vector(147, 112, 219))
		ParticleManager:ReleaseParticleIndex(expFX)

		caster:EmitSound("Hero_ArcWarden.SparkWraith.Damage")

		local targets = FindUnitsInRadius(
			caster:GetTeamNumber(),
			targetPoint,
			nil,
			impact_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(targets) do
			ApplyDamage({
				victim = enemy,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			})
			enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = stun_duration })
		end

		caster:StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
		return nil
	end, jump_delay)
end

-------------------------------------------------------------------------------------

modifier_boss_arc_hide_lua = class({})

function modifier_boss_arc_hide_lua:IsHidden()
	return true
end
function modifier_boss_arc_hide_lua:IsPurgable()
	return false
end
function modifier_boss_arc_hide_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_boss_arc_hide_lua:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end

function modifier_boss_arc_hide_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_boss_arc_hide_lua:GetModifierModelChange()
	return "models/development/invisiblebox.vmdl"
end

function modifier_boss_arc_hide_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_arc_clone_passive", "abilities/bosses/arc/arc", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_arc_clone_immortal", "abilities/bosses/arc/arc", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_arc_clone_target_logic", "abilities/bosses/arc/arc", LUA_MODIFIER_MOTION_NONE)

boss_arc_clone = class({})

function boss_arc_clone:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_tempest_cast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_arc_warden/arc_warden_tempest_death.vpcf", context)
end

function boss_arc_clone:GetIntrinsicModifierName()
	return "modifier_boss_arc_clone_passive"
end

--------------------------------------------------------------------------------

modifier_boss_arc_clone_passive = class({})

function modifier_boss_arc_clone_passive:IsHidden()
	return true
end

function modifier_boss_arc_clone_passive:DeclareFunctions()
	return { MODIFIER_EVENT_ON_TAKEDAMAGE }
end

function modifier_boss_arc_clone_passive:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if self.triggered then
		return
	end

	local parent = self:GetParent()
	local threshold = self:GetAbility():GetSpecialValueFor("hp_threshold")

	if parent:GetHealthPercent() <= threshold then
		self.triggered = true
		self:SpawnClone()
	end
end

function modifier_boss_arc_clone_passive:SpawnClone()
	local caster = self:GetCaster()

	caster:EmitSound("Hero_ArcWarden.TempestDouble")
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_arc_warden/arc_warden_tempest_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(pfx)

	local clone = CreateUnitByName(
		"npc_dota_boss_arc_warden_clone",
		caster:GetAbsOrigin() + RandomVector(200),
		true,
		caster,
		caster:GetOwner(),
		caster:GetTeamNumber()
	)
	clone:AddNewModifier(clone, nil, "modifier_difficult", {}):SetStackCount(_G.Game_Difficulty)
	clone:SetRenderColor(150, 150, 255)
	clone:AddNewModifier(caster, self:GetAbility(), "modifier_boss_arc_clone_target_logic", {})
	local mod = caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_arc_clone_immortal", {})
	if mod then
		mod.clone = clone
	end
end

--------------------------------------------------------------------------------

modifier_boss_arc_clone_target_logic = class({})

function modifier_boss_arc_clone_target_logic:IsHidden()
	return true
end

function modifier_boss_arc_clone_target_logic:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_boss_arc_clone_target_logic:GetMinHealth()
	return 1
end

function modifier_boss_arc_clone_target_logic:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end

	if params.unit:GetHealth() <= 1 then
		local pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_arc_warden/arc_warden_tempest_death.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			params.unit
		)
		ParticleManager:ReleaseParticleIndex(pfx)
		params.unit:EmitSound("Hero_ArcWarden.TempestDouble.End")

		params.unit:ForceKill(false)
		params.unit:AddNoDraw()
		UTIL_Remove(params.unit)
	end
end

--------------------------------------------------------------------------------

modifier_boss_arc_clone_immortal = class({})

function modifier_boss_arc_clone_immortal:IsHidden()
	return false
end
function modifier_boss_arc_clone_immortal:GetTexture()
	return "arc_warden_tempest_double"
end

function modifier_boss_arc_clone_immortal:DeclareFunctions()
	return { MODIFIER_PROPERTY_MIN_HEALTH }
end

function modifier_boss_arc_clone_immortal:GetMinHealth()
	if self.clone and not self.clone:IsNull() and self.clone:IsAlive() then
		return 1
	else
		if IsServer() then
			self:Destroy()
		end
		return 0
	end
end

function modifier_boss_arc_clone_immortal:GetEffectName()
	return "particles/items_fx/abyssal_blade_buff.vpcf"
end