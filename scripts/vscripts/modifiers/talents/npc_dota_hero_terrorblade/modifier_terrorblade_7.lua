--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_terrorblade_7=class({})

LinkLuaModifier("modifier_terrorblade_7_buff", "modifiers/talents/npc_dota_hero_terrorblade/modifier_terrorblade_7", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_terrorblade_7_counter", "modifiers/talents/npc_dota_hero_terrorblade/modifier_terrorblade_7", LUA_MODIFIER_MOTION_NONE)

function modifier_terrorblade_7:IsHidden() return true end
function modifier_terrorblade_7:IsPurgable() return false end
function modifier_terrorblade_7:IsPurgeException() return false end
function modifier_terrorblade_7:RemoveOnDeath() return false end

function modifier_terrorblade_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_terrorblade_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_terrorblade_7:DeclareFunctions()
	return {
		 
	}
end

function modifier_terrorblade_7:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if not self:GetParent():IsAlive() then return end

	self:SetStackCount(self:GetStackCount() + params.damage)

	if self:GetStackCount() >= self:GetParent():GetMaxHealth() / 100 * 10 then
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_terrorblade_7_counter", {duration = 7})
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_terrorblade_7_buff", {duration = 7})
		self:SetStackCount(0)
	end
end

modifier_terrorblade_7_counter = class({})

function modifier_terrorblade_7_counter:IsHidden() return false end
function modifier_terrorblade_7_counter:IsPurgable() return false end

function modifier_terrorblade_7_counter:GetStatusEffectName()
	return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_terrorblade_7_counter:StatusEffectPriority() return 10 end

function modifier_terrorblade_7_counter:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_terrorblade_7_counter:OnIntervalThink()
	if not IsServer() then return end
	local mod = self:GetParent():FindAllModifiersByName("modifier_terrorblade_7_buff")
	self:SetStackCount(#mod)
end

function modifier_terrorblade_7_counter:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
	}
end

function modifier_terrorblade_7_counter:GetModifierTotalDamageOutgoing_Percentage()
	return 7 * self:GetStackCount()
end

function modifier_terrorblade_7_counter:GetTexture() return "terrorblade_7" end

modifier_terrorblade_7_buff = class({})
function modifier_terrorblade_7_buff:IsHidden() return true end
function modifier_terrorblade_7_buff:IsPurgable() return false end
function modifier_terrorblade_7_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end