--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_pudge_dismember","abilities/pudge/custom_pudge_dismember", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_custom_pudge_dismember_visual", "abilities/pudge/custom_pudge_dismember", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_dismember_illusion", "abilities/pudge/custom_pudge_dismember", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_dismember_outgoing", "abilities/pudge/custom_pudge_dismember", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_dismember_devour", "abilities/pudge/custom_pudge_dismember", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_dismember_devour_caster", "abilities/pudge/custom_pudge_dismember", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_dismember_blood_str_buff", "abilities/pudge/custom_pudge_dismember", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_dismember_stack_effect", "abilities/pudge/custom_pudge_dismember", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_dismember_break", "abilities/pudge/custom_pudge_dismember", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_pudge_dismember_bkb", "abilities/pudge/custom_pudge_dismember", LUA_MODIFIER_MOTION_NONE)



custom_pudge_dismember = class({})


custom_pudge_dismember.arcana_style = 
{
	["npc_dota_hero_abaddon"] = {"ethereal", Vector(38, 46, 139)},
	["npc_dota_hero_arc_warden"] = {"ethereal", Vector(64, 160, 242)},
	["npc_dota_hero_bane"] = {"ethereal", Vector(51, 20, 72)},
	["npc_dota_hero_chaos_knight"] = {"ethereal", Vector(38, 23, 21)},
	["npc_dota_hero_death_prophet"] = {"ethereal", Vector(40, 177, 130)},
	["npc_dota_hero_enigma"] = {"ethereal", Vector(38, 46, 139)},
	["npc_dota_hero_wisp"] = {"ethereal", Vector(184, 194, 239)},
	["npc_dota_hero_morphling"] = {"ethereal", Vector(64, 160, 242)},
	["npc_dota_hero_necrolyte"] = {"ethereal", Vector(40, 177, 130)},
	["npc_dota_hero_obsidian_destroyer"] = {"ethereal", Vector(14, 92, 69)},
	["npc_dota_hero_shadow_demon"] = {"ethereal", Vector(93, 19, 19)},
	["npc_dota_hero_nevermore"] = {"ethereal", Vector(93, 19, 19)},
	["npc_dota_hero_spectre"] = {"ethereal", Vector(81, 51, 108)},
	["npc_dota_hero_spirit_breaker"] = {"ethereal", Vector(64, 160, 242)},
	["npc_dota_hero_terrorblade"] = {"ethereal", Vector(68, 84, 115)},
	["npc_dota_hero_vengefulspirit"] = {"ethereal", Vector(38, 46, 139)},
	["npc_dota_hero_visage"] = {"ethereal", Vector(81, 113, 173)},
	["npc_dota_hero_void_spirit"] = {"ethereal", Vector(108, 46, 184)},
	["npc_dota_hero_skeleton_king"] = {"ethereal", Vector(40, 177, 130)},
	["npc_dota_hero_muerta"] = {"ethereal", Vector(40, 177, 130)},

	["npc_dota_hero_bristleback"] = {"goo", Vector(64, 241, 41)},
	["npc_dota_hero_broodmother"] = {"goo", Vector(64, 241, 41)},
	["npc_dota_hero_nyx_assassin"] = {"goo", Vector(64, 241, 41)},
	["npc_dota_hero_undying"] = {"goo", Vector(64, 241, 41)},
	["npc_dota_hero_venomancer"] = {"goo", Vector(64, 241, 41)},
	["npc_dota_hero_viper"] = {"goo", Vector(64, 241, 41)},
	["npc_dota_hero_weaver"] = {"goo", Vector(64, 241, 41)},

	["npc_dota_hero_rattletrap"] = "motor",
	["npc_dota_hero_gyrocopter"] = "motor",
	["npc_dota_hero_rizzrak"] = "motor",
	["npc_dota_hero_tinker"] = "motor",

	["npc_dota_hero_crystal_maiden"] = "ice",
	["npc_dota_hero_ancient_apparition"] = "ice",
	["npc_dota_hero_lich"] = "ice",
	["npc_dota_hero_winter_wyvern"] = "ice",

	["npc_dota_hero_lina"] = "fire",
	["npc_dota_hero_ember_spirit"] = "fire",
	["npc_dota_hero_phoenix"] = "fire",

	["npc_dota_hero_razor"] = "electric",
	["npc_dota_hero_storm_spirit"] = "electric",
	["npc_dota_hero_zuus"] = "electric",

	["npc_dota_hero_treant"] = "wood",
	["npc_dota_hero_furion"] = "wood",

	["npc_dota_hero_tiny"] = "stone",
	["npc_dota_hero_earth_spirit"] = "stone",
}




