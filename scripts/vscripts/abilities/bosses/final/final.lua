--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_necro_firestorm", "abilities/bosses/final/final", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_necro_firestorm_thinker", "abilities/bosses/final/final", LUA_MODIFIER_MOTION_NONE)

boss_necro_firestorm = class({})

function boss_necro_firestorm:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf",
		context
	)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_abyssal_underlord.vsndevts", context)
end

function boss_necro_firestorm:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_necro_firestorm:OnSpellStart()
	CreateModifierThinker(
		self:GetCaster(),
		self,
		"modifier_boss_necro_firestorm_thinker",
		{},
		self:GetCaster():GetAbsOrigin(),
		self:GetCaster():GetTeamNumber(),
		false
	)
end

----------------------------------------------------------------

modifier_boss_necro_firestorm_thinker = class({})

function modifier_boss_necro_firestorm_thinker:IsHidden()
	return true
end

function modifier_boss_necro_firestorm_thinker:IsPurgable()
	return false
end

function modifier_boss_necro_firestorm_thinker:OnCreated(kv)
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.damage = self.ability:GetSpecialValueFor("wave_damage") + self.ability:GetSpecialValueFor("diff_boost_damage")
	self.radius = self.ability:GetSpecialValueFor("radius")
	self.count = self.ability:GetSpecialValueFor("wave_count")
	self.interval = self.ability:GetSpecialValueFor("wave_interval")
	self.burn_duration = self.ability:GetSpecialValueFor("burn_duration")
	self.burn_interval = self.ability:GetSpecialValueFor("burn_interval")
	self.burn_damage = self.ability:GetSpecialValueFor("burn_damage")
		+ self.ability:GetSpecialValueFor("diff_boost_additional")

	if not IsServer() then
		return
	end

	self.wave = 0
	self.damageTable = {
		attacker = self.caster,
		damage = self.damage,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability,
	}
	self:StartIntervalThink(0)
end

function modifier_boss_necro_firestorm_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	UTIL_Remove(self:GetParent())
end

function modifier_boss_necro_firestorm_thinker:OnIntervalThink()
	if not self.delayed then
		self.delayed = true
		self:StartIntervalThink(self.interval)
		self:OnIntervalThink()
		return
	end

	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.parent:GetOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)
		enemy:AddNewModifier(self.caster, self.ability, "modifier_boss_necro_firestorm", {
			duration = self.burn_duration,
			interval = self.burn_interval,
			damage = self.burn_damage,
		})
	end
	self:PlayEffects()
	self.wave = self.wave + 1
	if self.wave >= self.count then
		self:Destroy()
	end
end

function modifier_boss_necro_firestorm_thinker:PlayEffects()
	local particle_cast = "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.Firestorm"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 4, Vector(self.radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self.parent)
end

----------------------------------------------------------------

modifier_boss_necro_firestorm = class({})

function modifier_boss_necro_firestorm:IsHidden()
	return false
end

function modifier_boss_necro_firestorm:IsDebuff()
	return true
end

function modifier_boss_necro_firestorm:IsPurgable()
	return true
end

function modifier_boss_necro_firestorm:OnCreated(kv)
	if not IsServer() then
		return
	end
	local interval = kv.interval

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = kv.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	self:StartIntervalThink(interval)
end

function modifier_boss_necro_firestorm:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

function modifier_boss_necro_firestorm:GetEffectName()
	return "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf"
end

function modifier_boss_necro_firestorm:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

----------------------------------------------------------------
----------------------------------------------------------------

boss_necro_poison_raze = class({})

function boss_necro_poison_raze:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_necro_poison_raze:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context)
end

function boss_necro_poison_raze:OnSpellStart()
	for i = 1, RandomInt(9, 18) do
		local effect_name = "particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf"
		local info = {
			EffectName = effect_name,
			Ability = self,
			vSpawnOrigin = self:GetCaster():GetOrigin(),
			fStartRadius = 100,
			fEndRadius = 100,
			vVelocity = RandomVector(1) * 400,
			fDistance = 1500,
			Source = self:GetCaster(),
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO,
		}

		ProjectileManager:CreateLinearProjectile(info)
	end

	Timers:CreateTimer(2, function()
		EmitSoundOn("Conquest.PoisonTrap.Generic", self:GetCaster())
		for i = 1, RandomInt(9, 18) do
			local effect_name = "particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf"
			local info = {
				EffectName = effect_name,
				Ability = self,
				vSpawnOrigin = self:GetCaster():GetOrigin(),
				fStartRadius = 100,
				fEndRadius = 100,
				vVelocity = RandomVector(1) * 400,
				fDistance = 1500,
				Source = self:GetCaster(),
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetType = DOTA_UNIT_TARGET_HERO,
			}

			ProjectileManager:CreateLinearProjectile(info)
		end
	end)
	EmitSoundOn("Conquest.PoisonTrap.Generic", self:GetCaster())
