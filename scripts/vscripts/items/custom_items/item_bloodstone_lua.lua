--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_bloodstone_lua1 = item_bloodstone_lua1 or class({})
item_bloodstone_lua2 = item_bloodstone_lua1 or class({})
item_bloodstone_lua3 = item_bloodstone_lua1 or class({})

LinkLuaModifier("modifier_item_bloodstone_lua", "items/custom_items/item_bloodstone_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_item_blodstone_active_lua",
	"items/custom_items/item_bloodstone_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)

function item_bloodstone_lua1:GetIntrinsicModifierName()
	return "modifier_item_bloodstone_lua"
end

function item_bloodstone_lua1:GetManaCost()
	if self and not self:IsNull() and self.GetCaster and self:GetCaster() ~= nil then
		return self:GetCaster():GetMaxMana() * 0.3
	end
end

function item_bloodstone_lua1:OnSpellStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_blodstone_active_lua", { duration = 2 })
end

----------------------------------------------------------------------------------

modifier_item_bloodstone_lua = class({})

function modifier_item_bloodstone_lua:IsHidden()
	return true
end

function modifier_item_bloodstone_lua:IsPurgable()
	return false
end

function modifier_item_bloodstone_lua:RemoveOnDeath()
	return false
end

function modifier_item_bloodstone_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_bloodstone_lua:OnCreated()
	local ability = self:GetAbility()

	self.bonus_intellect = ability:GetSpecialValueFor("bonus_intellect")
	self.bonus_mana = ability:GetSpecialValueFor("bonus_mana")
	self.bonus_health = ability:GetSpecialValueFor("bonus_health")
	self.mana_regen_multiplier = ability:GetSpecialValueFor("mana_regen_multiplier")
	self.spell_amp = ability:GetSpecialValueFor("spell_amp")
	self.creep_lifesteal = ability:GetSpecialValueFor("creep_lifesteal")
end
function modifier_item_bloodstone_lua:OnRefresh()
	self:OnCreated()
end

function modifier_item_bloodstone_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_item_bloodstone_lua:GetModifierHealthBonus()
	return self.bonus_health
end

function modifier_item_bloodstone_lua:GetModifierManaBonus()
	return self.bonus_mana
end

function modifier_item_bloodstone_lua:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end

function modifier_item_bloodstone_lua:GetModifierSpellAmplify_Percentage()
	return self.spell_amp
end

function modifier_item_bloodstone_lua:GetModifierMPRegenAmplify_Percentage()
	return self.mana_regen_multiplier
end

function modifier_item_bloodstone_lua:OnTakeDamage(keys)
	if
		keys.attacker == self:GetParent()
		and keys.unit ~= keys.attacker
		and not keys.unit:IsBuilding()
		and not keys.unit:IsOther()
	then
		if
			self:GetParent():FindAllModifiersByName(self:GetName())[1] == self
			and keys.damage_category == 0
			and keys.inflictor
			and bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL)
				~= DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL
		then
			-- Particle effect
			self.lifesteal_pfx = ParticleManager:CreateParticle(
				"particles/items3_fx/octarine_core_lifesteal.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				keys.attacker
			)
			ParticleManager:SetParticleControl(self.lifesteal_pfx, 0, keys.attacker:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(self.lifesteal_pfx)

			if
				keys.attacker:GetHealth() <= (keys.original_damage * (self.creep_lifesteal / 100))
				and keys.inflictor
				and bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION
			then
				keys.attacker:ForceKill(true)
			else
				keys.attacker:Heal(keys.original_damage * (self.creep_lifesteal / 100), self)
			end
		end
	end
end

-----------------------------------------------------------------------

modifier_item_blodstone_active_lua = class({})

function modifier_item_blodstone_active_lua:OnCreated()
	EmitSoundOn("DOTA_Item.Bloodstone.Cast", self:GetCaster())
	self.particle = ParticleManager:CreateParticle(
		"particles/items_fx/bloodstone_heal.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		self.particle,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetCaster():GetAbsOrigin(),
		true
	)
	self:AddParticle(self.particle, false, false, -1, false, false)

	self.regen = self:GetCaster():GetMaxMana() * 0.15
end

function modifier_item_blodstone_active_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_blodstone_active_lua:GetModifierConstantHealthRegen()
	return self.regen
end