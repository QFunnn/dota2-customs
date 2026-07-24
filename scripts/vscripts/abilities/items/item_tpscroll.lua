--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_ability_teleport", "abilities/items/item_tpscroll", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_ability_teleport_tracker", "abilities/items/item_tpscroll", LUA_MODIFIER_MOTION_NONE)

item_tpscroll_custom = class({})

function item_tpscroll_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/teleport_start.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/teleport_end.vpcf", context )
PrecacheResource( "particle","particles/items_fx/glyph.vpcf", context ) 

PrecacheResource( "particle","particles/econ/events/ti10/teleport/teleport_start_ti10_lvl1_rewardline.vpcf", context )
PrecacheResource( "particle","particles/econ/events/ti5/teleport_end_lvl2_ti5.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/smoke_of_deceit.vpcf", context )
PrecacheResource( "particle","particles/econ/items/tinker/boots_of_travel/teleport_start_bots.vpcf", context )
PrecacheResource( "particle","particles/tinker/teleport_end_bots.vpcf", context )
end

function item_tpscroll_custom:GlobalTeleport()
local caster = self:GetCaster()
return caster:HasModifier("modifier_patrol_reward_2_portal") or (caster:HasModifier("modifier_tinker_innate_custom") and caster:HasScepter())
end

function item_tpscroll_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_ability_teleport_tracker"
end


function item_tpscroll_custom:GetAbilityTextureName()
if not self or not self:GetCaster() then return end 
local caster = self:GetCaster()
if caster:HasModifier("modifier_patrol_reward_2_portal") then
    return "items/warp_amulet"
end
if caster:HasModifier("modifier_tinker_innate_custom") and caster:HasScepter() then
	return "items/tinker_keen_teleport"
end
return "item_tpscroll"
end

function item_tpscroll_custom:GetCastRange(vector, target)
local caster = self:GetCaster()
if (IsClient() or caster:HasModifier("modifier_the_hunt_custom_hero")) and caster:HasScepter() and self.tinker_range then
	return self.tinker_range - caster:GetCastRangeBonus()
end

if not IsServer() then return end
return 99999
end



function item_tpscroll_custom:GetBehavior()
local base = DOTA_ABILITY_BEHAVIOR_NO_TARGET 
if self:GlobalTeleport() then
	base = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT
end
return base + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + 549755813888
end

function item_tpscroll_custom:GetChannelTime() 
return self:GetCaster():GetUpgradeStack("modifier_custom_ability_teleport_tracker")/100
end

function item_tpscroll_custom:GetCooldown(level)
local caster = self:GetCaster()
if caster:HasModifier("modifier_patrol_reward_2_portal") then
	return caster:GetTalentValue("modifier_patrol_reward_portal", "cd", true)/caster:GetCooldownReduction()
end
return self.BaseClass.GetCooldown( self, level )
end


function item_tpscroll_custom:OnAbilityPhaseStart()
return self:GetCaster():CanTeleport() 
end


function item_tpscroll_custom:OnSpellStart()
local caster = self:GetCaster()
local go_home = false

local effect_start = "particles/items2_fx/teleport_start.vpcf"
local effect_end = "particles/items2_fx/teleport_end.vpcf"
local color = Vector(255, 255, 255)

local player_id = caster:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_teleportation")

if self:GlobalTeleport() then
	local unit = self:GetCursorTarget()
	if unit and unit == caster then
		go_home = true
	end
	self.point = self:GetCursorPosition()

	if caster:HasModifier("modifier_patrol_reward_2_portal") then
		effect_start = "particles/econ/events/ti10/teleport/teleport_start_ti10_lvl1_rewardline.vpcf"
		effect_end = "particles/econ/events/ti5/teleport_end_lvl2_ti5.vpcf"
	end
else
	go_home = true
end

local tinker_checkout = wearables_system:GetParticleReplacementAbility(caster, "particles/items2_fx/teleport_start.vpcf", self)
if tinker_checkout == "particles/econ/items/tinker/boots_of_travel/teleport_start_bots.vpcf" then
	effect_start = "particles/econ/items/tinker/boots_of_travel/teleport_start_bots.vpcf"
	effect_end = "particles/tinker/teleport_end_bots.vpcf"
