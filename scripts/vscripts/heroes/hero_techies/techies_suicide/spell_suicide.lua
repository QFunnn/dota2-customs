--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


techies_suicide_lua = class({})

LinkLuaModifier(
	"modifier_techies_suicide_stacks",
	"heroes/hero_techies/techies_suicide/spell_suicide.lua",
	LUA_MODIFIER_MOTION_NONE
)

function techies_suicide_lua:GetIntrinsicModifierName()
	return "modifier_techies_suicide_stacks"
end

------------------------------------------------------------------------

modifier_techies_suicide_stacks = class({})

function modifier_techies_suicide_stacks:IsHidden()
	return false
end

function modifier_techies_suicide_stacks:RemoveOnDeath()
	return true
end

function modifier_techies_suicide_stacks:OnCreated()
	if IsServer() then
		self:StartIntervalThink(1)
	end
end

function modifier_techies_suicide_stacks:OnIntervalThink()
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + 1)
	end
end

function modifier_techies_suicide_stacks:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_techies_suicide_stacks:OnDeath(params)
	if params.unit == self:GetParent() then
		params.unit:EmitSound(
			"sounds/vo/techies/tech_suicidesquad_03.vsnd" or "sounds/vo/techies/tech_suicidesquad_09.vsnd"
		)

		local caster = self:GetParent()
		self.damage = self:GetAbility():GetSpecialValueFor("damage_per_stack")
			* self:GetParent():GetModifierStackCount("modifier_techies_suicide_stacks", self:GetParent())

		local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_techies_int3")
		if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
			self.damage = (self:GetAbility():GetSpecialValueFor("damage_per_stack") + 2)
				* self:GetParent():GetModifierStackCount("modifier_techies_suicide_stacks", self:GetParent())
		end

		local radius = self:GetAbility():GetSpecialValueFor("radius")

		local pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_techies/techies_suicide.vpcf",
			PATTACH_ABSORIGIN,
			caster
		)
		ParticleManager:SetParticleControl(pfx, 1, Vector(self:GetAbility():GetSpecialValueFor("radius") / 4, 0, 0))
		ParticleManager:SetParticleControl(pfx, 2, Vector(self:GetAbility():GetSpecialValueFor("radius"), 1, 1))
		ParticleManager:ReleaseParticleIndex(pfx)
		caster:EmitSound("Hero_Techies.BlastOff.Cast")

		self.damage_table =
			{ attacker = caster, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() }
		if IsServer() then
			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				caster:GetAbsOrigin(),
				caster,
				radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
				FIND_ANY_ORDER,
				false
			)
			for _, enemy in pairs(enemies) do
				self.damage_table.victim = enemy
				ApplyDamage(self.damage_table)
			end
		end
		caster:ForceKill(true)
		caster:SetModifierStackCount("modifier_techies_suicide_stacks", self:GetParent(), 0)
	end
end