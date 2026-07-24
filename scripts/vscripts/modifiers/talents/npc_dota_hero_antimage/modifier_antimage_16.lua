--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_antimage_16_buff", "modifiers/talents/npc_dota_hero_antimage/modifier_antimage_16", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_antimage_16_buff_stack", "modifiers/talents/npc_dota_hero_antimage/modifier_antimage_16", LUA_MODIFIER_MOTION_NONE)

modifier_antimage_16=class({})

function modifier_antimage_16:IsHidden() return true end
function modifier_antimage_16:IsPurgable() return false end
function modifier_antimage_16:IsPurgeException() return false end
function modifier_antimage_16:RemoveOnDeath() return false end

function modifier_antimage_16:OnCreated()
	self.bonus = 2
    self.duration = {10,15,20}
	if not IsServer() then return end
	self:SetStackCount(1)
    local antimage_mana_break_custom = self:GetParent():FindAbilityByName("antimage_mana_break_custom")
    if antimage_mana_break_custom then
        antimage_mana_break_custom:SetHidden(true)
        antimage_mana_break_custom:SetLevel(0)
    end
end

function modifier_antimage_16:OnRefresh()
	self.bonus = 2
    self.duration = {10,15,20}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_antimage_16:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end

function modifier_antimage_16:GetModifierPreAttack_BonusDamage()
	return self:GetParent():GetMana() / 100 * self.bonus
end

function modifier_antimage_16:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    local mana_bonus = {30,45,60}
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_antimage_16_buff", {duration = self.duration[self:GetStackCount()]})
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_antimage_16_buff_stack", {duration = self.duration[self:GetStackCount()], mana = mana_bonus[self:GetStackCount()]})
end

modifier_antimage_16_buff = class({})
function modifier_antimage_16_buff:GetTexture() return "antimage_16" end
function modifier_antimage_16_buff:IsPurgable() return false end

function modifier_antimage_16_buff:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:StartIntervalThink(FrameTime())
end

function modifier_antimage_16_buff:OnIntervalThink()
	if not IsServer() then return end
	local mod = self:GetParent():FindAllModifiersByName("modifier_antimage_16_buff_stack")
	self:SetStackCount(#mod)
end

modifier_antimage_16_buff_stack = class({})
function modifier_antimage_16_buff_stack:IsHidden() return true end
function modifier_antimage_16_buff_stack:IsPurgable() return false end
function modifier_antimage_16_buff_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_antimage_16_buff_stack:OnCreated(kv)
	if not IsServer() then return end
	self:GetCaster():CalculateStatBonus(true)
	self.mana = kv.mana
	self:GetParent():GiveMana(self.mana)
end

function modifier_antimage_16_buff_stack:OnDestroy(kv)
	if not IsServer() then return end
	self:GetCaster():CalculateStatBonus(true)
end

function modifier_antimage_16_buff_stack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_BONUS
	}
end

function modifier_antimage_16_buff_stack:GetModifierManaBonus()
	return self.mana
end