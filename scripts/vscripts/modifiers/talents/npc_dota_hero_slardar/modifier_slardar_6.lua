--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_slardar_6_buff", "modifiers/talents/npc_dota_hero_slardar/modifier_slardar_6", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_slardar_6_buff_counter", "modifiers/talents/npc_dota_hero_slardar/modifier_slardar_6", LUA_MODIFIER_MOTION_NONE)

modifier_slardar_6=class({})

function modifier_slardar_6:IsHidden() return true end
function modifier_slardar_6:IsPurgable() return false end
function modifier_slardar_6:IsPurgeException() return false end
function modifier_slardar_6:RemoveOnDeath() return false end

function modifier_slardar_6:OnCreated()
	self.duration = {2,3}
    self.max_effect = 15
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_slardar_6:OnRefresh()
	self.duration = {2,3}
    self.max_effect = 15
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_slardar_6:DeclareFunctions()
	return 
	{
		 
	}
end

function modifier_slardar_6:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker == self:GetParent() then return end
	if params.target ~= self:GetParent() then return end
	local stack = self:GetParent():FindAllModifiersByName("modifier_slardar_6_buff")
	if #stack < 15 then
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_slardar_6_buff_counter", {duration = self.duration[self:GetStackCount()] })
    	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_slardar_6_buff", {duration = self.duration[self:GetStackCount()] })
    end
end

modifier_slardar_6_buff = class({})
function modifier_slardar_6_buff:IsHidden() return true end
function modifier_slardar_6_buff:IsPurgable() return false end
function modifier_slardar_6_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

modifier_slardar_6_buff_counter = class({})

function modifier_slardar_6_buff_counter:GetTexture()
	return "slardar_6"
end

function modifier_slardar_6_buff_counter:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(0)
    self:StartIntervalThink(FrameTime())
end

function modifier_slardar_6_buff_counter:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_slardar_6_buff")
    self:SetStackCount(#stack)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_slardar_6_buff_counter:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_slardar_6_buff_counter:GetModifierPhysicalArmorBonus()
    return self:GetStackCount()
end