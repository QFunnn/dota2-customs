--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_set_mjolnir_strike", "modifiers/modifier_sets.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_desolator_set", "modifiers/modifier_sets.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_magic_desolator_set", "modifiers/modifier_sets.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_multicast_lua_proc", "modifiers/modifier_sets.lua", LUA_MODIFIER_MOTION_NONE)

modifier_sets = class({})

function modifier_sets:IsHidden()
	return true
end

function modifier_sets:IsPurgable()
	return false
end

function modifier_sets:RemoveOnDeath()
	return false
end

function modifier_sets:OnCreated(kv)
	if not IsServer() then
		return
	end
	self:SetupRewards(kv)
	self:SetHasCustomTransmitterData(true)
	self.bChainCooldown = false
end

function modifier_sets:SetupRewards(kv)
	if not IsServer() then
		return
	end
	self.desolator = kv.desolator or 0
	self.magic_desolator = kv.magic_desolator or 0
	self.reflect = kv.reflect or 0
	self.lifesteal = kv.lifesteal or 0
	self.magic_lifesteal = kv.magic_lifesteal or 0
	self.mjolnir = kv.mjolnir or 0
	self.mjolnir_armor = kv.mjolnir_armor or 0
	self.mkb = kv.mkb or 0
	self.hp_regen = kv.hp_regen or 0
	self.magic_crit = kv.magic_crit or 0 --
	self.hp_regen_amp = kv.hp_regen_amp or 0 --
	self.damage_block = kv.damage_block or 0 --
	self.manacost = kv.manacost or 0 --
	self.crit = kv.crit or 0 --
	self.multicast = kv.multicast or 0 --

	self.head = kv.head or 0
	self.armor = kv.armor or 0
	self.weapon = kv.weapon or 0
	self.legs = kv.legs or 0
	self.boots = kv.boots or 0
	self.shield = kv.shield or 0

	self.full_set = kv.full_set or 1
end

function modifier_sets:AddCustomTransmitterData()
	return {
		desolator = self.desolator,
		magic_desolator = self.magic_desolator,
		reflect = self.reflect,
		lifesteal = self.lifesteal,
		magic_lifesteal = self.magic_lifesteal,
		mjolnir = self.mjolnir,
		mjolnir_armor = self.mjolnir_armor,
		mkb = self.mkb,
		hp_regen = self.hp_regen,
		magic_crit = self.magic_crit,
		hp_regen_amp = self.hp_regen_amp,
		damage_block = self.damage_block,
		manacost = self.manacost,
		crit = self.crit,
		multicast = self.multicast,

		head = self.head,
		armor = self.armor,
		weapon = self.weapon,
		legs = self.legs,
		boots = self.boots,
		shield = self.shield,

		full_set = self.full_set,
	}
end

function modifier_sets:HandleCustomTransmitterData(data)
	self.desolator = data.desolator
	self.magic_desolator = data.magic_desolator
	self.reflect = data.reflect
	self.lifesteal = data.lifesteal
	self.magic_lifesteal = data.magic_lifesteal
	self.mjolnir = data.mjolnir
	self.mjolnir_armor = data.mjolnir_armor
	self.mkb = data.mkb
	self.hp_regen = data.hp_regen
	self.magic_crit = data.magic_crit
	self.hp_regen_amp = data.hp_regen_amp
	self.damage_block = data.damage_block
	self.manacost = data.manacost
	self.crit = data.crit
	self.multicast = data.multicast

	self.head = data.head
	self.armor = data.armor
	self.weapon = data.weapon
	self.legs = data.legs
	self.boots = data.boots
	self.shield = data.shield

	self.full_set = data.full_set
end

function modifier_sets:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,

		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,

		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_TAKEDAMAGE,

		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
	return funcs
end

function modifier_sets:OnIntervalThink()
	self:StartIntervalThink(-1)
	self.bChainCooldown = false
end

----------------------------------BONUS----------------------------------------------------------

function modifier_sets:GetModifierTotal_ConstantBlock(params)
	if RandomInt(0, 100) <= 15 then
		return self.damage_block * self.full_set
	end
	return 0
end

function modifier_sets:GetModifierHPRegenAmplify_Percentage()
	return self.hp_regen_amp * self.full_set
end

function modifier_sets:GetModifierPercentageManacostStacking()
	return self.manacost * self.full_set
end

function modifier_sets:GetModifierPreAttack_CriticalStrike(params)
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then
			return
		end
		if RandomInt(0, 100) < 15 and self.crit > 0 then
			self.record = params.record
			return self.crit * self.full_set + 100
		end
	end
