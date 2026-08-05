--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_hero_pangolier_blade_of_the_exile",
	"heroes/hero_pangolier/hero_pangolier_blade_of_the_exile/hero_pangolier_blade_of_the_exile",
	LUA_MODIFIER_MOTION_NONE
)

hero_pangolier_blade_of_the_exile = class({})

function hero_pangolier_blade_of_the_exile:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	local ability = self:GetCaster():FindAbilityByName("pango_3")
	if ability ~= nil and ability:GetLevel() > 0 then
		duration = duration + 1
	end

	caster:EmitSound("Hero_Pangolier.Gyroshell.Cast")
	caster:AddNewModifier(caster, self, "modifier_hero_pangolier_blade_of_the_exile", { duration = duration })
end

----------------------------------------------------------------------------

modifier_hero_pangolier_blade_of_the_exile = class({})

function modifier_hero_pangolier_blade_of_the_exile:IsHidden()
	return false
end

function modifier_hero_pangolier_blade_of_the_exile:IsDebuff()
	return false
end

function modifier_hero_pangolier_blade_of_the_exile:IsPurgable()
	return false
end

function modifier_hero_pangolier_blade_of_the_exile:OnCreated(kv)
	DOTA_ABILITY_TYPE_BASIC = 0
	self.refresh_interval = self:GetAbility():GetSpecialValueFor("refresh_interval")

	if IsServer() then
		self:StartIntervalThink(self.refresh_interval)
		self:RefreshCooldown()
	end
end

function modifier_hero_pangolier_blade_of_the_exile:OnRefresh(kv)
	self.refresh_interval = self:GetAbility():GetSpecialValueFor("refresh_interval")

	if IsServer() then
		self:RefreshCooldown()
	end
end

function modifier_hero_pangolier_blade_of_the_exile:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
	return funcs
end

function modifier_hero_pangolier_blade_of_the_exile:GetModifierPercentageCooldown(params)
	if not params.ability:IsItem() and not params.ability == self:GetAbility() then
		return 100
	end
end

function modifier_hero_pangolier_blade_of_the_exile:OnIntervalThink()
	self:RefreshCooldown()
end

function modifier_hero_pangolier_blade_of_the_exile:RefreshCooldown()
	for i = 0, self:GetParent():GetAbilityCount() - 1 do
		local ability = self:GetParent():GetAbilityByIndex(i)
		if ability and ability:GetAbilityType() == DOTA_ABILITY_TYPE_BASIC then
			ability:EndCooldown()
		end
	end
end