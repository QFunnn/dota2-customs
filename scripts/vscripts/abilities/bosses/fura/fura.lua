--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_furion_custom_forest", "abilities/bosses/fura/fura", LUA_MODIFIER_MOTION_NONE)

boss_furion_custom_forest = class({})

function boss_furion_custom_forest:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_furion_custom_forest:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/treant_protector/treant_ti10_immortal_head/treant_ti10_immortal_overgrowth_cast.vpcf",
		context
	)
	PrecacheResource("particle", "particles/ui_mouseactions/range_display.vpcf", context)
end

function boss_furion_custom_forest:OnSpellStart()
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster()
		:AddNewModifier(self:GetCaster(), self, "modifier_boss_furion_custom_forest", { duration = duration })
end

--------------------------------------------------------------------------

modifier_boss_furion_custom_forest = class({})

function modifier_boss_furion_custom_forest:IsHidden()
	return true
end

function modifier_boss_furion_custom_forest:IsPurgable()
	return false
end

function modifier_boss_furion_custom_forest:OnCreated(kv)
	local tick = self:GetAbility():GetSpecialValueFor("tick")
	self:StartIntervalThink(tick)
end

function modifier_boss_furion_custom_forest:OnIntervalThink()
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

		local particleIndex = ParticleManager:CreateParticle(
			"particles/econ/items/treant_protector/treant_ti10_immortal_head/treant_ti10_immortal_overgrowth_cast.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(particleIndex, 0, target_pos)
		ParticleManager:SetParticleControl(particleIndex, 1, Vector(damage_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particleIndex)

		EmitSoundOn("Hero_Leshrac.Split_Earth", ability)

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

require("data")

boss_furion_custom_sprout = class({})

local creeps = {
	"npc_dota_zone_8_unit_5",
	"npc_dota_zone_8_unit_3",
	"npc_dota_zone_8_unit_4",
	"npc_dota_zone_8_unit_2",
	"npc_dota_zone_8_unit_6",
}

function boss_furion_custom_sprout:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_furion/furion_sprout.vpcf", context)
end

function boss_furion_custom_sprout:OnSpellStart()
	if not IsServer() then
		return
	end
	self.duration = self:GetSpecialValueFor("duration")
	self.radius = self:GetSpecialValueFor("radius")
	EmitSoundOn("Hero_Furion.Sprout", self:GetCaster())

	local nFXIndex = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_furion/furion_sprout.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(nFXIndex, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(nFXIndex, 1, Vector(0.0, self.radius, 0.0))
	ParticleManager:ReleaseParticleIndex(nFXIndex)

	local random_ability = passive[RandomInt(1, #passive)]
	local line_pos = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * self.radius
	local rotation_rate = 360 / 20

	for i = 1, 20 do
		line_pos = RotatePosition(self:GetCaster():GetAbsOrigin(), QAngle(0, rotation_rate, 0), line_pos)
		CreateTempTree(line_pos, self.duration)
		if i % 5 == 0 then
			local unit = CreateUnitByName(creeps[math.random(#creeps)], line_pos, true, nil, nil, DOTA_TEAM_NEUTRALS)
			unit:SetMaximumGoldBounty(0)
			unit:SetMinimumGoldBounty(0)
			unit:SetDeathXP(0)
			rules:aura_dif(unit, random_ability)
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_furion_wrath_of_nature_thinker_lua", "abilities/bosses/fura/fura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_seed", "abilities/bosses/fura/fura", LUA_MODIFIER_MOTION_NONE)

boss_furion_custom_wrath = class({})

function boss_furion_custom_wrath:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_furion/furion_wrath_of_nature.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_furion/furion_wrath_of_nature_start.vpcf", context)
end

function boss_furion_custom_wrath:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_furion_custom_wrath:OnSpellStart()
	self.hTarget = self:GetCursorTarget()
	self.vTargetPos = self:GetCursorPosition()
	EmitSoundOn("Hero_Furion.WrathOfNature_Cast", self:GetCaster())
	CreateModifierThinker(
		self:GetCaster(),
		self,
		"modifier_furion_wrath_of_nature_thinker_lua",
		kv,
		self.vTargetPos,
		self:GetCaster():GetTeamNumber(),
		false
	)
end

--------------------------------------------------------------------------------

modifier_furion_wrath_of_nature_thinker_lua = class({})

function modifier_furion_wrath_of_nature_thinker_lua:IsHidden()
	return true
end

function modifier_furion_wrath_of_nature_thinker_lua:OnCreated(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.max_targets = 6
	self.jump_delay = 1

	if IsServer() then
		self.hTarget = self:GetAbility().hTarget
		if self.hTarget ~= nil and self.hTarget:TriggerSpellAbsorb(self) then
			self:Destroy()
			return
		end

		if self.hTarget == nil then
			local vPos = self:GetParent():GetOrigin()

			local nFXIndexStart = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_furion/furion_wrath_of_nature_start.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(nFXIndexStart, 0, self:GetParent():GetOrigin())
			ParticleManager:ReleaseParticleIndex(nFXIndexStart)

			self.hTarget = self:GetNextTarget()
			if self.hTarget == nil then
				Msg("Couldn't find target")
				self:Destroy()
				return
			end
		end

		self.flLastTickTime = GameRules:GetGameTime()
		self.flTimeAccumlator = 0.0
		self.hTargetsHit = {}
		self:StartIntervalThink(0.0)

		self:CreateBounceFX(self.hTarget)
		self:GetParent():SetOrigin(self.hTarget:GetOrigin())
		self:HitTarget(self.hTarget)
	end
end

function modifier_furion_wrath_of_nature_thinker_lua:OnDestroy()
	if IsServer() then
		UTIL_Remove(self:GetParent())
	end
end

function modifier_furion_wrath_of_nature_thinker_lua:OnIntervalThink()
	if IsServer() then
		local flCurTime = GameRules:GetGameTime()
		local dt = flCurTime - self.flLastTickTime
		self.flLastTickTime = flCurTime
		self.flTimeAccumlator = self.flTimeAccumlator + dt

		if self.flTimeAccumlator < self.jump_delay then
			return
		end

		self.flTimeAccumlator = self.flTimeAccumlator - self.jump_delay

		local hNewTarget = self:GetNextTarget()
		if hNewTarget == nil then
			self:Destroy()
			return
		end

		self:CreateBounceFX(hNewTarget)
		self:GetParent():SetOrigin(hNewTarget:GetOrigin())
		self:HitTarget(hNewTarget)

		local nMaxTargets = self.max_targets

		if #self.hTargetsHit >= nMaxTargets then
			self:Destroy()
		end
	end
end

function modifier_furion_wrath_of_nature_thinker_lua:GetNextTarget()
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetOrigin(),
		self:GetCaster(),
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)

	local hClosestTarget = nil
	local flClosestDist = 0.0
	if #enemies > 0 then
		for _, enemy in pairs(enemies) do
			if enemy ~= nil and self:GetCaster():CanEntityBeSeenByMyTeam(enemy) then
				local bHitByWrath = false

				if self.hTargetsHit ~= nil then
					for _, hHitEnemy in ipairs(self.hTargetsHit) do
						if enemy == hHitEnemy then
							bHitByWrath = true
						end
					end
				end

				if bHitByWrath == false then
					local vToTarget = enemy:GetOrigin() - self:GetParent():GetOrigin()
					local flDistToTarget = vToTarget:Length()

					if hClosestTarget == nil or flDistToTarget < flClosestDist then
						hClosestTarget = enemy
						flClosestDist = flDistToTarget
					end
				end
			end
		end
	end

	return hClosestTarget
end

function modifier_furion_wrath_of_nature_thinker_lua:HitTarget(hTarget)
	if hTarget == nil then
		return
	end

	local nTargetsHit = 0
	if self.hTargetsHit ~= nil then
		nTargetsHit = #self.hTargetsHit
	end

	local flDamage = self.damage

	local damage = {
		victim = hTarget,
		attacker = self:GetCaster(),
		damage = flDamage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	}
	ApplyDamage(damage)

	hTarget:AddNewModifier(
		self:GetCaster(),
		self:GetAbility(),
		"modifier_custom_seed",
		{ duration = self:GetAbility():GetSpecialValueFor("duration") - FrameTime() }
	)
	hTarget:AddNewModifier(
		self:GetCaster(),
		self:GetAbility(),
		"modifier_silence",
		{ duration = self:GetAbility():GetSpecialValueFor("duration") - FrameTime() }
	)

	if hTarget:IsHero() then
		EmitSoundOn("Hero_Furion.WrathOfNature_Damage", hTarget)
	else
		EmitSoundOn("Hero_Furion.WrathOfNature_Damage.Creep", hTarget)
	end

	table.insert(self.hTargetsHit, hTarget)
end

function modifier_furion_wrath_of_nature_thinker_lua:CreateBounceFX(hTarget)
	local vTarget1 = self:GetParent():GetOrigin()

	local vTarget2 = hTarget:GetOrigin() - vTarget1
	local flDistance = math.min(vTarget2:Length() / 2, 256.0)
	vTarget2 = vTarget2:Normalized() * flDistance

	local vTarget3 = vTarget1 - hTarget:GetOrigin()
	vTarget3 = vTarget3:Normalized() * flDistance

	vTarget2 = vTarget2 + vTarget1
	vTarget3 = vTarget3 + hTarget:GetOrigin()

	local vTarget4 = hTarget:GetOrigin()

	vTarget2.z = vTarget2.z + math.max(flDistance, 128)
	vTarget3.z = vTarget3.z + math.max(flDistance, 128)
	vTarget4.z = vTarget4.z + 100

	local nFXIndexHit = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_furion/furion_wrath_of_nature.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(nFXIndexHit, 0, vTarget1)
	ParticleManager:SetParticleControl(nFXIndexHit, 1, vTarget2)
	ParticleManager:SetParticleControl(nFXIndexHit, 2, vTarget3)
	ParticleManager:SetParticleControl(nFXIndexHit, 3, vTarget4)
	ParticleManager:SetParticleControlOrientation(nFXIndexHit, 0, Vector(0, 0, 1), Vector(0, 1, 0), Vector(1, 0, 0))
	ParticleManager:SetParticleControlOrientation(nFXIndexHit, 1, Vector(0, 0, 1), Vector(0, 1, 0), Vector(1, 0, 0))
	ParticleManager:SetParticleControlOrientation(nFXIndexHit, 2, Vector(0, 0, 1), Vector(0, 1, 0), Vector(1, 0, 0))
	ParticleManager:SetParticleControlEnt(
		nFXIndexHit,
		4,
		self.hTarget,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self:GetCaster():GetOrigin(),
		false
	)
	ParticleManager:ReleaseParticleIndex(nFXIndexHit)
end

--------------------------------------------------------------------------------

modifier_custom_seed = class({})

function modifier_custom_seed:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.damage_interval = 1
	self.leech_damage = self:GetAbility():GetSpecialValueFor("tick_damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_additional")
	self.remnants_radius = 400
	self.projectile_speed = 400

	if not IsServer() then
		return
	end

	self.damage_type = self:GetAbility():GetAbilityDamageType()

	self:OnIntervalThink()
	self:StartIntervalThink(self.damage_interval)
end

function modifier_custom_seed:OnIntervalThink()
	self:GetParent():EmitSound("Hero_Treant.LeechSeed.Tick")

	self.damage_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(self.damage_particle)
	self.damage_particle = nil

	ApplyDamage({
		victim = self:GetParent(),
		damage = self.leech_damage * self.damage_interval,
		damage_type = self.damage_type,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self:GetAbility(),
	})

	for _, unit in
		pairs(
			FindUnitsInRadius(
				self:GetCaster():GetTeamNumber(),
				self:GetParent():GetAbsOrigin(),
				self:GetParent(),
				self.remnants_radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
		)
	do
		ProjectileManager:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf",
			Ability = self:GetAbility(),
			Source = unit,
			vSourceLoc = unit:GetAbsOrigin(),
			Target = self:GetCaster(),
			iMoveSpeed = self.projectile_speed,
			flExpireTime = nil,
			bDodgeable = false,
			bIsAttack = false,
			bReplaceExisting = false,
			iSourceAttachment = nil,
			bDrawsOnMinimap = nil,
			bVisibleToEnemies = true,
			bProvidesVision = false,
			iVisionRadius = nil,
			iVisionTeamNumber = nil,
			ExtraData = {},
		})
	end
end

function boss_furion_custom_wrath:OnProjectileHit_ExtraData(target, location, ExtraData)
	target:Heal(self:GetSpecialValueFor("tick_damage"), self:GetCaster())
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, self:GetSpecialValueFor("leech_damage"), nil)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

boss_furion_vine_grab = class({})

function boss_furion_vine_grab:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_furion_vine_grab:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_enchantress/enchantress_enchant_slow_grass_long.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_treant/treant_overgrowth_vines.vpcf", context)
end

function boss_furion_vine_grab:OnSpellStart()
	local caster = self:GetCaster()
	local target_pos = self:GetCursorPosition()
	self.speed = self:GetSpecialValueFor("speed")
	self.grab_duration = self:GetSpecialValueFor("grab_duration")
	self.width = self:GetSpecialValueFor("width")
	self.count = self:GetSpecialValueFor("count")
	self.damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	self.frequency = self:GetSpecialValueFor("frequency")
	local spawn_points = GetFivePointsAroundUnit(caster, 50, self.count)

	for _, point in pairs(spawn_points) do
		local direction = (point - caster:GetAbsOrigin()):Normalized()
		local target_pos = point + direction * 1000
		self:LaunchRandomParticle(caster, point, target_pos)
	end

	caster:EmitSound("Hero_Treant.Overgrowth.Cast")
end

function GetFivePointsAroundUnit(unit, radius, count)
	local points = {}
	local caster_pos = unit:GetAbsOrigin()
	local forward_vec = unit:GetForwardVector()
	local angle_step = 360 / count

	for i = 0, count - 1 do
		local angle = i * angle_step
		local rotation = QAngle(0, angle, 0)
		local direction = RotatePosition(Vector(0, 0, 0), rotation, forward_vec)
		local point = caster_pos + (direction * radius)

		point.z = GetGroundHeight(point, unit)
		table.insert(points, point)
	end
	return points
end

function boss_furion_vine_grab:LaunchRandomParticle(caster, start_pos, target_pos)
	local random_sign = (RollPercentage(50)) and 1 or -1
	local amplitude = 300 * random_sign

	local direction = (target_pos - start_pos):Normalized()
	local side_direction = Vector(-direction.y, direction.x, 0)

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_enchantress/enchantress_enchant_slow_grass_long.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)

	local elapsed_time = 0
	local interval = 0.03

	Timers:CreateTimer(interval, function()
		elapsed_time = elapsed_time + interval
		local forward_offset = direction * self.speed * elapsed_time
		local side_offset = side_direction * math.sin(elapsed_time * self.frequency) * amplitude
		local current_pos = start_pos + forward_offset + side_offset
		ParticleManager:SetParticleControl(particle, 0, current_pos)

		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			current_pos,
			nil,
			self.width,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		if #enemies > 0 or elapsed_time >= self.grab_duration then
			if #enemies > 0 then
				local target = enemies[1]
				ApplyDamage({
					victim = target,
					attacker = caster,
					damage = self.damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
				})
				target:EmitSound("Hero_Treant.Overgrowth.Target")
				self:MoveBack(target)
			end
			ParticleManager:DestroyParticle(particle, false)
			ParticleManager:ReleaseParticleIndex(particle)
			return nil
		end

		return interval
	end)
end

function boss_furion_vine_grab:MoveBack(target)
	if target and not target:IsMagicImmune() then
		local caster = self:GetCaster()
		local duration = 1.75
		target:AddNewModifier(caster, self, "modifier_stunned", { duration = duration })

		local knockback = {
			should_stun = 1,
			knockback_duration = duration,
			duration = duration,
			knockback_distance = -(target:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D() + 150,
			knockback_height = 0,
			center_x = caster:GetAbsOrigin().x,
			center_y = caster:GetAbsOrigin().y,
			center_z = caster:GetAbsOrigin().z,
		}

		target:AddNewModifier(caster, self, "modifier_knockback", knockback)
		local pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_treant/treant_overgrowth_vines.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			target
		)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end