end

if custom_effect_data then
    effect_start = custom_effect_data[1]
    effect_end = custom_effect_data[2]
end

if go_home then
	self.point = GetGroundPosition(towers[caster:GetTeamNumber()]:GetAbsOrigin() + RandomVector(220), nil)
end

if effect_end == "particles/econ/events/compendium_2024/compendium_2024_teleport_lvl3_end.vpcf" or effect_end == "particles/econ/events/compendium_2023/compendium_2023_teleport_lvl3_end.vpcf" then
	color = Vector(0.5, 0.5, 0.5)
end

self.point_start = caster:GetAbsOrigin()

caster:StartGesture(ACT_DOTA_TELEPORT)

self.teleport_center = CreateUnitByName("npc_dota_companion", self.point, false, nil, nil, 0)
self.teleport_center:AddNewModifier(self.teleport_center, nil, "modifier_phased", {})
self.teleport_center:AddNewModifier(self.teleport_center, nil, "modifier_invulnerable", {})
self.teleport_center:SetAbsOrigin(self.point)

AddFOWViewer(caster:GetTeamNumber(), self.point, 400, self:GetChannelTime() + 0.5, false)
caster:AddNewModifier(caster, self, "modifier_custom_ability_teleport", {duration = self:GetChannelTime(), center = self.teleport_center:entindex()})

