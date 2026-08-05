--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


abaddon_mist_coil_lua = class({})

function abaddon_mist_coil_lua:GetAOERadius()
	local ability = self:GetCaster():FindAbilityByName("special_bonus_unique_abaddon_lua_8")
	if ability ~= nil and ability:GetLevel() > 0 then
		return 300
	end
	return 0
end

function abaddon_mist_coil_lua:GetBehavior()
	local ability = self:GetCaster():FindAbilityByName("special_bonus_unique_abaddon_lua_8")
	if ability ~= nil and ability:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function abaddon_mist_coil_lua:OnSpellStart(unit, ult_cast)
	local caster = self:GetCaster()
	local ability = self:GetCaster():FindAbilityByName("special_bonus_unique_abaddon_lua_8")
	if ability ~= nil and ability:GetLevel() > 0 and not ult_cast then
		targets = FindUnitsInRadius(
			caster:GetTeamNumber(),
			self:GetCursorPosition(),
			nil,
			300,
			DOTA_UNIT_TARGET_TEAM_BOTH,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
		if #targets > 0 then
			for _, target in pairs(targets) do
				self:cast(target)
			end
		else
			self:cast(caster)
		end
	else
		target = unit or self:GetCursorTarget()
		self:cast(target)
	end
end

function abaddon_mist_coil_lua:cast(target)
	local caster = self:GetCaster()
	local self_damage = self:GetSpecialValueFor("self_damage")
	local ability = self:GetCaster():FindAbilityByName("special_bonus_abaddon_3")
	if ability ~= nil and ability:GetLevel() > 0 then
		self_damage = self_damage + 150
	end

	local projectile_speed = self:GetSpecialValueFor("missile_speed")
	local info = {
		Target = target,
		Source = caster,
		Ability = self,

		EffectName = "particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true, -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)

	local damageTable = {
		victim = caster,
		attacker = caster,
		damage = self_damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	self:PlayEffects()
end

function abaddon_mist_coil_lua:OnProjectileHit(target, location)
	local ally = false
	self.heal_amount = self:GetSpecialValueFor("damage")
	local ability = self:GetCaster():FindAbilityByName("special_bonus_abaddon_3")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.heal_amount = self.heal_amount + 150
	end

	if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		ally = true
	end

	if ally then
		target:Heal(self.heal_amount, self:GetCaster())
	else
		if target:IsInvulnerable() or target:TriggerSpellAbsorb(self) then
			return
		end

		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = self.heal_amount,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)
	end
	local sound_target = "Hero_Abaddon.DeathCoil.Target"
	EmitSoundOn(sound_target, target)
end

function abaddon_mist_coil_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_abaddon/abaddon_death_coil_abaddon.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Abaddon.DeathCoil.Cast", self:GetCaster())
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_abaddon_aphotic_shield_lua", "heroes/hero_abaddon/hero_abaddon", LUA_MODIFIER_MOTION_NONE)

abaddon_aphotic_shield_lua = class({})

function abaddon_aphotic_shield_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	target:Purge(false, true, false, true, false)
	target:RemoveModifierByName("modifier_abaddon_aphotic_shield_lua")

	self.absorb = self:GetSpecialValueFor("damage_absorb")

	target:AddNewModifier(caster, self, "modifier_abaddon_aphotic_shield_lua", {
		duration = self:GetSpecialValueFor("duration"),
		absorb = self.absorb,
	})

	target:EmitSound("Hero_Abaddon.AphoticShield.Cast")
end

----------------------------------------------------------------

modifier_abaddon_aphotic_shield_lua = class({})

function modifier_abaddon_aphotic_shield_lua:IsHidden()
	return false
end

function modifier_abaddon_aphotic_shield_lua:IsPurgable()
	return false
end

function modifier_abaddon_aphotic_shield_lua:OnCreated(data)
	if not IsServer() then
		return
	end
	self.absorb = data.absorb
	self.absorbAmount = 0
	self.parent = self:GetParent()
	local shield_size = 70
	self.nfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_abaddon/abaddon_aphotic_shield.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.nfx, 1, Vector(shield_size, 0, shield_size))
	ParticleManager:SetParticleControl(self.nfx, 2, Vector(shield_size, 0, shield_size))
	ParticleManager:SetParticleControl(self.nfx, 4, Vector(shield_size, 0, shield_size))
	ParticleManager:SetParticleControl(self.nfx, 5, Vector(shield_size, 0, 0))
	ParticleManager:SetParticleControlEnt(
		self.nfx,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
end

function modifier_abaddon_aphotic_shield_lua:OnDestroy()
	if not IsServer() then
		return
	end

	local nfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		nfx,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(nfx)

	local units = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetOrigin(),
		nil,
		self:GetAbility():GetSpecialValueFor("radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		self:GetAbility():GetAbilityTargetType(),
		self:GetAbility():GetAbilityTargetFlags(),
		FIND_ANY_ORDER,
		false
	)

	local damage_type = self:GetAbility():GetAbilityDamageType()
	for __, v in pairs(units) do
		ApplyDamage({
			victim = v,
			attacker = self:GetCaster(),
			damage = self.absorb,
			damage_type = damage_type,
			ability = self:GetAbility(),
		})
	end
	ParticleManager:DestroyParticle(self.nfx, true)
	ParticleManager:ReleaseParticleIndex(self.nfx)
	self:GetParent():EmitSound("Hero_Abaddon.AphoticShield.Destroy")
end

function modifier_abaddon_aphotic_shield_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end

function modifier_abaddon_aphotic_shield_lua:GetModifierIncomingDamage_Percentage(data)
	self.absorbAmount = self.absorbAmount + data.damage
	if self.absorbAmount > self.absorb then
		self:Destroy()
	end
	return -100
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_abaddon_curse_of_avernus_lua_debuff",
	"heroes/hero_abaddon/hero_abaddon",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_abaddon_curse_of_avernus_lua_debuff_slow",
	"heroes/hero_abaddon/hero_abaddon",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_abaddon_curse_of_avernus_lua", "heroes/hero_abaddon/hero_abaddon", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_abaddon_curse_of_avernus_lua_buff",
	"heroes/hero_abaddon/hero_abaddon",
	LUA_MODIFIER_MOTION_NONE
)

abaddon_curse_of_avernus_lua = class({})

function abaddon_curse_of_avernus_lua:GetIntrinsicModifierName()
	return "modifier_abaddon_curse_of_avernus_lua"
end

-----------------------------------------------------------------------------------------------

modifier_abaddon_curse_of_avernus_lua = class({})

function modifier_abaddon_curse_of_avernus_lua:IsHidden()
	return true
end

function modifier_abaddon_curse_of_avernus_lua:IsPurgable()
	return false
end

function modifier_abaddon_curse_of_avernus_lua:IsPermanent()
	return true
end

function modifier_abaddon_curse_of_avernus_lua:OnCreated()
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal")
end

function modifier_abaddon_curse_of_avernus_lua:OnRefresh()
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal")
end

function modifier_abaddon_curse_of_avernus_lua:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_abaddon_curse_of_avernus_lua:OnAttackLanded(data)
	if not IsServer() then
		return
	end
	if data.attacker ~= self:GetParent() then
		return
	end
	if data.target:HasModifier("modifier_abaddon_curse_of_avernus_lua_debuff") then
		ApplyDamage({
			victim = data.target,
			attacker = data.attacker,
			damage = self.lifesteal,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
				+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
		})

		data.attacker:Heal(self.lifesteal, self:GetParent())
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, data.attacker, self.lifesteal, nil)
	end

	if not data.target:HasModifier("modifier_abaddon_curse_of_avernus_lua_debuff") then
		local modifier = data.target:AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_abaddon_curse_of_avernus_lua_debuff_slow",
			{ duration = self.duration }
		)
		modifier:SetStackCount(modifier:GetStackCount() + 1)
		modifier:UpdateCounter()

		count = self:GetAbility():GetSpecialValueFor("hit_count")

		if modifier:GetStackCount() >= count then
			modifier:Destroy()
			data.target:AddNewModifier(
				self:GetCaster(),
				self:GetAbility(),
				"modifier_abaddon_curse_of_avernus_lua_debuff",
				{ duration = self.duration }
			)
			data.attacker:AddNewModifier(
				self:GetCaster(),
				self:GetAbility(),
				"modifier_abaddon_curse_of_avernus_lua_buff",
				{ duration = self.duration }
			)
			data.target:EmitSound("Hero_Abaddon.Curse.Proc")
		end
	end
