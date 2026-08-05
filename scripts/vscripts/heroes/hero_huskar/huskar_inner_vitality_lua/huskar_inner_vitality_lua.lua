--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_huskar_inner_vitality_lua",
	"heroes/hero_huskar/huskar_inner_vitality_lua/huskar_inner_vitality_lua",
	LUA_MODIFIER_MOTION_NONE
)

huskar_inner_vitality_lua = class({})

function huskar_inner_vitality_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetDuration()
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_huskar_inner_vitality_lua", -- modifier name
		{ duration = duration } -- kv
	)
	self:PlayEffects(target)
end

function huskar_inner_vitality_lua:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_huskar/huskar_inner_vitality_cast.vpcf"
	local sound_cast = "Hero_Huskar.Inner_Vitality"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn("DOTA_Item.UrnOfShadows.Activate", self:GetCaster())
end

----------------------------------------------------------------------------------

modifier_huskar_inner_vitality_lua = class({})

function modifier_huskar_inner_vitality_lua:IsHidden()
	return false
end

function modifier_huskar_inner_vitality_lua:IsDebuff()
	return false
end

function modifier_huskar_inner_vitality_lua:IsPurgable()
	return true
end

function modifier_huskar_inner_vitality_lua:OnCreated(kv)
	self.heal_base = self:GetAbility():GetSpecialValueFor("heal")
	self.str_bonus = self:GetAbility():GetSpecialValueFor("str_bonus")
	self.str_heal = self:GetAbility():GetSpecialValueFor("str_heal")
	self.hurt_percent = self:GetAbility():GetSpecialValueFor("hurt_percent")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_huskar_tal_2")
	if talent and talent:GetLevel() > 0 then
		self.str_bonus = self.str_bonus + 10
	end

	local talent = self:GetCaster():FindAbilityByName("special_bonus_huskar_tal_7")
	if talent and talent:GetLevel() > 0 then
		self.str_heal = 100
	end
end

function modifier_huskar_inner_vitality_lua:OnRefresh(kv)
	self:OnCreated()
end

function modifier_huskar_inner_vitality_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}
	return funcs
end

function modifier_huskar_inner_vitality_lua:GetModifierBonusStats_Strength()
	return self:GetParent():GetBaseStrength() * self.str_bonus / 100
end

function modifier_huskar_inner_vitality_lua:GetModifierConstantHealthRegen()
	-- if IsServer() then
	local heal = self.heal_base + self:GetCaster():GetStrength() / 100 * self.str_heal
	if self:GetParent():GetHealthPercent() < self.hurt_percent then
		heal = heal * 1.25
	end
	self:SetStackCount(heal)
	return heal
	-- end
end

function modifier_huskar_inner_vitality_lua:GetEffectName()
	return "particles/units/heroes/hero_huskar/huskar_inner_vitality.vpcf"
end

function modifier_huskar_inner_vitality_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end