self.teleportFromEffect = ParticleManager:CreateParticle(effect_start, PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.teleportFromEffect, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(self.teleportFromEffect, 2, color)
ParticleManager:SetParticleControl(self.teleportFromEffect, 7, Vector(1, 1, 1))

self.teleportToEffect = ParticleManager:CreateParticle(effect_end, PATTACH_ABSORIGIN_FOLLOW, self.teleport_center)
ParticleManager:SetParticleControlEnt(self.teleportToEffect, 1, self.teleport_center, PATTACH_ABSORIGIN_FOLLOW, nil, self.teleport_center:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(self.teleportToEffect, 2, color)
--ParticleManager:SetParticleControlEnt(self.teleportToEffect, 3, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.teleport_center:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(self.teleportToEffect, 4, Vector(0.9, 0, 0))
ParticleManager:SetParticleControlEnt(self.teleportToEffect, 5, self.teleport_center, PATTACH_ABSORIGIN_FOLLOW, nil, self.teleport_center:GetAbsOrigin(), true)

self.tinker_tp = false
if caster:HasScepter() and IsValid(caster.tinker_innate) then
	self.tinker_tp = true
end

end


function item_tpscroll_custom:OnChannelFinish(bInterrupted)

local caster = self:GetCaster()
caster:RemoveModifierByName("modifier_custom_ability_teleport")

if IsValid(self.teleport_center) then
	self.teleport_center:StopSound("Portal.Loop_Appear")
	self.teleport_center:StopSound("Hero_Tinker.MechaBoots.Loop")
	UTIL_Remove(self.teleport_center)
end

caster:RemoveGesture(ACT_DOTA_TELEPORT)

if self.teleportFromEffect then
	ParticleManager:DestroyParticle(self.teleportFromEffect, false)
	ParticleManager:ReleaseParticleIndex(self.teleportFromEffect)
end

if self.teleportToEffect then
	ParticleManager:DestroyParticle(self.teleportToEffect, false)
	ParticleManager:ReleaseParticleIndex(self.teleportToEffect)
end

if bInterrupted then 
	if self.tinker_tp then
		self:EndCd(0.2)
	end
    return 
end   

EmitSoundOnLocationWithCaster(self.point_start, "Portal.Hero_Disappear", caster)

caster:SetAbsOrigin(self.point)
FindClearSpaceForUnit(caster, self.point, true)

caster:Stop()
caster:Interrupt()

caster:EmitSound("Portal.Hero_Disappear")
caster:StartGesture(ACT_DOTA_TELEPORT_END)

if caster:HasModifier("modifier_patrol_reward_2_portal") then
	caster:AddNewModifier(caster, self, "modifier_can_not_push", {duration = caster:GetTalentValue("modifier_patrol_reward_portal", "push_duration", true)})
else
	caster:AddNewModifier(caster, self, "modifier_invun", {duration = self:GetSpecialValueFor("invun")})
end

if self.tinker_tp and IsValid(caster.tinker_innate) then
	caster.tinker_innate:ProcTeleport()
	caster:AddNewModifier(caster, self, "modifier_can_not_push", {duration = 6})
end

end


function item_tpscroll_custom:OnChannelThink(fInterval)

if not self:GetCaster():TeleportThink() then 
    self:GetCaster():Stop()
    self:GetCaster():Interrupt() 
end 

end

modifier_custom_ability_teleport_tracker = class(mod_hidden)
function modifier_custom_ability_teleport_tracker:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.channel_time = self.ability:GetSpecialValueFor("channel_time")
self.channel_bonus = self.ability:GetSpecialValueFor("channel_time_bonus")

self.patrol_cast = self.parent:GetTalentValue("modifier_patrol_reward_portal", "cast", true)

if self.parent.tinker_innate then
	self.ability.tinker_cast = self.parent.tinker_innate:GetSpecialValueFor("scepter_cast")
	self.ability.tinker_range = self.parent.tinker_innate:GetSpecialValueFor("scepter_range")
end

end

function modifier_custom_ability_teleport_tracker:SpellEvent(params)
if not IsServer() then return end
if params.ability ~= self.ability then return end
if self.parent ~= params.unit then return end

local cast = self.channel_time

if self.parent:HasModifier("modifier_item_travel_boots_custom") or self.parent:HasModifier("modifier_item_travel_boots_2_custom") or self.parent:HasModifier("modifier_item_travel_boots_2_perma") then 
	cast = cast + self.channel_bonus
end

if self.ability.tinker_cast and self.parent:HasScepter() then
	local point = self.ability:GetCursorPosition()
	if self.ability:GetCursorTarget() and self.ability:GetCursorTarget() == self.parent and towers[self.parent:GetTeamNumber()] then
		point = towers[self.parent:GetTeamNumber()]:GetAbsOrigin()
	end
 	if (point - self.parent:GetAbsOrigin()):Length2D() <= self.ability.tinker_range then
		cast = self.ability.tinker_cast
	end
end

if self.parent:HasModifier("modifier_patrol_reward_2_portal") then
	cast = math.min(self.patrol_cast, cast)
end
self:SetStackCount(cast*100)
end






modifier_custom_ability_teleport = class({})
function modifier_custom_ability_teleport:IsHidden() return false end
function modifier_custom_ability_teleport:IsPurgable() return false end
function modifier_custom_ability_teleport:GetTexture()
if self:GetCaster():HasModifier("modifier_patrol_reward_2_portal") then
    return "buffs/warp_amulet"
end
return "item_tpscroll"
end

function modifier_custom_ability_teleport:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_custom_ability_teleport:GetOverrideAnimation()
return ACT_DOTA_TELEPORT
end


function modifier_custom_ability_teleport:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.center = EntIndexToHScript(table.center)

self.sound = "Portal.Loop_Appear"
local tinker_checkout = wearables_system:GetParticleReplacementAbility(self.parent, "particles/items2_fx/teleport_start.vpcf", self)
if tinker_checkout == "particles/econ/items/tinker/boots_of_travel/teleport_start_bots.vpcf" then
	self.sound = "Hero_Tinker.MechaBoots.Loop"
end

self:StartIntervalThink(0.2)
end

function modifier_custom_ability_teleport:OnIntervalThink()
if not IsServer() then return end
self.parent:EmitSound(self.sound)

if self.center and not self.center:IsNull() then
	self.center:EmitSound(self.sound)
end

self:StartIntervalThink(-1)
end

function modifier_custom_ability_teleport:OnDestroy()
if not IsServer() then return end

self.parent:StopSound("Portal.Loop_Appear")
self.parent:StopSound("Hero_Tinker.MechaBoots.Loop")

if IsValid(self.center) then
	self.center:StopSound("Portal.Loop_Appear")
	self.center:StopSound("Hero_Tinker.MechaBoots.Loop")
end

end