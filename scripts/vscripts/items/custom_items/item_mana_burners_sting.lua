--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_mana_burners_sting_1 = item_mana_burners_sting_1 or class({})
item_mana_burners_sting_2 = item_mana_burners_sting_1 or class({})
item_mana_burners_sting_3 = item_mana_burners_sting_1 or class({})

LinkLuaModifier(
	"modifier_item_mana_burners_sting",
	"items/custom_items/item_mana_burners_sting.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_mana_burners_sting_debuff",
	"items/custom_items/item_mana_burners_sting.lua",
	LUA_MODIFIER_MOTION_NONE
)

function item_mana_burners_sting_1:GetIntrinsicModifierName()
	return "modifier_item_mana_burners_sting"
end

function item_mana_burners_sting_1:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	target:AddNewModifier(caster, self, "modifier_item_mana_burners_sting_debuff", {
		duration = self:GetSpecialValueFor("debuff_duration"),
	})

	caster:EmitSound("DOTA_Item.Orchid.Activate")
end

---------------------------------------------------------------------------------------------------

modifier_item_mana_burners_sting = modifier_item_mana_burners_sting or class({})

function modifier_item_mana_burners_sting:IsHidden()
	return true
end
function modifier_item_mana_burners_sting:IsPurgable()
	return false
end
function modifier_item_mana_burners_sting:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_mana_burners_sting:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.bonus_agility = ability:GetSpecialValueFor("bonus_agility")
	self.bonus_intellect = ability:GetSpecialValueFor("bonus_intellect")
	self.bonus_attack_speed = ability:GetSpecialValueFor("bonus_attack_speed")
	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
	self.bonus_mana_regen = ability:GetSpecialValueFor("bonus_mana_regen")
	self.bonus_health_regen = ability:GetSpecialValueFor("bonus_health_regen")
end

function modifier_item_mana_burners_sting:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_mana_burners_sting:GetModifierBonusStats_Agility()
	return self.bonus_agility
end
function modifier_item_mana_burners_sting:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end
function modifier_item_mana_burners_sting:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end
function modifier_item_mana_burners_sting:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_mana_burners_sting:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end
function modifier_item_mana_burners_sting:GetModifierHealthRegenConstant()
	return self.bonus_health_regen
end

---------------------------------------------------------------------------------------------------

modifier_item_mana_burners_sting_debuff = modifier_item_mana_burners_sting_debuff or class({})

function modifier_item_mana_burners_sting_debuff:IsHidden()
	return false
end
function modifier_item_mana_burners_sting_debuff:IsPurgable()
	return true
end
function modifier_item_mana_burners_sting_debuff:IsDebuff()
	return true
end

function modifier_item_mana_burners_sting_debuff:GetTexture()
	return "new/item_mana_burners_sting_1"
end

function modifier_item_mana_burners_sting_debuff:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.mana_burn = ability:GetSpecialValueFor("mana_burn")
	self.burst_multiplier = ability:GetSpecialValueFor("burst_multiplier")
	self._accum = 0

	self:SetStackCount(0)
end

function modifier_item_mana_burners_sting_debuff:OnRefresh()
	self:OnCreated()
end

function modifier_item_mana_burners_sting_debuff:OnDestroy()
	if not IsServer() then
		return
	end

	local accum = self._accum or 0
	if accum <= 0 then
		return
	end

	local parent = self:GetParent()
	if not parent or parent:IsNull() or not parent:IsAlive() then
		return
	end

	local ability = self:GetAbility()
	if not ability then
		return
	end

	local orchid_end_pfx =
		ParticleManager:CreateParticle("particles/items2_fx/orchid_pop.vpcf", PATTACH_OVERHEAD_FOLLOW, parent)
	ParticleManager:SetParticleControl(orchid_end_pfx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(orchid_end_pfx, 1, Vector(100, 0, 0))
	ParticleManager:ReleaseParticleIndex(orchid_end_pfx)

	ApplyDamage({
		victim = parent,
		attacker = ability:GetCaster(),
		damage = accum * (self.burst_multiplier or 3),
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = ability,
	})

	parent:EmitSound("DOTA_Item.Orchid.Purge")
end

function modifier_item_mana_burners_sting_debuff:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_item_mana_burners_sting_debuff:GetEffectName()
	return "particles/items2_fx/orchid.vpcf"
end

function modifier_item_mana_burners_sting_debuff:OnAttackLanded(keys)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if keys.target ~= parent then
		return
	end

	local ability = self:GetAbility()
	if not ability then
		return
	end
	if keys.attacker ~= ability:GetCaster() then
		return
	end

	local burned = math.min(parent:GetMana(), self.mana_burn or 0)
	if burned <= 0 then
		return
	end

	parent:SetMana(parent:GetMana() - burned)
	self._accum = self._accum + burned
	self:SetStackCount(math.floor(self._accum))
end