end

function modifier_sets:OnAbilityFullyCast(params)
	if params.unit ~= self:GetCaster() then
		return
	end
	if params.ability == self:GetAbility() then
		return
	end
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if not params.target then
		return
	end

	if bit.band(params.ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
		return
	end
	if bit.band(params.ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_OPTIONAL_UNIT_TARGET) ~= 0 then
		return
	end

	if
		params.ability:IsRefreshable()
		and params.ability:GetName() ~= "hero_pangolier_blade_of_the_exile"
		and params.ability:IsItem() == false
		and RandomInt(1, 100) <= self.multicast * self.full_set
	then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_multicast_lua_proc", {
			ability = params.ability:entindex(),
			target = params.target:entindex(),
		})
	end
end
-------------------

function modifier_sets:GetModifierProcAttack_Feedback(params)
	if self.desolator > 0 then
		local mod_desolator = params.target:FindModifierByName("modifier_desolator_set")
		if mod_desolator then
			if mod_desolator.armor_reduction < self.desolator * self.full_set then
				params.target:AddNewModifier(
					self:GetParent(),
					self,
					"modifier_desolator_set",
					{ duration = 5, armor_reduction = self.desolator * self.full_set }
				)
			end
		else
			params.target:AddNewModifier(
				self:GetParent(),
				self,
				"modifier_desolator_set",
				{ duration = 5, armor_reduction = self.desolator * self.full_set }
			)
		end
	end
	if IsServer() then
		if self.crit > 0 and self.record and self.record == params.record then
			self.record = nil
			EmitSoundOn("Hero_Juggernaut.BladeDance", params.target)
		end
	end
end

function modifier_sets:GetModifierProcAttack_BonusDamage_Magical(keys)
	if
		not self:GetParent():IsIllusion()
		and not keys.target:IsBuilding()
		and RandomInt(1, 100) <= 40
		and self.mkb > 0
	then
		local damage = self.mkb * self.full_set
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, keys.target, damage, nil)
		self:GetParent():EmitSound("DOTA_Item.MKB.proc")
		return damage
	end
end

function modifier_sets:OnAttackLanded(params)
	if IsServer() then
		local attacker = self:GetParent()
		if attacker ~= params.attacker then
			return
		end
		local heal = params.damage * self.lifesteal * self.full_set / 100
		if heal > 1 then
			self:GetParent():Heal(heal, self:GetAbility())
			self:PlayEffects(self:GetParent())
		end
	end

	if
		RandomInt(1, 100) <= 10
		and self.mjolnir > 0
		and params.attacker == self:GetParent()
		and self.bChainCooldown == false
		and self:GetParent():IsAlive()
		and not self:GetParent():IsIllusion()
		and not params.target:IsMagicImmune()
		and not params.target:IsBuilding()
		and not params.target:IsOther()
		and self:GetParent():GetTeamNumber() ~= params.target:GetTeamNumber()
	then
		self:GetParent():EmitSound("Item.Maelstrom.Chain_Lightning")
		self:GetParent():AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_set_mjolnir_strike",
			{ starting_unit_entindex = params.target:entindex(), damage = self.mjolnir * self.full_set }
		)
		self.bChainCooldown = true
		self:StartIntervalThink(1)
	end
end

function modifier_sets:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_sets:OnTakeDamage(keys)
	if not IsServer() then
		return
	end

	self:OnTakeDamageMagicLifesteal(keys)
	self:OnTakeDamageReflect(keys)
	self:OnTakeDamageMjolnirArmor(keys)
end

local magicLifestealIgnoredInflictors = {
	["sven_great_cleave_lua"] = true,
	["kunkka_tidebringer_custom"] = true,
	["magnus_empower_custom"] = true,
}

