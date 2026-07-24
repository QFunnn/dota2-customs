--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_bane_innate_custom", "abilities/bane/bane_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bane_innate_custom_buff", "abilities/bane/bane_innate_custom", LUA_MODIFIER_MOTION_NONE )

bane_innate_custom = class({})

function bane_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_bane.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_bane", context)
end

function bane_innate_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_e3 = 0,
    e3_stats = 0,
  }
end

if caster:HasTalent("modifier_bane_nightmare_3") then
  self.talents.has_e3 = 1
  self.talents.e3_stats = caster:GetTalentValue("modifier_bane_nightmare_3", "stats")/100
  if IsServer() then
		self.caster:AddPercentStat({agi = self.talents.e3_stats, str = self.talents.e3_stats, int = self.talents.e3_stats}, self.tracker)
  end
end

end

function bane_innate_custom:GetIntrinsicModifierName()
return "modifier_bane_innate_custom"
end


modifier_bane_innate_custom = class({})
function modifier_bane_innate_custom:IsHidden() return true end
function modifier_bane_innate_custom:IsPurgable() return false end
function modifier_bane_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.bane_innate_ability = self.ability

self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.stats = self.ability:GetSpecialValueFor("stats")/100
self.ability.max = self.ability:GetSpecialValueFor("max")
self.ability.duration = self.ability:GetSpecialValueFor("duration")

if not IsServer() then return end
self.active_mods = {}
self.current_think = false
end

function modifier_bane_innate_custom:UpdateMod(mod, remove)
if not IsServer() then return end

if remove then
	self.active_mods[mod] = nil
else
	self.active_mods[mod] = true
end

local has_mod = false
for check_mod,_ in pairs(self.active_mods) do
	if IsValid(check_mod) then
		has_mod = true
	else
		self.active_mods[check_mod] = nil
	end
end

if has_mod then
	if not self.current_think then
		self.current_think = true
		self:StartIntervalThink(1)
	end
else
	self.current_think = false
	self:StartIntervalThink(-1)
end

end

function modifier_bane_innate_custom:OnIntervalThink()
if not IsServer() then return end
self.parent:AddNewModifier(self.parent, self.ability, "modifier_bane_innate_custom_buff", {duration = self.ability.duration})
end

function modifier_bane_innate_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_bane_innate_custom:GetModifierTotalDamageOutgoing_Percentage(params)
if not IsServer() then return end
if not params.target then return end
if not params.target:IsCreep() then return end

return self.ability.damage
end


modifier_bane_innate_custom_buff = class(mod_visible)
function modifier_bane_innate_custom_buff:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.max
self.stats = (self.ability.stats/self.max)

if not IsServer() then return end
self:OnRefresh(table)
end

function modifier_bane_innate_custom_buff:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
self.parent:AddPercentStat({agi = self.stats*self:GetStackCount(), str = self.stats*self:GetStackCount(), int = self.stats*self:GetStackCount()}, self)
end

function modifier_bane_innate_custom_buff:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_bane_innate_custom_buff:OnTooltip()
return self:GetStackCount()*self.stats*100
end