--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_windrunner_attack_triggers",
	"heroes/hero_windranger/hero_windranger",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_windrunner_shackle_stun", "heroes/hero_windranger/hero_windranger", LUA_MODIFIER_MOTION_NONE)

windrunner_attack_triggers = class({})

function windrunner_attack_triggers:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_windrunner/windrunner_shackleshot.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_windrunner/windrunner_shackleshot_pair.vpcf", context)
end

function windrunner_attack_triggers:OnUpgrade()
	if self:GetLevel() == 1 then
		self:ToggleAutoCast()
	end
end

function windrunner_attack_triggers:GetIntrinsicModifierName()
	return "modifier_windrunner_attack_triggers"
end

function windrunner_attack_triggers:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	caster:EmitSound("Hero_Windrunner.ShackleshotCast")

	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_windrunner/windrunner_shackleshot.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("arrow_speed"),
		bDodgeable = true,
		ExtraData = {
			source_x = caster:GetAbsOrigin().x,
			source_y = caster:GetAbsOrigin().y,
			source_z = caster:GetAbsOrigin().z,
		},
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

function windrunner_attack_triggers:OnProjectileHit_ExtraData(target, location, ExtraData)
	if not target or target:IsMagicImmune() or target:TriggerSpellAbsorb(self) then
		return
	end

	local caster = self:GetCaster()
	target:EmitSound("Hero_Windrunner.ShackleshotStun")

	self:DealShackleDamage(target)

	local shackled_targets = {}
	local current_source = target
	local last_pos = Vector(ExtraData.source_x, ExtraData.source_y, ExtraData.source_z)

	local max_chains = self:GetSpecialValueFor("shackle_count") or 2

	for i = 1, max_chains do
		local found_next = self:FindAndBindNext(current_source, last_pos, shackled_targets)
		if found_next then
			shackled_targets[found_next] = true
			current_source = found_next
			last_pos = current_source:GetAbsOrigin()

			self:DealShackleDamage(found_next)
		else
			if i == 1 then
				target:AddNewModifier(
					caster,
					self,
					"modifier_stunned",
					{ duration = self:GetSpecialValueFor("fail_stun_duration") }
				)
			end
			break
		end
	end
end

function windrunner_attack_triggers:DealShackleDamage(target)
	if not target or not target:IsAlive() or not target.GetAbsOrigin then
		return
	end

	local damage = self:GetSpecialValueFor("damage")

	ApplyDamage({
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	})
end

function windrunner_attack_triggers:FindAndBindNext(source, last_pos, ignore_table)
	local caster = self:GetCaster()
	local distance = self:GetSpecialValueFor("shackle_distance")
	local angle_limit = self:GetSpecialValueFor("shackle_angle")

	local has_talent = false
	local talent = caster:FindAbilityByName("special_bonus_unique_windrunner_5")
	if talent and talent:GetLevel() > 0 then
		has_talent = true
	end

	if has_talent then
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			source:GetAbsOrigin(),
			source,
			distance,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		local last_enemy = nil
		for _, enemy in pairs(enemies) do
			if enemy ~= source and not ignore_table[enemy] then
				self:ApplyShackle(source, enemy)
				ignore_table[enemy] = true
				last_enemy = enemy
			end
		end

		local trees = GridNav:GetAllTreesAroundPoint(source:GetAbsOrigin(), distance, false)
		for _, tree in pairs(trees) do
			self:ApplyShackle(source, tree)
		end

		return last_enemy
	end

	local dir_to_source = (source:GetAbsOrigin() - last_pos):Normalized()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		source:GetAbsOrigin(),
		source,
		distance,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)

	for _, enemy in pairs(enemies) do
		if enemy ~= source and not ignore_table[enemy] then
			local dir_to_enemy = (enemy:GetAbsOrigin() - source:GetAbsOrigin()):Normalized()
			local angle = math.abs(RotationDelta(VectorToAngles(dir_to_source), VectorToAngles(dir_to_enemy)).y)

			if angle <= angle_limit then
				self:ApplyShackle(source, enemy)
				return enemy
			end
		end
	end

	local trees = GridNav:GetAllTreesAroundPoint(source:GetAbsOrigin(), distance, false)
	for _, tree in pairs(trees) do
		local dir_to_tree = (tree:GetAbsOrigin() - source:GetAbsOrigin()):Normalized()
		local angle = math.abs(RotationDelta(VectorToAngles(dir_to_source), VectorToAngles(dir_to_tree)).y)

		if angle <= angle_limit then
			self:ApplyShackle(source, tree)
			return nil
		end
	end

	return nil
