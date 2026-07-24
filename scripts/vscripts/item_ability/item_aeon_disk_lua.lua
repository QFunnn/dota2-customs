--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_aeon_disk_lua = class({}) ---@class item_aeon_disk_lua : CDOTA_Item_Lua

LinkLuaModifier("modifier_item_aeon_disk_lua", "item_ability/item_aeon_disk_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_aeon_disk_lua_buff", "item_ability/item_aeon_disk_lua", LUA_MODIFIER_MOTION_NONE)

function item_aeon_disk_lua:GetIntrinsicModifierName()
	return "modifier_item_aeon_disk_lua"
end

------------------------------------------------------
modifier_item_aeon_disk_lua = class({}) ---@class modifier_item_aeon_disk_lua : CDOTA_Modifier_Lua

function modifier_item_aeon_disk_lua:IsHidden() return true end

function modifier_item_aeon_disk_lua:IsDebuff() return false end

function modifier_item_aeon_disk_lua:IsPurgable() return false end

function modifier_item_aeon_disk_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT +
		MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_item_aeon_disk_lua:OnCreated(keys)
	local ability = self:GetAbility()
	if not ability then return end

	self.bonus_health = ability:GetSpecialValueFor("bonus_health")
	self.bonus_mana = ability:GetSpecialValueFor("bonus_mana")
	self.health_threshold_pct = ability:GetSpecialValueFor("health_threshold_pct")
	self.buff_duration = ability:GetSpecialValueFor("buff_duration")
end

function modifier_item_aeon_disk_lua:OnRefresh(keys)
	self:OnCreated(keys)
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
	local parent = self:GetParent()
	local health_threshold = parent:GetMaxHealth() * self.health_threshold_pct * 0.01
	local ability = self:GetAbility()
	local damage_flags = keys.damage_flags

	if
		ability
		and IsValid(ability)
		and ability:IsCooldownReady()
		and parent:IsRealHero()
		and keys.damage > 0
		and not parent:IsIllusion()
		and parent:GetHealth() - keys.damage <= (health_threshold + 1)
		and bit.band(damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS
		and not parent:HasModifier("modifier_oracle_false_promise_lua")
	then
		ability:UseResources(true, false, true, true) -- Если требуется расходовать здоровье, нужно проверять снаружи, что damage > 0.
		parent:EmitSound("DOTA_Item.ComboBreaker")

		parent:Purge(false, true, false, true, true)
		parent:AddNewModifier(parent, ability, "modifier_item_aeon_disk_lua_buff", { duration = self.buff_duration })

		if parent:GetHealth() > health_threshold then
			parent:SetHealth(health_threshold)
		end

		return keys.damage * 10
	end
end

----------------------------------------------------------------
modifier_item_aeon_disk_lua_buff = class({}) ---@class modifier_item_aeon_disk_lua_buff : CDOTA_Modifier_Lua

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

	self.buff_pfx = ParticleManager:CreateParticle("particles/items4_fx/combo_breaker_buff.vpcf",
		PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(self.buff_pfx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc",
		Vector(0, 0, 0), true)

	self:AddParticle(self.buff_pfx, false, false, 255, true, false)
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
	local parent = self:GetParent()
	local curseModifier = parent:FindModifierByName("modifier_loser_curse") --находим курсы
	if curseModifier then
		totalCurseStacks = curseModifier:GetStackCount()                 --получаем количество стаков курс
		return -100 - totalCurseStacks * 10                              --возвращаем увеличенное значение снижения урона
	else
		return -100                                                      --если курс нет, возвращаем прост -100
	end
end

function modifier_item_aeon_disk_lua_buff:GetModifierTotalDamageOutgoing_Percentage()
	return -100
end