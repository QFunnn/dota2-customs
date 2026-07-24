--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_muerta_shovel_custom_stats", "abilities/items/item_muerta_shovel_custom", LUA_MODIFIER_MOTION_NONE)

item_muerta_shovel_custom  = class({})
item_muerta_shovel_custom.items =
{
	"item_ward_observer",
	"item_smoke_of_deceit",
	"item_dust",
	"item_patrol_warp_amulet",
	"item_patrol_restrained_orb",
	"item_patrol_midas",
}

function item_muerta_shovel_custom:GetIntrinsicModifierName()
return "modifier_muerta_shovel_custom_stats"
end

function item_muerta_shovel_custom:OnAbilityPhaseStart()
if not IsServer() then return end
local caster = self:GetCaster()

if not caster.muerta_innate or not caster.muerta_innate.tracker then return end
self.area = nil

local thinkers = FindUnitsInRadius(caster:GetTeamNumber(), self:GetCursorPosition(), nil, caster.muerta_innate.tracker.quest_dig_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL ,DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 0 , false)
local dig = false

for _,thinker in pairs(thinkers) do
	if thinker:HasModifier("modifier_muerta_innate_custom_dig_area") then 
		dig = true
		self.area = thinker
		break
	end
end

if dig == false then 
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(caster:GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#no_dig_area"})
end
return dig
end

function item_muerta_shovel_custom:GetChannelTime()
return self.time and self.time or 0
end

function item_muerta_shovel_custom:GetAOERadius()
return self.radius and self.radius or 0
end

function item_muerta_shovel_custom:OnSpellStart()
local caster = self:GetCaster()
self.point = self:GetCursorPosition()

caster:EmitSound("SeasonalConsumable.TI9.Shovel.Dig")

self.pfx = ParticleManager:CreateParticle("particles/econ/events/ti9/shovel_dig.vpcf", PATTACH_WORLDORIGIN, caster)
ParticleManager:SetParticleControl(self.pfx, 0, self.point)
end

function item_muerta_shovel_custom:OnChannelFinish(bInterrupted)
if not IsServer() then return end
local caster = self:GetCaster()

caster:StopSound("SeasonalConsumable.TI9.Shovel.Dig")

if self.pfx then
	ParticleManager:DestroyParticle(self.pfx, false)
	ParticleManager:ReleaseParticleIndex(self.pfx)
	self.pfx = nil
end

if not IsValid(self.area) then return end
if bInterrupted then return end

local area_mod = self.area:FindModifierByName("modifier_muerta_innate_custom_dig_area")
local thinkers = FindUnitsInRadius(caster:GetTeamNumber(), self.point, nil, self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL ,DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 0 , false)
local found_mod = nil

for _,thinker in pairs(thinkers) do
	found_mod = thinker:FindModifierByName("modifier_muerta_innate_custom_dig_bounty")
	if found_mod then 
		self.point = thinker:GetAbsOrigin()
		break
	end
end

local particle = "particles/muerta_dig_drop.vpcf"

if not found_mod then
	if area_mod:GetStackCount() < 3 and RollPseudoRandomPercentage(50, 131, caster)  then 
	particle = "particles/econ/events/ti9/shovel_revealed_nothing.vpcf"

	area_mod:IncrementStackCount()

	if RollPseudoRandomPercentage(20, 129, caster) then 
		CreateRune(self.point, DOTA_RUNE_BOUNTY)  
		caster:GenericParticle("particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf")
		return
	end
	local item = CreateItem(self.items[RandomInt(1, #self.items)], caster, caster)
	CreateItemOnPositionSync(GetGroundPosition(self.point, nil), item)
	else
		 particle = "particles/econ/events/ti9/shovel_smoke_cloud.vpcf"
	end
end

local effect_cast = ParticleManager:CreateParticle(particle , PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, self.point )
ParticleManager:SetParticleControl( effect_cast, 1, self.point )
ParticleManager:ReleaseParticleIndex(effect_cast)

if not found_mod then return end
found_mod:Complete()
end



modifier_muerta_shovel_custom_stats = class(mod_hidden)
function modifier_muerta_shovel_custom_stats:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.time = self.ability:GetSpecialValueFor("time")
self.ability.radius = self.ability:GetSpecialValueFor("radius")
self.ability.movespeed = self.ability:GetSpecialValueFor("movespeed")
self.ability.stats = self.ability:GetSpecialValueFor("stats")
self.ability.goal = self.ability:GetSpecialValueFor("goal")
self.ability.cd = self.ability:GetSpecialValueFor("cd")
self.ability.duration = self.ability:GetSpecialValueFor("duration")
if not IsServer() then return end
self:SendStack()
end

function modifier_muerta_shovel_custom_stats:SendStack(reset)
if not IsServer() then return end
self:SetStackCount(reset and 0 or self.ability:GetSpecialValueFor("innate_bonus"))

if IsValid(self.parent.muerta_innate) and self.parent.muerta_innate.tracker then
	self.parent.muerta_innate.tracker:ChangeStack()
end

end

function modifier_muerta_shovel_custom_stats:OnDestroy()
if not IsServer() then return end
self:SendStack(true)
end

function modifier_muerta_shovel_custom_stats:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
 	MODIFIER_PROPERTY_IS_SCEPTER,
}
end

function modifier_muerta_shovel_custom_stats:GetModifierMoveSpeedBonus_Constant()
return self.ability.movespeed
end

function modifier_muerta_shovel_custom_stats:GetModifierBonusStats_Strength()
return self.ability.stats
end

function modifier_muerta_shovel_custom_stats:GetModifierBonusStats_Agility()
return self.ability.stats
end

function modifier_muerta_shovel_custom_stats:GetModifierBonusStats_Intellect()
return self.ability.stats
end

function modifier_muerta_shovel_custom_stats:GetModifierScepter()
return 1
end