end

function boss_necro_poison_raze:OnProjectileHit(hTarget, vLocation)
	if hTarget ~= nil and (not hTarget:IsMagicImmune()) and (not hTarget:IsInvulnerable()) then
		local damage = {
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage"),
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		}
		ApplyDamage(damage)
	end
	return false
end

----------------------------------------------------------------
----------------------------------------------------------------

LinkLuaModifier("modifier_boss_necro_spike", "abilities/bosses/final/final", LUA_MODIFIER_MOTION_VERTICAL)

boss_necro_spike = class({})

function boss_necro_spike:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_necro_spike:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/leshrac/leshrac_tormented_staff_retro/leshrac_split_retro_d_tormented.vpcf",
		context
	)
	PrecacheResource("particle", "particles/ui_mouseactions/range_display.vpcf", context)
end

function boss_necro_spike:OnSpellStart()
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_boss_necro_spike", { duration = duration })
end

----------------------------------------------------------------

modifier_boss_necro_spike = class({})

function modifier_boss_necro_spike:IsHidden()
	return false
end
function modifier_boss_necro_spike:IsPurgable()
	return false
end

function modifier_boss_necro_spike:OnCreated(kv)
	if not IsServer() then
		return
	end
	local interval = self:GetAbility():GetSpecialValueFor("interval")
	self:StartIntervalThink(interval)
end

-- function modifier_boss_necro_spike:CheckState()
--     return {
--         [MODIFIER_STATE_STUNNED] = true,
--         [MODIFIER_STATE_ATTACK_IMMUNE] = true,
--     }
-- end

-- function modifier_boss_necro_spike:DeclareFunctions()
--     return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
-- end

-- function modifier_boss_necro_spike:GetOverrideAnimation()
--     return ACT_DOTA_TELEPORT
-- end

function modifier_boss_necro_spike:OnIntervalThink()
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
			"particles/econ/items/leshrac/leshrac_tormented_staff_retro/leshrac_split_retro_d_tormented.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(particle_blast_fx, 0, target_pos)
		ParticleManager:SetParticleControl(particle_blast_fx, 1, Vector(damage_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle_blast_fx)

		local sound_cast = "Hero_Leshrac.Split_Earth"
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
				damage_type = ability:GetAbilityDamageType(),
				damage = damage,
			})
		end
	end)
end

----------------------------------------------------------------
----------------------------------------------------------------

LinkLuaModifier("modifier_boss_necro_blast", "abilities/bosses/final/final", LUA_MODIFIER_MOTION_NONE)

boss_necro_blast = class({})

function boss_necro_blast:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_pugna/pugna_netherblast_pre.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_pugna/pugna_netherblast.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_pugna.vsndevts", context)
end

function boss_necro_blast:GetIntrinsicModifierName()
	return "modifier_boss_necro_blast"
end

----------------------------------------------------------------------------------

modifier_boss_necro_blast = class({})

function modifier_boss_necro_blast:IsHidden()
	return true
end

function modifier_boss_necro_blast:OnCreated()
	self.interval = self:GetAbility():GetSpecialValueFor("interval")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end

	self:StartIntervalThink(self.interval)
end

