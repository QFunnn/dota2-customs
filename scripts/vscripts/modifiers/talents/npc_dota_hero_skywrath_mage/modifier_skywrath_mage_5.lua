--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skywrath_mage_5_buff_stack", "modifiers/talents/npc_dota_hero_skywrath_mage/modifier_skywrath_mage_5", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_5_buff", "modifiers/talents/npc_dota_hero_skywrath_mage/modifier_skywrath_mage_5", LUA_MODIFIER_MOTION_NONE)

modifier_skywrath_mage_5 = class({})

function modifier_skywrath_mage_5:IsHidden() return true end
function modifier_skywrath_mage_5:IsPurgable() return false end
function modifier_skywrath_mage_5:IsPurgeException() return false end
function modifier_skywrath_mage_5:RemoveOnDeath() return false end

function modifier_skywrath_mage_5:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_skywrath_mage_5:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_skywrath_mage_5:DeclareFunctions()
	return 
	{
		MODIFIER_EVENT_ON_ABILITY_EXECUTED
	}
end

function modifier_skywrath_mage_5:OnAbilityExecuted( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end
	if not params.ability then return end
	if params.ability:IsItem() or params.ability:IsToggle() then return end
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_skywrath_mage_5_buff_stack", {duration = 20})
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_skywrath_mage_5_buff", {duration = 20})
end

modifier_skywrath_mage_5_buff = class({})

function modifier_skywrath_mage_5_buff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
	self:SetStackCount(1)
end

function modifier_skywrath_mage_5_buff:OnIntervalThink()
	if not IsServer() then return end
	local modifiers = self:GetParent():FindAllModifiersByName("modifier_skywrath_mage_5_buff_stack")
	self:SetStackCount(#modifiers)
end

function modifier_skywrath_mage_5_buff:GetTexture() return "skywrath_mage_5" end

modifier_skywrath_mage_5_buff_stack = class({})

modifier_skywrath_mage_5_buff_stack.bonus_str = {1,2}
modifier_skywrath_mage_5_buff_stack.bonus_move = {2,4}

function modifier_skywrath_mage_5_buff_stack:GetTexture() return "skywrath_mage_5" end
function modifier_skywrath_mage_5_buff_stack:IsHidden() return true end
function modifier_skywrath_mage_5_buff_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_skywrath_mage_5_buff_stack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}
end

function modifier_skywrath_mage_5_buff_stack:GetModifierBonusStats_Strength()
	return self.bonus_str[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_5")]
end

function modifier_skywrath_mage_5_buff_stack:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_move[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_5")]
end