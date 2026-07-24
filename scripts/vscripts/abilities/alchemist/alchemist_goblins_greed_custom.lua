--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_alchemist_goblins_greed_custom", "abilities/alchemist/alchemist_goblins_greed_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_goblins_greed_custom_stack", "abilities/alchemist/alchemist_goblins_greed_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_goblins_greed_custom_rune_cd", "abilities/alchemist/alchemist_goblins_greed_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_goblins_greed_custom_runes", "abilities/alchemist/alchemist_goblins_greed_custom", LUA_MODIFIER_MOTION_NONE )

alchemist_goblins_greed_custom = class({})


function alchemist_goblins_greed_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_alchemist_goblins_greed_custom"
end



function alchemist_goblins_greed_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/orange_drop.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context )
PrecacheResource( "particle", "particles/lc_wave.vpcf", context )
PrecacheResource( "particle", "particles/items2_fx/hand_of_midas.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_lasthit_msg_gold.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/rune_haste_owner.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/rune_doubledamage_owner.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/rune_regen_owner.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/rune_arcane_owner.vpcf", context )
PrecacheResource( "particle", "particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle", "particles/items2_fx/hand_of_midas.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_gold_lvl2.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/effigies/status_fx_effigies/gold_effigy_ambient_dire_lvl2.vpcf", context )
PrecacheResource( "particle", "particles/econ/events/ti9/shovel_smoke_cloud.vpcf" , context )

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_alchemist.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_alchemist", context)
end



modifier_alchemist_goblins_greed_custom = class(mod_visible)
function modifier_alchemist_goblins_greed_custom:OnCreated( kv )
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.parent:AddDeathEvent(self, true)

self.base_gold = self.ability:GetSpecialValueFor( "bonus_gold" )
self.bonus_gold = self.ability:GetSpecialValueFor( "bonus_bonus_gold" )
self.max_gold = self.ability:GetSpecialValueFor( "bonus_gold_cap" )
self.duration = self.ability:GetSpecialValueFor( "duration" )
self.scepter_gold = self.ability:GetSpecialValueFor("scepter_gold")

self.rune_cd = self.parent:GetTalentValue("modifier_alchemist_hero_6", "cd", true)

self.legendary_init = self.parent:GetTalentValue("modifier_alchemist_rage_legendary", "points_start", true)
self.legendary_inc = self.parent:GetTalentValue("modifier_alchemist_rage_legendary", "points_inc", true)
self.points_current = 0
self.points_max = self.legendary_init

self.scepter_init = false

if not IsServer() then return end
self:CheckStack()
self:UpdateTalent()

if self.ability:IsStolen() then return end
if not self.parent:IsRealHero() then return end

self:StartIntervalThink(2)
end


function modifier_alchemist_goblins_greed_custom:OnIntervalThink()
if not IsServer() then return end
if self.ability:IsStolen() then return end
if not self.parent:HasScepter() then return end
if self.scepter_init then return end
if not self.parent:IsAlive() then return end

self.scepter_init = true

local scepter = self.parent:FindItemInInventory("item_ultimate_scepter")
if scepter and not scepter:IsNull() then
	scepter:StartCooldown(1)
end

local item = CreateItem("item_alchemist_recipe", self.parent, self.parent)
self.parent:GenericParticle("particles/orange_drop.vpcf")
EmitSoundOnEntityForPlayer("powerup_02", self.parent, self.parent:GetId())
self.parent:AddItem(item)

self:StartIntervalThink(-1)
end


function modifier_alchemist_goblins_greed_custom:CheckStack()
if not IsServer() then return end
local stack = self.base_gold
local mod = self.parent:FindModifierByName("modifier_alchemist_goblins_greed_custom_stack")
if mod then
	stack = stack + mod:GetStackCount()*self.bonus_gold
end

local more_gold = self.parent:HasScepter() and self.scepter_gold or 0

self:SetStackCount(math.min(self.max_gold + more_gold, stack))
end


function modifier_alchemist_goblins_greed_custom:DeathEvent( params )
if not IsServer() then return end
if params.attacker~=self.parent then return end
if self.parent:GetTeamNumber()==params.unit:GetTeamNumber() then return end
if not params.unit:IsUnit() then return end
if not self.parent:IsAlive() then return end

local gold = self:GetStackCount()
local target = params.unit

if self.parent:GetQuest() == "Alch.Quest_7" and self.parent:QuestCompleted() == false then 
	self.parent:UpdateQuest(gold)
end

self.parent:ModifyGoldFiltered(gold, false, DOTA_ModifyGold_Unspecified)

local effect_name = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf", self)

local effect_cast = ParticleManager:CreateParticleForPlayer( effect_name, PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent:GetPlayerOwner() )
ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetOrigin() )
ParticleManager:ReleaseParticleIndex( effect_cast )