function custom_pudge_dismember:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "pudge_dismember", self)
end

function custom_pudge_dismember:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_pudge/pudge_dismember.vpcf", context )
PrecacheResource( "particle","particles/brist_lowhp_.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/sange_maim.vpcf", context )
PrecacheResource( "particle","particles/econ/items/dazzle/dazzle_dark_light_weapon/pudge_grave.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_life_stealer/life_stealer_loadout.vpcf", context )
PrecacheResource( "particle","particles/pudge_swallow.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_pudge/pudge_swallow_release.vpcf", context )
PrecacheResource( "particle","particles/items_fx/black_king_bar_avatar.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_break.vpcf", context ) 
PrecacheResource( "particle","particles/pudge/dismember_stack.vpcf", context ) 

end



function custom_pudge_dismember:GetIntrinsicModifierName()
if not self:GetCaster():HasModifier("modifier_custom_pudge_dismember_visual") then 
	return "modifier_custom_pudge_dismember_visual"
end 
	return 
end

function custom_pudge_dismember:GetChannelTime()
local k = 1
local caster = self:GetCaster()
if caster:IsIllusion() then 
	k = 0.5
end
if not caster:HasModifier("modifier_custom_pudge_dismember_visual") then 
	return self:GetFullDuration()
end
return (caster:GetUpgradeStack("modifier_custom_pudge_dismember_visual")*self:GetFullDuration()/100) * k
end


function custom_pudge_dismember:GetFullDuration()
local bonus = 0
local caster = self:GetCaster()
if caster:HasModifier("modifier_custom_pudge_dismember_stack_effect") then
	local duration = caster:GetTalentValue("modifier_pudge_dismember_4", "duration")/caster:GetTalentValue("modifier_pudge_dismember_4", "max")
	bonus = caster:GetUpgradeStack("modifier_custom_pudge_dismember_stack_effect")*duration
end
return self:GetSpecialValueFor("duration") + bonus
end


function custom_pudge_dismember:GetCastRange(location, target)
return self:GetSpecialValueFor("cast_range")
end

function custom_pudge_dismember:GetChannelAnimation()
return ACT_DOTA_CHANNEL_ABILITY_4
end

function custom_pudge_dismember:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_pudge_dismember_3") then 
	bonus = self:GetCaster():GetTalentValue("modifier_pudge_dismember_3", "cd")
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end


function custom_pudge_dismember:OnSpellStart(new_target)
local caster = self:GetCaster()
caster:RemoveModifierByName("modifier_custom_pudge_dismember_blood_str_buff")

