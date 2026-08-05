--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_ancient_apparition_cold_feet_lua_freeze",
	"heroes/hero_ancient_apparition/ancient_apparition",
	LUA_MODIFIER_MOTION_NONE
)

ancient_apparition_cold_feet_lua = class({})

function ancient_apparition_cold_feet_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function ancient_apparition_cold_feet_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:EmitSound("Hero_Ancient_Apparition.ColdFeetCast")

	local target_point = self:GetCursorPosition()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target_point,
		nil,
		self:GetSpecialValueFor("radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)
	for _, hEnemy in pairs(enemies) do
		hEnemy:AddNewModifier(caster, self, "modifier_ancient_apparition_cold_feet_lua_freeze", { duration = duration })
	end
end

---------------------------------------------------------------------------------------------------

modifier_ancient_apparition_cold_feet_lua_freeze = class({})

function modifier_ancient_apparition_cold_feet_lua_freeze:IsHidden()
	return true
end
function modifier_ancient_apparition_cold_feet_lua_freeze:IsPurgable()
	return false
end

function modifier_ancient_apparition_cold_feet_lua_freeze:GetEffectName()
	return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_frozen.vpcf"
end

function modifier_ancient_apparition_cold_feet_lua_freeze:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_ancient_apparition_cold_feet_lua_freeze:OnCreated()
	if not IsServer() then
		return
	end
	self.resist = self:GetAbility():GetSpecialValueFor("resist") * -1
	self:GetParent():EmitSound("Hero_Ancient_Apparition.ColdFeetFreeze")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")
	self:StartIntervalThink(0.5)
end

function modifier_ancient_apparition_cold_feet_lua_freeze:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
	return state
end

function modifier_ancient_apparition_cold_feet_lua_freeze:OnIntervalThink()
	if not IsServer() then
		return
	end
	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage / 2,
		damage_type = DAMAGE_TYPE_MAGICAL,
	})
end

function modifier_ancient_apparition_cold_feet_lua_freeze:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return decFuncs
end

function modifier_ancient_apparition_cold_feet_lua_freeze:GetModifierMagicalResistanceBonus()
	return self.magic_resist
end

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_ancient_apparition_ice_vortex_lua_aura",
	"heroes/hero_ancient_apparition/ancient_apparition",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_ancient_apparition_ice_vortex_lua_aura_effect",
	"heroes/hero_ancient_apparition/ancient_apparition",
	LUA_MODIFIER_MOTION_NONE
)

ancient_apparition_ice_vortex_lua = class({})

function ancient_apparition_ice_vortex_lua:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():EmitSound("Hero_Ancient_Apparition.IceVortexCast")
	caster:AddNewModifier(caster, self, "modifier_ancient_apparition_ice_vortex_lua_aura", { duration = duration })
end

---------------------------------------------------------------------------------------------------

modifier_ancient_apparition_ice_vortex_lua_aura = class({})

function modifier_ancient_apparition_ice_vortex_lua_aura:IsHidden()
	return true
end

function modifier_ancient_apparition_ice_vortex_lua_aura:OnCreated()
	local vortex_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ancient_apparition/ancient_anti_abrasion.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(vortex_particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(vortex_particle, 5, Vector(700, 0, 0))
	self:AddParticle(vortex_particle, false, false, -1, false, false)

	self.effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(700, 700, 1))
	self:AddParticle(self.effect_cast, false, false, -1, false, false)
end

function modifier_ancient_apparition_ice_vortex_lua_aura:IsDebuff()
	return false
end

function modifier_ancient_apparition_ice_vortex_lua_aura:IsPurgable()
	return false
end

function modifier_ancient_apparition_ice_vortex_lua_aura:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_ancient_apparition_ice_vortex_lua_aura:GetModifierAura()
	return "modifier_ancient_apparition_ice_vortex_lua_aura_effect"
end

function modifier_ancient_apparition_ice_vortex_lua_aura:GetAuraRadius()
	return 700
end

function modifier_ancient_apparition_ice_vortex_lua_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_ancient_apparition_ice_vortex_lua_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

------------------------------------------------------------------------------------------------

modifier_ancient_apparition_ice_vortex_lua_aura_effect = class({})

function modifier_ancient_apparition_ice_vortex_lua_aura_effect:IsHidden()
	return false
end

function modifier_ancient_apparition_ice_vortex_lua_aura_effect:IsDebuff()
	return false
end

function modifier_ancient_apparition_ice_vortex_lua_aura_effect:IsPurgable()
	return false
end

function modifier_ancient_apparition_ice_vortex_lua_aura_effect:OnCreated(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("slow") * -1
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_ancient_apparition_ice_vortex_lua_aura_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return funcs
end

function modifier_ancient_apparition_ice_vortex_lua_aura_effect:GetModifierMoveSpeedBonus_Percentage(keys)
	return self.slow
end

function modifier_ancient_apparition_ice_vortex_lua_aura_effect:GetModifierIncomingDamage_Percentage(keys)
	return self.damage
end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_ancient_apparition_chilling_touch_lua",
	"heroes/hero_ancient_apparition/ancient_apparition",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_generic_orb_effect_lua",
	"heroes/generic/modifier_generic_orb_effect_lua",
	LUA_MODIFIER_MOTION_NONE
)

ancient_apparition_chilling_touch_lua = class({})