local digit = string.len(tostring(math.floor(gold))) + 1
local effect_cast_2 = ParticleManager:CreateParticleForPlayer( "particles/units/heroes/hero_alchemist/alchemist_lasthit_msg_gold.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent:GetPlayerOwner() )
ParticleManager:SetParticleControl( effect_cast_2, 1, Vector( 0, gold, 0 ) )
ParticleManager:SetParticleControl( effect_cast_2, 2, Vector( 1, digit, 0 ) )
ParticleManager:SetParticleControl( effect_cast_2, 3, Vector( 255, 255, 0 ) )
ParticleManager:ReleaseParticleIndex( effect_cast_2 )

self.parent:AddNewModifier( self.parent, self.ability, "modifier_alchemist_goblins_greed_custom_stack", {duration = self.duration})


if target:IsCreep() and self.parent:HasTalent("modifier_alchemist_hero_6") and not self.parent:HasModifier("modifier_alchemist_goblins_greed_custom_rune_cd") then
	local point = GetGroundPosition(self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*150, nil)

	EmitSoundOnLocationWithCaster(point, "Alch.gold", self.parent)
	CreateRune(point, DOTA_RUNE_BOUNTY)

	local effect_cast = ParticleManager:CreateParticle("particles/econ/events/ti9/shovel_smoke_cloud.vpcf" , PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:ReleaseParticleIndex(effect_cast)

	self.parent:AddNewModifier(self.parent, nil, "modifier_alchemist_goblins_greed_custom_rune_cd", {duration = self.rune_cd})
end


if self.parent:HasTalent("modifier_alchemist_rage_legendary") then
	local points = BluePoints[target:GetUnitName()]
	if not points and Shared_Bounty[target:GetUnitName()] then
		points = Shared_Bounty[target:GetUnitName()].blue 
	end

	if not points then return end
	self.points_current = self.points_current + points
	if self.points_current >= self.points_max then
		self.points_current = self.points_current - self.points_max
		self.points_max = self.points_max + self.legendary_inc

		dota1x6:CreateUpgradeOrb(self.parent, 1)
	end

	self.parent:UpdateUIlong({max = self.points_max, stack = self.points_current, override_stack = tostring(self.points_current)..'/'..tostring(self.points_max), no_min = 1, style = "AlchemistPoints"})
end

end

function modifier_alchemist_goblins_greed_custom:UpdateTalent(name)
if not IsServer() then return end

if name == "modifier_alchemist_rage_legendary" or self.parent:HasTalent("modifier_alchemist_rage_legendary") then
	self.parent:UpdateUIlong({max = self.points_max, stack = self.points_current, override_stack = tostring(self.points_current)..'/'..tostring(self.points_max), no_min = 1, style = "AlchemistPoints"})
end

end




modifier_alchemist_goblins_greed_custom_stack = class(mod_hidden)
function modifier_alchemist_goblins_greed_custom_stack:RemoveOnDeath() return false end
function modifier_alchemist_goblins_greed_custom_stack:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.duration = self.ability:GetSpecialValueFor("duration")

if not IsServer() then return end 
self.mod = self.parent:FindModifierByName("modifier_alchemist_goblins_greed_custom")

self:AddStack()
end

function modifier_alchemist_goblins_greed_custom_stack:OnRefresh(table)
if not IsServer() then return end 
self:AddStack()
end 

function modifier_alchemist_goblins_greed_custom_stack:AddStack()
if not IsServer() then return end

Timers:CreateTimer(self.duration, function() 
	if self and not self:IsNull() then 
		self:DecrementStackCount()
		if self:GetStackCount() <= 0 then 
			self:Destroy()
		end 
	end 
end)

self:IncrementStackCount()

end

function modifier_alchemist_goblins_greed_custom_stack:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if not self.mod or self.mod:IsNull() then return end
self.mod:CheckStack()
end


function modifier_alchemist_goblins_greed_custom_stack:OnDestroy()
if not IsServer() then return end
if not self.mod or self.mod:IsNull() then return end
self.mod:CheckStack()
end






modifier_alchemist_goblins_greed_custom_runes = class({})
function modifier_alchemist_goblins_greed_custom_runes:IsHidden() return not self.parent:HasTalent("modifier_alchemist_hero_6") or self:GetStackCount() >= self.max end
function modifier_alchemist_goblins_greed_custom_runes:IsPurgable() return false end
function modifier_alchemist_goblins_greed_custom_runes:RemoveOnDeath() return false end
function modifier_alchemist_goblins_greed_custom_runes:GetTexture() return "buffs/alchemist/hero_7" end
function modifier_alchemist_goblins_greed_custom_runes:OnCreated()
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_alchemist_hero_6", "max", true)
self.cdr = self.parent:GetTalentValue("modifier_alchemist_hero_6", "cdr", true)/self.max

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_alchemist_goblins_greed_custom_runes:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()
end

function modifier_alchemist_goblins_greed_custom_runes:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self.parent:HasTalent("modifier_alchemist_hero_6") then return end

self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 


function modifier_alchemist_goblins_greed_custom_runes:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end


function modifier_alchemist_goblins_greed_custom_runes:GetModifierPercentageCooldown() 
if not self.parent:HasTalent("modifier_alchemist_hero_6") then return end
return self:GetStackCount()*self.cdr
end









modifier_alchemist_goblins_greed_custom_rune_cd = class(mod_cd)
function modifier_alchemist_goblins_greed_custom_rune_cd:GetTexture() return "buffs/alchemist/hero_7" end