local stack_mod = caster:FindModifierByName("modifier_custom_pudge_dismember_stack_effect")
if stack_mod then

	if stack_mod:GetStackCount() >= caster:GetTalentValue("modifier_pudge_dismember_4", "max") then
		caster:EmitSound("Pudge.Dismember_stack")
		local particle_peffect = ParticleManager:CreateParticle("particles/brist_lowhp_.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(particle_peffect, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(particle_peffect, 2, caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(particle_peffect)
	end

	caster:AddNewModifier(caster, self, "modifier_custom_pudge_dismember_blood_str_buff", {stack = stack_mod:GetStackCount(), duration = caster:GetTalentValue("modifier_pudge_dismember_4", "effect_duration")})
end

if caster:IsIllusion() then 
	caster:AddNewModifier(caster, self, "modifier_custom_pudge_dismember_illusion", {duration = self:GetChannelTime()})
end

self.targets = {}

local target = self:GetCursorTarget()
if new_target ~= nil then
	target = new_target
end

if caster:HasTalent("modifier_pudge_dismember_5") then
	self.targets = caster:FindTargets(self:GetSpecialValueFor("cast_range") + caster:GetCastRangeBonus() + caster:GetTalentValue("modifier_pudge_dismember_5", "radius"))
end

if caster:HasTalent("modifier_pudge_dismember_6") then
	self.bkb_mod = caster:AddNewModifier(caster, self, "modifier_custom_pudge_dismember_bkb", {duration = self:GetChannelTime() + 1})
end

table.insert(self.targets, target)

if not caster:HasTalent("modifier_pudge_dismember_5") then
	if target:TriggerSpellAbsorb(self) then 
		caster:Interrupt() 
		return 
	end
end

for _,unit in pairs(self.targets) do
	local main = 0
	if unit == target then
		main = 1
	end
	unit:AddNewModifier(caster, self, "modifier_custom_pudge_dismember", {main = main, duration = self:GetChannelTime()})
end

end


function custom_pudge_dismember:OnChannelFinish(bInterrupted)
local caster = self:GetCaster()

if self.targets then
	for _,target in pairs(self.targets) do
		target:RemoveModifierByName("modifier_custom_pudge_dismember")
	end
end

if self.bkb_mod and not self.bkb_mod:IsNull() then
	self.bkb_mod:SetDuration(caster:GetTalentValue("modifier_pudge_dismember_6", "duration"), true)
end

caster:RemoveModifierByName("modifier_custom_pudge_dismember_stack_effect")
end


function custom_pudge_dismember:GetDamage()
local caster = self:GetCaster()
local dismember_damage	= self:GetSpecialValueFor("dismember_damage")
local strength_damage	= self:GetSpecialValueFor("strength_damage") + caster:GetTalentValue("modifier_pudge_dismember_1", "str")/100
return dismember_damage + strength_damage*caster:GetStrength()
end


function custom_pudge_dismember:DealDamage(target, damage_amount, no_heal, damage_ability)
local creeps_damage = self:GetSpecialValueFor("creeps")
local caster = self:GetCaster()
local ability = nil
if damage_ability then
	ability = damage_ability
end

local damage = damage_amount
local k = 1
if target:IsCreep() then
	k = 1 + creeps_damage/100
end

DoDamage({ victim = target, attacker = caster, damage = damage*k, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self}, ability)

if caster:HasTalent("modifier_pudge_dismember_2") then 
	target:AddNewModifier(caster, self, "modifier_custom_pudge_dismember_outgoing", {duration = caster:GetTalentValue("modifier_pudge_dismember_2", "duration")})
end

if caster:HasTalent("modifier_pudge_dismember_5") then 
	target:AddNewModifier(caster, self, "modifier_custom_pudge_dismember_break", {duration = caster:GetTalentValue("modifier_pudge_dismember_5", "duration")})
end

if no_heal == true or no_heal == 0 then return end

local heal = damage*(1 + caster:GetTalentValue("modifier_pudge_dismember_1", "heal")/100)

if caster:GetQuest() == "Pudge.Quest_8" and target:IsRealHero() and caster:GetHealthPercent() < 100 then 
  caster:UpdateQuest( math.floor( math.min( (caster:GetMaxHealth() - caster:GetHealth()), heal )))
end
caster:GenericHeal(heal, self)
end


modifier_custom_pudge_dismember = class({})
function modifier_custom_pudge_dismember:IsPurgeException() return true end
function modifier_custom_pudge_dismember:IsPurgable() return false end
function modifier_custom_pudge_dismember:IsStunDebuff() return true end

function modifier_custom_pudge_dismember:CheckState()
return 
{
	[MODIFIER_STATE_STUNNED] = true,
}
end


function modifier_custom_pudge_dismember:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()


if not IsServer() then return end
self.main = table.main
self.parent:StartGestureWithPlaybackRate(ACT_DOTA_FLAIL, self.ability:GetSpecialValueFor("animation_rate"))

self.cast_sound = wearables_system:GetSoundReplacement(self:GetCaster(), "Hero_Pudge.Dismember", self)
local pfx =  wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_pudge/pudge_dismember.vpcf", self)

if self.caster.current_model == "models/items/pudge/arcana/pudge_arcana_base.vmdl" or pfx == "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_default.vpcf" then

	local part = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_default.vpcf"
	local color = nil

	if self.ability.arcana_style[self.parent:GetUnitName()] then 

		if type(self.ability.arcana_style[self.parent:GetUnitName()]) == "string" then
			part = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_"..self.ability.arcana_style[self.parent:GetUnitName()]..".vpcf"
		end 

		if type(self.ability.arcana_style[self.parent:GetUnitName()]) == "table" then
			part = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_"..self.ability.arcana_style[self.parent:GetUnitName()][1]..".vpcf"
			color = self.ability.arcana_style[self.parent:GetUnitName()][2]
		end 
	end

	self.pfx = ParticleManager:CreateParticle(part, PATTACH_ABSORIGIN, self.parent)
	ParticleManager:SetParticleControl(self.pfx, 1, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.pfx, 8, Vector(1, 1, 1))

    if color ~= nil then 
		ParticleManager:SetParticleControl(self.pfx, 2, Vector(color.x/255, color.y/255, color.z/255))
	end

	ParticleManager:SetParticleControl(self.pfx, 15, Vector(64, 9, 9))

    local bonus_checkout_green = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/econ/items/pudge/pudge_arcana/pudge_arcana_red_back_ambient.vpcf", self)
    if self.caster:HasUnequipItem(77561) or bonus_checkout_green ~= "particles/econ/items/pudge/pudge_arcana/pudge_arcana_red_back_ambient.vpcf" then
        ParticleManager:SetParticleControl(self.pfx, 14, Vector(1, 0, 0))
		ParticleManager:SetParticleControl(self.pfx, 15, Vector(9, 64, 9))
    end
else
	self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_dismember.vpcf", PATTACH_ABSORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt(self.pfx, 0, self.caster, PATTACH_ABSORIGIN_FOLLOW, "attach_attack1", self.caster:GetAbsOrigin(), true)
end

self:AddParticle(self.pfx, false, false, -1, false, false)

if not self.caster:IsAlive() then 
	self:Destroy()
	return
end

self.max = self.ability:GetSpecialValueFor("ticks")
self.interval = self.ability:GetChannelTime() / (self.max - 1) 
self.duration_k = self:GetRemainingTime()/self.ability:GetFullDuration()

self.damage = (self.ability:GetDamage()*self.ability:GetFullDuration()*self.duration_k)/self.max

self.pull_units_per_second = self.ability:GetSpecialValueFor("pull_units_per_second")
self.pull_distance_limit = self.ability:GetSpecialValueFor("pull_distance_limit")
if self:ApplyHorizontalMotionController() == false then 
	self:Destroy()
	return
end

self:OnIntervalThink()
self:StartIntervalThink(self.interval - FrameTime())
end


function modifier_custom_pudge_dismember:OnIntervalThink()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()

self.ability:DealDamage(self.parent, self.damage, self.main == 0)
self.parent:EmitSound(self.cast_sound)
end


function modifier_custom_pudge_dismember:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local distance = self.caster:GetOrigin() - me:GetOrigin()

if distance:Length2D() > self.pull_distance_limit then
	me:SetOrigin( me:GetOrigin() + distance:Normalized() * self.pull_units_per_second * dt )
end

end

function modifier_custom_pudge_dismember:OnDestroy()
if not IsServer() then return end

self.parent:FadeGesture(ACT_DOTA_FLAIL)
self.parent:RemoveHorizontalMotionController( self )

if self.main == 1 and self.caster:IsChanneling() then
	self.ability:EndChannel(false)
	self.caster:MoveToPositionAggressive(self.parent:GetAbsOrigin())
end

end





modifier_custom_pudge_dismember_visual = class({})
function modifier_custom_pudge_dismember_visual:IsHidden() return true end
function modifier_custom_pudge_dismember_visual:IsPurgable() return false end
function modifier_custom_pudge_dismember_visual:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end

function modifier_custom_pudge_dismember_visual:GetModifierPercentageCooldown() 
if not self.parent:HasTalent("modifier_pudge_dismember_6") then return end
return self.cdr
end

function modifier_custom_pudge_dismember_visual:GetModifierCastRangeBonusStacking()
if not self.parent:HasTalent("modifier_pudge_dismember_3") then return end 
return self.parent:GetTalentValue("modifier_pudge_dismember_3", "range")
end

function modifier_custom_pudge_dismember_visual:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.stack_duration = self.parent:GetTalentValue("modifier_pudge_dismember_4", "stack_duration", true)

self.cdr = self.parent:GetTalentValue("modifier_pudge_dismember_6", "cdr", true)

if self.parent:IsRealHero() then
	self.parent:AddSpellEvent(self)
end
self:SetStackCount(100)
end

function modifier_custom_pudge_dismember_visual:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end

if self.parent:HasTalent("modifier_pudge_dismember_4") and self.ability ~= params.ability then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_pudge_dismember_stack_effect", {duration = self.stack_duration})
end

if self.ability ~= params.ability then return end
self:SetStackCount((1 - params.target:GetStatusResistance()) * 100)
end





modifier_custom_pudge_dismember_illusion = class({})
function modifier_custom_pudge_dismember_illusion:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true
}
end