end

function windrunner_attack_triggers:ApplyShackle(unit1, unit2)
	local duration = self:GetSpecialValueFor("stun_duration")
	local caster = self:GetCaster()
	local ability = self

	local function IsTree(ent)
		if not ent or ent:IsNull() then
			return true
		end
		if ent:GetClassname() == "ent_dota_tree" then
			return true
		end
		return false
	end

	local u1_is_tree = IsTree(unit1)
	if not u1_is_tree then
		unit1:AddNewModifier(caster, ability, "modifier_windrunner_shackle_stun", { duration = duration })
		unit1:EmitSound("Hero_Windrunner.ShackleshotBind")
	end

	local u2_is_tree = IsTree(unit2)
	if not u2_is_tree then
		unit2:AddNewModifier(caster, ability, "modifier_windrunner_shackle_stun", { duration = duration })
		if u1_is_tree then
			unit2:EmitSound("Hero_Windrunner.ShackleshotBind")
		end
	end

	local shackleshot_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_windrunner/windrunner_shackleshot_pair.vpcf",
		PATTACH_POINT_FOLLOW,
		unit1
	)

	if not u1_is_tree then
		ParticleManager:SetParticleControlEnt(
			shackleshot_particle,
			0,
			unit1,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			unit1:GetAbsOrigin(),
			true
		)
	else
		ParticleManager:SetParticleControl(shackleshot_particle, 0, unit1:GetAbsOrigin())
	end

	if not u2_is_tree then
		ParticleManager:SetParticleControlEnt(
			shackleshot_particle,
			1,
			unit2,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			unit2:GetAbsOrigin(),
			true
		)
	else
		ParticleManager:SetParticleControl(shackleshot_particle, 1, unit2:GetAbsOrigin())
	end
	ParticleManager:SetParticleControl(shackleshot_particle, 2, Vector(duration, 0, 0))
end

--------------------------------------------------------------------------------

modifier_windrunner_attack_triggers = class({})

function modifier_windrunner_attack_triggers:IsHidden()
	return true
end

function modifier_windrunner_attack_triggers:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_START,
	}
end

function modifier_windrunner_attack_triggers:OnAttackStart(keys)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local ability = self:GetAbility()
	local target = keys.target

	if keys.attacker == parent and ability:GetAutoCastState() and not parent:IsSilenced() then
		if target:GetTeamNumber() ~= parent:GetTeamNumber() and target:IsAlive() then
			if ability:IsFullyCastable() then
				ability:UseResources(true, false, false, true)
				parent:StartGesture(ACT_DOTA_CAST_ABILITY_1)

				local cast_keys = {
					target = target,
				}

				parent:SetCursorCastTarget(target)
				ability:OnSpellStart()
			end
		end
	end
end

--------------------------------------------------------------------------------

modifier_windrunner_shackle_stun = class({})

function modifier_windrunner_shackle_stun:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_windrunner_shackle_stun:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_windrunner_shackle_stun:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

windrunner_powershot_lua = class({})

function windrunner_powershot_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local pos = self:GetCursorPosition()
	local direction = (pos - caster:GetAbsOrigin()):Normalized()
	direction.z = 0

	local speed = self:GetSpecialValueFor("arrow_speed")
	local distance = self:GetSpecialValueFor("arrow_range")
	local width = self:GetSpecialValueFor("arrow_width")
	local vision_radius = self:GetSpecialValueFor("vision_radius")
	local p_name = "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf"

	caster:EmitSound("Ability.Powershot")
	caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_2)

	local talent = caster:FindAbilityByName("special_bonus_unique_windrunner_6")
	if talent and talent:GetLevel() > 0 then
		local angle = 5
		local dir_left = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), direction)
		local dir_right = RotatePosition(Vector(0, 0, 0), QAngle(0, -angle, 0), direction)
		self:FirePowershot(dir_left * speed, distance, width, vision_radius, p_name)
		self:FirePowershot(dir_right * speed, distance, width, vision_radius, p_name)
	else
		self:FirePowershot(direction * speed, distance, width, vision_radius, p_name)
	end
end

function windrunner_powershot_lua:FirePowershot(velocity, distance, width, vision, fx)
	local info = {
		EffectName = fx,
		Ability = self,
		vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
		fStartRadius = width,
		fEndRadius = width,
		vVelocity = velocity,
		fDistance = distance,
		Source = self:GetCaster(),
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		bDeleteOnHit = false,
		bProvidesVision = true,
		iVisionRadius = vision,
		iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
	}
	ProjectileManager:CreateLinearProjectile(info)
