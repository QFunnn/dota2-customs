--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phantom_assassin_1_armor", "modifiers/talents/npc_dota_hero_phantom_assassin/modifier_phantom_assassin_1", LUA_MODIFIER_MOTION_NONE)

modifier_phantom_assassin_1=class({})

function modifier_phantom_assassin_1:IsHidden() return true end
function modifier_phantom_assassin_1:IsPurgable() return false end
function modifier_phantom_assassin_1:IsPurgeException() return false end
function modifier_phantom_assassin_1:RemoveOnDeath() return false end

function modifier_phantom_assassin_1:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_phantom_assassin_1:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_phantom_assassin_1:DeclareFunctions()
	return {
		 
	}
end

function modifier_phantom_assassin_1:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	params.target:AddNewModifier(self:GetCaster(), nil, "modifier_phantom_assassin_1_armor", {duration = 7})
end

modifier_phantom_assassin_1_armor = class({})

modifier_phantom_assassin_1_armor.armor = {-2,-4}

function modifier_phantom_assassin_1_armor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_phantom_assassin_1_armor:GetModifierPhysicalArmorBonus()
	return self.armor[self:GetCaster():GetTalentLevel("modifier_phantom_assassin_1")]
end

function modifier_phantom_assassin_1_armor:GetTexture()
	return "phantom_assassin_1"
end