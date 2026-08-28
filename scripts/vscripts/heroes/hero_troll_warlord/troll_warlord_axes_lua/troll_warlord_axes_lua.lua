--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_imba_whirling_axes_ranged",
	"heroes/hero_troll_warlord/troll_warlord_axes_lua/troll_warlord_axes_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_axes_debuff",
	"heroes/hero_troll_warlord/troll_warlord_axes_lua/troll_warlord_axes_lua",
	LUA_MODIFIER_MOTION_NONE
)

troll_warlord_whirling_axes_ranged_lua = troll_warlord_whirling_axes_ranged_lua or class({})
function troll_warlord_whirling_axes_ranged_lua:IsHiddenWhenStolen()
	return false
end
function troll_warlord_whirling_axes_ranged_lua:IsRefreshable()
	return true
end
function troll_warlord_whirling_axes_ranged_lua:IsStealable()
	return true
end
function troll_warlord_whirling_axes_ranged_lua:IsNetherWardStealable()
	return true
end

function troll_warlord_whirling_axes_ranged_lua:GetAbilityTextureName()
	return "troll_warlord_whirling_axes_ranged"
end

function troll_warlord_whirling_axes_ranged_lua:OnUpgrade()
	if IsServer() then
		local ability_melee = self:GetCaster():FindAbilityByName("troll_warlord_whirling_axes_melee_lua")
		local level = self:GetLevel()
		if ability_melee then
			if ability_melee:GetLevel() < level then
				ability_melee:SetLevel(level)
			end
		end

		local rage_ability = self:GetCaster():FindAbilityByName("troll_warlord_rage_lua")
		if rage_ability and rage_ability:GetLevel() < 1 then
			self:GetCaster():FindAbilityByName("troll_warlord_whirling_axes_melee_lua"):SetActivated(false)
			self:GetCaster():FindAbilityByName("troll_warlord_whirling_axes_ranged_lua"):SetActivated(true)
		end
	end
end

function troll_warlord_whirling_axes_ranged_lua:OnAbilityPhaseStart()
	self:SetOverrideCastPoint(0.2)
	return true
end

function troll_warlord_whirling_axes_ranged_lua:OnSpellStart()
	if IsServer() then
		local caster = self:GetCaster()
		local target_loc = self:GetCursorPosition()
		local caster_loc = caster:GetAbsOrigin()

		-- Parameters
		local axe_width = self:GetSpecialValueFor("axe_width")
		local axe_speed = self:GetSpecialValueFor("axe_speed")
		local axe_range = self:GetSpecialValueFor("axe_range")
		local axe_damage = self:GetSpecialValueFor("axe_damage")
		local duration = self:GetSpecialValueFor("duration")
		local axe_spread = self:GetSpecialValueFor("axe_spread")
		local axe_count = self:GetSpecialValueFor("axe_count")
		local on_hit_pct = self:GetSpecialValueFor("on_hit_pct")
		local direction

		local abil = self:GetCaster():FindAbilityByName("special_bonus_troll_warlord_int1")
		if abil ~= nil and abil:GetLevel() > 0 then
			axe_damage = axe_damage + 150
		end

		if target_loc == caster_loc then
			direction = caster:GetForwardVector()
		else
			direction = (target_loc - caster_loc):Normalized()
		end

		-- Emit sounds
		caster:EmitSound("Hero_TrollWarlord.WhirlingAxes.Ranged")
		-- Randomly play a cast line
		if (math.random(1, 100) <= 25) and (caster:GetName() == "npc_dota_hero_troll_warlord") then
			caster:EmitSound("troll_warlord_troll_whirlingaxes_0" .. math.random(1, 6))
		end
		-- Create a unique table with stored hit enemies
		local index = DoUniqueString("index")
		self[index] = {}
		-- Dynamic projectile spawning via angles
		local start_angle
		local interval_angle = 0
		if axe_count == 1 then
			start_angle = 0
		else
			start_angle = axe_spread / 2 * -1
			interval_angle = axe_spread / (axe_count - 1)
		end
		for i = 1, axe_count, 1 do
			local angle = start_angle + (i - 1) * interval_angle
			local velocity = RotateVector2D(direction, angle, true) * axe_speed

			local projectile = {
				Ability = self,
				EffectName = "particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_ranged.vpcf",
				vSpawnOrigin = caster_loc,
				fDistance = axe_range,
				fStartRadius = axe_width,
				fEndRadius = axe_width,
				Source = caster,
				bHasFrontalCone = false,
				bReplaceExisting = false,
				iUnitTargetTeam = self:GetAbilityTargetTeam(),
				iUnitTargetFlags = self:GetAbilityTargetFlags(),
				iUnitTargetType = self:GetAbilityTargetType(),
				fExpireTime = GameRules:GetGameTime() + 10.0,
				bDeleteOnHit = false,
				vVelocity = Vector(velocity.x, velocity.y, 0),
				bProvidesVision = false,
				ExtraData = {
					index = index,
					damage = axe_damage,
					duration = duration,
					axe_count = axe_count,
					on_hit_pct = on_hit_pct,
				},
			}
			ProjectileManager:CreateLinearProjectile(projectile)
		end
	end
