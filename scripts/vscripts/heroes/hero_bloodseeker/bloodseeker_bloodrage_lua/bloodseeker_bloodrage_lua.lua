--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_bloodseeker_bloodrage_lua",
	"heroes/hero_bloodseeker/bloodseeker_bloodrage_lua/bloodseeker_bloodrage_lua",
	LUA_MODIFIER_MOTION_NONE
)

bloodseeker_bloodrage_lua = class({})

function bloodseeker_bloodrage_lua:GetBehavior()
	local abil = self:GetCaster():FindAbilityByName("special_bonus_bloodseeker_8")
	if abil ~= nil and abil:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function bloodseeker_bloodrage_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local duration = self:GetSpecialValueFor("duration")

	local abil = self:GetCaster():FindAbilityByName("special_bonus_bloodseeker_3")
	if abil ~= nil and abil:GetLevel() > 0 then
		duration = duration + 2
	end
	if not target then
		caster:AddNewModifier(caster, self, "modifier_bloodseeker_bloodrage_lua", { duration = duration })
	else
		target:AddNewModifier(caster, self, "modifier_bloodseeker_bloodrage_lua", { duration = duration })
	end
	EmitSoundOn("hero_bloodseeker.bloodRage", caster)
end

---------------------------------------------------------------

modifier_bloodseeker_bloodrage_lua = class({})

function modifier_bloodseeker_bloodrage_lua:IsHidden()
	return false
end

function modifier_bloodseeker_bloodrage_lua:IsPurgable()
	return true
end

function modifier_bloodseeker_bloodrage_lua:OnCreated(kv)
	self.debuff = self:GetCaster() ~= self:GetParent()
	self.ampli = self:GetAbility():GetSpecialValueFor("damage_increase_pct")
	self.attack_speed = self:GetAbility():GetSpecialValueFor("attack_speed")
	self.health_lose = self:GetAbility():GetSpecialValueFor("health_lose")

	local abil = self:GetCaster():FindAbilityByName("special_bonus_bloodseeker_5")
	if abil ~= nil and abil:GetLevel() > 0 then
		self.attack_speed = self.attack_speed + 80
	end

	local abil = self:GetCaster():FindAbilityByName("special_bonus_bloodseeker_6")
	if abil ~= nil and abil:GetLevel() > 0 then
		self.ampli = self.ampli + 10
	end

	self:StartIntervalThink(0.03)
end

function modifier_bloodseeker_bloodrage_lua:OnIntervalThink()
	if IsServer() then
		self:GetParent():SetHealth(
			math.max(
				self:GetParent():GetHealth() - (self:GetParent():GetMaxHealth() / 100 * self.health_lose) * 0.03,
				1
			)
		)
	end
end

function modifier_bloodseeker_bloodrage_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		-- MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_bloodseeker_bloodrage_lua:GetModifierDamageOutgoing_Percentage()
	return self.ampli
end

function modifier_bloodseeker_bloodrage_lua:GetModifierIncomingDamage_Percentage()
	return self.ampli
end

function modifier_bloodseeker_bloodrage_lua:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end

function modifier_bloodseeker_bloodrage_lua:GetEffectName()
	return "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf"
end

function modifier_bloodseeker_bloodrage_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_bloodseeker_bloodrage_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end