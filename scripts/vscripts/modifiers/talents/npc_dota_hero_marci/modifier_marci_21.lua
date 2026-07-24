--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_marci_21_debuff", "modifiers/talents/npc_dota_hero_marci/modifier_marci_21", LUA_MODIFIER_MOTION_NONE)

modifier_marci_21=class({})

function modifier_marci_21:IsHidden() return true end
function modifier_marci_21:IsPurgable() return false end
function modifier_marci_21:IsPurgeException() return false end
function modifier_marci_21:RemoveOnDeath() return false end

function modifier_marci_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_marci_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_marci_21:DeclareFunctions()
	local funcs = 
	{
		 
	}
	return funcs
end

function modifier_marci_21:OnAttackLanded(params)
	if params.target == self:GetParent() then return end
	if params.attacker ~= self:GetParent() then return end
	params.target:AddNewModifier(self:GetCaster(), nil, "modifier_marci_21_debuff", {duration = 4})
end

modifier_marci_21_debuff = class({})

function modifier_marci_21_debuff:GetTexture() return "marci_21" end

function modifier_marci_21_debuff:OnCreated()
	self.debuff = -50
end

function modifier_marci_21_debuff:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
	return funcs
end

function modifier_marci_21_debuff:GetModifierPropertyRestorationAmplification()
	return self.debuff
end