--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_modifier_chen_13_movespeed", "modifiers/talents/npc_dota_hero_chen/modifier_chen_13", LUA_MODIFIER_MOTION_NONE)

modifier_chen_13 = class({})

function modifier_chen_13:IsHidden() return true end
function modifier_chen_13:IsPurgable() return false end
function modifier_chen_13:IsPurgeException() return false end
function modifier_chen_13:RemoveOnDeath() return false end

function modifier_chen_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_chen_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_chen_13:DeclareFunctions()
	return 
    {
		 
	}
end

function modifier_chen_13:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	params.target:AddNewModifier(self:GetCaster(), nil, "modifier_modifier_chen_13_movespeed", {duration = 3})
end

modifier_modifier_chen_13_movespeed = class({})
modifier_modifier_chen_13_movespeed.speed = {-10,-15,-20}

function modifier_modifier_chen_13_movespeed:GetTexture()
    return "chen_13"
end

function modifier_modifier_chen_13_movespeed:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_modifier_chen_13_movespeed:GetModifierMoveSpeedBonus_Percentage()
	return self.speed[self:GetCaster():GetTalentLevel("modifier_chen_13")]
end