function modifier_boss_necro_blast:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster_pos = self:GetCaster():GetAbsOrigin()
	if self:GetCaster():IsAlive() then
		self.interval = self:GetAbility():GetSpecialValueFor("interval")
			- (((100 - self:GetCaster():GetHealthPercent()) / 10) / 2.3)

		for i = 1, 4 do
			local angle = RandomInt(0, 360)
			local variance = RandomInt(-self.radius, self.radius)
			local dy = math.sin(angle) * variance
			local dx = math.cos(angle) * variance
			local target_point = Vector(caster_pos.x + dx, caster_pos.y + dy, caster_pos.z)
			local blast_delay = 1
			local damage = self:GetAbility():GetSpecialValueFor("damage")
				+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
			local main_blast_radius = 300
			local sound_cast = "Hero_Pugna.NetherBlastPreCast"
			-- EmitSoundOnLocationForAllies(self:GetCaster():GetAbsOrigin(), sound_cast, self:GetCaster())
			EmitSoundOn(sound_cast, self:GetCaster())

			local particle_pre_blast_fx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_pugna/pugna_netherblast_pre.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(particle_pre_blast_fx, 0, target_point)
			ParticleManager:SetParticleControl(particle_pre_blast_fx, 1, Vector(main_blast_radius, blast_delay, 1))
			ParticleManager:ReleaseParticleIndex(particle_pre_blast_fx)

			Timers:CreateTimer(blast_delay, function()
				local particle_blast_fx = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_pugna/pugna_netherblast.vpcf",
					PATTACH_ABSORIGIN,
					self:GetCaster()
				)
				ParticleManager:SetParticleControl(particle_blast_fx, 0, target_point)
				ParticleManager:SetParticleControl(particle_blast_fx, 1, Vector(main_blast_radius, 0, 0))
				ParticleManager:ReleaseParticleIndex(particle_blast_fx)

				EmitSoundOn("Hero_Pugna.NetherBlast", self:GetCaster())

				local enemies = FindUnitsInRadius(
					self:GetCaster():GetTeamNumber(),
					target_point,
					self:GetCaster(),
					main_blast_radius,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				for _, enemy in pairs(enemies) do
					local damageTable = {
						victim = enemy,
						damage = damage,
						damage_type = self:GetAbility():GetAbilityDamageType(),
						attacker = self:GetCaster(),
					}

					ApplyDamage(damageTable)
				end
			end)
		end
		self:StartIntervalThink(-1)
		self:StartIntervalThink(self.interval)
	end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_necro_glimps", "abilities/bosses/final/final", LUA_MODIFIER_MOTION_NONE)

boss_necro_glimps = class({})

function boss_necro_glimps:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_glimpse_travel.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_glimpse_targetend.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_glimpse_targetstart.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_disruptor.vsndevts", context)
end

function boss_necro_glimps:OnSpellStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_boss_necro_glimps", {})
end
----------------------------------------------------------------------------------

modifier_boss_necro_glimps = class({})

function modifier_boss_necro_glimps:IsHidden()
	return true
end

function modifier_boss_necro_glimps:OnCreated()
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
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, enemy in pairs(enemies) do
		local angle = RandomInt(0, 360)
		local variance = RandomInt(-1000, 1000)
		local dy = math.sin(angle) * variance
		local dx = math.cos(angle) * variance
		enemy.target_point = Vector(
			self:GetCaster():GetOrigin().x + dx,
			self:GetCaster():GetOrigin().y + dy,
			self:GetCaster():GetOrigin().z
		)
		self:BeginGlimpse(enemy, enemy.target_point)
		EmitSoundOn("Hero_Disruptor.Glimpse.Target", enemy)
	end
end