function modifier_sets:OnTakeDamageMagicLifesteal(keys)
	local parent = self:GetParent()
	if parent ~= keys.attacker then
		return
	end

	local magicLifestealPct = self.magic_lifesteal
	if magicLifestealPct <= 0 then
		return
	end

	if keys.unit == keys.attacker then
		return
	end
	if keys.unit:IsBuilding() then
		return
	end
	if keys.unit:IsOther() then
		return
	end
	if keys.damage_category ~= DOTA_DAMAGE_CATEGORY_SPELL then
		return
	end

	local inflictor = keys.inflictor
	if not inflictor then
		return
	end

	if bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
		return
	end
	if bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL) == DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL then
		return
	end

	if magicLifestealIgnoredInflictors[inflictor:GetName()] then
		return
	end

	local lifesteal = keys.original_damage * magicLifestealPct / 100 * self.full_set
	if lifesteal <= 1 then
		return
	end

	self.lifesteal_pfx = ParticleManager:CreateParticle(
		"particles/items3_fx/octarine_core_lifesteal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		keys.attacker
	)
	ParticleManager:SetParticleControl(self.lifesteal_pfx, 0, keys.attacker:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(self.lifesteal_pfx)

	keys.attacker:Heal(lifesteal, self)
end

function modifier_sets:OnTakeDamageReflect(keys)
	local parent = self:GetParent()
	if parent ~= keys.unit then
		return
	end

	local reflectPct = self.reflect
	if reflectPct <= 0 then
		return
	end

	if keys.attacker:IsBuilding() then
		return
	end
	if keys.attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end

	if bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then
		return
	end
	if bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
		return
	end

	ApplyDamage({
		victim = keys.attacker,
		attacker = keys.unit,
		damage = keys.damage * reflectPct / 100 * self.full_set,
		damage_type = DAMAGE_TYPE_PURE, --keys.damage_type,
		damage_flags = DOTA_DAMAGE_FLAG_REFLECTION
			+ DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL
			+ DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
			+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
	})
end

function modifier_sets:OnTakeDamageMjolnirArmor(keys)
	local parent = self:GetParent()
	if parent ~= keys.unit then
		return
	end

	local mjolnirArmorDamage = self.mjolnir_armor
	if mjolnirArmorDamage <= 0 then
		return
	end

	if self.mjolnirArmorOnCooldown then
		return
	end

	local attacker = keys.attacker
	if attacker == parent then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end

	if keys.damage < 5 then
		return
	end

	if RandomInt(1, 100) >= 10 then
		return
	end

	local nearbyUnits = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		parent,
		700,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
		FIND_ANY_ORDER,
		false
	)
	local nearbyUnitsLen = #nearbyUnits

	local leftStaticStrikes = 3

	for i = 1, nearbyUnitsLen do
		local enemy = nearbyUnits[i]

		local particle =
			ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
		ParticleManager:SetParticleControlEnt(
			particle,
			0,
			enemy,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			enemy:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			particle,
			1,
			parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle)

		ApplyDamage({
			attacker = self:GetCaster(),
			victim = enemy,
			damage = mjolnirArmorDamage * self.full_set,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			ability = self:GetAbility(),
		})

		leftStaticStrikes = leftStaticStrikes - 1

		if leftStaticStrikes <= 0 then
			break
		end
	end

	if nearbyUnitsLen > 0 then
		parent:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")
	end

	self.mjolnirArmorOnCooldown = true
	Timers:CreateTimer(0.3, function()
		if self:IsNull() then
			return
		end

		self.mjolnirArmorOnCooldown = false
	end)
end

---------------- magic desolator ------------------------

function modifier_sets:GetModifierTotalDamageOutgoing_Percentage(params)
	if self.magic_desolator <= 0 then
		return
	end
	if params.attacker ~= self:GetParent() then
		return
	end
	if params.target == params.attacker then
		return
	end
	if params.target:IsBuilding() then
		return
	end
	if params.target:IsOther() then
		return
	end

	local mod_magic_desolator = params.target:FindModifierByName("modifier_magic_desolator_set")
	if mod_magic_desolator then
		if mod_magic_desolator.armor_reduction < self.magic_desolator * self.full_set then
			params.target:AddNewModifier(
				self:GetParent(),
				self,
				"modifier_magic_desolator_set",
				{ duration = 5, armor_reduction = self.magic_desolator * self.full_set }
			)
		end
	else
		params.target:AddNewModifier(
			self:GetParent(),
			self,
			"modifier_magic_desolator_set",
			{ duration = 5, armor_reduction = self.magic_desolator * self.full_set }
		)
	end
end

----------------------------------BASE----------------------------------------------------------

function modifier_sets:GetModifierHealthRegenPercentage()
	return self.hp_regen * self.full_set
end

function modifier_sets:GetModifierHealthBonus()
	return self.head * self.full_set
end

function modifier_sets:GetModifierPhysicalArmorBonus()
	return self.armor * self.full_set
end

function modifier_sets:GetModifierPreAttack_BonusDamage()
	return self.weapon * self.full_set
end