end

-----------------------------------------------------------------------------------------------

modifier_abaddon_curse_of_avernus_lua_buff = class({})

function modifier_abaddon_curse_of_avernus_lua_buff:IsHidden()
	return true
end

function modifier_abaddon_curse_of_avernus_lua_buff:IsPurgable()
	return false
end

function modifier_abaddon_curse_of_avernus_lua_buff:DeclareFunctions()
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
end

function modifier_abaddon_curse_of_avernus_lua_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_as")
end

-----------------------------------------------------------------------------------------------

modifier_abaddon_curse_of_avernus_lua_debuff = class({})

function modifier_abaddon_curse_of_avernus_lua_debuff:IsHidden()
	return true
end

function modifier_abaddon_curse_of_avernus_lua_debuff:IsPurgable()
	return false
end

-----------------------------------------------------------------------------------------------

modifier_abaddon_curse_of_avernus_lua_debuff_slow = class({})

function modifier_abaddon_curse_of_avernus_lua_debuff_slow:IsHidden()
	return true
end

function modifier_abaddon_curse_of_avernus_lua_debuff_slow:IsPurgable()
	return false
end

function modifier_abaddon_curse_of_avernus_lua_debuff_slow:OnCreated()
	if not IsServer() then
		return
	end
	self.nfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_abaddon/abaddon_curse_counter_stack.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.nfx, 1, Vector(0, 1, 0))
