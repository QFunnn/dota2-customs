--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_npc_dota_hero_queenofpain_spell3",
	"heroes/hero_qop/npc_dota_hero_queenofpain_spell3",
	LUA_MODIFIER_MOTION_NONE
)

npc_dota_hero_queenofpain_spell3 = class({})

function npc_dota_hero_queenofpain_spell3:OnSpellStart()
	local target = self:GetCursorTarget()

	local duration = self:GetSpecialValueFor("duration")
	local ability = self:GetCaster():FindAbilityByName("special_bonus_qop_tal_5")
	if ability ~= nil and ability:GetLevel() > 0 then
		duration = duration + 1
	end

	target:AddNewModifier(self:GetCaster(), self, "modifier_npc_dota_hero_queenofpain_spell3", { duration = duration })
	local effect_cast = ParticleManager:CreateParticle(
		"particles/items4_fx/bull_whip_enemy.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetCaster():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Item.Bullwhip.Cast", target)
	Timers:CreateTimer(0.3, function()
		local effect_cast = ParticleManager:CreateParticle(
			"particles/econ/items/doom/doom_2021_immortal_weapon/doom_2021_immortal_weapon_infernalblade_impact.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			target
		)
		ParticleManager:ReleaseParticleIndex(effect_cast)
		EmitSoundOn("Hero_DoomBringer.InfernalBlade.Target", target)
	end)
end

-----------------------------------------------------------------

modifier_npc_dota_hero_queenofpain_spell3 = class({})

function modifier_npc_dota_hero_queenofpain_spell3:IsHidden()
	return false
end

function modifier_npc_dota_hero_queenofpain_spell3:IsDebuff()
	return true
end

function modifier_npc_dota_hero_queenofpain_spell3:IsPurgable()
	return true
end

function modifier_npc_dota_hero_queenofpain_spell3:OnCreated()
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	local ability = self:GetCaster():FindAbilityByName("special_bonus_qop_tal_5")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.duration = self.duration + 1
	end

	if not IsServer() then
		return
	end
	self.damage = self:GetAbility():GetSpecialValueFor("burn_damage")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")
	local ability = self:GetCaster():FindAbilityByName("special_bonus_qop_tal_4")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.damage = self.damage + 60
	end

	self:StartIntervalThink(1)
end

function modifier_npc_dota_hero_queenofpain_spell3:OnIntervalThink()
	if not IsServer() then
		return
	end
	local units = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		self:GetParent(),
		self:GetAbility():GetSpecialValueFor("radius_flashback"),
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, unit in ipairs(units) do
		if unit ~= self:GetParent() and not unit:HasModifier("modifier_npc_dota_hero_queenofpain_spell3") then
			unit:AddNewModifier(
				self:GetCaster(),
				self:GetAbility(),
				"modifier_npc_dota_hero_queenofpain_spell3",
				{ duration = self.duration }
			)
			local effect_cast = ParticleManager:CreateParticle(
				"particles/econ/items/doom/doom_2021_immortal_weapon/doom_2021_immortal_weapon_infernalblade_impact.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				unit
			)
			ParticleManager:ReleaseParticleIndex(effect_cast)
			EmitSoundOn("Hero_DoomBringer.InfernalBlade.Target", unit)
			break
		end
	end
	ApplyDamage({
		victim = self:GetParent(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		attacker = self:GetCaster(),
		ability = self:GetAbility(),
	})
end

function modifier_npc_dota_hero_queenofpain_spell3:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_npc_dota_hero_queenofpain_spell3:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end