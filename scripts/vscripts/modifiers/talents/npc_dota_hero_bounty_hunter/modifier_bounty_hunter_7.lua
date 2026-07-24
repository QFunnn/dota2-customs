--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bounty_hunter_7_armor", "modifiers/talents/npc_dota_hero_bounty_hunter/modifier_bounty_hunter_7", LUA_MODIFIER_MOTION_NONE)

modifier_bounty_hunter_7=class({})

function modifier_bounty_hunter_7:IsHidden() return true end
function modifier_bounty_hunter_7:IsPurgable() return false end
function modifier_bounty_hunter_7:IsPurgeException() return false end
function modifier_bounty_hunter_7:RemoveOnDeath() return false end

function modifier_bounty_hunter_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_bounty_hunter_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_bounty_hunter_7:DeclareFunctions()
	return {
		 
	}
end

function modifier_bounty_hunter_7:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	params.target:AddNewModifier(self:GetCaster(), nil, "modifier_bounty_hunter_7_armor", {duration = 4})
end


modifier_bounty_hunter_7_armor = class({})

modifier_bounty_hunter_7_armor.armor = {-3,-6}

function modifier_bounty_hunter_7_armor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_bounty_hunter_7_armor:GetModifierPhysicalArmorBonus()
	return self.armor[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_7")]
end

function modifier_bounty_hunter_7_armor:GetTexture()
	return "bounty_hunter_7"
end