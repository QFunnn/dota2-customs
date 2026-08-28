--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_medusa_poison_arrow_lua", "heroes/hero_medusa/hero_medusa", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_generic_orb_effect_lua",
	"heroes/generic/modifier_generic_orb_effect_lua",
	LUA_MODIFIER_MOTION_NONE
)

medusa_poison_arrow_lua = class({})

function medusa_poison_arrow_lua:Precache(context)
	PrecacheResource("particle", "particles/medusa_arrow.vpcf", context)
end

function medusa_poison_arrow_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

function medusa_poison_arrow_lua:OnSpellStart() end

function medusa_poison_arrow_lua:GetProjectileName()
	return "particles/medusa_arrow.vpcf"
end

function medusa_poison_arrow_lua:OnOrbImpact(params)
	local duration = self:GetSpecialValueFor("duration")

	if not params.target:HasModifier("modifier_medusa_poison_arrow_lua") then
		params.target:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_medusa_poison_arrow_lua",
			{ duration = duration }
		)
	end
end

----------------------------------------------------------------

modifier_medusa_poison_arrow_lua = class({})

function modifier_medusa_poison_arrow_lua:IsHidden()
	return false
end

function modifier_medusa_poison_arrow_lua:IsDebuff()
	return true
end

function modifier_medusa_poison_arrow_lua:IsStunDebuff()
	return false
end

function modifier_medusa_poison_arrow_lua:IsPurgable()
	return true
end

function modifier_medusa_poison_arrow_lua:OnCreated(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
	}
	ApplyDamage(self.damageTable)
	self:StartIntervalThink(0.5)
end