function modifier_custom_pudge_dismember_illusion:OnCreated(table)
if not IsServer() then return end
self:GetParent():StartGesture(ACT_DOTA_CHANNEL_ABILITY_4)
end

function modifier_custom_pudge_dismember_illusion:OnDestroy()
if not IsServer() then return end
self:GetParent():RemoveGesture(ACT_DOTA_CHANNEL_ABILITY_4)
end







modifier_custom_pudge_dismember_outgoing = class({})
function modifier_custom_pudge_dismember_outgoing:IsHidden() return false end
function modifier_custom_pudge_dismember_outgoing:IsPurgable() return true end
function modifier_custom_pudge_dismember_outgoing:GetTexture() return "buffs/dismember_damage" end
function modifier_custom_pudge_dismember_outgoing:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
}
end

function modifier_custom_pudge_dismember_outgoing:GetModifierDamageOutgoing_Percentage()
return self.damage
end

function modifier_custom_pudge_dismember_outgoing:GetModifierSpellAmplify_Percentage() 
return self.damage 
end

function modifier_custom_pudge_dismember_outgoing:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal
end

function modifier_custom_pudge_dismember_outgoing:GetModifierHealChange() 
return self.heal
end

function modifier_custom_pudge_dismember_outgoing:GetModifierHPRegenAmplify_Percentage() 
return self.heal
end

