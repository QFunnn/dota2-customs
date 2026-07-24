--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skywrath_mage_17_buff_stack", "modifiers/talents/npc_dota_hero_skywrath_mage/modifier_skywrath_mage_17", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_17_buff", "modifiers/talents/npc_dota_hero_skywrath_mage/modifier_skywrath_mage_17", LUA_MODIFIER_MOTION_NONE)

modifier_skywrath_mage_17 = class({})

function modifier_skywrath_mage_17:IsHidden() return true end
function modifier_skywrath_mage_17:IsPurgable() return false end
function modifier_skywrath_mage_17:IsPurgeException() return false end
function modifier_skywrath_mage_17:RemoveOnDeath() return false end

function modifier_skywrath_mage_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_skywrath_mage_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_skywrath_mage_17:DeclareFunctions()
	return 
	{
		MODIFIER_EVENT_ON_ABILITY_EXECUTED
	}
end

function modifier_skywrath_mage_17:OnAbilityExecuted( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end
	if not params.ability then return end
	if params.ability:IsItem() or params.ability:IsToggle() then return end
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_skywrath_mage_17_buff_stack", {duration = 20})
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_skywrath_mage_17_buff", {duration = 20})
end

modifier_skywrath_mage_17_buff = class({})

function modifier_skywrath_mage_17_buff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
	self:SetStackCount(1)
end

function modifier_skywrath_mage_17_buff:OnIntervalThink()
	if not IsServer() then return end
	local modifiers = self:GetParent():FindAllModifiersByName("modifier_skywrath_mage_17_buff_stack")
	self:SetStackCount(#modifiers)
end

function modifier_skywrath_mage_17_buff:GetTexture() return "skywrath_mage_17" end

modifier_skywrath_mage_17_buff_stack = class({})

modifier_skywrath_mage_17_buff_stack.bonus_int = {1,2}
modifier_skywrath_mage_17_buff_stack.bonus_armor = {0.5,1}

function modifier_skywrath_mage_17_buff_stack:GetTexture() return "skywrath_mage_5" end
function modifier_skywrath_mage_17_buff_stack:IsHidden() return true end
function modifier_skywrath_mage_17_buff_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_skywrath_mage_17_buff_stack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_skywrath_mage_17_buff_stack:GetModifierBonusStats_Intellect()
	return self.bonus_int[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_17")]
end

function modifier_skywrath_mage_17_buff_stack:GetModifierPhysicalArmorBonus()
	return self.bonus_armor[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_17")]
end