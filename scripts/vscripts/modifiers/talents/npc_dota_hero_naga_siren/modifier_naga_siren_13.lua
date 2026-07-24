--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_naga_siren_13_debuff", "modifiers/talents/npc_dota_hero_naga_siren/modifier_naga_siren_13", LUA_MODIFIER_MOTION_NONE)

modifier_naga_siren_13=class({})

function modifier_naga_siren_13:IsHidden() return true end
function modifier_naga_siren_13:IsPurgable() return false end
function modifier_naga_siren_13:IsPurgeException() return false end
function modifier_naga_siren_13:RemoveOnDeath() return false end

function modifier_naga_siren_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_naga_siren_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_naga_siren_13:DeclareFunctions()
	local funcs = 
	{
		 
	}
	return funcs
end

function modifier_naga_siren_13:OnAttackLanded(params)
	if params.target == self:GetParent() then return end
	if params.attacker ~= self:GetParent() then return end
	params.target:AddNewModifier(self:GetCaster(), nil, "modifier_naga_siren_13_debuff", {duration = 3})
end

modifier_naga_siren_13_debuff = class({})

function modifier_naga_siren_13_debuff:GetTexture() return "naga_siren_13" end

function modifier_naga_siren_13_debuff:OnCreated()
	self.debuff = {-10,-20,-30}
end

function modifier_naga_siren_13_debuff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
end

function modifier_naga_siren_13_debuff:GetModifierPropertyRestorationAmplification()
	return self.debuff[self:GetCaster():GetTalentLevel("modifier_naga_siren_13")]
end