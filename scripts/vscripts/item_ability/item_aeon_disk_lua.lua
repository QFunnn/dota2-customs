--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_aeon_disk_lua = class({})

LinkLuaModifier("modifier_item_aeon_disk_lua", "item_ability/item_aeon_disk_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_aeon_disk_lua_buff", "item_ability/item_aeon_disk_lua", LUA_MODIFIER_MOTION_NONE)

function item_aeon_disk_lua:GetIntrinsicModifierName()
	return "modifier_item_aeon_disk_lua"
end

modifier_item_aeon_disk_lua = class({})

function modifier_item_aeon_disk_lua:IsHidden() return true end
function modifier_item_aeon_disk_lua:IsDebuff() return false end
function modifier_item_aeon_disk_lua:IsPurgable() return false end
function modifier_item_aeon_disk_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_aeon_disk_lua:OnCreated(keys)
	self.bonus_health = self:GetAbilitySpecialValueFor("bonus_health")
	self.bonus_mana = self:GetAbilitySpecialValueFor("bonus_mana")
	self.health_threshold_pct = self:GetAbilitySpecialValueFor("health_threshold_pct")
	self.buff_duration = self:GetAbilitySpecialValueFor("buff_duration")
end

function modifier_item_aeon_disk_lua:OnRefresh(keys)
	self.bonus_health = self:GetAbilitySpecialValueFor("bonus_health")
	self.bonus_mana = self:GetAbilitySpecialValueFor("bonus_mana")
	self.health_threshold_pct = self:GetAbilitySpecialValueFor("health_threshold_pct")
	self.buff_duration = self:GetAbilitySpecialValueFor("buff_duration")
	if IsServer() then
	end
end

function modifier_item_aeon_disk_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	}
end

function modifier_item_aeon_disk_lua:GetModifierHealthBonus()
	return self.bonus_health or 0
end

function modifier_item_aeon_disk_lua:GetModifierManaBonus()
	return self.bonus_mana or 0
end

function modifier_item_aeon_disk_lua:GetModifierTotal_ConstantBlock(keys)
	local hParent = self:GetParent()
	local health_threshold = hParent:GetMaxHealth() * self.health_threshold_pct * 0.01
	local hAbility = self:GetAbility()
	local damage_flags = keys.damage_flags

	if IsValid(hAbility) and hAbility:IsCooldownReady() and hParent:IsRealHero() and keys.damage > 0 and not hParent:IsIllusion() and hParent:GetHealth() - keys.damage <= (health_threshold + 1) and bit.band(damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS then
		hAbility:UseResources(true, false, true, true) -- 如果需要消耗生命，必须在外层判断damage>0
		hParent:EmitSound("DOTA_Item.ComboBreaker")

		hParent:Purge(false, true, false, true, true)
		hParent:AddNewModifier(hParent, hAbility, "modifier_item_aeon_disk_lua_buff", { duration = self.buff_duration })

		if hParent:GetHealth() > health_threshold then
			hParent:SetHealth(health_threshold)
		end

		return keys.damage * 10
	end
end



modifier_item_aeon_disk_lua_buff = class({})

function modifier_item_aeon_disk_lua_buff:IsHidden() return false end
function modifier_item_aeon_disk_lua_buff:IsDebuff() return false end
function modifier_item_aeon_disk_lua_buff:IsPurgable() return true end

function modifier_item_aeon_disk_lua_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_combo_breaker.vpcf"
end

function modifier_item_aeon_disk_lua_buff:StatusEffectPriority()
	return 10
end

function modifier_item_aeon_disk_lua_buff:OnCreated(keys)
	self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")

	if IsClient() then return end

	self.buff_pfx = ParticleManager:CreateParticle("particles/items4_fx/combo_breaker_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(self.buff_pfx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)

	self:AddParticle(self.buff_pfx, false, false, 255, true, false)
end

function modifier_item_aeon_disk_lua_buff:OnDestroy()
end

function modifier_item_aeon_disk_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_item_aeon_disk_lua_buff:GetModifierStatusResistanceStacking()
	return self.status_resistance or 0
end
function modifier_item_aeon_disk_lua_buff:GetModifierIncomingDamage_Percentage()
	return -100
end
function modifier_item_aeon_disk_lua_buff:GetModifierTotalDamageOutgoing_Percentage()
	return -100
end