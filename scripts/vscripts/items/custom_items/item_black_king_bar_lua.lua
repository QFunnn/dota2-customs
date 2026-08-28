--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_black_king_bar_lua",
	"items/custom_items/item_black_king_bar_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_black_king_bar_lua_buff",
	"items/custom_items/item_black_king_bar_lua",
	LUA_MODIFIER_MOTION_NONE
)

item_black_king_bar_lua1 = item_black_king_bar_lua1 or class({})
item_black_king_bar_lua2 = item_black_king_bar_lua1 or class({})
item_black_king_bar_lua3 = item_black_king_bar_lua1 or class({})

function item_black_king_bar_lua1:GetIntrinsicModifierName()
	return "modifier_item_black_king_bar_lua"
end

function item_black_king_bar_lua1:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local modifier_bkb = "modifier_item_black_king_bar_lua_buff"

	if ability:GetName() == "item_black_king_bar_lua3" then
		caster = self:GetCursorTarget()
	end
	local duration = ability:GetSpecialValueFor("duration")
	local max_level = ability:GetSpecialValueFor("max_level")

	if ability:GetLevel() < max_level then
		ability:SetLevel(ability:GetLevel() + 1)

		caster.bkb_current_level = ability:GetLevel()
	end

	EmitSoundOn("DOTA_Item.BlackKingBar.Activate", caster)

	caster:Purge(false, true, false, false, false)

	caster:AddNewModifier(caster, ability, modifier_bkb, { duration = duration })
end

-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------

modifier_item_black_king_bar_lua = class({})

function modifier_item_black_king_bar_lua:IsHidden()
	return true
end
function modifier_item_black_king_bar_lua:IsPurgable()
	return false
end
function modifier_item_black_king_bar_lua:RemoveOnDeath()
	return false
end
function modifier_item_black_king_bar_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_black_king_bar_lua:OnCreated()
	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_black_king_bar_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}
end

function modifier_item_black_king_bar_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_item_black_king_bar_lua:GetModifierBonusStats_Strength()
	return self.bonus_strength
end

-------------------------------------------------------------------------------------------------------------------------------------

modifier_item_black_king_bar_lua_buff = class({})

function modifier_item_black_king_bar_lua_buff:IsHidden()
	return false
end
function modifier_item_black_king_bar_lua_buff:IsPurgable()
	return false
end

function modifier_item_black_king_bar_lua_buff:GetEffectName()
	return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_item_black_king_bar_lua_buff:OnCreated()
	self.model_scale = self:GetAbility():GetSpecialValueFor("model_scale")
end

function modifier_item_black_king_bar_lua_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_black_king_bar_lua_buff:CheckState()
	return {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
end

function modifier_item_black_king_bar_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_item_black_king_bar_lua_buff:GetModifierModelScale()
	return self.model_scale
end