function modifier_medusa_poison_arrow_lua:OnRefresh(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_medusa_poison_arrow_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self:GetParent():IsNull() or not self:GetParent():IsAlive() then
		return
	end
	self.damageTable.damage = self.damage / 2
	ApplyDamage(self.damageTable)
end

function modifier_medusa_poison_arrow_lua:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf"
end

function modifier_medusa_poison_arrow_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

LinkLuaModifier("modifier_medusa_stone_gaze_lua_petrified", "heroes/hero_medusa/hero_medusa", LUA_MODIFIER_MOTION_NONE)

medusa_mystic_snake_lua = class({})

function medusa_mystic_snake_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local mana_steal = self:GetSpecialValueFor("snake_mana_steal")
	local jumps = self:GetSpecialValueFor("snake_jumps")
	local radius = self:GetSpecialValueFor("radius")
	local base_damage = self:GetSpecialValueFor("snake_damage")
	local mult_damage = self:GetSpecialValueFor("snake_scale") / 100

	local base_stun = 0

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_medusa_4")
	if talent ~= nil and talent:GetLevel() > 0 then
		base_stun = 1
	end

	local mult_stun = 0

	local projectile_name = "particles/units/heroes/hero_medusa/medusa_mystic_snake_projectile.vpcf"
	local projectile_speed = self:GetSpecialValueFor("initial_speed")
	local projectile_vision = 100

	local index = self:GetUniqueInt()

	local info = {
		Target = target,
		Source = caster,
		Ability = self,

		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = false, -- Optional
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,

		bDrawsOnMinimap = false, -- Optional
		bVisibleToEnemies = true, -- Optional
		bProvidesVision = true, -- Optional
		iVisionRadius = projectile_vision, -- Optional
		iVisionTeamNumber = caster:GetTeamNumber(), -- Optional

		ExtraData = {
			index = index,
		},
	}
	ProjectileManager:CreateTrackingProjectile(info)

	local data = {}
	data.jump = 0
	data.mana_stolen = 0
	data.isReturning = false
	data.hit_units = {}

	data.jumps = jumps
	data.radius = radius
	data.base_damage = base_damage
	data.mult_damage = mult_damage
	data.base_stun = base_stun
	data.mult_stun = mult_stun
	data.mana_steal = mana_steal
	data.projectile_info = info

	self.projectiles[index] = data

	local sound_cast = "Hero_Medusa.MysticSnake.Cast"
	EmitSoundOn(sound_cast, caster)
end

medusa_mystic_snake_lua.projectiles = {}

function medusa_mystic_snake_lua:OnProjectileHit_ExtraData(target, location, ExtraData)
	local data = self.projectiles[ExtraData.index]

	if data.isReturning then
		self:Returned(data)
		return
	end
	if target and (not target:IsMagicImmune()) and (not target:IsInvulnerable()) then
		data.hit_units[target] = true

		if data.base_stun > 0 then
			if not target:IsAncient() then
				target:AddNewModifier(
					self:GetCaster(), -- player source
					self, -- ability source
					"modifier_medusa_stone_gaze_lua_petrified", -- modifier name
					{
						duration = data.base_stun + data.mult_stun * data.jump,
						physical_bonus = 50, -- hard coded because caster may not have Stone Gaze
						center_unit = self:GetCaster():entindex(),
					}
				)
			end
		end

		local damage_type = self:GetAbilityDamageType()

		local damage = data.base_damage + data.base_damage * data.mult_damage * data.jump

		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = damage_type,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)

		-- take mana
		local mana_taken = math.min(data.mana_steal, target:GetMana())

		target:Script_ReduceMana(mana_taken, nil)
		data.mana_stolen = data.mana_stolen + mana_taken

		-- play effects
		local sound_cast = "Hero_Medusa.MysticSnake.Target"
		EmitSoundOn(sound_cast, target)

		-- counter
		data.jump = data.jump + 1
		if data.jump >= data.jumps then
			-- return projectile with target
			self:Returning(data, target)
			return
		end
	end

	-- jump to nearby target
	local pos = location
	if target then
		pos = target:GetOrigin()
	end

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(), -- int, your team number
		pos, -- point, center point
		target, -- handle, cacheUnit. (not known)
		data.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		0, -- int, flag filter
		FIND_CLOSEST, -- int, order filter
		false -- bool, can grow cache
	)

	-- pick next target
	local next_target = nil
	for _, enemy in pairs(enemies) do
		-- check if it is already hit
		local found = false
		for unit, _ in pairs(data.hit_units) do
			if enemy == unit then
				found = true
				break
			end
		end

		if not found then
			next_target = enemy
			break
		end
	end

	-- not found
	if not next_target then
		-- return projectile without target
		self:Returning(data, target)
		return
	end

	-- create bounce projectile
	data.projectile_info.Target = next_target
	data.projectile_info.Source = target
	ProjectileManager:CreateTrackingProjectile(data.projectile_info)
end

function medusa_mystic_snake_lua:Returning(data, target)
	if not target then
		self:Returned(data)
		return
	end

	-- set returning
	data.isReturning = true

	-- create projectile
	local projectile_name = "particles/units/heroes/hero_medusa/medusa_mystic_snake_projectile_return.vpcf"
	data.projectile_info.Target = self:GetCaster()
	data.projectile_info.Source = target
	data.projectile_info.EffectName = projectile_name
	ProjectileManager:CreateTrackingProjectile(data.projectile_info)
end

function medusa_mystic_snake_lua:Returned(data)
	-- unregister projectile
	local index = data.projectile_info.ExtraData.index
	self.projectiles[index] = nil
	self:DelUniqueInt(index)

	-- only do things if alive
	if not self:GetCaster():IsAlive() then
		return
	end

	-- give mana
	self:GetCaster():GiveMana(data.mana_stolen)

	-- play effects
	local sound_cast = "Hero_Medusa.MysticSnake.Return"
	EmitSoundOn(sound_cast, self:GetCaster())
	SendOverheadEventMessage(
		nil, -- DOTAPlayer sendToPlayer,
		OVERHEAD_ALERT_MANA_ADD, --int iMessageType,
		self:GetCaster(), -- Entity targetEntity,
		data.mana_stolen, -- int iValue,
		self:GetCaster():GetPlayerOwner() -- DOTAPlayer sourcePlayer
	) -- - sendToPlayer and sourcePlayer can be nil - iMessageType is one of OVERHEAD_ALERT_* ])
