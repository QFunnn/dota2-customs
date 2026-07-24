--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_felling_shield_lua_1", "item_ability/item_felling_shield_lua_1.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_felling_shield_lua_buff", "item_ability/item_felling_shield_lua_1.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_felling_shield_lua_shield", "item_ability/item_felling_shield_lua_1.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_felling_shield_lua_3_slow", "item_ability/item_felling_shield_lua_3.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_felling_shield_lua_3_buff", "item_ability/item_felling_shield_lua_3.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_felling_shield_lua_3_root", "item_ability/item_felling_shield_lua_3.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_felling_shield_lua_3 == nil then
	item_felling_shield_lua_3 = class({})
end
function item_felling_shield_lua_3:GetIntrinsicModifierName()
	return "modifier_item_felling_shield_lua_1"
end
function item_felling_shield_lua_3:OnSpellStart()
	local hCaster = self:GetCaster()
	local purge_root_duration = self:GetSpecialValueFor("purge_root_duration")
	local purge_slow_duration = self:GetSpecialValueFor("purge_slow_duration")

	if IsValid(hCaster) then
		EmitSoundOn("DOTA_Item.DiffusalBlade.Activate", hCaster)
		hCaster:Purge(false, true, false, false, false)
		hCaster:AddNewModifier(hCaster, self, "modifier_item_felling_shield_lua_3_buff", {duration = purge_slow_duration})
		local units = FindUnitsInRadius(hCaster:GetTeamNumber(), hCaster:GetAbsOrigin(), nil, self:GetCastRange(hCaster:GetAbsOrigin(), nil), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				if not unit:TriggerSpellAbsorb(self) then
					Wearable_System:PlayItemEffect(hCaster:GetPlayerOwnerID(), hCaster, self:GetAbilityName(), MODIFIER_FUNCTION_CUSTOM_1, {
						hTarget = unit,
					})
					if not unit:IsConsideredHero() then
						unit:AddNewModifier(hCaster, self, "modifier_item_felling_shield_lua_3_root", { duration = purge_root_duration * unit:GetStatusResistanceFactor(hCaster) })
					end
					unit:AddNewModifier(hCaster, self, "modifier_item_felling_shield_lua_3_slow", { duration = purge_slow_duration * unit:GetStatusResistanceFactor(hCaster) })
				end
			end
		end
	end

end
---------------------------------------------------------------------
--Modifiers
if modifier_item_felling_shield_lua_3_slow == nil then
	modifier_item_felling_shield_lua_3_slow = class({})
end
function modifier_item_felling_shield_lua_3_slow:IsHidden()
	return false
end
function modifier_item_felling_shield_lua_3_slow:IsDebuff()
	return true
end
function modifier_item_felling_shield_lua_3_slow:IsPurgable()
	return true
end
function modifier_item_felling_shield_lua_3_slow:IsPurgeException()
	return true
end
function modifier_item_felling_shield_lua_3_slow:OnCreated(params)
	self.purge_rate = self:GetAbilitySpecialValueFor("purge_rate")
	if IsServer() then
		local hCaster = self:GetCaster()
		local hParent = self:GetParent()
		Wearable_System:PlayItemEffect(hCaster:GetPlayerOwnerID(), hCaster, self:GetAbility():GetAbilityName(), MODIFIER_FUNCTION_CUSTOM_1, {
			tBuff = self,
			hTarget = hParent,
		})
		EmitSoundOn("DOTA_Item.DiffusalBlade.Target", hParent)
	end
end
function modifier_item_felling_shield_lua_3_slow:OnRefresh(params)
	self.purge_rate = self:GetAbilitySpecialValueFor("purge_rate")
	if IsServer() then
		local hParent = self:GetParent()
		EmitSoundOn("DOTA_Item.DiffusalBlade.Target", hParent)
	end
end
function modifier_item_felling_shield_lua_3_slow:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_felling_shield_lua_3_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end
function modifier_item_felling_shield_lua_3_slow:GetModifierMoveSpeedBonus_Percentage()
	local time_phase = 100 / self.purge_rate
	return -math.ceil((self:GetRemainingTime() / self:GetDuration() * 100) / time_phase) * time_phase
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_felling_shield_lua_3_root == nil then
	modifier_item_felling_shield_lua_3_root = class({})
end
function modifier_item_felling_shield_lua_3_root:IsHidden()
	return false
end
function modifier_item_felling_shield_lua_3_root:IsDebuff()
	return true
end
function modifier_item_felling_shield_lua_3_root:IsPurgable()
	return true
end
function modifier_item_felling_shield_lua_3_root:IsPurgeException()
	return true
end
function modifier_item_felling_shield_lua_3_root:OnCreated(params)
	if IsServer() then
	end
end
function modifier_item_felling_shield_lua_3_root:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_felling_shield_lua_3_root:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_felling_shield_lua_3_root:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true
	}
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_felling_shield_lua_3_buff == nil then
	modifier_item_felling_shield_lua_3_buff = class({})
end
function modifier_item_felling_shield_lua_3_buff:IsHidden()
	return false
end
function modifier_item_felling_shield_lua_3_buff:IsDebuff()
	return false
end
function modifier_item_felling_shield_lua_3_buff:IsPurgable()
	return true
end
function modifier_item_felling_shield_lua_3_buff:IsPurgeException()
	return true
end
function modifier_item_felling_shield_lua_3_buff:OnCreated(params)
	self.purge_rate = self:GetAbilitySpecialValueFor("purge_rate")
	if IsServer() then
		local hCaster = self:GetCaster()
		local hParent = self:GetParent()
		Wearable_System:PlayItemEffect(hCaster:GetPlayerOwnerID(), hCaster, self:GetAbility():GetAbilityName(), MODIFIER_FUNCTION_CUSTOM_1, {
			tBuff = self,
			hTarget = hParent,
		})
		EmitSoundOn("DOTA_Item.DiffusalBlade.Target", hParent)
	end
end
function modifier_item_felling_shield_lua_3_buff:OnRefresh(params)
	self.purge_rate = self:GetAbilitySpecialValueFor("purge_rate")
	if IsServer() then
		local hParent = self:GetParent()
		EmitSoundOn("DOTA_Item.DiffusalBlade.Target", hParent)
	end
end
function modifier_item_felling_shield_lua_3_buff:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_felling_shield_lua_3_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end
function modifier_item_felling_shield_lua_3_buff:GetModifierMoveSpeedBonus_Percentage()
	local time_phase = 100 / self.purge_rate
	return math.ceil((self:GetRemainingTime() / self:GetDuration() * 100) / time_phase) * time_phase
end
function modifier_item_felling_shield_lua_3_buff:CheckState()
	return {
		[MODIFIER_STATE_UNSLOWABLE] = true
	}
end
function modifier_item_felling_shield_lua_3_buff:GetEffectName()
	return "particles/items_fx/disperser_buff.vpcf"
end
function modifier_item_felling_shield_lua_3_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end