--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_rapier_custom", "abilities/items/item_rapier_custom", LUA_MODIFIER_MOTION_NONE)

item_rapier_custom = class({})

function item_rapier_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_item_rapier_custom"
end

function item_rapier_custom:GetAbilityTextureName()
	if self:GetToggleState() then
		return "item_rapier_alt"
	end

	return "item_rapier"
end

function item_rapier_custom:OnToggle()
	if not IsServer() then
		return
	end

	self:StartCooldown(self:GetCooldown(self:GetLevel()))
end

function item_rapier_custom:IsUsable(unit)
	if self.rapier_free then
		return true
	end

	local purchaser = self:GetPurchaser()

	if not IsValid(purchaser) then
		return true
	end

	return purchaser:GetId() == unit:GetId()
end

function item_rapier_custom:UpdateOwner(unit)
	if self.rapier_free then
		return
	end

	local purchaser = self:GetPurchaser()

	if IsValid(purchaser) and purchaser:GetTeamNumber() ~= unit:GetTeamNumber() then
		self.rapier_free = true
	end
end

function item_rapier_custom:DropOnDeath(unit)
	unit:DropItemAtPositionImmediate(self, unit:GetAbsOrigin())
end

modifier_item_rapier_custom = class(mod_hidden)
function modifier_item_rapier_custom:RemoveOnDeath()
	return false
end
function modifier_item_rapier_custom:OnCreated(table)
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
	self.bonus_damage_base = self.ability:GetSpecialValueFor("bonus_damage_base")
	self.bonus_spell_amp = self.ability:GetSpecialValueFor("bonus_spell_amp")

	if not IsServer() then
		return
	end

	self.ability:UpdateOwner(self.parent)
	self:SetStackCount(self.ability:IsUsable(self.parent) and 1 or 0)
	self.parent:AddDeathEvent(self, true)
end

function modifier_item_rapier_custom:OnRefresh(table)
	self:OnCreated(table)
end

function modifier_item_rapier_custom:DeathEvent(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if self.parent:IsReincarnating() then
		return
	end
	if not self.parent:IsRealHero() then
		return
	end
	if self.parent:IsTempestDouble() then
		return
	end

	self.ability:DropOnDeath(self.parent)
end

function modifier_item_rapier_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_rapier_custom:GetModifierPreAttack_BonusDamage()
	if self:GetStackCount() ~= 1 then
		return 0
	end
	if self.ability:GetToggleState() then
		return self.bonus_damage_base
	end

	return self.bonus_damage_base + self.bonus_damage
end

function modifier_item_rapier_custom:GetModifierSpellAmplify_Percentage()
	if not self.ability:GetToggleState() then
		return 0
	end
	if self:GetStackCount() ~= 1 then
		return 0
	end

	return self.bonus_spell_amp
end