end

medusa_mystic_snake_lua.unique = {}
medusa_mystic_snake_lua.i = 0
medusa_mystic_snake_lua.max = 65536
function medusa_mystic_snake_lua:GetUniqueInt()
	while self.unique[self.i] do
		self.i = self.i + 1
		if self.i == self.max then
			self.i = 0
		end
	end

	self.unique[self.i] = true
	return self.i
end
function medusa_mystic_snake_lua:DelUniqueInt(i)
	self.unique[i] = nil
end

----------------------------------------------------------------------------------------------------

modifier_medusa_stone_gaze_lua_petrified = class({})

function modifier_medusa_stone_gaze_lua_petrified:IsHidden()
	return false
end

function modifier_medusa_stone_gaze_lua_petrified:IsDebuff()
	return true
end

function modifier_medusa_stone_gaze_lua_petrified:IsStunDebuff()
	return true
end

function modifier_medusa_stone_gaze_lua_petrified:IsPurgable()
	return true
end

function modifier_medusa_stone_gaze_lua_petrified:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.center_unit = EntIndexToHScript(kv.center_unit)
	self:PlayEffects()
end

function modifier_medusa_stone_gaze_lua_petrified:OnRefresh(kv)
	if not IsServer() then
		return
	end
	self.center_unit = EntIndexToHScript(kv.center_unit)
	self:PlayEffects()
end

function modifier_medusa_stone_gaze_lua_petrified:OnRemoved() end

function modifier_medusa_stone_gaze_lua_petrified:OnDestroy() end

function modifier_medusa_stone_gaze_lua_petrified:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
	return state
end

function modifier_medusa_stone_gaze_lua_petrified:GetStatusEffectName()
	return "particles/status_fx/status_effect_medusa_stone_gaze.vpcf"
end
function modifier_medusa_stone_gaze_lua_petrified:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_medusa_stone_gaze_lua_petrified:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff_stoned.vpcf"
	local sound_cast = "Hero_Medusa.StoneGaze.Stun"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.center_unit,
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
	EmitSoundOnClient(sound_cast, self:GetParent():GetPlayerOwner())
end

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

LinkLuaModifier("modifier_medusa_mana_shield_lua", "heroes/hero_medusa/hero_medusa", LUA_MODIFIER_MOTION_NONE)

medusa_mana_shield_lua = class({})

function medusa_mana_shield_lua:GetIntrinsicModifierName()
	return "modifier_medusa_mana_shield_lua"
end

--------------------------------------------------------------

modifier_medusa_mana_shield_lua = class({})

function modifier_medusa_mana_shield_lua:IsHidden()
	return true
end
function modifier_medusa_mana_shield_lua:IsPurgable()
	return false
end
function modifier_medusa_mana_shield_lua:RemoveOnDeath()
	return false
end

function modifier_medusa_mana_shield_lua:OnCreated()
	self.absorption = self:GetAbility():GetSpecialValueFor("absorption")
	self.damage_per_mana = self:GetAbility():GetSpecialValueFor("damage_per_mana")
end

function modifier_medusa_mana_shield_lua:OnRefresh()
	self:OnCreated()
end

function modifier_medusa_mana_shield_lua:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return decFuncs
end

function modifier_medusa_mana_shield_lua:GetModifierIncomingDamage_Percentage(params)
	if not IsServer() then
		return
	end

	local damage_to_absorb = params.damage * self.absorption / 100
	local manacost = damage_to_absorb * self.damage_per_mana
	local mana = self:GetParent():GetMana()

	if mana < manacost then
		damage_to_absorb = mana / self.damage_per_mana
		manacost = mana
	end

	self:GetParent():SpendMana(manacost, self:GetAbility())

	local absorb_pct = (damage_to_absorb / params.damage) * 100
	return -absorb_pct