function modifier_custom_pudge_dismember_outgoing:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.heal = self.caster:GetTalentValue("modifier_pudge_dismember_2", "heal")
self.damage = self.caster:GetTalentValue("modifier_pudge_dismember_2", "damage")

if not IsServer() then return end 

for i = 1,2 do
	self.parent:GenericParticle("particles/items2_fx/sange_maim.vpcf", self)
end

end 






custom_pudge_dismember_devour = class({})

custom_pudge_dismember_devour.DisableAbilities = 
{
	["primal_beast_pulverize_custom"] = true,
	["life_stealer_infest_custom"] = true,
	["snapfire_mortimer_kisses_custom"] = true,
}


function custom_pudge_dismember_devour:CreateTalent()
self:SetHidden(false)
end

function custom_pudge_dismember_devour:OnAbilityPhaseStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()
caster:StartGesture(ACT_DOTA_CHANNEL_ABILITY_4)

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_life_stealer/life_stealer_loadout.vpcf", PATTACH_POINT_FOLLOW, target)
ParticleManager:SetParticleControlEnt(self.particle,0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), false)
ParticleManager:SetParticleControlEnt(self.particle,1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), false)
ParticleManager:ReleaseParticleIndex(self.particle)
return true
end

function custom_pudge_dismember_devour:OnAbilityPhaseInterrupted()
self:GetCaster():FadeGesture(ACT_DOTA_CHANNEL_ABILITY_4)

if self.particle then 
	ParticleManager:ReleaseParticleIndex(self.particle)
	ParticleManager:DestroyParticle(self.particle, false)
end

end

function custom_pudge_dismember_devour:OnSpellStart()
local caster = self:GetCaster()
self.target = self:GetCursorTarget()

if caster:GetUnitName() ~= "npc_dota_hero_pudge" then return end

caster:EmitSound("Pudge.Dismember_devour")
caster:FadeGesture(ACT_DOTA_CHANNEL_ABILITY_4)

if self.target:TriggerSpellAbsorb(self) then 
	return
end

self.target:AddNewModifier(caster, self, "modifier_custom_pudge_dismember_devour", {duration = self:GetSpecialValueFor("duration")})
end




modifier_custom_pudge_dismember_devour = class({})
function modifier_custom_pudge_dismember_devour:IsHidden() return true end
function modifier_custom_pudge_dismember_devour:IsPurgable() return false end
function modifier_custom_pudge_dismember_devour:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.RemoveForDuel = true

self.max_health = math.floor(self.ability:GetSpecialValueFor("max_health")*self.caster:GetMaxHealth()/100)
self.damage = 0
if not IsServer() then return end