end

function modifier_abaddon_curse_of_avernus_lua_debuff_slow:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_abaddon_curse_of_avernus_lua_debuff_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("movement_speed")
end

function modifier_abaddon_curse_of_avernus_lua_debuff_slow:OnDestroy()
	if not IsServer() then
		return
	end
	ParticleManager:DestroyParticle(self.nfx, true)
	ParticleManager:ReleaseParticleIndex(self.nfx)
end

function modifier_abaddon_curse_of_avernus_lua_debuff_slow:UpdateCounter()
	ParticleManager:SetParticleControl(self.nfx, 1, Vector(0, self:GetStackCount(), 0))
end

------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------

LinkLuaModifier(
	"modifier_abaddon_borrowed_time_lua_active",
	"heroes/hero_abaddon/hero_abaddon",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_abaddon_borrowed_time_lua_passive",
	"heroes/hero_abaddon/hero_abaddon",
	LUA_MODIFIER_MOTION_NONE
)

abaddon_borrowed_time_lua = class({})

function abaddon_borrowed_time_lua:GetIntrinsicModifierName()
	return "modifier_abaddon_borrowed_time_lua_passive"
end

function abaddon_borrowed_time_lua:OnSpellStart()
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_abaddon_borrowed_time_lua_active",
		{ duration = self:GetSpecialValueFor("duration") }
	)
	self:GetCaster():EmitSound("Hero_Abaddon.BorrowedTime")
end

------------------------------------------------------------------------

modifier_abaddon_borrowed_time_lua_passive = class({})

function modifier_abaddon_borrowed_time_lua_passive:IsHidden()
	return true
end

function modifier_abaddon_borrowed_time_lua_passive:IsPurgable()
	return false
end

function modifier_abaddon_borrowed_time_lua_passive:IsPermanent()
	return true
end

function modifier_abaddon_borrowed_time_lua_passive:OnCreated()
	self.hp_threshold = self:GetAbility():GetSpecialValueFor("hp_threshold")
end

function modifier_abaddon_borrowed_time_lua_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_abaddon_borrowed_time_lua_passive:GetModifierIncomingDamage_Percentage(data)
	if
		self:GetParent():GetHealth() - data.damage <= self.hp_threshold
		and self:GetAbility():IsCooldownReady()
		and not self:GetParent():HasModifier("modifier_abaddon_aphotic_shield_lua")
	then
		self:GetAbility():OnSpellStart()
		self:GetAbility():UseResources(false, false, false, true)
		return -100
	end
	return 0
end

---------------------------------------------------------------------------

modifier_abaddon_borrowed_time_lua_active = class({})

function modifier_abaddon_borrowed_time_lua_active:IsHidden()
	return false
end

function modifier_abaddon_borrowed_time_lua_active:IsPurgable()
	return false
end

function modifier_abaddon_borrowed_time_lua_active:GetStatusEffectName()
	return "particles/status_fx/status_effect_abaddon_borrowed_time.vpcf"
end

function modifier_abaddon_borrowed_time_lua_active:GetEffectName()
	return "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf"
end

function modifier_abaddon_borrowed_time_lua_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_abaddon_borrowed_time_lua_active:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_abaddon_borrowed_time_lua_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		-- MODIFIER_EVENT_ON_TAKEDAMAGE
	}
end

function modifier_abaddon_borrowed_time_lua_active:GetModifierIncomingDamage_Percentage(data)
	if not IsServer() then
		return
	end
	self:GetParent():Heal(data.damage, self:GetParent())
	return -100
end

function modifier_abaddon_borrowed_time_lua_active:OnCreated()
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.caster:Purge(false, true, true, true, false)
end

function modifier_abaddon_borrowed_time_lua_active:OnCreated(kv)
	local ability = self:GetCaster():FindAbilityByName("special_bonus_unique_abaddon_lua_7")
	if ability ~= nil and ability:GetLevel() > 0 then
		self:StartIntervalThink(1)
	end
end

function modifier_abaddon_borrowed_time_lua_active:OnIntervalThink()
	if not IsServer() then
		return
	end
	local ability = self:GetCaster():FindAbilityByName("abaddon_mist_coil_lua")
	if ability then
		local allies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetOrigin(),
			self:GetParent(),
			500,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO,
			0,
			0,
			false
		)
		for _, ally in pairs(allies) do
			if ally ~= self:GetCaster() then
				ability:OnSpellStart(ally, true)
			end
		end
	end
end