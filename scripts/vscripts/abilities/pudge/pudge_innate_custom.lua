--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_pudge_innate_custom", "abilities/pudge/pudge_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_pudge_innate_custom_creeps", "abilities/pudge/pudge_innate_custom", LUA_MODIFIER_MOTION_NONE )


pudge_innate_custom = class({})



function pudge_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_pudge_innate_custom"
end

function pudge_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_pudge.vsndevts", context )
PrecacheResource( "soundfile", "soundevents/vo_custom/pudge_vo_custom.vsndevts", context ) 
end


modifier_pudge_innate_custom = class({})
function modifier_pudge_innate_custom:IsHidden() return false end
function modifier_pudge_innate_custom:IsPurgable() return false end
function modifier_pudge_innate_custom:RemoveOnDeath() return false end
function modifier_pudge_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)

self.ability = self:GetAbility()

self.str = self.ability:GetSpecialValueFor("str")
self.radius = self.ability:GetSpecialValueFor("radius")
self.max = self.ability:GetSpecialValueFor("max_stacks")
self.shard_str = self.ability:GetSpecialValueFor("shard_str")
self.shard_point = self.ability:GetSpecialValueFor("shard_point")

self.stack = 0
self.creeps_k = 150
self.creeps_max = 15

self.legendary_k = self.parent:GetTalentValue("modifier_pudge_flesh_legendary", "bonus", true)/100 + 1

self.str_count = self.parent:GetTalentValue("modifier_pudge_flesh_3", "count", true)

if not IsServer() then return end
self.parent:AddNewModifier(self.parent, self.ability, "modifier_pudge_innate_custom_creeps" , {})
end

function modifier_pudge_innate_custom:OnRefresh(table)
self.str = self.ability:GetSpecialValueFor("str")
end


function modifier_pudge_innate_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end


function modifier_pudge_innate_custom:GetModifierSpellAmplify_Percentage() 
if not self.parent:HasTalent("modifier_pudge_flesh_3") then return end
return (self.parent:GetStrength()/self.str_count)*self.parent:GetTalentValue("modifier_pudge_flesh_3", "spell")
end

function modifier_pudge_innate_custom:GetModifierBonusStats_Strength()
local bonus = 0
local k = 1
if self.parent:HasTalent("modifier_pudge_flesh_legendary") then
	k = self.legendary_k
end
if self.parent:HasShard() then
	bonus = self.shard_str
end
return (self.str + bonus) * self:GetStackCount() * k
end


function modifier_pudge_innate_custom:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_pudge_innate_custom:AddStack()
if self.stack >= self.max then return end

self:SetStackCount(self:GetStackCount() + 1)
self.stack = self.stack + 1

self.parent:GenericParticle("particles/units/heroes/hero_pudge/pudge_fleshheap_count.vpcf")

if self.parent:GetQuest() == "Pudge.Quest_7" then 
	self.parent:UpdateQuest(1)
end

self:CheckMax()
end


function modifier_pudge_innate_custom:CheckMax()

local mod = self.parent:FindModifierByName("modifier_pudge_innate_custom_creeps")

if self.stack >= self.max then 
	if mod then 
		self.parent:UpdateUIlong({hide = 1, style = "PudgeShard"})
		mod:Destroy()
	end
	return
end
end


function modifier_pudge_innate_custom:DeathEvent(params)
if not IsServer() then return end

local target = params.unit
if self.parent:GetTeamNumber() == target:GetTeamNumber() then return end
if target:IsReincarnating() then return end

self:CheckMax()

local mod = self.parent:FindModifierByName("modifier_pudge_innate_custom_creeps")
if mod and target:GetTeam() == DOTA_TEAM_NEUTRALS and self.parent:HasShard() and params.attacker == self.parent and not self.ability:IsStolen() then 

	local inc = math.min(self.creeps_max, target:GetMaxHealth()/self.creeps_k)

	if mod:GetStackCount() + inc < self.shard_point then 
		mod:SetStackCount(mod:GetStackCount() + inc)
	else 
		mod:SetStackCount(inc - (self.shard_point - mod:GetStackCount()))
		self:AddStack()
	end

	self.parent:UpdateUIlong({max = self.shard_point, stack = mod:GetStackCount(), style = "PudgeShard"})
end


if not target:IsValidKill(self.parent) then return end

if ((self.parent:GetAbsOrigin() - target:GetAbsOrigin()):Length2D() <= self.radius) or (params.attacker and params.attacker == self.parent) then
	self:AddStack()
end

end





modifier_pudge_innate_custom_creeps = class({})
function modifier_pudge_innate_custom_creeps:IsHidden() return true end
function modifier_pudge_innate_custom_creeps:IsPurgable() return false end
function modifier_pudge_innate_custom_creeps:RemoveOnDeath() return false end
function modifier_pudge_innate_custom_creeps:GetTexture() return "buffs/flesh_creep" end