--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


shadow_shaman_ether_shock_lua = class({})

function shadow_shaman_ether_shock_lua:OnSpellStart()
	local target = self:GetCursorTarget()
	count = self:GetSpecialValueFor("targets")

	if not IsServer() then
		return
	end
	damage = self:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")

	if target:TriggerSpellAbsorb(self) then
		return
	end

	self:GetCaster():EmitSound("Hero_ShadowShaman.EtherShock")

	if self:GetCaster():GetName() == "npc_dota_hero_shadow_shaman" and RollPercentage(75) then
		self:GetCaster():EmitSound("shadowshaman_shad_ability_ether_0" .. RandomInt(1, 4))
	end

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		target:GetAbsOrigin(),
		target,
		500,
		self:GetAbilityTargetTeam(),
		self:GetAbilityTargetType(),
		self:GetAbilityTargetFlags(),
		FIND_CLOSEST,
		false
	)

	local enemies_hit = 0
	local attachment

	for _, enemy in pairs(enemies) do
		if enemies_hit < count then
			enemy:EmitSound("Hero_ShadowShaman.EtherShock.Target")

			local ether_shock_particle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_shadowshaman/shadowshaman_ether_shock.vpcf",
				PATTACH_POINT_FOLLOW,
				self:GetCaster()
			)

			if enemies_hit % 2 == 1 then
				attachment = "attach_attack1"
			else
				attachment = "attach_attack2"
			end

			ParticleManager:SetParticleControlEnt(
				ether_shock_particle,
				0,
				self:GetCaster(),
				PATTACH_POINT_FOLLOW,
				attachment,
				self:GetCaster():GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControl(ether_shock_particle, 1, enemy:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(ether_shock_particle)

			local damageTable = {
				victim = enemy,
				damage = damage,
				damage_type = self:GetAbilityDamageType(),
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				attacker = self:GetCaster(),
				ability = self,
			}

			ApplyDamage(damageTable)

			enemies_hit = enemies_hit + 1
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_shaman_hex_thinker", "heroes/hero_shaman/hero_shaman", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_shaman_hex_logic", "heroes/hero_shaman/hero_shaman", LUA_MODIFIER_MOTION_NONE)

shaman_hex = class({})

function shaman_hex:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:EmitSound("Hero_ShadowShaman.Hex.Target")
	caster:AddNewModifier(caster, self, "modifier_shaman_hex_thinker", { duration = duration })
end

-------------------------------------------------------------------------------

modifier_shaman_hex_thinker = class({})

function modifier_shaman_hex_thinker:IsHidden()
	return true
end

function modifier_shaman_hex_thinker:OnCreated()
	if not IsServer() then
		return
	end
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	local delay = 0.5

	self:StartIntervalThink(delay)
end

function modifier_shaman_hex_thinker:OnIntervalThink()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local point = caster:GetAbsOrigin()
	caster:EmitSound("Hero_ShadowShaman.Hex.Target")

	local spawn_hex = CreateUnitByName(
		"npc_shaman_hex",
		point + RandomVector(RandomInt(50, 150)),
		true,
		caster,
		caster,
		caster:GetTeamNumber()
	)
	spawn_hex:SetControllableByPlayer(caster:GetPlayerID(), true)
	spawn_hex:AddNewModifier(caster, ability, "modifier_shaman_hex_logic", {})
	spawn_hex:AddNewModifier(caster, ability, "modifier_kill", { duration = ability:GetSpecialValueFor("duration") })
end

-------------------------------------------------------------------------------

modifier_shaman_hex_logic = class({})

function modifier_shaman_hex_logic:IsHidden()
	return false
end
function modifier_shaman_hex_logic:IsPurgable()
	return false
end

function modifier_shaman_hex_logic:OnCreated()
	if IsServer() then
		self.caster = self:GetCaster()
		self.parent = self:GetParent()
		self.ability = self:GetAbility()
		self.player = self.caster:GetOwner()

		-- Радиусы в KV одиночные, читаем один раз вместо каждого тика.
		self.activation_radius = self.ability:GetSpecialValueFor("activation_radius")
		self.damage_radius = self.ability:GetSpecialValueFor("damage_radius")

		self:StartIntervalThink(0.1)
	end
end

function modifier_shaman_hex_logic:DeclareFunctions()
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end

function modifier_shaman_hex_logic:GetModifierSpellAmplify_Percentage()
	if IsServer() and self.caster then
		return self.caster:GetSpellAmplification(false) * 100
	end
	return 0
end

function modifier_shaman_hex_logic:OnIntervalThink()
	if not IsServer() then
		return
	end

	if not self.parent:IsAlive() then
		self:Destroy()
		return
	end

	local center = self.parent:GetAbsOrigin()

	local nearbyEnemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		center,
		self.parent,
		self.activation_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	if #nearbyEnemies > 0 then
		-- Урон считаем в момент взрыва, а не на каждом тике ожидания:
		-- он зависит от текущего интеллекта, кешировать его нельзя.
		local damage = self.ability:GetSpecialValueFor("damage")
			+ self.caster:ExtraIntelligenceDamage() * self.ability:GetSpecialValueFor("ExtraIntelligenceDamage")

		EmitSoundOn("Hero_Techies.RemoteMine.Detonate", self.parent)
		local particle_explosion = "particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf"
		local fx = ParticleManager:CreateParticle(particle_explosion, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(fx, 0, center)
		ParticleManager:SetParticleControl(fx, 1, Vector(self.damage_radius, 1, 1))
		ParticleManager:ReleaseParticleIndex(fx)

		local targets = FindUnitsInRadius(
			self.caster:GetTeamNumber(),
			center,
			self.parent,
			self.damage_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(targets) do
			ApplyDamage({
				victim = enemy,
				attacker = self.caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
				ability = self.ability,
			})
		end
		self.parent:ForceKill(false)
		self:Destroy()
	end
end

function modifier_shaman_hex_logic:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_shaman_shackles", "heroes/hero_shaman/hero_shaman", LUA_MODIFIER_MOTION_NONE)

shaman_shackles = class({})

function shaman_shackles:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")

	if target:TriggerSpellAbsorb(self) then
		caster:Interrupt()
		return
	end

	caster:EmitSound("Hero_ShadowShaman.Shackles.Cast")

	local talent_aoe = caster:FindAbilityByName("special_bonus_unique_shadow_shaman_5")
	local targets = { target }

	if talent_aoe and talent_aoe:GetLevel() > 0 then
		local extra_enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target:GetAbsOrigin(),
			target,
			250,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in pairs(extra_enemies) do
			if enemy ~= target then
				table.insert(targets, enemy)
			end
		end
	end

	for _, victim in pairs(targets) do
		victim:AddNewModifier(caster, self, "modifier_shaman_shackles", { duration = duration })
	end
end

function shaman_shackles:OnChannelFinish(bInterrupted)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:StopSound("Hero_ShadowShaman.Shackles.Cast")
	caster:RemoveModifierByName("modifier_magic_immune")
end

-------------------------------------------------------------------------------

modifier_shaman_shackles = class({})

function modifier_shaman_shackles:IsPurgable()
	return false
end
function modifier_shaman_shackles:IsPurgeException()
	return true
end
function modifier_shaman_shackles:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_shaman_shackles:OnCreated()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()

	self.nFXIndex = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_shadowshaman/shadowshaman_shackle.vpcf",
		PATTACH_POINT_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControlEnt(
		self.nFXIndex,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.nFXIndex,
		1,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.nFXIndex,
		4,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.nFXIndex,
		5,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.nFXIndex,
		6,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(self.nFXIndex, true, false, -1, true, false)

	local tick_interval = ability:GetSpecialValueFor("tick_interval")
	local total_damage = ability:GetSpecialValueFor("total_damage")

	local damage = ability:GetSpecialValueFor("total_damage")
		+ caster:ExtraIntelligenceDamage() * ability:GetSpecialValueFor("ExtraIntelligenceDamage")

	self.damage_per_tick = total_damage / (ability:GetChannelTime() / tick_interval)

	self:StartIntervalThink(tick_interval)
end

function modifier_shaman_shackles:OnIntervalThink()
	if not IsServer() then
		return
	end

	if not self:GetAbility():IsChanneling() then
		self:Destroy()
		return
	end

	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage_per_tick,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
		ability = self:GetAbility(),
	})
end

function modifier_shaman_shackles:CheckState()
	return { [MODIFIER_STATE_STUNNED] = true }
end

function modifier_shaman_shackles:DeclareFunctions()
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end

function modifier_shaman_shackles:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_shadow_shaman_ward_logic", "heroes/hero_shaman/hero_shaman", LUA_MODIFIER_MOTION_NONE)

shaman_wards_custom = class({})

function shaman_wards_custom:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end

function shaman_wards_custom:GetAOERadius()
	return 150
end

function shaman_wards_custom:OnSpellStart()
	local caster = self:GetCaster()
	local position = self:GetCursorPosition()
	local count = self:GetSpecialValueFor("count")
	local sound_cast = "Hero_ShadowShaman.SerpentWard"
	EmitSoundOn(sound_cast, caster)

	for i = 1, count do
		shadow_ward = CreateUnitByName(
			"shadow_shaman_ward",
			position + RandomVector(RandomFloat(50, 50)),
			true,
			caster,
			nil,
			caster:GetTeam()
		)
		FindClearSpaceForUnit(shadow_ward, position, false)
		shadow_ward:SetControllableByPlayer(caster:GetPlayerID(), true)
		shadow_ward:SetOwner(caster)
		shadow_ward:AddNewModifier(caster, nil, "modifier_kill", { duration = self:GetSpecialValueFor("duration") })
		shadow_ward:AddNewModifier(caster, self, "modifier_shadow_shaman_ward_logic", {})
	end
end

-------------------------------------------------------------------------------

modifier_shadow_shaman_ward_logic = class({})

function modifier_shadow_shaman_ward_logic:IsHidden()
	return true
end
function modifier_shadow_shaman_ward_logic:IsPurgable()
	return false
end
function modifier_shadow_shaman_ward_logic:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_shadow_shaman_ward_logic:OnCreated()
	self:SetHasCustomTransmitterData(true)

	if IsServer() then
		local caster = self:GetCaster()
		local ability = self:GetAbility()

		self.as_per_agi = ability:GetSpecialValueFor("as_per_agi")
		self.dmg_per_int = ability:GetSpecialValueFor("dmg_per_int")

		local agi = caster:GetAgility()
		local int = caster:GetIntellect(true)

		self.bonus_dmg = math.floor(self.dmg_per_int * int)
		self.bonus_as = math.floor(self.as_per_agi * agi)

		self:SendBuffRefreshToClients()
	end
end

function modifier_shadow_shaman_ward_logic:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_DISABLE_HEALING,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_shadow_shaman_ward_logic:CheckState()
	return {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
end

function modifier_shadow_shaman_ward_logic:GetModifierIncomingDamage_Percentage()
	return -100
end

function modifier_shadow_shaman_ward_logic:GetDisableHealing()
	return 1
end

function modifier_shadow_shaman_ward_logic:OnAttackLanded(params)
	if IsServer() then
		if params.target == self:GetParent() then
			local parent = self:GetParent()
			local damage = 1

			if parent:GetHealth() > damage then
				parent:SetHealth(parent:GetHealth() - damage)
			else
				parent:ForceKill(false)
			end
		end
	end
end

function modifier_shadow_shaman_ward_logic:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_as
end

function modifier_shadow_shaman_ward_logic:GetModifierPreAttack_BonusDamage()
	return self.bonus_dmg
end

function modifier_shadow_shaman_ward_logic:AddCustomTransmitterData()
	return {
		bonus_as = self.bonus_as,
		bonus_dmg = self.bonus_dmg,
	}
end

function modifier_shadow_shaman_ward_logic:HandleCustomTransmitterData(data)
	self.bonus_as = tonumber(data.bonus_as)
	self.bonus_dmg = tonumber(data.bonus_dmg)
end