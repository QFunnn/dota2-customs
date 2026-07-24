--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



item_summoner_crown = class({})
item_summoner_crown_1 = item_summoner_crown
item_summoner_crown_2 = item_summoner_crown
item_summoner_crown_3 = item_summoner_crown

LinkLuaModifier("modifier_item_summoner_crown", "items/item_summoner_crown", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_summoner_crown_buff_agi", "items/item_summoner_crown", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_summoner_crown_buff_int", "items/item_summoner_crown", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_summoner_crown_model_size", "items/item_summoner_crown", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_summon_flying_movement_aura", "modifiers/modifier_summon_flying_movement_aura", LUA_MODIFIER_MOTION_NONE)


function item_summoner_crown:GetIntrinsicModifierName()
	return "modifier_item_summoner_crown"
end


modifier_item_summoner_crown = class({})

function modifier_item_summoner_crown:IsDebuff() return false end
function modifier_item_summoner_crown:IsHidden() return true end
function modifier_item_summoner_crown:IsPurgable() return false end
function modifier_item_summoner_crown:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_summoner_crown:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
	return funcs
end

function modifier_item_summoner_crown:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_summoner_crown:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_summoner_crown:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_summoner_crown:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
	self:UpdateFlyingAura()
end

function modifier_item_summoner_crown:OnRefresh()
	if not IsServer() then return end
	self:UpdateFlyingAura()
end

function modifier_item_summoner_crown:OnIntervalThink()
	self:UpdateFlyingAura()
end

function modifier_item_summoner_crown:UpdateFlyingAura()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then return end
	local item_name = ability:GetAbilityName()
	local is_active = not ability:IsInBackpack()
	local needs_aura = is_active and (item_name == "item_summoner_crown_2" or item_name == "item_summoner_crown_3")
	if needs_aura and not parent:HasModifier("modifier_summon_flying_movement_aura") then
		parent:AddNewModifier(parent, ability, "modifier_summon_flying_movement_aura", {})
	elseif not needs_aura and not self:HasOtherFlyingAuraSource(parent) then
		if parent:HasModifier("modifier_summon_flying_movement_aura") then
			parent:RemoveModifierByName("modifier_summon_flying_movement_aura")
		end
	end
end

function modifier_item_summoner_crown:HasOtherFlyingAuraSource(parent)
	for i = 0, parent:GetNumItemsInInventory() - 1 do
		local item = parent:GetItemInSlot(i)
		if item and item ~= self:GetAbility() and not item:IsInBackpack() then
			local name = item:GetAbilityName()
			if name == "item_summoner_crown_2" or name == "item_summoner_crown_3" or name == "item_wraith_dominator" then
				return true
			end
		end
	end
	return false
end

function modifier_item_summoner_crown:OnDestroy()
	if not IsServer() then return end
	local parent = self:GetParent()
	if parent and not parent:IsNull() and parent:HasModifier("modifier_summon_flying_movement_aura") then
		if not self:HasOtherFlyingAuraSource(parent) then
			parent:RemoveModifierByName("modifier_summon_flying_movement_aura")
		end
	end
end


modifier_item_summoner_crown_buff_agi = class({})

function modifier_item_summoner_crown_buff_agi:IsDebuff() return false end
function modifier_item_summoner_crown_buff_agi:IsHidden() return true end
function modifier_item_summoner_crown_buff_agi:IsPurgable() return false end
function modifier_item_summoner_crown_buff_agi:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_summoner_crown_buff_agi:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_item_summoner_crown_buff_agi:OnCreated()
	self.speed_bonus_per_agi = self:GetAbility():GetSpecialValueFor("speed_bonus_per_agi")
    self.armor_bonus_per_agi = self:GetAbility():GetSpecialValueFor("armor_bonus_per_agi")
end

function modifier_item_summoner_crown_buff_agi:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount() * self.speed_bonus_per_agi
end

function modifier_item_summoner_crown_buff_agi:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * self.armor_bonus_per_agi
end

modifier_item_summoner_crown_buff_int = class({})

function modifier_item_summoner_crown_buff_int:IsDebuff() return false end
function modifier_item_summoner_crown_buff_int:IsHidden() return true end
function modifier_item_summoner_crown_buff_int:IsPurgable() return false end
function modifier_item_summoner_crown_buff_int:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_summoner_crown_buff_int:OnCreated()
	self.damage_bonus_per_int = self:GetAbility():GetSpecialValueFor("damage_bonus_per_int")
end


function modifier_item_summoner_crown_buff_int:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
	return funcs
end

function modifier_item_summoner_crown_buff_int:GetModifierDamageOutgoing_Percentage()
	return self:GetStackCount() * self.damage_bonus_per_int
end

function modifier_item_summoner_crown_buff_int:TakeDamageScriptModifier(params)
	if not IsServer() then return end
	if params.unit == self:GetParent() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.unit:IsAttackImmune() then return end
	if params.unit:IsInvulnerable() then return end
	--if params.attacker:GetUnitName() == "npc_dota_witch_doctor_death_ward" then
    --    if params.attacker:GetOwner() ~= nil then
    --        local witch_doctor_death_ward = params.attacker:GetOwner():FindAbilityByName("witch_doctor_death_ward")
    --        if witch_doctor_death_ward then
    --            print(params.original_damage, witch_doctor_death_ward:GetSpecialValueFor("damage"))
    --            if params.original_damage == witch_doctor_death_ward:GetSpecialValueFor("damage") then
    --                print("aka")
    --                ApplyDamage({ victim = params.unit, attacker = params.attacker, damage = params.attacker:GetAverageTrueAttackDamage(nil) / 2, damage_type = DAMAGE_TYPE_PURE })
    --            end
    --        end
    --    end
	--end
end

modifier_item_summoner_crown_model_size = class({})

function modifier_item_summoner_crown_model_size:IsDebuff() return false end
function modifier_item_summoner_crown_model_size:IsHidden() return true end
function modifier_item_summoner_crown_model_size:IsPurgable() return false end
function modifier_item_summoner_crown_model_size:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_item_summoner_crown_model_size:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_SCALE
	}
	return funcs
end

function modifier_item_summoner_crown_model_size:OnCreated()
	self.model_scale = self:GetAbility():GetSpecialValueFor("model_scale")
end


function modifier_item_summoner_crown_model_size:GetModifierModelScale()
	return self.model_scale
end