end

function windrunner_powershot_lua:OnProjectileHit(hTarget, vLocation)
	if not hTarget then
		AddFOWViewer(
			self:GetCaster():GetTeamNumber(),
			vLocation,
			self:GetSpecialValueFor("vision_radius"),
			self:GetSpecialValueFor("vision_duration"),
			false
		)
		return false
	end

	local caster = self:GetCaster()
	hTarget:EmitSound("Ability.PowershotDamage")

	local damage = self:GetSpecialValueFor("powershot_damage")

	ApplyDamage({
		victim = hTarget,
		attacker = caster,
		ability = self,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
	})

	return false
end

function windrunner_powershot_lua:OnProjectileThink(vLocation)
	GridNav:DestroyTreesAroundPoint(vLocation, self:GetSpecialValueFor("arrow_width"), false)
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

LinkLuaModifier("modifier_windrunner_windrun_lua", "heroes/hero_windranger/hero_windranger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_windrunner_windrun_lua_effect",
	"heroes/hero_windranger/hero_windranger",
	LUA_MODIFIER_MOTION_NONE
)

windrunner_windrun_lua = class({})

function windrunner_windrun_lua:GetIntrinsicModifierName()
	return "modifier_windrunner_windrun_lua"
end

--------------------------------------------------------------------------------

modifier_windrunner_windrun_lua = class({})

function modifier_windrunner_windrun_lua:IsHidden()
	return true
end

function modifier_windrunner_windrun_lua:IsPurgable()
	return false
end

function modifier_windrunner_windrun_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_UNIT_MOVED,
	}
	return funcs
end

function modifier_windrunner_windrun_lua:OnUnitMoved(keys)
	if keys.unit == self:GetCaster() and not self:GetCaster():PassivesDisabled() then
		self:GetCaster():AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_windrunner_windrun_lua_effect",
			{ duration = 0.2 }
		)
	end
end

----------------------------------------------------------------------------

modifier_windrunner_windrun_lua_effect = class({})

function modifier_windrunner_windrun_lua_effect:IsHidden()
	return false
end

function modifier_windrunner_windrun_lua_effect:IsPurgable()
	return false
end

function modifier_windrunner_windrun_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}
	return funcs
end

function modifier_windrunner_windrun_lua_effect:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_windrunner_windrun_lua_effect:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("speed")
end

function modifier_windrunner_windrun_lua_effect:GetModifierEvasion_Constant()
	return self:GetAbility():GetSpecialValueFor("eva")
end

function modifier_windrunner_windrun_lua_effect:GetEffectName()
	return "particles/units/heroes/hero_windrunner/windrunner_windrun.vpcf"
end

function modifier_windrunner_windrun_lua_effect:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

windrunner_focusfire_lua = class({})

function windrunner_focusfire_lua:OnSpellStart()
	local caster = self:GetCaster()
	self.damage = self:GetSpecialValueFor("damage")

	local duration = self:GetSpecialValueFor("duration")
	local arrows_count = self:GetSpecialValueFor("count")
	local current_count = arrows_count

	local interval = 0.1
	if arrows_count > 0 then
		interval = duration / arrows_count
	end

	local info = {
		EffectName = "particles/econ/items/windrunner/windrunner_weapon_sparrowhawk/windrunner_spell_powershot_sparrowhawk.vpcf",
		Ability = self,
		fStartRadius = 200,
		fEndRadius = 200,
		fDistance = 700,
		Source = caster,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	}

	caster:EmitSound("Ability.Focusfire")

	caster:SetContextThink(DoUniqueString("focusfire_think"), function()
		if not caster:IsAlive() then
			return nil
		end

		local direction = caster:GetForwardVector()

		info.vSpawnOrigin = caster:GetOrigin() + direction * 50 + RandomVector(200)

		info.vVelocity = direction * 1200
		info.fExpireTime = GameRules:GetGameTime() + 2

		ProjectileManager:CreateLinearProjectile(info)

		current_count = current_count - 1
		if current_count <= 0 then
			return nil
		end

		return interval
	end, 0)
end

function windrunner_focusfire_lua:OnProjectileHit(hTarget, vLocation)
	if hTarget ~= nil and not hTarget:IsMagicImmune() and not hTarget:IsInvulnerable() then
		ApplyDamage({
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
	end
	return false
end