end

function troll_warlord_whirling_axes_ranged_lua:OnProjectileHit_ExtraData(target, location, ExtraData)
	local caster = self:GetCaster()
	if target then
		local was_hit = false
		for _, stored_target in ipairs(self[ExtraData.index]) do
			if target == stored_target then
				was_hit = true
				break
			end
		end
		if was_hit then
			return nil
		end
		table.insert(self[ExtraData.index], target)
		ApplyDamage({
			victim = target,
			attacker = caster,
			ability = self,
			damage = ExtraData.damage,
			damage_type = self:GetAbilityDamageType(),
		})
		--if RollPseudoRandom(ExtraData.on_hit_pct, self) then
		caster:PerformAttack(target, true, true, true, true, false, true, true)
		--	end
		target:AddNewModifier(
			caster,
			self,
			"modifier_imba_whirling_axes_ranged",
			{ duration = ExtraData.duration * (1 - target:GetStatusResistance()) }
		)
		local abil = self:GetCaster():FindAbilityByName("special_bonus_troll_warlord_int3")
		if abil ~= nil and abil:GetLevel() > 0 then
			target:AddNewModifier(
				caster,
				self,
				"modifier_axes_debuff",
				{ duration = blind_duration * (1 - target:GetStatusResistance()), blind_stacks = blind_stacks }
			)
		end
		target:EmitSound("Hero_TrollWarlord.WhirlingAxes.Target")
	else
		self[ExtraData.index]["count"] = self[ExtraData.index]["count"] or 0
		self[ExtraData.index]["count"] = self[ExtraData.index]["count"] + 1
		if self[ExtraData.index]["count"] == ExtraData.axe_count then
			self[ExtraData.index] = nil
		end
	end
end

-------------------------------------------
modifier_imba_whirling_axes_ranged = modifier_imba_whirling_axes_ranged or class({})
function modifier_imba_whirling_axes_ranged:IsDebuff()
	return true
end
function modifier_imba_whirling_axes_ranged:IsHidden()
	return false
end
function modifier_imba_whirling_axes_ranged:IsPurgable()
	return true
end
function modifier_imba_whirling_axes_ranged:IsPurgeException()
	return false
end
function modifier_imba_whirling_axes_ranged:IsStunDebuff()
	return false
end
function modifier_imba_whirling_axes_ranged:RemoveOnDeath()
	return true
end
-------------------------------------------

function modifier_imba_whirling_axes_ranged:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_imba_whirling_axes_ranged:OnCreated()
	if not self:GetAbility() then
		self:Destroy()
		return
	end

	self.slow = self:GetAbility():GetSpecialValueFor("movement_speed") * -1
end

function modifier_imba_whirling_axes_ranged:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end
-------------------------------------------
--		  WHIRLING AXES (MELEE)
-------------------------------------------
LinkLuaModifier(
	"modifier_imba_whirling_axes_melee",
	"heroes/hero_troll_warlord/troll_warlord_axes_lua/troll_warlord_axes_lua",
	LUA_MODIFIER_MOTION_NONE
)

