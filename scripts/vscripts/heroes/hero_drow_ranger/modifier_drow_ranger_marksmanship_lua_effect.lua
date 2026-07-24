--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_drow_ranger_marksmanship_lua_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_drow_ranger_marksmanship_lua_effect:IsHidden()
	return false
end

function modifier_drow_ranger_marksmanship_lua_effect:IsDebuff()
	return false
end

function modifier_drow_ranger_marksmanship_lua_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_drow_ranger_marksmanship_lua_effect:OnCreated( kv )
	-- references
	self.agility = self:GetAbility():GetSpecialValueFor( "agility_multiplier" )

	if not IsServer() then return end
end

function modifier_drow_ranger_marksmanship_lua_effect:OnRefresh( kv )
	-- references
	self.agility = self:GetAbility():GetSpecialValueFor( "agility_multiplier" )
end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_drow_ranger_marksmanship_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}

	return funcs
end

function modifier_drow_ranger_marksmanship_lua_effect:GetModifierBonusStats_Agility()
	if not IsServer() then return self:GetStackCount() end

	-- use lock mechanism to prevent infinite recursive
	if self.lock1 then return end

    if self:GetCaster() ==nil then
    	return 
    end

    if self:GetCaster():IsNull() then
    	return 
    end
    
    if self:GetCaster().GetAgility ==nil then
    	return 
    end

	-- calculate bonus
	self.lock1 = true
	local agi = self:GetCaster():GetAgility()
	self.lock1 = false

	local bonus = self.agility*agi/100
	self:SetStackCount(bonus)

	return bonus
end