--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_dark_stick", "items/d_items/item_dark_stick", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dark_stick_debuff", "items/d_items/item_dark_stick", LUA_MODIFIER_MOTION_NONE)

item_dark_stick = item_dark_stick or class({})
item_dark_stick2 = item_dark_stick or class({})
item_dark_stick3 = item_dark_stick or class({})
item_dark_stick4 = item_dark_stick or class({})
item_dark_stick5 = item_dark_stick or class({})

function item_dark_stick:GetIntrinsicModifierName()
	return "modifier_item_dark_stick"
end

function item_dark_stick:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_dark_stick:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_dark_stick:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

function item_dark_stick:GetCastRange()
	return self:GetSpecialValueFor("radius") - self:GetCaster():GetCastRangeBonus()
end

function item_dark_stick:OnSpellStart()
	local current_charges = self:GetCurrentCharges()
	local caster = self:GetCaster()
	caster:EmitSound("DOTA_Item.MagicStick.Activate")

	local stick_pfx =
		ParticleManager:CreateParticle("particles/items2_fx/magic_stick.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(stick_pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(stick_pfx, 1, Vector(10, 0, 0))

	caster:Heal(current_charges * self:GetSpecialValueFor("hp_recovery"), self)
	caster:GiveMana(current_charges * self:GetSpecialValueFor("mp_recovery"))
	caster:ModifyGold(current_charges * self:GetSpecialValueFor("gold_per_kill"), true, 0)
	SendOverheadEventMessage(
		caster,
		OVERHEAD_ALERT_GOLD,
		caster,
		current_charges * self:GetSpecialValueFor("gold_per_kill"),
		nil
	)
	self:SetCurrentCharges(0)
end

--------------------------------------------------------------------------------

modifier_item_dark_stick = class({})

function modifier_item_dark_stick:IsHidden()
	return true
end

function modifier_item_dark_stick:IsPurgable()
	return false
end

function modifier_item_dark_stick:OnCreated(kv)
	self.bonus_hp = self:GetAbility():GetSpecialValueFor("bonus_hp")
	self.bonus_mp = self:GetAbility():GetSpecialValueFor("bonus_mp")
end

function modifier_item_dark_stick:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_ATTRIBUTE_NONEs,
	}
	return funcs
end

function modifier_item_dark_stick:GetModifierHealthBonus(params)
	return self.bonus_hp
end

function modifier_item_dark_stick:GetModifierManaBonus(params)
	return self.bonus_mp
end

function modifier_item_dark_stick:OnDeath(params)
	local parent = self:GetParent()
	if params.unit:IsIllusion() then
		return
	end

	if not params.unit:FindModifierByNameAndCaster("modifier_item_dark_stick_debuff", parent) then
		return
	end

	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] or parent:HasModifier("modifier_guild_event") then
		return
	end

	self:GetAbility():SetCurrentCharges(self:GetAbility():GetCurrentCharges() + 1)
end

function modifier_item_dark_stick:IsAura()
	return true
end

function modifier_item_dark_stick:GetModifierAura()
	return "modifier_item_dark_stick_debuff"
end

function modifier_item_dark_stick:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius") - self:GetCaster():GetCastRangeBonus()
end

function modifier_item_dark_stick:GetAuraDuration()
	return 0.5
end

function modifier_item_dark_stick:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_item_dark_stick:GetAuraSearchType()
	return DOTA_UNIT_TARGET_ALL
end

function modifier_item_dark_stick:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_item_dark_stick:IsAuraActiveOnDeath()
	return false
end

function modifier_item_dark_stick:GetAuraEntityReject(hEntity)
	if IsServer() then
		if hEntity == self:GetCaster() then
			return true
		end
	end
	return false
end

-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------

modifier_item_dark_stick_debuff = class({})

function modifier_item_dark_stick_debuff:IsHidden()
	return true
end

function modifier_item_dark_stick_debuff:IsPurgable()
	return false
end