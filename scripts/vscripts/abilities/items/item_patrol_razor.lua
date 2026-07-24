--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_razor_tower_custom_aura", "abilities/items/item_patrol_razor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_tower_custom", "abilities/items/item_patrol_razor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_tower_custom_timer", "abilities/items/item_patrol_razor", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_razor_tower_custom_friendly_aura", "abilities/items/item_patrol_razor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_tower_custom_friendly", "abilities/items/item_patrol_razor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_tower_custom_friendly_timer", "abilities/items/item_patrol_razor", LUA_MODIFIER_MOTION_NONE)

item_patrol_razor = class({})

function item_patrol_razor:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/mjollnir_shield.vpcf", context )
PrecacheResource( "particle","particles/tower_dd.vpcf", context )
PrecacheResource( "particle","particles/glyph_damage.vpcf", context )
end


function item_patrol_razor:OnSpellStart()
local caster = self:GetCaster()

local find_towers = FindUnitsInRadius(caster:GetTeamNumber(), self:GetCursorPosition(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)

if #find_towers == 0 then return false end

local tower = towers[find_towers[1]:GetTeamNumber()]

if not tower then return end

local shrines = FindUnitsInRadius(tower:GetTeamNumber(), tower:GetAbsOrigin(), nil, 1200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)

for _,building in pairs(shrines) do
	local item_effect = ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(item_effect, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
	ParticleManager:SetParticleControlEnt(item_effect, 1, building, PATTACH_POINT_FOLLOW, "attach_hitloc", building:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex(item_effect)
end

AddFOWViewer(caster:GetTeamNumber(), tower:GetAbsOrigin(), 1000, 2, false)

local heroes = dota1x6:FindPlayers(tower:GetTeamNumber(), true)
CustomGameEventManager:Send_ServerToAllClients("mini_alert_event",  {hero_1 = caster:GetUnitName(), heroes_2 = heroes, event_type = "razor"})

local name = "modifier_razor_tower_custom_aura"
local duration = dota1x6.current_wave*self:GetSpecialValueFor("duration")

if tower:GetTeamNumber() == caster:GetTeamNumber() then
	name = "modifier_razor_tower_custom_friendly_aura"
	duration = self:GetSpecialValueFor("duration_friendly")
	tower:EmitSound("BB.Quill_cdr")

	if tower:HasModifier("modifier_razor_tower_custom_aura") then
		tower:RemoveModifierByName("modifier_razor_tower_custom_aura")
		name = nil
	end
else
	tower:EmitSound("Patrol_razor")

	if tower:HasModifier("modifier_razor_tower_custom_friendly_aura") then
		tower:RemoveModifierByName("modifier_razor_tower_custom_friendly_aura")
		name = nil
	end
end

if name then
	tower:AddNewModifier(caster, self, name, {duration = duration, damage_inc = self:GetSpecialValueFor("damage")})
end


if caster.razor_count then
	caster.razor_count = math.max(0, caster.razor_count - 1)
end

self:SpendCharge(0)
end




modifier_razor_tower_custom_aura = class({})
function modifier_razor_tower_custom_aura:IsHidden() return true end
function modifier_razor_tower_custom_aura:IsPurgable() return false end
function modifier_razor_tower_custom_aura:IsAura() return true end
function modifier_razor_tower_custom_aura:GetAuraDuration() return 0.1 end
function modifier_razor_tower_custom_aura:GetAuraRadius() return 1200 end
function modifier_razor_tower_custom_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_razor_tower_custom_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_BUILDING end
function modifier_razor_tower_custom_aura:GetModifierAura() return "modifier_razor_tower_custom" end
function modifier_razor_tower_custom_aura:OnCreated(table)
if not IsServer() then return end
self.damage_inc = table.damage_inc
end

function modifier_razor_tower_custom_aura:OnRefresh(table)
if not IsServer() then return end
self.damage_inc = table.damage_inc
end


modifier_razor_tower_custom = class({})
function modifier_razor_tower_custom:IsHidden() return true end
function modifier_razor_tower_custom:IsPurgable() return false end
function modifier_razor_tower_custom:OnCreated(table)
if not IsServer() then return end
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.owner = self:GetAuraOwner()

local mod = self.owner:FindModifierByName("modifier_razor_tower_custom_aura")
if mod then
	self.damage = mod.damage_inc
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_razor_tower_custom_timer", {duration = mod:GetRemainingTime()})
end

end

function modifier_razor_tower_custom:OnDestroy()
if not IsServer() then return end
self.parent:RemoveModifierByName("modifier_razor_tower_custom_timer")
end

function modifier_razor_tower_custom:GetStatusEffectName()
return "particles/status_fx/status_effect_mjollnir_shield.vpcf"
end

function modifier_razor_tower_custom:StatusEffectPriority()
return MODIFIER_PRIORITY_SUPER_ULTRA   
end

function modifier_razor_tower_custom:GetEffectName()
return "particles/items2_fx/mjollnir_shield.vpcf"
end

function modifier_razor_tower_custom:CheckState()
return
{
	[MODIFIER_STATE_DISARMED] = true
}
end

function modifier_razor_tower_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
}
end

function modifier_razor_tower_custom:GetModifierIncomingDamage_Percentage()
return self.damage
end



modifier_razor_tower_custom_timer = class({})
function modifier_razor_tower_custom_timer:IsHidden() return false end
function modifier_razor_tower_custom_timer:IsPurgable() return false end
function modifier_razor_tower_custom_timer:GetTexture() return "item_ex_machina" end
function modifier_razor_tower_custom_timer:OnDestroy()
if not IsServer() then return end
if self:GetRemainingTime() <= 0.1 then return end

self:GetParent():GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")
end










modifier_razor_tower_custom_friendly_aura = class({})
function modifier_razor_tower_custom_friendly_aura:IsHidden() return true end
function modifier_razor_tower_custom_friendly_aura:IsPurgable() return false end
function modifier_razor_tower_custom_friendly_aura:IsAura() return true end
function modifier_razor_tower_custom_friendly_aura:GetAuraDuration() return 0.1 end
function modifier_razor_tower_custom_friendly_aura:GetAuraRadius() return 1200 end
function modifier_razor_tower_custom_friendly_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_razor_tower_custom_friendly_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_BUILDING end
function modifier_razor_tower_custom_friendly_aura:GetModifierAura() return "modifier_razor_tower_custom_friendly" end




modifier_razor_tower_custom_friendly = class({})
function modifier_razor_tower_custom_friendly:IsHidden() return true end
function modifier_razor_tower_custom_friendly:IsPurgable() return false end
function modifier_razor_tower_custom_friendly:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()

if not self.ability then
	self:Destroy()
	return
end

self.speed = self.ability:GetSpecialValueFor("speed_bonus")
self.aoe_bonus = self.ability:GetSpecialValueFor("aoe_bonus")
self.heal_duration = self.ability:GetSpecialValueFor("heal_duration")
self.tower_heal = self.ability:GetSpecialValueFor("heal_tower")
self.shrine_heal = self.ability:GetSpecialValueFor("heal_shrine")

self.owner = self:GetAuraOwner()

if not IsServer() then return end

local mod = self.owner:FindModifierByName("modifier_razor_tower_custom_friendly_aura")

if mod then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_razor_tower_custom_friendly_timer", {duration = mod:GetRemainingTime()})
end

self.heal_mod = self.parent:AddNewModifier(self.parent, self, "modifier_generic_repair", {duration = self.heal_duration, tower_heal = self.tower_heal, heal_shrine = self.shrine_heal})

if self.parent == self.owner then

	self.parent:AddAttackStartEvent_out(self, true)

	self.parent:EmitSound("DOTA_Item.Mjollnir.Loop")
	self.parent:GenericParticle("particles/patrol/razor_friendly_shield.vpcf", self)
	self.parent:GenericParticle("particles/tower_dd.vpcf", self)
end

end

function modifier_razor_tower_custom_friendly:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if params.no_attack_cooldown then return end

local count = 0
for _,target in pairs(self.parent:FindTargets(self.parent:Script_GetAttackRange() + 50)) do
	if target ~= params.target then
		self.parent:PerformAttack(target, true, true, true, false, true, false, true)
		count = count + 1
		if count >= self.aoe_bonus then 
			break
		end
	end
end


end


function modifier_razor_tower_custom_friendly:OnDestroy()
if not IsServer() then return end

self.parent:StopSound("DOTA_Item.Mjollnir.Loop")

if self.heal_mod and not self.heal_mod:IsNull() then
	self.heal_mod:Destroy()
end

self.parent:RemoveModifierByName("modifier_razor_tower_custom_friendly_timer")
end

function modifier_razor_tower_custom_friendly:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_razor_tower_custom_friendly:GetModifierAttackSpeedBonus_Constant()
return self.speed
end




modifier_razor_tower_custom_friendly_timer = class({})
function modifier_razor_tower_custom_friendly_timer:IsHidden() return false end
function modifier_razor_tower_custom_friendly_timer:IsPurgable() return false end
function modifier_razor_tower_custom_friendly_timer:GetTexture() return "item_ex_machina" end

function modifier_razor_tower_custom_friendly_timer:OnDestroy()
if not IsServer() then return end
if self:GetRemainingTime() <= 0.1 then return end

self:GetParent():GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")
end