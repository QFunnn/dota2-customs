--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_outworld_devourer_astral_imprisonment_lua",
	"heroes/hero_outworld_devourer/outworld_devourer_astral_imprisonment_lua/outworld_devourer_astral_imprisonment_lua",
	LUA_MODIFIER_MOTION_NONE
)

outworld_devourer_astral_imprisonment_lua = class({})

function outworld_devourer_astral_imprisonment_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local duration = self:GetSpecialValueFor("prison_duration")

	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_outworld_devourer_astral_imprisonment_lua", -- modifier name
		{ duration = duration } -- kv
	)

	local sound_cast = "Hero_ObsidianDestroyer.AstralImprisonment.Cast"
	EmitSoundOn(sound_cast, caster)
end

----------------------------------------------------------------------

modifier_outworld_devourer_astral_imprisonment_lua = class({})

function modifier_outworld_devourer_astral_imprisonment_lua:IsHidden()
	return false
end

function modifier_outworld_devourer_astral_imprisonment_lua:IsDebuff()
	return self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber()
end

function modifier_outworld_devourer_astral_imprisonment_lua:IsStunDebuff()
	return true
end

function modifier_outworld_devourer_astral_imprisonment_lua:IsPurgable()
	return true
end

function modifier_outworld_devourer_astral_imprisonment_lua:RemoveOnDeath()
	return false
end

function modifier_outworld_devourer_astral_imprisonment_lua:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	if not IsServer() then
		return
	end
	local damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")
	self.damageTable = {
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	self:GetParent():AddNoDraw()
	self:PlayEffects()
end

function modifier_outworld_devourer_astral_imprisonment_lua:OnDestroy()
	if not IsServer() then
		return
	end
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetOrigin(),
		self:GetParent(),
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_ALL,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)

		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), self.damageTable.damage, nil)
	end

	self:GetParent():RemoveNoDraw()
	local sound_loop = "Hero_ObsidianDestroyer.AstralImprisonment.Cast"
	StopSoundOn(sound_loop, self:GetCaster())

	local sound_loop = "Hero_ObsidianDestroyer.AstralImprisonment"
	StopSoundOn(sound_loop, self:GetCaster())

	local sound_cast = "Hero_ObsidianDestroyer.AstralImprisonment.End"
	-- EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

function modifier_outworld_devourer_astral_imprisonment_lua:CheckState()
	local state = {
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

function modifier_outworld_devourer_astral_imprisonment_lua:PlayEffects()
	local particle_cast1 = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_prison.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_prison_ring.vpcf"
	local sound_loop = "Hero_ObsidianDestroyer.AstralImprisonment"

	local effect_cast1 = ParticleManager:CreateParticle(particle_cast1, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast1, 0, self:GetParent():GetOrigin())

	local effect_cast2 = ParticleManager:CreateParticleForTeam(
		particle_cast2,
		PATTACH_WORLDORIGIN,
		nil,
		self:GetCaster():GetTeamNumber()
	)
	ParticleManager:SetParticleControl(effect_cast2, 0, self:GetParent():GetOrigin())

	self:AddParticle(
		effect_cast1,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	self:AddParticle(
		effect_cast2,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
	EmitSoundOn(sound_loop, self:GetCaster())
	--EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_loop, self:GetCaster() )
end