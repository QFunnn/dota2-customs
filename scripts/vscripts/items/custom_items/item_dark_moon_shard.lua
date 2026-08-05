--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_dark_moon_shard", "items/custom_items/item_dark_moon_shard", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier(
	"modifier_item_dark_moon_shard_passive",
	"items/custom_items/item_dark_moon_shard",
	LUA_MODIFIER_MOTION_BOTH
)

-- способности, которые задают MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT.
-- пока активна любая из них — шард есть нельзя (иначе SetBaseAttackTime запечёт переопределённое значение в базу).
local DMS_BAT_ABILITY_MODIFIERS = {
	"modifier_alchemist_chemical_rage_lua",
	"modifier_mars_lil",
	"modifier_terrorblade_metamorphosis_lua",
	"modifier_sniper_ult",
	"modifier_lua_snapfire_lil_shredder",
	-- "modifier_troll_warlord_rage_lua_melee",
	-- "modifier_troll_warlord_rage_lua_ranged",
	"modifier_troll_warlord_battle_trance_lua",
}

item_dark_moon_shard = class({})

function item_dark_moon_shard:GetIntrinsicModifierName()
	return "modifier_item_dark_moon_shard_passive"
end

function item_dark_moon_shard:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	if not caster or not caster:IsRealHero() then
		return
	end

	local hPlayer = caster:GetPlayerOwner()

	if caster:HasModifier("modifier_item_dark_moon_shard") then
		rules:DisplayError(hPlayer:GetPlayerID(), "#cant_modifier_item_dark_moon_shard")
		return
	end
	for _, modName in ipairs(DMS_BAT_ABILITY_MODIFIERS) do
		if caster:HasModifier(modName) then
			rules:DisplayError(hPlayer:GetPlayerID(), "#cant_modifier_item_dark_moon_shard_bat")
			return
		end
	end
	caster:AddNewModifier(caster, self, "modifier_item_dark_moon_shard", {})
	self:SpendCharge(0)
	EmitSoundOn("Item.MoonShard.Consume", caster)
end

-------------------------------------------------------

modifier_item_dark_moon_shard = class({})

function modifier_item_dark_moon_shard:IsHidden()
	return false
end
function modifier_item_dark_moon_shard:IsPermanent()
	return true
end
function modifier_item_dark_moon_shard:RemoveOnDeath()
	return false
end
function modifier_item_dark_moon_shard:IsPurgable()
	return false
end
function modifier_item_dark_moon_shard:GetTexture()
	return "dark_moon_shard"
end

function modifier_item_dark_moon_shard:OnCreated()
	self.reduction = self:GetAbility():GetSpecialValueFor("base_attack_time_reduction")

	local caster = self:GetCaster()
	caster.dms_bat_factor = (100 - self.reduction) / 100

	if not IsServer() then
		return
	end

	caster:SetBaseAttackTime(caster:GetBaseAttackTime(false) * caster.dms_bat_factor)
end

-------------------------------------------------------

modifier_item_dark_moon_shard_passive = class({})

function modifier_item_dark_moon_shard_passive:IsPurgable()
	return false
end
function modifier_item_dark_moon_shard_passive:IsPurgeException()
	return false
end
function modifier_item_dark_moon_shard_passive:IsHidden()
	return true
end
function modifier_item_dark_moon_shard_passive:RemoveOnDeath()
	return false
end
function modifier_item_dark_moon_shard_passive:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_dark_moon_shard_passive:OnCreated()
	self.passive_attack_speed = self:GetAbility():GetSpecialValueFor("passive_attack_speed")
end

function modifier_item_dark_moon_shard_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_item_dark_moon_shard_passive:GetModifierAttackSpeedBonus_Constant()
	return self.passive_attack_speed
end