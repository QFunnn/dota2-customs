--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_generic_orb_effect_lua",
	"heroes/generic/modifier_generic_orb_effect_lua",
	LUA_MODIFIER_MOTION_NONE
)

outworld_devourer_arcane_orb_lua = class({})

function outworld_devourer_arcane_orb_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

function outworld_devourer_arcane_orb_lua:GetManaCost(iLevel)
	local caster = self:GetCaster()
	local manacost = self:GetSpecialValueFor("manacost")
	if caster then
		return caster:GetMana() * manacost / 100
	end
end

function outworld_devourer_arcane_orb_lua:OnSpellStart() end

function outworld_devourer_arcane_orb_lua:GetProjectileName()
	return "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_arcane_orb.vpcf"
end

function outworld_devourer_arcane_orb_lua:OnOrbFire(params)
	local sound_cast = "Hero_ObsidianDestroyer.ArcaneOrb"
	EmitSoundOn(sound_cast, self:GetCaster())

	local abil = self:GetCaster():FindAbilityByName("outworld_devourer_flux_lua")
	if abil ~= nil and abil:GetLevel() > 0 then
		local abil2 = self:GetCaster():FindAbilityByName("special_bonus_outworld_devourer_tal2")
		local chance = abil:GetSpecialValueFor("chance")
		if abil2 ~= nil and abil2:GetLevel() > 0 then
			chance = abil:GetSpecialValueFor("chance") + 10
		end
		if RandomInt(1, 100) < chance then
			self.proc_particle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_essence_effect.vpcf",
				PATTACH_ABSORIGIN,
				self:GetCaster()
			)
			ParticleManager:SetParticleControlEnt(
				self.proc_particle,
				0,
				self:GetCaster(),
				PATTACH_ABSORIGIN_FOLLOW,
				"attach_hitloc",
				self:GetCaster():GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(self.proc_particle)
			self:GetCaster():GiveMana(self:GetCaster():GetMaxMana() * abil:GetSpecialValueFor("mp_back") * 0.01)
		end
	end
end

function outworld_devourer_arcane_orb_lua:OnOrbImpact(params)
	local caster = self:GetCaster()
	local mana_pool = self:GetSpecialValueFor("mana_pool_damage_pct")
	local radius = self:GetSpecialValueFor("radius")

	local abil = self:GetCaster():FindAbilityByName("special_bonus_outworld_devourer_tal3")
	if abil ~= nil and abil:GetLevel() > 0 then
		mana_pool = self:GetSpecialValueFor("mana_pool_damage_pct") + 2
	end

	local damage = caster:GetMana() * mana_pool / 100
	local damageTable = {
		attacker = caster,
		damage_type = self:GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
		ability = self, --Optional.
	}

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		params.target:GetOrigin(),
		params.target,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy

		damageTable.damage = damage

		if enemy ~= params.target then
			damageTable.damage = damage / 2
		end

		ApplyDamage(damageTable)

		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, enemy, damageTable.damage, nil)
	end

	local sound_cast = "Hero_ObsidianDestroyer.ArcaneOrb.Impact"
	EmitSoundOn(sound_cast, params.target)
end