troll_warlord_whirling_axes_melee_lua = troll_warlord_whirling_axes_melee_lua or class({})
function troll_warlord_whirling_axes_melee_lua:IsHiddenWhenStolen()
	return false
end
function troll_warlord_whirling_axes_melee_lua:IsRefreshable()
	return true
end
function troll_warlord_whirling_axes_melee_lua:IsStealable()
	return true
end
function troll_warlord_whirling_axes_melee_lua:IsNetherWardStealable()
	return true
end

function troll_warlord_whirling_axes_melee_lua:GetAbilityTextureName()
	return "troll_warlord_whirling_axes_melee"
end
-------------------------------------------

function troll_warlord_whirling_axes_melee_lua:OnUpgrade()
	if IsServer() then
		local ability_ranged = self:GetCaster():FindAbilityByName("troll_warlord_whirling_axes_ranged_lua")
		local level = self:GetLevel()
		if ability_ranged then
			if ability_ranged:GetLevel() < level then
				ability_ranged:SetLevel(level)
			end
		end
	end
end

function troll_warlord_whirling_axes_melee_lua:OnSpellStart()
	if IsServer() then
		local caster = self:GetCaster()
		local caster_loc = caster:GetAbsOrigin()

		local axe_radius = self:GetSpecialValueFor("axe_radius")
		local max_range = self:GetSpecialValueFor("max_range")
		local axe_movement_speed = self:GetSpecialValueFor("axe_movement_speed")
		local whirl_duration = self:GetSpecialValueFor("whirl_duration")
		local direction = caster:GetForwardVector()
		-- Emit sounds
		caster:EmitSound("Hero_TrollWarlord.WhirlingAxes.Melee")
		if (math.random(1, 100) <= 25) and (caster:GetName() == "npc_dota_hero_troll_warlord") then
			caster:EmitSound("troll_warlord_troll_whirlingaxes_0" .. math.random(1, 6))
		end
		-- Create a unique table with stored hit enemies
		local index = DoUniqueString("index")
		self[index] = {}
		-- Set the particle
		local axe_pfx = {}
		local axe_loc = {}
		local axe_random = {}
		for i = 1, 10, 1 do
			table.insert(
				axe_pfx,
				ParticleManager:CreateParticle(
					"particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_melee.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					caster
				)
			)
			ParticleManager:SetParticleControl(axe_pfx[i], 1, caster_loc)
			ParticleManager:SetParticleControl(axe_pfx[i], 4, Vector(whirl_duration, 0, 0))
			table.insert(axe_random, math.random() * 0.9 + 1.8)
		end
		local counter = 0
		caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
		-- Projectile logic
		-- Note: Most of it is purely cosmetical, it's basicly just checking if new units are in the increasing range
		-- Why? Because trollolololo
		Timers:CreateTimer(FrameTime(), function()
			counter = counter + FrameTime()
			caster_loc = caster:GetAbsOrigin()
			if counter <= (whirl_duration / 2) then
				for i = 1, 10, 1 do
					axe_loc[i] = counter
						* (max_range - axe_radius)
						* RotateVector2D(direction, 36 * i + counter * axe_movement_speed, true):Normalized()
					self:DoAxeStuff(index, counter * (max_range - axe_radius) + axe_radius, caster_loc)
				end
			else
				for i = 1, 10, 1 do
					axe_loc[i] = (whirl_duration - counter / 2)
						* (max_range - axe_radius)
						* RotateVector2D(direction, 36 * i + counter * axe_movement_speed * axe_random[i], true):Normalized()
					self:DoAxeStuff(
						index,
						(whirl_duration - counter / 2) * (max_range - axe_radius) + axe_radius,
						caster_loc
					)
				end
			end
			for i = 1, 10, 1 do
				ParticleManager:SetParticleControl(axe_pfx[i], 1, caster_loc + axe_loc[i] + Vector(0, 0, 40))
			end
			if counter <= whirl_duration then
				return FrameTime()
			else
				for i = 1, 10, 1 do
					ParticleManager:DestroyParticle(axe_pfx[i], false)
					ParticleManager:ReleaseParticleIndex(axe_pfx[i])
				end
			end
		end)
	end
