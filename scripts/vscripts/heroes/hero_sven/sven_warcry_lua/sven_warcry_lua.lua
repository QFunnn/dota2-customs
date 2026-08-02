--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_sven_warcry_lua",
	"heroes/hero_sven/sven_warcry_lua/sven_warcry_lua",
	LUA_MODIFIER_MOTION_NONE
)

sven_warcry_lua = class({})

function sven_warcry_lua:GetCastRange()
	return self:GetSpecialValueFor("warcry_radius")
end

function sven_warcry_lua:OnSpellStart()
	local warcry_radius = self:GetSpecialValueFor("warcry_radius")
	local warcry_duration = self:GetSpecialValueFor("warcry_duration")

	local allies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		self:GetCaster(),
		warcry_radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	if #allies > 0 then
		for _, ally in pairs(allies) do
			ally:AddNewModifier(self:GetCaster(), self, "modifier_sven_warcry_lua", { duration = warcry_duration })
		end
	end

	local nFXIndex = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sven/sven_spell_warcry.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		nFXIndex,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_head",
		self:GetCaster():GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(nFXIndex)

	EmitSoundOn("Hero_Sven.WarCry", self:GetCaster())

	self:GetCaster():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
end

----------------------

modifier_sven_warcry_lua = class({})

function modifier_sven_warcry_lua:IsHidden()
	return false
end

function modifier_sven_warcry_lua:OnCreated(kv)
	self.warcry_armor = self:GetAbility():GetSpecialValueFor("warcry_armor")
	self.warcry_movespeed = self:GetAbility():GetSpecialValueFor("warcry_movespeed")
	if IsServer() then
		local nFXIndex = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_sven/sven_warcry_buff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			nFXIndex,
			2,
			self:GetCaster(),
			PATTACH_POINT_FOLLOW,
			"attach_head",
			self:GetCaster():GetOrigin(),
			true
		)
		self:AddParticle(nFXIndex, false, false, -1, false, true)
	end
end

function modifier_sven_warcry_lua:OnRefresh(kv)
	self.warcry_armor = self:GetAbility():GetSpecialValueFor("warcry_armor")
	self.warcry_movespeed = self:GetAbility():GetSpecialValueFor("warcry_movespeed")
end

function modifier_sven_warcry_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return funcs
end

function modifier_sven_warcry_lua:GetActivityTranslationModifiers(params)
	if self:GetParent() == self:GetCaster() then
		return "sven_warcry"
	end
	return 0
end

function modifier_sven_warcry_lua:GetModifierMagicalResistanceBonus()
	local ability = self:GetCaster():FindAbilityByName("special_bonus_sven_tal1")
	if ability ~= nil and ability:GetLevel() > 0 then
		return self.warcry_armor
	end
	return 0
end

function modifier_sven_warcry_lua:GetModifierMoveSpeedBonus_Percentage(params)
	return self.warcry_movespeed
end

function modifier_sven_warcry_lua:GetModifierPhysicalArmorBonus(params)
	return self.warcry_armor
end