self.caster_mod =  self.caster:AddNewModifier(self.caster, self.ability, "modifier_custom_pudge_dismember_devour_caster", {target = self.parent:entindex()})

for abilitySlot = 0,8 do
	local ability = self.parent:GetAbilityByIndex(abilitySlot)
	if ability ~= nil and self.ability.DisableAbilities[ability:GetName()] then
		ability:SetActivated(false)
	end
end

self.interval = 0.03
self.damage_interval = self.ability:GetSpecialValueFor("interval")
self.count = self.damage_interval

self.main_ability = self.caster:FindAbilityByName("custom_pudge_dismember")

self.parent:NoDraw(self)
self.parent:AddNoDraw()
self.ended = false

if not self.main_ability then
	self:Destroy()
	return
end

self.max_time = self.caster:GetTalentValue("modifier_pudge_dismember_legendary", "duration")
self.max = self.max_time/self.damage_interval
self.damage = (self.main_ability:GetDamage()*self.max_time)/self.max

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end




function modifier_custom_pudge_dismember_devour:OnIntervalThink()
if not IsServer() then return end

self.count = self.count + self.interval
if self.count >= (self.damage_interval - FrameTime()) then 
	self.count = 0
	self.main_ability:DealDamage(self.parent, self.damage, false, "modifier_pudge_dismember_legendary")
	self.caster:EmitSound("Pudge.Dismember_devour_tick")
end

if not self.caster or self.caster:IsNull() or not self.caster:IsAlive() or not self.caster_mod or self.caster_mod:IsNull() then 
	self:Destroy()
	return
end

self.parent:SetOrigin(self.caster:GetAbsOrigin() + self.caster:GetForwardVector()*10)

if self.ended == true then return end
self.caster:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self.caster_mod:GetStackCount(), priority = 1, style = "PudgeDevour"})
self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self.caster_mod:GetStackCount(), priority = 3, top_text = "deal_damage_to_pudge", style = "PudgeDevour"})
end


function modifier_custom_pudge_dismember_devour:CheckState()
return
{
	[MODIFIER_STATE_OUT_OF_GAME] = true,
	[MODIFIER_STATE_UNTARGETABLE] = true,
	[MODIFIER_STATE_UNSELECTABLE] = true,
	[MODIFIER_STATE_ROOTED] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,

}
end


function modifier_custom_pudge_dismember_devour:OnDestroy()
if not IsServer() then return end
self.ended = true

self.caster:RemoveModifierByName("modifier_custom_pudge_dismember_devour_caster")
self.parent:RemoveNoDraw()

if self.caster then
	self.parent:SetOrigin(self.caster:GetAbsOrigin() + self.caster:GetForwardVector()*250)
end

local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_swallow_release.vpcf", PATTACH_WORLDORIGIN,  nil)
ParticleManager:SetParticleControl(pfx, 0, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(pfx)

FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)

for abilitySlot = 0,8 do
	local ability = self.parent:GetAbilityByIndex(abilitySlot)
	if ability ~= nil and self.ability.DisableAbilities[ability:GetName()] then
		ability:SetActivated(true)
	end
end

self.caster:UpdateUIshort({hide = 1, hide_full = 1, style = "PudgeDevour"})
self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "PudgeDevour"})
self.parent:EmitSound("Pudge.Dismember_devour_end")
end




modifier_custom_pudge_dismember_devour_caster = class({})
function modifier_custom_pudge_dismember_devour_caster:IsHidden() return true end
function modifier_custom_pudge_dismember_devour_caster:IsPurgable() return false end
function modifier_custom_pudge_dismember_devour_caster:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.shield_talent = "modifier_pudge_dismember_legendary"
self.max_shield = self.parent:GetTalentValue("modifier_pudge_dismember_legendary", "shield")*self.parent:GetMaxHealth()/100

if not IsServer() then return end

self.parent:GenericParticle("particles/pudge_swallow.vpcf", self, true)
self.ability:EndCd()

self.target = EntIndexToHScript(table.target)
self.RemoveForDuel = true
self:SetStackCount(self.max_shield)
end 


function modifier_custom_pudge_dismember_devour_caster:OnDestroy()
if not IsServer() then return end 

self.ability:StartCd()

if self.target and not self.target:IsNull() then 
	self.target:RemoveModifierByName("modifier_custom_pudge_dismember_devour")
end 

end