function modifier_sets:GetModifierSpellAmplify_Percentage()
	return self.legs * self.full_set
end

function modifier_sets:GetModifierMoveSpeedBonus_Constant()
	return self.boots * self.full_set
end

function modifier_sets:GetModifierMagicalResistanceBonus()
	return self.shield * self.full_set
end

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

modifier_set_mjolnir_strike = class({})

function modifier_set_mjolnir_strike:IsHidden()
	return true
end
function modifier_set_mjolnir_strike:IsPurgable()
	return false
end
function modifier_set_mjolnir_strike:RemoveOnDeath()
	return false
end
function modifier_set_mjolnir_strike:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_set_mjolnir_strike:OnCreated(keys)
	self.static_damage = keys.damage
	self.static_radius = 600
	self.static_strikes = 3
	self.jump_delay = 0.1
	self.starting_unit_entindex = keys.starting_unit_entindex
	self.units_affected = {}
	if self.starting_unit_entindex and EntIndexToHScript(self.starting_unit_entindex) then
		self.current_unit = EntIndexToHScript(self.starting_unit_entindex)
		self.units_affected[self.current_unit] = 1

		ApplyDamage({
			victim = self.current_unit,
			damage = self.static_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
				+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			attacker = self:GetCaster(),
			ability = self:GetAbility(),
		})
	else
		self:Destroy()
		return
	end

	self.unit_counter = 0

	self:StartIntervalThink(self.jump_delay)
end

