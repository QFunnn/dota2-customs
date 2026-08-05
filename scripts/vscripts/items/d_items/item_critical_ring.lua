--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_critical_ring", "items/d_items/item_critical_ring", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
item_critical_ring = item_critical_ring or class({})
item_critical_ring2 = item_critical_ring or class({})
item_critical_ring3 = item_critical_ring or class({})
item_critical_ring4 = item_critical_ring or class({})
item_critical_ring5 = item_critical_ring or class({})

function item_critical_ring:GetIntrinsicModifierName()
	return "modifier_critical_ring"
end

function item_critical_ring:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_critical_ring:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_critical_ring:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

modifier_critical_ring = class({})

function modifier_critical_ring:IsHidden()
	return true
end

function modifier_critical_ring:IsPurgable()
	return false
end

function modifier_critical_ring:DestroyOnExpire()
	return false
end

function modifier_critical_ring:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end
function modifier_critical_ring:OnCreated(kv) end

function modifier_critical_ring:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_ATTRIBUTE_NONE,
	}

	return funcs
end

function modifier_critical_ring:GetModifierConstantHealthRegen(params)
	return self:GetAbility():GetSpecialValueFor("bonus_hpregen") or 0
end

function modifier_critical_ring:GetModifierBonusStats_Intellect(params)
	return self:GetAbility():GetSpecialValueFor("bonus_int") or 0
end

function modifier_critical_ring:GetModifierSpellAmplify_Percentage(params)
	return self:GetAbility():GetSpecialValueFor("bonus_spellamp") or 0
end

function modifier_critical_ring:GetModifierManaBonus(params)
	return self:GetAbility():GetSpecialValueFor("bonus_mana") or 0
end

function modifier_critical_ring:OnTakeDamage(params)
	if IsServer() then
		if params.attacker ~= self:GetParent() then
			return
		end

		if self:GetParent():GetTeamNumber() == params.unit:GetTeamNumber() then
			return
		end

		if
			params.damage_type ~= DAMAGE_TYPE_MAGICAL
			and params.damage_type ~= DAMAGE_TYPE_PURE
			and params.inflictor == nil
		then
			return
		end

		if params.damage_flags == DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION then
			return
		end

		if not RollPercentage(self:GetAbility():GetSpecialValueFor("chance")) then
			return
		end

		for i = 0, 5 do
			if
				self:GetCaster():GetItemInSlot(i)
				and self:GetCaster():GetItemInSlot(i):GetName() == self:GetAbility():GetName()
			then
				if self:GetAbility() ~= self:GetCaster():GetItemInSlot(i) then
					return
				else
					break
				end
			end
		end

		ApplyDamage({
			victim = params.unit,
			attacker = params.attacker,
			damage = params.damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self:GetAbility(),
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		})

		SendOverheadEventMessage(
			params.attacker,
			OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
			params.unit,
			params.damage * 2,
			nil
		)
	end
	return 0
end