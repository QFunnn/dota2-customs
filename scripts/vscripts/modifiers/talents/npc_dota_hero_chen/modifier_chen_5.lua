--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_modifier_chen_5_armor", "modifiers/talents/npc_dota_hero_chen/modifier_chen_5", LUA_MODIFIER_MOTION_NONE)

modifier_chen_5 = class({})

function modifier_chen_5:IsHidden() return true end
function modifier_chen_5:IsPurgable() return false end
function modifier_chen_5:IsPurgeException() return false end
function modifier_chen_5:RemoveOnDeath() return false end

function modifier_chen_5:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_chen_5:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_chen_5:DeclareFunctions()
	return 
    {
		 
	}
end

function modifier_chen_5:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	params.target:AddNewModifier(self:GetCaster(), nil, "modifier_modifier_chen_5_armor", {duration = 3})
end

modifier_modifier_chen_5_armor = class({})
modifier_modifier_chen_5_armor.armor = {-4,-8}

function modifier_modifier_chen_5_armor:GetTexture()
    return "chen_5"
end

function modifier_modifier_chen_5_armor:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_modifier_chen_5_armor:GetModifierPhysicalArmorBonus()
	return self.armor[self:GetCaster():GetTalentLevel("modifier_chen_5")]
end