end

function RotateVector2D(v, angle, bIsDegree)
	if bIsDegree then
		angle = math.rad(angle)
	end
	local xp = v.x * math.cos(angle) - v.y * math.sin(angle)
	local yp = v.x * math.sin(angle) + v.y * math.cos(angle)

	return Vector(xp, yp, v.z):Normalized()
end

function troll_warlord_whirling_axes_melee_lua:DoAxeStuff(index, range, caster_loc)
	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("damage")

	local abil = self:GetCaster():FindAbilityByName("special_bonus_troll_warlord_int1")
	if abil ~= nil and abil:GetLevel() > 0 then
		damage = damage + 150
	end

	local blind_duration = self:GetSpecialValueFor("blind_duration")
	local blind_stacks = self:GetSpecialValueFor("blind_stacks")
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster_loc,
		caster,
		range,
		self:GetAbilityTargetTeam(),
		self:GetAbilityTargetType(),
		self:GetAbilityTargetFlags(),
		FIND_ANY_ORDER,
		false
	)
	for _, enemy in ipairs(enemies) do
		local was_hit = false
		for _, stored_target in ipairs(self[index]) do
			if enemy == stored_target then
				was_hit = true
				break
			end
		end
		if was_hit then
			return nil
		else
			table.insert(self[index], enemy)
		end
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			ability = self,
			damage = damage,
			damage_type = self:GetAbilityDamageType(),
		})
		-- Imbued Axes
		caster:PerformAttack(enemy, true, true, true, true, false, true, true)
		enemy:AddNewModifier(
			caster,
			self,
			"modifier_imba_whirling_axes_melee",
			{ duration = blind_duration * (1 - enemy:GetStatusResistance()), blind_stacks = blind_stacks }
		)
		local abil = self:GetCaster():FindAbilityByName("special_bonus_troll_warlord_int3")
		if abil ~= nil and abil:GetLevel() > 0 then
			enemy:AddNewModifier(
				caster,
				self,
				"modifier_axes_debuff",
				{ duration = blind_duration * (1 - enemy:GetStatusResistance()), blind_stacks = blind_stacks }
			)
		end
		enemy:EmitSound("Hero_TrollWarlord.WhirlingAxes.Target")
	end
end

-------------------------------------------
modifier_imba_whirling_axes_melee = modifier_imba_whirling_axes_melee or class({})
function modifier_imba_whirling_axes_melee:IsDebuff()
	return true
end
function modifier_imba_whirling_axes_melee:IsHidden()
	return false
end
function modifier_imba_whirling_axes_melee:IsPurgable()
	return true
end
function modifier_imba_whirling_axes_melee:IsPurgeException()
	return false
end
function modifier_imba_whirling_axes_melee:IsStunDebuff()
	return false
end
function modifier_imba_whirling_axes_melee:RemoveOnDeath()
	return true
end
-------------------------------------------

function modifier_imba_whirling_axes_melee:DeclareFunctions()
	local decFuns = {
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
	}

	return decFuns
end

function modifier_imba_whirling_axes_melee:OnCreated(params)
	self.miss_chance = self:GetAbility():GetSpecialValueFor("blind_pct")
end

function modifier_imba_whirling_axes_melee:GetModifierMiss_Percentage()
	return self.miss_chance
end

function modifier_imba_whirling_axes_melee:OnRefresh(params)
	self:OnCreated(params)
end

--------------------------------------------------------

modifier_axes_debuff = class({})
function modifier_axes_debuff:IsDebuff()
	return true
end
function modifier_axes_debuff:IsHidden()
	return false
end
function modifier_axes_debuff:IsPurgable()
	return true
end
function modifier_axes_debuff:IsPurgeException()
	return false
end
function modifier_axes_debuff:IsStunDebuff()
	return false
end
function modifier_axes_debuff:RemoveOnDeath()
	return true
end
-------------------------------------------

function modifier_axes_debuff:DeclareFunctions()
	local decFuns = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return decFuns
end

function modifier_axes_debuff:GetModifierDamageOutgoing_Percentage()
	return -15
end