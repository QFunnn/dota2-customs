--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_immune_mask", "items/d_items/item_immune_mask", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
item_immune_mask = item_immune_mask or class({})
item_immune_mask2 = item_immune_mask or class({})
item_immune_mask3 = item_immune_mask or class({})
item_immune_mask4 = item_immune_mask or class({})
item_immune_mask5 = item_immune_mask or class({})

function item_immune_mask:GetIntrinsicModifierName()
	return "modifier_item_immune_mask"
end

function item_immune_mask:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_immune_mask:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_immune_mask:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

modifier_item_immune_mask = class({})

function modifier_item_immune_mask:IsHidden()
	return true
end

function modifier_item_immune_mask:IsPurgable()
	return false
end

function modifier_item_immune_mask:OnCreated(kv)
	self.bonus_mgarmor = self:GetAbility():GetSpecialValueFor("bonus_mgarmor")
	self.bonus_health = self:GetAbility():GetSpecialValueFor("bonus_health")
	self.bkbchance = self:GetAbility():GetSpecialValueFor("bkbchance")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_item_immune_mask:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_immune_mask:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_immune_mask:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mgarmor")
end

function modifier_item_immune_mask:OnTakeDamage(keys)
	if IsServer() then
		local parent = self:GetParent()
		if parent ~= keys.unit then
			return
		end
		if self:GetParent():IsHero() then
			local R5 = RandomInt(1, 1000)
			if R5 <= self.bkbchance then
				self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_item_bkb", { duration = 1 })
				--self:GetParent():EmitSound("DOTA_Item.BlackKingBar.Activate")
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_item_bkb", "items/d_items/item_immune_mask", LUA_MODIFIER_MOTION_NONE)

modifier_item_bkb = class({})

function modifier_item_bkb:GetEffectName()
	return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_item_bkb:GetTexture()
	return "devils_seal"
end

function modifier_item_bkb:CheckState()
	return {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
end
function modifier_item_bkb:GetAbsoluteNoDamageMagical()
	return 1
end