function modifier_set_mjolnir_strike:OnIntervalThink()
	self.zapped = false

	if
		self.current_unit
			and not self.current_unit:IsNull()
			and self.current_unit:IsAlive()
			and (self.unit_counter >= self.static_strikes and self.static_strikes > 0)
		or not self.zapped
	then
		for _, enemy in
			pairs(
				FindUnitsInRadius(
					self:GetCaster():GetTeamNumber(),
					self.current_unit:GetAbsOrigin(),
					self.current_unit,
					self.static_radius,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
					FIND_CLOSEST,
					false
				)
			)
		do
			if not self.units_affected[enemy] and enemy ~= self.current_unit and enemy ~= self.previous_unit then
				enemy:EmitSound("Hero_Zuus.ArcLightning.Target")

				self.lightning_particle = ParticleManager:CreateParticle(
					"particles/items_fx/chain_lightning.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self.current_unit
				)
				ParticleManager:SetParticleControlEnt(
					self.lightning_particle,
					0,
					self.current_unit,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					self.current_unit:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(
					self.lightning_particle,
					1,
					enemy,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					enemy:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControl(self.lightning_particle, 62, Vector(2, 0, 2))
				ParticleManager:ReleaseParticleIndex(self.lightning_particle)

				self.unit_counter = self.unit_counter + 1
				self.previous_unit = self.current_unit
				self.current_unit = enemy

				if self.units_affected[self.current_unit] then
					self.units_affected[self.current_unit] = self.units_affected[self.current_unit] + 1
				else
					self.units_affected[self.current_unit] = 1
				end

				self.zapped = true

				ApplyDamage({
					victim = enemy,
					damage = self.static_damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
						+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
					attacker = self:GetCaster(),
				})
				break
			end
		end

		if (self.unit_counter >= self.static_strikes and self.static_strikes > 0) or not self.zapped then
			self:StartIntervalThink(-1)
			self:Destroy()
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

modifier_desolator_set = class({})

function modifier_desolator_set:IsHidden()
	return false
end

function modifier_desolator_set:IsDebuff()
	return true
end

function modifier_desolator_set:IsPurgable()
	return true
end

function modifier_desolator_set:GetTexture()
	return "set_desolator"
end

function modifier_desolator_set:OnCreated(data)
	if not IsServer() then
		return
	end
	self.armor_reduction = 0
	if data.armor_reduction then
		self.armor_reduction = data.armor_reduction
	end
	self.interval = false
	self:SetHasCustomTransmitterData(true)
end

function modifier_desolator_set:OnRefresh(data)
	if not IsServer() then
		return
	end
	if self.armor_reduction < data.armor_reduction then
		self.armor_reduction = data.armor_reduction
		self.caster = self:GetCaster()
	end
	if self.interval and self.armor_reduction == data.armor_reduction then
		self:StartIntervalThink(5)
	end
	if self.armor_reduction > data.armor_reduction and self.caster ~= self:GetCaster() and not self.interval then
		self.interval = true
		self:StartIntervalThink(5)
	end
	self:SendBuffRefreshToClients()
end

function modifier_desolator_set:OnIntervalThink()
	self:Destroy()
end

function modifier_desolator_set:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_desolator_set:GetModifierPhysicalArmorBonus()
	return self.armor_reduction * -1
end

function modifier_desolator_set:AddCustomTransmitterData()
	return {
		armor_reduction = self.armor_reduction,
	}
end

function modifier_desolator_set:HandleCustomTransmitterData(data)
	self.armor_reduction = data.armor_reduction
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

modifier_magic_desolator_set = class({})

function modifier_magic_desolator_set:IsHidden()
	return false
end

function modifier_magic_desolator_set:IsDebuff()
	return true
end

function modifier_magic_desolator_set:IsPurgable()
	return true
end

function modifier_magic_desolator_set:GetTexture()
	return "set_magic_desolator"
end

function modifier_magic_desolator_set:OnCreated(data)
	if not IsServer() then
		return
	end
	self.armor_reduction = 0
	if data.armor_reduction then
		self.armor_reduction = data.armor_reduction
	end
	self.interval = false
	self:SetHasCustomTransmitterData(true)
end

function modifier_magic_desolator_set:OnRefresh(data)
	if not IsServer() then
		return
	end
	if self.armor_reduction < data.armor_reduction then
		self.armor_reduction = data.armor_reduction
		self.caster = self:GetCaster()
	end
	if self.interval and self.armor_reduction == data.armor_reduction then
		self:StartIntervalThink(5)
	end
	if self.armor_reduction > data.armor_reduction and self.caster ~= self:GetCaster() and not self.interval then
		self.interval = true
		self:StartIntervalThink(5)
	end
	self:SendBuffRefreshToClients()
end

function modifier_magic_desolator_set:OnIntervalThink()
	self:Destroy()
end

function modifier_magic_desolator_set:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_magic_desolator_set:GetModifierMagicalResistanceBonus()
	return self.armor_reduction * -1
end

function modifier_magic_desolator_set:AddCustomTransmitterData()
	return {
		armor_reduction = self.armor_reduction,
	}
end

function modifier_magic_desolator_set:HandleCustomTransmitterData(data)
	self.armor_reduction = data.armor_reduction
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

modifier_multicast_lua_proc = class({})

function modifier_multicast_lua_proc:IsHidden()
	return false
end

function modifier_multicast_lua_proc:IsDebuff()
	return false
end

function modifier_multicast_lua_proc:IsStunDebuff()
	return false
end

function modifier_multicast_lua_proc:IsPurgable()
	return true
end

function modifier_multicast_lua_proc:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_multicast_lua_proc:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.caster = self:GetParent()
	self.ability = EntIndexToHScript(kv.ability)
	self.target = EntIndexToHScript(kv.target)
	self.multicast = 2
	self.delay = 0.5
	self.buffer_range = 200

	self:SetStackCount(self.multicast)

	self.casts = 0
	if self.multicast == 1 then
		self:Destroy()
		return
	end

	self.targets = {}
	self.targets[self.target] = true

	self.radius = self.ability:GetCastRange(self.target:GetOrigin(), self.target) + self.buffer_range

	self.target_team = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	if self.target:GetTeamNumber() ~= self.caster:GetTeamNumber() then
		self.target_team = DOTA_UNIT_TARGET_TEAM_ENEMY
	end

	self.target_type = self.ability:GetAbilityTargetType()
	if self.target_type == DOTA_UNIT_TARGET_CUSTOM then
		self.target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	end

	self.target_flags = DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
	if bit.band(self.ability:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
		self.target_flags = self.target_flags + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	end

	self:PlayEffects(self.casts)
	self:StartIntervalThink(self.delay)
end

function modifier_multicast_lua_proc:OnIntervalThink()
	self.caster:SetCursorCastTarget(self.target)
	self.ability:OnSpellStart()
	self.casts = self.casts + 1
	if self.casts >= (self.multicast - 1) then
		self:StartIntervalThink(-1)
		self:Destroy()
	end
	self:PlayEffects(self.casts)
end

function modifier_multicast_lua_proc:PlayEffects(value)
	value = value + 1

	local counter_speed = 2
	if value == self.multicast then
		counter_speed = 1
	end

	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self.caster
	)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(value, counter_speed, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local sound = math.min(value - 1, 3)
	local sound_cast = "Hero_OgreMagi.Fireblast.x" .. sound
	if sound > 0 then
		EmitSoundOn(sound_cast, self.caster)
	end
end