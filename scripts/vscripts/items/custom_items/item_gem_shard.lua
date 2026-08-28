--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gem_shard", "items/custom_items/item_gem_shard", LUA_MODIFIER_MOTION_NONE)

item_gem_shard = class({})

function item_gem_shard:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if caster:HasModifier("modifier_item_gem_shard") then
		return
	end
	local item = self
	caster:AddNewModifier(caster, nil, "modifier_item_gem_shard", {})
	item:SpendCharge(0)
end

--------------------------------------------

modifier_item_gem_shard = class({})

function modifier_item_gem_shard:RemoveOnDeath()
	return false
end

function modifier_item_gem_shard:GetTexture()
	return "gem_shard"
end

function modifier_item_gem_shard:IsAura()
	return true
end

function modifier_item_gem_shard:IsHidden()
	return true
end

function modifier_item_gem_shard:IsPurgable()
	return false
end

function modifier_item_gem_shard:GetAuraRadius()
	return 500
end

function modifier_item_gem_shard:GetModifierAura()
	return "modifier_truesight"
end

function modifier_item_gem_shard:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_item_gem_shard:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_item_gem_shard:GetAuraSearchType()
	return DOTA_UNIT_TARGET_ALL
end

function modifier_item_gem_shard:GetAuraDuration()
	return 0.1
end