end

function modifier_medusa_mana_shield_lua:GetEffectName()
	return "particles/units/heroes/hero_medusa/medusa_mana_shield.vpcf"
end

function modifier_medusa_mana_shield_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_medusa_mana_shield_lua:PlayEffects(damage)
	local particle_cast = "particles/units/heroes/hero_medusa/medusa_mana_shield_impact.vpcf"
	local sound_cast = "Hero_Medusa.ManaShield.Proc"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(damage, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_cast, self:GetParent())
end

---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------

LinkLuaModifier("modifier_medusa_split_shot_lua", "heroes/hero_medusa/hero_medusa", LUA_MODIFIER_MOTION_NONE)

medusa_split_shot_lua = class({})

function medusa_split_shot_lua:GetIntrinsicModifierName()
	return "modifier_medusa_split_shot_lua"
end

function medusa_split_shot_lua:OnUpgrade()
	self.OnUpgrade = function() end

	if not IsServer() then
		return
	end

	self:ToggleAutoCast()
end

---------------------------------------------------------------------

modifier_medusa_split_shot_lua = class({})

function modifier_medusa_split_shot_lua:IsHidden()
	return true
end

function modifier_medusa_split_shot_lua:IsPurgable()
	return false
end

function modifier_medusa_split_shot_lua:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_medusa_split_shot_lua:OnCreated()
	local ability = self:GetAbility()
	self.damage = ability:GetSpecialValueFor("damage") - 100
	self.count = ability:GetSpecialValueFor("arrow_count")
	self.bonus_range = ability:GetSpecialValueFor("split_shot_bonus_range")
	self.talent7 = self:GetParent():FindAbilityByName("special_bonus_unique_medusa_7")
	self.talent8 = self:GetParent():FindAbilityByName("special_bonus_unique_medusa_8")
end

function modifier_medusa_split_shot_lua:OnRefresh()
	self:OnCreated()
end

function modifier_medusa_split_shot_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_medusa_split_shot_lua:GetSplitShotTargets()
	local parent = self:GetParent()

	return FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		parent,
		parent:Script_GetAttackRange() + self.bonus_range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
			+ DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
			+ DOTA_UNIT_TARGET_FLAG_NO_INVIS
			+ DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_ANY_ORDER,
		false
	)
end

function modifier_medusa_split_shot_lua:OnAttack(keys)
	if not IsServer() then
		return
	end

	if self.split_shot_target then
		return
	end

	local parent = self:GetParent()

	if keys.attacker ~= parent then
		return
	end
	if not keys.target or keys.target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if keys.no_attack_cooldown then
		return
	end
	if parent:PassivesDisabled() then
		return
	end

	local ability = self:GetAbility()
	if not ability:IsTrained() then
		return
	end
	if not ability:GetAutoCastState() then
		return
	end

	local applyModifiers = self.talent8 and self.talent8:GetLevel() > 0 or false

	local targets = self:GetSplitShotTargets()

	local target_number = 0

	for i = 1, #targets do
		local target = targets[i]

		if target ~= keys.target then
			self.split_shot_target = true

			parent:PerformAttack(target, applyModifiers, applyModifiers, true, true, true, false, false)

			self.split_shot_target = false

			target_number = target_number + 1

			if target_number >= self.count then
				break
			end
		end
	end
end

function modifier_medusa_split_shot_lua:GetModifierDamageOutgoing_Percentage(keys)
	if IsServer() then
		if keys.attacker == self:GetParent() and keys.target and not self.split_shot_target then
			self:SetStackCount(0)

			if not self.talent7 or self.talent7:GetLevel() < 1 then
				return
			end

			local targets = self:GetSplitShotTargets()

			if #targets > 1 then
				return
			end

			self:SetStackCount(80)
		end
	end
	return self:GetStackCount()
end