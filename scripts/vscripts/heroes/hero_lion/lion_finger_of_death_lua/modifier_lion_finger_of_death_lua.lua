--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_lion_soul_collector",
	"heroes/hero_lion/lion_soul_collector/lion_soul_collector",
	LUA_MODIFIER_MOTION_NONE
)

modifier_lion_finger_of_death_lua = class({})

function modifier_lion_finger_of_death_lua:IsHidden()
	return true
end

function modifier_lion_finger_of_death_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_lion_finger_of_death_lua:IsPurgable()
	return false
end

function modifier_lion_finger_of_death_lua:OnCreated(kv)
	if IsServer() then
		local caster = self:GetCaster()

		self.damage = self:GetAbility():GetSpecialValueFor("damage")
			+ self:GetCaster():ExtraIntelligenceDamage()
				* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")

		local fleshHeapStackModifier = "modifier_lion_soul_collector"
		local currentStacks = caster:GetModifierStackCount(fleshHeapStackModifier, caster)

		local ability = self:GetCaster():FindAbilityByName("lion_soul_collector")
		if ability ~= nil and ability:GetLevel() >= 1 then
			stack_damage = ability:GetSpecialValueFor("stack_bonus_dmg")

			local tal = self:GetCaster():FindAbilityByName("special_bonus_lion_4")
			if tal ~= nil and tal:GetLevel() >= 1 then
				stack_damage = stack_damage + 0.2
			end

			self.damage = self.damage + (currentStacks * stack_damage)
		end
	end
end

function modifier_lion_finger_of_death_lua:OnDestroy(kv)
	if IsServer() then
		if not self:GetParent():IsAlive() then
			return
		end
		local nResult = UnitFilter(
			self:GetParent(),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
			0,
			self:GetCaster():GetTeamNumber()
		)
		if nResult ~= UF_SUCCESS then
			return
		end

		local damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}
		ApplyDamage(damageTable)
	end
end