function modifier_boss_necro_glimps:BeginGlimpse(target, new_position)
	if IsServer() then
		if target and new_position then
			local vVelocity = (new_position - target:GetOrigin())
			vVelocity.z = 0.0

			local flDist = vVelocity:Length2D()
			vVelocity = vVelocity:Normalized()

			local flDuration = math.max(0.05, math.min(1.8, flDist / 600))
			local projectile = {
				Ability = self:GetAbility(),
				EffectName = "particles/units/heroes/hero_disruptor/disruptor_glimpse_travel.vpcf",
				vSpawnOrigin = target:GetOrigin(),
				fDistance = flDist,
				Source = self:GetCaster(),
				vVelocity = vVelocity * (flDist / flDuration),
				fStartRadius = 0,
				fEndRadius = 0,
				bProvidesVision = true,
				iVisionRadius = self.vision_radius,
				iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
			}

			ProjectileManager:CreateLinearProjectile(projectile)

			local nFXIndex = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_disruptor/disruptor_glimpse_travel.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlEnt(
				nFXIndex,
				0,
				target,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				target:GetOrigin(),
				true
			)
			ParticleManager:SetParticleControl(nFXIndex, 1, new_position)
			ParticleManager:SetParticleControl(nFXIndex, 2, Vector(flDuration, flDuration, flDuration))
			self:AddParticle(nFXIndex, false, false, -1, false, false)

			local nFXIndex2 = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_disruptor/disruptor_glimpse_targetend.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlEnt(
				nFXIndex2,
				0,
				target,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				target:GetOrigin(),
				true
			)
			ParticleManager:SetParticleControl(nFXIndex2, 1, new_position)
			ParticleManager:SetParticleControl(nFXIndex2, 2, Vector(flDuration, flDuration, flDuration))
			self:AddParticle(nFXIndex2, false, false, -1, false, false)

			local nFXIndex3 = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_disruptor/disruptor_glimpse_targetstart.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlEnt(
				nFXIndex3,
				0,
				target,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				target:GetOrigin(),
				true
			)
			ParticleManager:SetParticleControl(nFXIndex3, 2, Vector(flDuration, flDuration, flDuration))
			self:AddParticle(nFXIndex3, false, false, -1, false, false)

			local sound_cast = "Hero_Disruptor.GlimpseNB2017.Destination"
			-- EmitSoundOnLocationForAllies( new_position, sound_cast, self:GetCaster() )
			EmitSoundOn(sound_cast, self:GetCaster())

			self.time_glimps = flDuration

			Timers:CreateTimer(self.time_glimps, function()
				self:EndGlimpse(target, new_position)
			end)
		end
	end
end

function modifier_boss_necro_glimps:EndGlimpse(target, new_position)
	if target and not target:IsMagicImmune() then
		FindClearSpaceForUnit(target, new_position, true)
		target:Interrupt()
		self:Destroy()
	end
end

----------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_necro_passive", "abilities/bosses/final/final", LUA_MODIFIER_MOTION_NONE)

boss_necro_passive = class({})

function boss_necro_passive:GetIntrinsicModifierName()
	return "modifier_boss_necro_passive"
end

function boss_necro_passive:Precache(context)
	PrecacheResource("particle", "particles/nyx_phisical.vpcf", context)
	PrecacheResource("particle", "particles/nyx_magical.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_necrolyte.vsndevts", context)
end

----------------------------------------------------------------------------------

modifier_boss_necro_passive = class({})

function modifier_boss_necro_passive:IsHidden()
	return false
end
function modifier_boss_necro_passive:IsPurgable()
	return false
end

function modifier_boss_necro_passive:OnCreated()
	self.interval = self:GetAbility():GetSpecialValueFor("interval")
	if not IsServer() then
		return
	end

	self.is_magical_immune = true
	self:SetStackCount(1)

	self:StartIntervalThink(self.interval)
end

function modifier_boss_necro_passive:OnIntervalThink()
	self.is_magical_immune = not self.is_magical_immune
	self:SetStackCount(self.is_magical_immune and 1 or 0)
	self:GetParent():EmitSound("Hero_Necrolyte.SpiritForm.Cast")
	self:UpdateEffects()
end

function modifier_boss_necro_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_boss_necro_passive:GetAbsoluteNoDamageMagical()
	return self:GetStackCount() == 1 and 1 or 0
end

function modifier_boss_necro_passive:GetAbsoluteNoDamagePhysical()
	return self:GetStackCount() == 0 and 1 or 0
end

function modifier_boss_necro_passive:OnTooltip()
	return self.interval
end

----------------------------------------------------------------------------------

function modifier_boss_necro_passive:UpdateEffects()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
	local particle_name = self.is_magical_immune and "particles/nyx_magical.vpcf" or "particles/nyx_phisical.vpcf"

	self.pfx = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.pfx, 1, Vector(150, 150, 150))
end

function modifier_boss_necro_passive:OnDestroy()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