function ancient_apparition_chilling_touch_lua:ProcsMagicStick()
	return false
end

function ancient_apparition_chilling_touch_lua:GetCooldown(level)
	local ability = self:GetCaster():FindAbilityByName("special_bonus_unique_ancient_apparition_7")
	if ability ~= nil and ability:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 2
	end
	return self.BaseClass.GetCooldown(self, level)
end

function ancient_apparition_chilling_touch_lua:GetManaCost(level)
	local mana_cost = self.BaseClass.GetManaCost(self, level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_ancient_apparition_6")
	if talent and talent:GetLevel() > 0 then
		return mana_cost - 10
	end
	return mana_cost
end

function ancient_apparition_chilling_touch_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

function ancient_apparition_chilling_touch_lua:GetProjectileName()
	return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch_projectile.vpcf"
end

function ancient_apparition_chilling_touch_lua:GetCastRange()
	return self:GetCaster():Script_GetAttackRange() + self:GetSpecialValueFor("attack_range_bonus")
end

function ancient_apparition_chilling_touch_lua:OnOrbFire()
	self:GetCaster():EmitSound("Hero_Ancient_Apparition.ChillingTouch.Cast")
end

function ancient_apparition_chilling_touch_lua:OnOrbImpact(keys)
	if keys.target:IsMagicImmune() then
		return
	end
	keys.target:EmitSound("Hero_Ancient_Apparition.ChillingTouch.Target")

	self.damage = self:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")

	count = 0
	local talent8 = self:GetCaster():FindAbilityByName("special_bonus_unique_ancient_apparition_8")
	if talent8 ~= nil and talent8:GetLevel() > 0 then
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			keys.target:GetOrigin(),
			keys.target,
			250,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			FIND_CLOSEST,
			false
		)
		if #enemies > 0 then
			for _, enemy in pairs(enemies) do
				if enemy ~= keys.target then
					count = count + 1

					local projectile = {
						Target = enemy,
						Source = keys.target,
						Ability = self,
						EffectName = "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf",
						iMoveSpeed = 600,
						vSourceLoc = keys.target:GetAbsOrigin(),
						bDrawsOnMinimap = false,
						bDodgeable = true,
						bIsAttack = false,
						bVisibleToEnemies = true,
						bReplaceExisting = false,
						flExpireTime = GameRules:GetGameTime() + 10,
						bProvidesVision = true,
						iVisionRadius = 400,
						iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
						ExtraData = extra_data,
					}

					ProjectileManager:CreateTrackingProjectile(projectile)

					ApplyDamage({
						victim = enemy,
						damage = self.damage,
						damage_type = DAMAGE_TYPE_MAGICAL,
						damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
						attacker = self:GetCaster(),
					})
					if count == 1 then
						break
					end
				end
			end
		end
	end

	ApplyDamage({
		victim = keys.target,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
		attacker = self:GetCaster(),
	})

	if proc then
		self:PlayEffects(keys.target, self:GetCaster())
		proc = false
	end
end

function ancient_apparition_chilling_touch_lua:PlayEffects(target, caster)
	local crit_pfx = ParticleManager:CreateParticle(
		"particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_crit_tgt_line_sparks.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControl(crit_pfx, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(crit_pfx)
	EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", target)
end

------------------------------------------------------------------------
------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_ancient_apparition_ice_blast_lua",
	"heroes/hero_ancient_apparition/ancient_apparition",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_ancient_apparition_ice_blast_lua_slow",
	"heroes/hero_ancient_apparition/ancient_apparition",
	LUA_MODIFIER_MOTION_NONE
)

ancient_apparition_ice_blast_lua = class({})

function ancient_apparition_ice_blast_lua:GetIntrinsicModifierName()
	return "modifier_ancient_apparition_ice_blast_lua"
end

-------------------------------------------------------------------------------

modifier_ancient_apparition_ice_blast_lua = class({})

function modifier_ancient_apparition_ice_blast_lua:IsHidden()
	return true
end

function modifier_ancient_apparition_ice_blast_lua:IsPurgable()
	return false
end

function modifier_ancient_apparition_ice_blast_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_ancient_apparition_ice_blast_lua:OnAttackLanded(params)
	local caster = self:GetCaster()
	local target = params.target
	if params.attacker ~= self:GetParent() then
		return
	end

	target:AddNewModifier(
		caster,
		self:GetAbility(),
		"modifier_ancient_apparition_ice_blast_lua_slow",
		{ duration = self:GetAbility():GetSpecialValueFor("duration") }
	)
end

-----------------------------------------------------------------------------------

modifier_ancient_apparition_ice_blast_lua_slow = class({})

function modifier_ancient_apparition_ice_blast_lua_slow:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_ancient_apparition_ice_blast_lua_slow:OnCreated()
	if not IsServer() then
		return
	end
	self.move_speed_slow = self:GetAbility():GetSpecialValueFor("slow") * -1
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")

	self:StartIntervalThink(0.5)
end

function modifier_ancient_apparition_ice_blast_lua_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
end

function modifier_ancient_apparition_ice_blast_lua_slow:OnIntervalThink()
	if not IsServer() then
		return
	end
	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
	})
end

function modifier_ancient_apparition_ice_blast_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.move_speed_slow
end

function modifier_ancient_apparition_ice_blast_lua_slow:GetDisableHealing()
	return 1
end