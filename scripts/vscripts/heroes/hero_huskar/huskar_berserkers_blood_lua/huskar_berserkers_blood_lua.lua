--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_huskar_berserkers_blood_lua",
	"heroes/hero_huskar/huskar_berserkers_blood_lua/huskar_berserkers_blood_lua",
	LUA_MODIFIER_MOTION_NONE
)

huskar_berserkers_blood_lua = class({})

function huskar_berserkers_blood_lua:GetIntrinsicModifierName()
	return "modifier_huskar_berserkers_blood_lua"
end

-------------------------------------------------------------------

modifier_huskar_berserkers_blood_lua = class({})

function modifier_huskar_berserkers_blood_lua:IsHidden()
	return false
end

function modifier_huskar_berserkers_blood_lua:IsDebuff()
	return false
end

function modifier_huskar_berserkers_blood_lua:IsPurgable()
	return false
end

function modifier_huskar_berserkers_blood_lua:OnCreated(kv)
	self.max_as = self:GetAbility():GetSpecialValueFor("maximum_attack_speed")
	self.max_threshold = self:GetAbility():GetSpecialValueFor("hp_threshold_max")
	self.range = 100 - self.max_threshold
	self.max_size = 35

	self:PlayEffects()
end

function modifier_huskar_berserkers_blood_lua:OnRefresh(kv)
	self.max_as = self:GetAbility():GetSpecialValueFor("maximum_attack_speed")
	self.max_threshold = self:GetAbility():GetSpecialValueFor("hp_threshold_max")
	self.range = 100 - self.max_threshold
end

function modifier_huskar_berserkers_blood_lua:OnRemoved() end

function modifier_huskar_berserkers_blood_lua:OnDestroy() end

function modifier_huskar_berserkers_blood_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}

	return funcs
end

function modifier_huskar_berserkers_blood_lua:GetModifierMagicalResistanceBonus()
	self.max_mr = self:GetAbility():GetSpecialValueFor("maximum_resistance")
	local talent = self:GetCaster():FindAbilityByName("special_bonus_huskar_tal_4")
	if talent ~= nil and talent:GetLevel() > 0 then
		self.max_mr = self.max_mr + 40
	end

	local pct = math.max((self:GetParent():GetHealthPercent() - self.max_threshold) / self.range, 0)
	return (1 - pct) * self.max_mr
end

function modifier_huskar_berserkers_blood_lua:GetModifierAttackSpeedBonus_Constant()
	local pct = math.max((self:GetParent():GetHealthPercent() - self.max_threshold) / self.range, 0)
	return (1 - pct) * self.max_as
end

function modifier_huskar_berserkers_blood_lua:GetModifierModelScale()
	if IsServer() then
		local pct = math.max((self:GetParent():GetHealthPercent() - self.max_threshold) / self.range, 0)
		ParticleManager:SetParticleControl(self.effect_cast, 1, Vector((1 - pct) * 100, 0, 0))
		return (1 - pct) * self.max_size
	end
end

function modifier_huskar_berserkers_blood_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_huskar/huskar_berserkers_blood_glow.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end