--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_monkey_king_banana_attack",
	"heroes/hero_monkey_king/monkey_king_banana_attack/monkey_king_banana_attack",
	LUA_MODIFIER_MOTION_NONE
)

monkey_king_banana_attack = class({})

function monkey_king_banana_attack:GetIntrinsicModifierName()
	return "modifier_monkey_king_banana_attack"
end

---------------------------------------------------------------

modifier_monkey_king_banana_attack = class({})

function modifier_monkey_king_banana_attack:IsHidden()
	return true
end

function modifier_monkey_king_banana_attack:IsPurgable()
	return false
end

function modifier_monkey_king_banana_attack:RemoveOnDeath()
	return false
end

function modifier_monkey_king_banana_attack:OnCreated()
	self.chance = self:GetAbility():GetSpecialValueFor("chance")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	local ability = self:GetCaster():FindAbilityByName("special_bonus_monkey_king_5")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.damage = self.damage + 50
	end
end

function modifier_monkey_king_banana_attack:OnIntervalThink()
	self.chance = self:GetAbility():GetSpecialValueFor("chance")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	local ability = self:GetCaster():FindAbilityByName("special_bonus_monkey_king_5")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.damage = self.damage + 50
	end
end

function modifier_monkey_king_banana_attack:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,

		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}
end

function modifier_monkey_king_banana_attack:OnAttackLanded(data)
	if data.attacker ~= self:GetParent() then
		return
	end
	if data.target:IsBuilding() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if not self:GetAbility():IsCooldownReady() then
		return
	end
	if RollPercentage(self.chance) then
		local units = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			self:GetParent(),
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, u in pairs(units) do
			if u ~= data.target then
				ApplyDamage({
					victim = u,
					attacker = data.attacker,
					damage = self:GetParent():GetAverageTrueAttackDamage(nil),
					damage_type = DAMAGE_TYPE_PHYSICAL,
					damage_flags = DOTA_DAMAGE_FLAG_IGNORES_PHYSICAL_ARMOR
						+ DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
						+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
					ability = self:GetAbility(),
				})
			end
		end
		self:GetAbility():UseResources(false, false, false, true)
	end
end