LinkLuaModifier("modifier_necro_boss_necro_spawn_lua", "abilities/bosses/final/final", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necro_boss_necro_spawn_lua_effect", "abilities/bosses/final/final", LUA_MODIFIER_MOTION_NONE)

spawn_list = {
	"necrolyte_npc_dota_boss_ursa",
	"necrolyte_npc_dota_boss_undying",
	"necrolyte_npc_dota_boss_lich",
	"necrolyte_npc_dota_boss_tiny",
	"necrolyte_npc_dota_boss_nyx_1",
	"necrolyte_npc_dota_boss_slardar",
	"necrolyte_npc_dota_boss_bristleback",
	"necrolyte_npc_dota_boss_furion",
	"necrolyte_npc_dota_boss_doom",
	"necrolyte_npc_dota_boss_medusa",
	"necrolyte_npc_dota_boss_arc_warden",
}

spawn_index = 1

_G.spawn_count = 1

boss_necro_spawn_lua = class({})

function boss_necro_spawn_lua:OnSpellStart()
	local position = Entities:FindByName(nil, "necrotarget4"):GetAbsOrigin()
	local index = spawn_index
	local caster = self:GetCaster()

	if spawn_index < 12 then
		spawn_index = spawn_index + 1
	end

	local spawn_count = _G.spawn_count

	for i = 1, spawn_count do
		local angle = RandomInt(0, 360)
		local variance = RandomInt(-1200, 1200)
		local dy = math.sin(angle) * variance
		local dx = math.cos(angle) * variance
		local target_pos = Vector(position.x + dx, position.y + dy, position.z)
		local dummy = CreateUnitByName("npc_dummy_unit", target_pos, false, caster, caster, caster:GetTeamNumber())
		dummy:AddNewModifier(dummy, nil, "modifier_dummy", {})
		dummy:AddNewModifier(dummy, nil, "modifier_kill", { duration = 2 })
		dummy:AddNewModifier(dummy, self, "modifier_necro_boss_necro_spawn_lua", { duration = 2 })

		Timers:CreateTimer({
			useGameTime = false,
			endTime = 1.9,
			callback = function()
				SpawnUnit(dummy, index)
			end,
		})
	end

	if spawn_index == 12 then
		spawn_index = 1
		_G.spawn_count = _G.spawn_count + 1
	end
end

function SpawnUnit(dummy, index)
	if not IsServer() then
		return
	end
	local unit = CreateUnitByName(spawn_list[index], dummy:GetOrigin(), false, nil, nil, dummy:GetTeamNumber())
	unit:AddNewModifier(unit, nil, "modifier_necro_boss_necro_spawn_lua_effect", {})
	rules:aura_dif(unit, random_ability)
	if isNewYearNow() then
		unit:SetupHat(HAT_TYPE.NEW_YEAR)
	end
end

------------------------------------------------

modifier_necro_boss_necro_spawn_lua = class({})

function modifier_necro_boss_necro_spawn_lua:IsHidden()
	return true
end
function modifier_necro_boss_necro_spawn_lua:IsPurgable()
	return false
end

function modifier_necro_boss_necro_spawn_lua:OnCreated()
	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_necro_boss_necro_spawn_lua:OnDestroy()
	ParticleManager:DestroyParticle(self.effect_cast, true)
	StopSoundOn("Hero_AbyssalUnderlord.DarkRift.Cast", self:GetParent())
	StopSoundOn("Hero_AbyssalUnderlord.DarkRift.Target", self:GetParent())
	EmitSoundOn("Hero_AbyssalUnderlord.DarkRift.Cancel", self:GetParent())
end

function modifier_necro_boss_necro_spawn_lua:PlayEffects1()
	local parent = self:GetParent()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/heroes_underlord/abyssal_underlord_darkrift_target.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		6,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
	EmitSoundOn("Hero_AbyssalUnderlord.DarkRift.Target", parent)
end

function modifier_necro_boss_necro_spawn_lua:PlayEffects2()
	local caster = self:GetCaster()
	local parent = self:GetParent()
	self.effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/heroes_underlord/abbysal_underlord_darkrift_ambient.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 0, 0))
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		2,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn("Hero_AbyssalUnderlord.DarkRift.Cast", caster)
end

---------------------------------
modifier_necro_boss_necro_spawn_lua_effect = class({})

function modifier_necro_boss_necro_spawn_lua_effect:IsHidden()
	return true
end
function modifier_necro_boss_necro_spawn_lua_effect:IsPurgable()
	return false
end

function modifier_necro_boss_necro_spawn_lua_effect:GetStatusEffectName()
	return "particles/status_fx/status_effect_wraithking_ghosts.vpcf"
end