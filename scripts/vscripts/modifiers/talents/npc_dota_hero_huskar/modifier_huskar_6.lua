--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_huskar_6=class({})

LinkLuaModifier("modifier_huskar_6_buff", "modifiers/talents/npc_dota_hero_huskar/modifier_huskar_6", LUA_MODIFIER_MOTION_NONE)

function modifier_huskar_6:IsHidden() return true end
function modifier_huskar_6:IsPurgable() return false end
function modifier_huskar_6:IsPurgeException() return false end
function modifier_huskar_6:RemoveOnDeath() return false end

function modifier_huskar_6:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_huskar_6_buff", {})
end

function modifier_huskar_6:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

modifier_huskar_6_buff=class({})
function modifier_huskar_6_buff:IsHidden() return self:GetStackCount() == 0 end
function modifier_huskar_6_buff:IsPurgable() return false end
function modifier_huskar_6_buff:IsPurgeException() return false end
function modifier_huskar_6_buff:RemoveOnDeath() return false end
function modifier_huskar_6_buff:GetTexture() return "huskar_6" end
function modifier_huskar_6_buff:OnCreated()
    if not IsServer() then return end
    self.bonus = 1
    self.bonus_max = {7, 14, 21}
    self:StartIntervalThink(0.25)
end
function modifier_huskar_6_buff:OnIntervalThink()
    if not IsServer() then return end
    if GetMapName() == "arena" then return end
    self:SetStackCount(math.min(self:GetCaster():GetKills() * self.bonus, self.bonus_max[self:GetCaster():GetTalentLevel("modifier_huskar_6")]))
end