function modifier_custom_pudge_dismember_devour_caster:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_custom_pudge_dismember_devour_caster:GetModifierIncomingDamageConstant( params )

if IsClient() then 
	if params.report_max then 
		return self.max_shield
	else 
     	return self:GetStackCount()
    end 
end

if not IsServer() then return end
if self.parent == params.attacker then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end






modifier_custom_pudge_dismember_blood_str_buff = class({})
function modifier_custom_pudge_dismember_blood_str_buff:IsHidden() return false end
function modifier_custom_pudge_dismember_blood_str_buff:GetTexture() return "buffs/hunger_str" end
function modifier_custom_pudge_dismember_blood_str_buff:IsPurgable() return false end
function modifier_custom_pudge_dismember_blood_str_buff:DeclareFunctions()
return
{ 
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS 
} 
end

function modifier_custom_pudge_dismember_blood_str_buff:OnCreated(table)
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_pudge_dismember_4", "max")
self.str = self.parent:GetTalentValue("modifier_pudge_dismember_4", "str")/self.max

if not IsServer() then return end
self:SetStackCount(table.stack) 
self.parent:CalculateStatBonus(true)
end

function modifier_custom_pudge_dismember_blood_str_buff:OnDestroy()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_custom_pudge_dismember_blood_str_buff:GetModifierBonusStats_Strength()
return self:GetStackCount()*self.str
end






modifier_custom_pudge_dismember_stack_effect = class({})
function modifier_custom_pudge_dismember_stack_effect:IsHidden() return false end
function modifier_custom_pudge_dismember_stack_effect:IsPurgable() return false end
function modifier_custom_pudge_dismember_stack_effect:IsDebuff() return true end

function modifier_custom_pudge_dismember_stack_effect:OnCreated(table)
if not IsServer() then return end
self.RemoveForDuel = true
self.parent = self:GetParent()

self.max = self.parent:GetTalentValue("modifier_pudge_dismember_4", "max")
self.timer = self.parent:GetTalentValue("modifier_pudge_dismember_4", "stack_duration")
self.radius = self.parent:GetTalentValue("modifier_pudge_dismember_4", "radius")

self.particle = self.parent:GenericParticle("particles/pudge/dismember_stack.vpcf", self, true)

self:SetStackCount(1)
self:StartIntervalThink(0.1)
end

function modifier_custom_pudge_dismember_stack_effect:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_custom_pudge_dismember_stack_effect:OnStackCountChanged(iStackCount)
if self:GetStackCount() == 0 then return end
if not self.particle then return end

for i = 1,self.max do 
	if i <= self:GetStackCount() then 
		ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0))	
	else 
		ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))	
	end
end

end

function modifier_custom_pudge_dismember_stack_effect:OnIntervalThink()
if not IsServer() then return end

local heroes = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )

if #heroes > 0 then 
	self:SetDuration(self.timer, true)
end

end



modifier_custom_pudge_dismember_break = class({})
function modifier_custom_pudge_dismember_break:IsHidden() return true end
function modifier_custom_pudge_dismember_break:IsPurgable() return false end 
function modifier_custom_pudge_dismember_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_custom_pudge_dismember_break:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_custom_pudge_dismember_break:GetEffectName() 
return "particles/generic_gameplay/generic_break.vpcf" 
end
 

modifier_custom_pudge_dismember_bkb = class({})
function modifier_custom_pudge_dismember_bkb:IsHidden() return true end
function modifier_custom_pudge_dismember_bkb:IsPurgable() return false end
function modifier_custom_pudge_dismember_bkb:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
if not IsServer() then return end

local cd_items = self.parent:GetTalentValue("modifier_pudge_dismember_6", "cd_items")

for i = 0, 8 do
    local current_item = self.parent:GetItemInSlot(i)
    if current_item and not NoCdItems[current_item:GetName()] then  
		local cooldown_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_cooldown_speed", {ability = current_item:entindex(), is_item = true, cd_inc = cd_items})
		local name = self:GetName()
		cooldown_mod:SetEndRule(function()
			return self.parent:HasModifier(name)
		end)
    end
end

self.bkb_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {effect = 1})
end

function modifier_custom_pudge_dismember_bkb:OnDestroy()
if not IsServer() then return end

if self.bkb_mod and not self.bkb_mod:IsNull() then
	self.bkb_mod:Destroy()
end

end