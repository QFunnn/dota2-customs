--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_muerta_gunslinger_custom_slow", "modifiers/talents/npc_dota_hero_muerta/modifier_muerta_10", LUA_MODIFIER_MOTION_NONE)

modifier_muerta_10=class({})

function modifier_muerta_10:IsHidden() return true end
function modifier_muerta_10:IsPurgable() return false end
function modifier_muerta_10:IsPurgeException() return false end
function modifier_muerta_10:RemoveOnDeath() return false end

function modifier_muerta_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_muerta_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_muerta_10:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if self:GetCaster():HasModifier("modifier_muerta_10") then
		params.target:AddNewModifier(self:GetCaster(), nil, "modifier_muerta_gunslinger_custom_slow", {duration = 3})
	end
end

modifier_muerta_gunslinger_custom_slow = class({})

function modifier_muerta_gunslinger_custom_slow:GetTexture() return "muerta_10" end

function modifier_muerta_gunslinger_custom_slow:OnCreated()
    self.slow = {-7,-15}
end

function modifier_muerta_gunslinger_custom_slow:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_muerta_gunslinger_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow[self:GetCaster():GetTalentLevel("modifier_muerta_10")]
end