--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_sven_gods_strength_lua",
	"heroes/hero_sven/sven_gods_strength_lua/sven_gods_strength_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_sven_gods_strength_child_lua",
	"heroes/hero_sven/sven_gods_strength_lua/sven_gods_strength_lua",
	LUA_MODIFIER_MOTION_NONE
)

sven_gods_strength_lua = class({})

function sven_gods_strength_lua:OnSpellStart()
	local gods_strength_duration = self:GetSpecialValueFor("gods_strength_duration")

	self:GetCaster()
		:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_sven_gods_strength_lua",
			{ duration = gods_strength_duration }
		)

	local nFXIndex = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sven/sven_spell_gods_strength.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		nFXIndex,
		1,
		self:GetCaster(),
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self:GetCaster():GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(nFXIndex)

	EmitSoundOn("Hero_Sven.GodsStrength", self:GetCaster())

	self:GetCaster():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
end

function sven_gods_strength_lua:GetCastRange()
	return self:GetCaster():FindAbilityByName("special_bonus_sven_tal3"):GetLevel() > 0
		and self:GetSpecialValueFor("aura_radius")
end

-----------------------------------------------------------

modifier_sven_gods_strength_lua = class({})

function modifier_sven_gods_strength_lua:IsPurgable()
	return false
end

function modifier_sven_gods_strength_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_gods_strength.vpcf"
end

function modifier_sven_gods_strength_lua:StatusEffectPriority()
	return 1000
end

function modifier_sven_gods_strength_lua:GetHeroEffectName()
	return "particles/units/heroes/hero_sven/sven_gods_strength_hero_effect.vpcf"
end

function modifier_sven_gods_strength_lua:HeroEffectPriority()
	return 100
end

function modifier_sven_gods_strength_lua:IsAura()
	local ability = self:GetCaster():FindAbilityByName("special_bonus_sven_tal3")
	if ability ~= nil and ability:GetLevel() > 0 then
		return true
	end
	return false
end

function modifier_sven_gods_strength_lua:GetModifierAura()
	return "modifier_sven_gods_strength_child_lua"
end

function modifier_sven_gods_strength_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_sven_gods_strength_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_sven_gods_strength_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_sven_gods_strength_lua:GetAuraRadius()
	return 700
end

function modifier_sven_gods_strength_lua:GetAuraEntityReject(hEntity)
	if IsServer() then
		if self:GetParent() == hEntity then
			return true
		end
	end

	return false
end

function modifier_sven_gods_strength_lua:OnCreated(kv)
	self.gods_strength_damage = self:GetAbility():GetSpecialValueFor("gods_strength_damage")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_sven_tal4")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.gods_strength_damage = self.gods_strength_damage + 100
	end

	if IsServer() then
		local nFXIndex = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_sven/sven_spell_gods_strength_ambient.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			nFXIndex,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_weapon",
			self:GetParent():GetOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			nFXIndex,
			2,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_head",
			self:GetParent():GetOrigin(),
			true
		)
		self:AddParticle(nFXIndex, false, false, -1, false, true)
	end
end

function modifier_sven_gods_strength_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_sven_gods_strength_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self.gods_strength_damage
end

--------------------------------------------------------------------------------

modifier_sven_gods_strength_child_lua = class({})

function modifier_sven_gods_strength_child_lua:IsPurgable()
	return false
end

function modifier_sven_gods_strength_child_lua:OnCreated(kv)
	self.gods_strength_damage = self:GetAbility():GetSpecialValueFor("gods_strength_damage")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_sven_tal4")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.gods_strength_damage = self.gods_strength_damage + 100
	end
end

function modifier_sven_gods_strength_child_lua:DeclareFunctions()
	local funcs = {
		func1 = MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_sven_gods_strength_child_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self.gods_strength_damage
end