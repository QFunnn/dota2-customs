--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_troll_warlord_berserkers_rage_custom", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_custom_ranged_slow", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_custom_ensnare", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_tracker", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_cd", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_rampage_custom", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_legendary_charge", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_legendary_agility", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_aoe_damage", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_custom_proc_damage", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_custom_agi_perma", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_custom_unslow", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_custom_attack_slow", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_berserkers_rage_custom_break_cd", "abilities/troll_warlord/troll_warlord_berserkers_rage_custom", LUA_MODIFIER_MOTION_NONE)



troll_warlord_berserkers_rage_custom = class({})

function troll_warlord_berserkers_rage_custom:CreateTalent()

if self:GetToggleState() then
	self:ToggleAbility()
end

end


function troll_warlord_berserkers_rage_custom:GetIntrinsicModifierName()
return "modifier_troll_warlord_berserkers_rage_tracker"
end

function troll_warlord_berserkers_rage_custom:ResetToggleOnRespawn()
return false
end


function troll_warlord_berserkers_rage_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_troll_warlord/troll_warlord_melee_blur_6.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_troll_warlord/troll_warlord_melee_blur_1.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net_projectile.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_troll_warlord/troll_warlord_berserk_buff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle","particles/troll_haste.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_forcestaff.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/sange_maim.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_juggernaut/jugg_agility_boost.vpcf", context )
PrecacheResource( "particle","particles/troll_warlord/rage_jump.vpcf", context )
PrecacheResource( "particle","particles/troll_warlord/rage_jump_dustd.vpcf", context )
PrecacheResource( "particle","particles/brist_lowhp_.vpcf", context )
PrecacheResource( "particle","particles/troll_warlord/rage_unslow.vpcf", context )

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_troll_warlord.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_troll_warlord", context)
end


function troll_warlord_berserkers_rage_custom:GetAbilityTextureName()
if self:GetCaster():HasModifier("modifier_troll_warlord_berserkers_rage_custom") then
    return wearables_system:GetAbilityIconReplacement(self.caster, "troll_warlord_berserkers_rage_active", self)
end
return wearables_system:GetAbilityIconReplacement(self.caster, "troll_warlord_switch_stance", self)
end


function troll_warlord_berserkers_rage_custom:GetBehavior()	
if self:GetCaster():HasTalent("modifier_troll_rage_legendary") and not self:GetCaster():HasModifier("modifier_troll_warlord_berserkers_rage_custom") then
	return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function troll_warlord_berserkers_rage_custom:GetCooldown(level)
if not self:GetCaster():HasTalent("modifier_troll_rage_legendary") then return end
return self:GetCaster():GetTalentValue("modifier_troll_rage_legendary", "cd")
end

function troll_warlord_berserkers_rage_custom:GetCastRange(level)
if IsServer() then return end
local caster = self:GetCaster()

if not caster:HasTalent("modifier_troll_rage_legendary") then return end
return caster:GetTalentValue("modifier_troll_rage_legendary", "range") - caster:GetCastRangeBonus()
end


function troll_warlord_berserkers_rage_custom:OnAbilityPhaseStart()
local caster = self:GetCaster()

if not caster:HasTalent("modifier_troll_rage_legendary") then return end

caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
end


function troll_warlord_berserkers_rage_custom:OnAbilityPhaseInterrupted()
self:GetCaster():RemoveGesture(ACT_DOTA_CAST_ABILITY_3)
end



function troll_warlord_berserkers_rage_custom:OnSpellStart()
local caster = self:GetCaster()
if not caster:HasTalent("modifier_troll_rage_legendary") then return end

local duration = caster:GetTalentValue("modifier_troll_rage_legendary", "charge_duration")
local point = self:GetCursorPosition()
if point == caster:GetAbsOrigin() then
	point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
end

caster:AddNewModifier(caster, self, "modifier_troll_warlord_berserkers_rage_legendary_charge", {duration = 3, x = point.x, y = point.y})
end



function troll_warlord_berserkers_rage_custom:OnToggle()
local caster = self:GetCaster()
caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
caster:EmitSound("Hero_TrollWarlord.BerserkersRage.Toggle")

if self:GetToggleState() and not caster:HasTalent("modifier_troll_rage_legendary") then
	caster:AddNewModifier(caster, self, "modifier_troll_warlord_berserkers_rage_custom", {} )
else
	caster:RemoveModifierByName("modifier_troll_warlord_berserkers_rage_custom")
end

end



function troll_warlord_berserkers_rage_custom:ProcSlow(target)

local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("slow_duration")
local damage = self:GetSpecialValueFor("slow_damage")

target:EmitSound("DOTA_Item.Maim")
--DoDamage({victim = target, attacker = caster, damage = damage, ability = self, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK})
target:AddNewModifier(caster, self, "modifier_troll_warlord_berserkers_rage_custom_ranged_slow", {duration = (1 - target:GetStatusResistance())*duration})
end


function troll_warlord_berserkers_rage_custom:ProcRoot(target, ranged)
local caster = self:GetCaster()
local cd = self:GetSpecialValueFor("ensnare_cooldown") + caster:GetTalentValue("modifier_troll_rage_2", "cd")
local duration = self:GetSpecialValueFor("ensnare_duration")

if target:IsRealHero() then
	caster:AddNewModifier(caster, self, "modifier_troll_warlord_berserkers_rage_custom_agi_perma", {})

	if caster:GetQuest() == "Troll.Quest_5" and not caster:QuestCompleted() then 
		caster:UpdateQuest(1)
	end
end

caster:AddNewModifier(caster, self, "modifier_troll_warlord_berserkers_rage_cd", {duration = cd})

if ranged and ranged == true then 
	duration = caster:GetTalentValue("modifier_troll_rage_legendary", "root")*duration/100
end 

local net =
{
	Target = target,
	Source = caster,
	Ability = self,
	bDodgeable = false,
	EffectName = "particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net_projectile.vpcf",
	iMoveSpeed = 1500,
	flExpireTime = GameRules:GetGameTime() + 10,
	ExtraData = {duration = duration}
}
ProjectileManager:CreateTrackingProjectile(net)
end




function troll_warlord_berserkers_rage_custom:OnProjectileHit_ExtraData(target, vLocation, table)
if not IsServer() then return end
if not table.duration then return end
if not target or not target:IsAlive() then return end
local caster = self:GetCaster()

local ensnare_duration	= table.duration 
if not caster:HasTalent("modifier_troll_rage_6") then
	ensnare_duration = ensnare_duration * (1 - target:GetStatusResistance())
end

if caster:HasTalent("modifier_troll_rage_4") then

	caster:AddNewModifier(caster, self, "modifier_troll_warlord_berserkers_rage_custom_proc_damage", {duration = FrameTime()})
	caster:PerformAttack(target, true, true, true, true, false, false, true)
	caster:RemoveModifierByName("modifier_troll_warlord_berserkers_rage_custom_proc_damage")

	target:EmitSound("Troll.Rage_crit")
	local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControlEnt(hit_effect, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
	ParticleManager:SetParticleControlEnt(hit_effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
	ParticleManager:Delete(hit_effect, 1)
end

if caster:HasTalent("modifier_troll_rage_6") then
	target:AddNewModifier(caster, self, "modifier_troll_warlord_berserkers_rage_custom_attack_slow", {duration = caster:GetTalentValue("modifier_troll_rage_6", "slow_duration")})

	if target:GetHealthPercent() <= caster:GetTalentValue("modifier_troll_rage_6", "health") and not target:HasModifier("modifier_troll_warlord_berserkers_rage_custom_break_cd") then

		if target:IsHero() then
			target:EmitSound("DOTA_Item.SilverEdge.Target")
		end
		target:AddNewModifier(caster, self, "modifier_troll_warlord_berserkers_rage_custom_break_cd", {duration = caster:GetTalentValue("modifier_troll_rage_6", "cd")})
		local mod = target:AddNewModifier(caster, caster:BkbAbility(nil, false), "modifier_generic_break", {duration = caster:GetTalentValue("modifier_troll_rage_6", "break_duration")})
		if mod then
			target:GenericParticle("particles/items3_fx/silver_edge.vpcf", mod)
		end
	end

end

target:EmitSound("n_creep_TrollWarlord.Ensnare")
target:AddNewModifier(self:GetCaster(), self, "modifier_troll_warlord_berserkers_rage_custom_ensnare", {duration = ensnare_duration})
end





modifier_troll_warlord_berserkers_rage_custom = class({})
function modifier_troll_warlord_berserkers_rage_custom:IsHidden() return true end
function modifier_troll_warlord_berserkers_rage_custom:IsPurgable() return false end
function modifier_troll_warlord_berserkers_rage_custom:RemoveOnDeath() return false end
function modifier_troll_warlord_berserkers_rage_custom:OnCreated( kv )
if not IsServer() then return end
self.parent = self:GetParent()

self.pre_attack_capability = self.parent:GetAttackCapability()
self.parent:SetAttackCapability( DOTA_UNIT_CAP_MELEE_ATTACK )
self.parent:FadeGesture(ACT_DOTA_RUN)
self.attack_melee = false

local particle_name = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_troll_warlord/troll_warlord_berserk_buff.vpcf", self)
local particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, self.parent)
if particle_name ~= "particles/units/heroes/hero_troll_warlord/troll_warlord_berserk_buff.vpcf" then
    ParticleManager:SetParticleControl(particle, 16, Vector(239, 56, 15))
end
self:AddParticle(particle, false, false, -1, false, false)

self.StackOnIllusion = true

    local troll_warlord_weapon = self.parent:GetItemWearableHandle("weapon")
    local troll_warlord_shoulder = self.parent:GetItemWearableHandle("shoulder")
    if troll_warlord_weapon then
        local modifier_donate_hero_illusion_item = troll_warlord_weapon:FindModifierByName("modifier_donate_hero_illusion_item")
        if modifier_donate_hero_illusion_item and modifier_donate_hero_illusion_item.pfx_list then
            for _, particle_item in pairs(modifier_donate_hero_illusion_item.pfx_list) do
                if particle_item then
                    ParticleManager:SetParticleControl(particle_item, 1, Vector(239, 56, 15))
                end
            end
        end
    end
    if troll_warlord_shoulder then
        local modifier_donate_hero_illusion_item = troll_warlord_shoulder:FindModifierByName("modifier_donate_hero_illusion_item")
        if modifier_donate_hero_illusion_item and modifier_donate_hero_illusion_item.pfx_list then
            for _, particle_item in pairs(modifier_donate_hero_illusion_item.pfx_list) do
                if particle_item then
                    ParticleManager:SetParticleControl(particle_item, 1, Vector(239, 56, 15))
                end
            end
        end
    end
    if troll_warlord_weapon then
        troll_warlord_weapon:SetMaterialGroup("1")
    end
    if troll_warlord_shoulder then
        troll_warlord_shoulder:SetMaterialGroup("1")
    end
end

function modifier_troll_warlord_berserkers_rage_custom:OnDestroy( kv )
if not IsServer() then return end
if not self.parent or self.parent:IsNull() then return end

self.parent:SetAttackCapability(self.pre_attack_capability )
self.parent:FadeGesture(ACT_DOTA_RUN)

local troll_warlord_weapon = self.parent:GetItemWearableHandle("weapon")
    local troll_warlord_shoulder = self.parent:GetItemWearableHandle("shoulder")
    if troll_warlord_weapon then
        local modifier_donate_hero_illusion_item = troll_warlord_weapon:FindModifierByName("modifier_donate_hero_illusion_item")
        if modifier_donate_hero_illusion_item and modifier_donate_hero_illusion_item.pfx_list then
            for _, particle_item in pairs(modifier_donate_hero_illusion_item.pfx_list) do
                if particle_item then
                    ParticleManager:SetParticleControl(particle_item, 1, Vector(14, 123, 239))
                end
            end
        end
    end
    if troll_warlord_shoulder then
        local modifier_donate_hero_illusion_item = troll_warlord_shoulder:FindModifierByName("modifier_donate_hero_illusion_item")
        if modifier_donate_hero_illusion_item and modifier_donate_hero_illusion_item.pfx_list then
            for _, particle_item in pairs(modifier_donate_hero_illusion_item.pfx_list) do
                if particle_item then
                    ParticleManager:SetParticleControl(particle_item, 1, Vector(14, 123, 239))
                end
            end
        end
    end
    if troll_warlord_weapon then
        troll_warlord_weapon:SetMaterialGroup("0")
    end
    if troll_warlord_shoulder then
        troll_warlord_shoulder:SetMaterialGroup("default")
    end
end

function modifier_troll_warlord_berserkers_rage_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
}
end

function modifier_troll_warlord_berserkers_rage_custom:GetAttackSound()
return "Hero_TrollWarlord.ProjectileImpact"
end

function modifier_troll_warlord_berserkers_rage_custom:GetActivityTranslationModifiers()
return "melee"
end





modifier_troll_warlord_berserkers_rage_tracker = class({})
function modifier_troll_warlord_berserkers_rage_tracker:IsHidden() return true end
function modifier_troll_warlord_berserkers_rage_tracker:IsPurgable() return false end
function modifier_troll_warlord_berserkers_rage_tracker:OnCreated(table)
self.last_proc = nil

self.ability = self:GetAbility()
self.parent = self:GetParent()

self.legendary_cd = self.parent:GetTalentValue("modifier_troll_rage_legendary", "cd_inc", true)

self.range_inc = 0
self.range_bonus = self.parent:GetTalentValue("modifier_troll_rage_1", "bonus", true)
self.aoe_radius = self.parent:GetTalentValue("modifier_troll_rage_1", "aoe", true)

self.base_bva = self.parent:GetBaseAttackTime(false)
self.bva_bonus = self.parent:GetTalentValue("modifier_troll_fervor_6", "bva", true)

self.agi_damage = 0
self.agi_heal = self.parent:GetTalentValue("modifier_troll_rage_3", "heal", true)/100

self.move_inc = self.parent:GetTalentValue("modifier_troll_rage_5", "move", true)
self.low_health = self.parent:GetTalentValue("modifier_troll_rage_5", "health", true)

self.base_attack_time = self.ability:GetSpecialValueFor( "base_attack_time" )
self.bonus_move_speed = self.ability:GetSpecialValueFor( "bonus_move_speed" )
self.bonus_armor = self.ability:GetSpecialValueFor( "bonus_armor" )
self.root_chance = self.ability:GetSpecialValueFor("ensnare_chance")
self.melle_nerf = -350

self.bonus_chance = 0

if self.parent:IsRealHero() then
	self.parent:AddAttackEvent_out(self)
	self.parent:AddAttackStartEvent_out(self)
end
if not IsServer() then return end
self:SetHasCustomTransmitterData(true)

self:UpdateTalent()
end


function modifier_troll_warlord_berserkers_rage_tracker:OnRefresh()
self.base_attack_time = self.ability:GetSpecialValueFor( "base_attack_time" )
self.bonus_move_speed = self.ability:GetSpecialValueFor( "bonus_move_speed" )
self.bonus_armor = self.ability:GetSpecialValueFor( "bonus_armor" )
self.root_chance = self.ability:GetSpecialValueFor("ensnare_chance")
end


function modifier_troll_warlord_berserkers_rage_tracker:UpdateTalent(name)

self.range_inc = self.parent:GetTalentValue("modifier_troll_rage_1", "range")

self.agi_damage = self.parent:GetTalentValue("modifier_troll_rage_3", "damage")

self.bonus_chance = self.parent:GetTalentValue("modifier_troll_rage_2", "chance")

if name == "modifier_troll_rage_5" or self.parent:HasTalent("modifier_troll_rage_5") then
	self:StartIntervalThink(0.2)
end

self:SendBuffRefreshToClients()
end

function modifier_troll_warlord_berserkers_rage_tracker:AddCustomTransmitterData() 
return 
{
    agi_damage = self.agi_damage,
    range_inc = self.range_inc,
} 
end

function modifier_troll_warlord_berserkers_rage_tracker:HandleCustomTransmitterData(data)
self.agi_damage = data.agi_damage
self.range_inc = data.range_inc
end

function modifier_troll_warlord_berserkers_rage_tracker:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then return end

local allow = not self.parent:PassivesDisabled() and self.parent:GetHealthPercent() <= self.low_health

if allow then
	if not self.parent:HasModifier("modifier_troll_warlord_berserkers_rage_custom_unslow") then
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_troll_warlord_berserkers_rage_custom_unslow", {})
	end
else
	if self.parent:HasModifier("modifier_troll_warlord_berserkers_rage_custom_unslow") then
		self.parent:RemoveModifierByName("modifier_troll_warlord_berserkers_rage_custom_unslow")
	end
end

end


function modifier_troll_warlord_berserkers_rage_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end


function modifier_troll_warlord_berserkers_rage_tracker:AllowMelle()
return self.parent:HasModifier("modifier_troll_warlord_berserkers_rage_custom") or self.parent:HasTalent("modifier_troll_rage_legendary")
end


function modifier_troll_warlord_berserkers_rage_tracker:GetModifierAttackRangeBonus()
local bonus = 0
if self.parent:HasTalent("modifier_troll_rage_1") then
	bonus = self.range_inc
end
if not self.parent:IsRangedAttacker() then
	bonus = bonus/self.range_bonus
end
if self.parent:HasModifier("modifier_troll_warlord_berserkers_rage_custom") then
	bonus = bonus + self.melle_nerf
end
return bonus
end


function modifier_troll_warlord_berserkers_rage_tracker:GetModifierPreAttack_BonusDamage()
if not self.parent:HasTalent("modifier_troll_rage_3") then return end
return self.agi_damage*self.parent:GetAgility()/100
end

function modifier_troll_warlord_berserkers_rage_tracker:GetModifierBaseAttackTimeConstant()
local result = self.base_bva
if self:AllowMelle() then
	result = self.base_attack_time
end
if self.parent:HasTalent("modifier_troll_fervor_6") and self.parent:HasModifier("modifier_troll_warlord_fervor_custom_max") then
	result = result + self.bva_bonus
end
return result
end

function modifier_troll_warlord_berserkers_rage_tracker:GetModifierPhysicalArmorBonus()
if not self:AllowMelle() then return end
return self.bonus_armor
end

function modifier_troll_warlord_berserkers_rage_tracker:GetModifierMoveSpeedBonus_Constant()
if self:AllowMelle() then
	local bonus = self.bonus_move_speed
	if self.parent:HasTalent("modifier_troll_rage_5") then
		bonus = bonus + self.move_inc
	end
	return bonus
end
return 0
end



function modifier_troll_warlord_berserkers_rage_tracker:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if params.no_attack_cooldown then return end

local target = params.target

if self.parent:HasTalent("modifier_troll_rage_1") then
	for _,aoe_target in pairs(self.parent:FindTargets(self.aoe_radius, target:GetAbsOrigin())) do
		if aoe_target ~= target then
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_troll_warlord_berserkers_rage_aoe_damage", {duration = FrameTime()})
			self.parent:PerformAttack(aoe_target, true, false, true, false, true, false, false)
			self.parent:RemoveModifierByName("modifier_troll_warlord_berserkers_rage_aoe_damage")
			break
		end
	end
end

end


function modifier_troll_warlord_berserkers_rage_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local target = params.target

if not self.parent:PassivesDisabled() then

	if (not params.ranged_attack or self.parent:HasTalent("modifier_troll_rage_legendary")) and not self.parent:HasModifier("modifier_troll_warlord_berserkers_rage_cd") then
		if RollPseudoRandomPercentage(self.root_chance + self.bonus_chance, 3516, self.parent) then
			self.ability:ProcRoot(target, params.ranged_attack)
		end
	end

	if params.ranged_attack then
		if RollPseudoRandomPercentage(self.root_chance, 3517, self.parent) then
			self.ability:ProcSlow(params.target)
		end
	end
end

if self.parent:HasTalent("modifier_troll_rage_3") then
	self.parent:GenericHeal(self.agi_heal*self.agi_damage*self.parent:GetAgility()/100, self.ability, true, nil, "modifier_troll_rage_3")
end

if self.parent:HasTalent("modifier_troll_rage_legendary") then
	self.parent:CdAbility(self.ability, self.legendary_cd)
end

end





modifier_troll_warlord_berserkers_rage_custom_ensnare = class({})
function modifier_troll_warlord_berserkers_rage_custom_ensnare:IsHidden() return false end
function modifier_troll_warlord_berserkers_rage_custom_ensnare:IsPurgable() return true end
function modifier_troll_warlord_berserkers_rage_custom_ensnare:GetEffectName() return "particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net.vpcf" end
function modifier_troll_warlord_berserkers_rage_custom_ensnare:CheckState()
return 
{
	[MODIFIER_STATE_ROOTED] = true
}
end



modifier_troll_warlord_berserkers_rage_cd = class({})
function modifier_troll_warlord_berserkers_rage_cd:IsHidden() return false end
function modifier_troll_warlord_berserkers_rage_cd:IsPurgable() return false end
function modifier_troll_warlord_berserkers_rage_cd:IsDebuff() return true end






troll_warlord_rampage_custom = class({})

function troll_warlord_rampage_custom:GetCastPoint(iLevel)
if self:GetCaster():HasModifier("modifier_troll_warlord_battle_trance_custom") then 
    return 0
end
return self.BaseClass.GetCastPoint(self)
end

function troll_warlord_rampage_custom:GetCastRange(vLocation, hTarget)
return self:GetSpecialValueFor("range")
end

function troll_warlord_rampage_custom:OnSpellStart()
local caster = self:GetCaster()
local point = caster:GetAbsOrigin() + caster:GetForwardVector()*self:GetSpecialValueFor("range")
local duration = self:GetSpecialValueFor("range")/self:GetSpecialValueFor("speed")
caster:AddNewModifier(caster, self, "modifier_troll_warlord_rampage_custom", {x = point.x, y = point.y, duration = duration})
end 



modifier_troll_warlord_rampage_custom = class({})
function modifier_troll_warlord_rampage_custom:IsHidden() return true end
function modifier_troll_warlord_rampage_custom:IsPurgable() return false end
function modifier_troll_warlord_rampage_custom:GetEffectName() return "particles/troll_haste.vpcf" end
function modifier_troll_warlord_rampage_custom:GetOverrideAnimation() return ACT_DOTA_RUN end
function modifier_troll_warlord_rampage_custom:GetModifierDisableTurning() return 1 end
function modifier_troll_warlord_rampage_custom:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_troll_warlord_rampage_custom:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL  end

function modifier_troll_warlord_rampage_custom:OnCreated(kv)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddOrderEvent(self)

self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0.7)

self.turn_speed = 100
self.target_angle = self.parent:GetAnglesAsVector().y
self.current_angle = self.target_angle
self.face_target = true


self.parent:EmitSound("Troll.Rampage")

self.point = GetGroundPosition(Vector(kv.x, kv.y, 0), nil)

self.parent:EmitSound("Lc.Odds_Charge")

self.angle = self.parent:GetForwardVector():Normalized()

self.distance = (self.point - self.parent:GetAbsOrigin()):Length2D() / ( self:GetDuration() / FrameTime())

self.speed = self.ability:GetSpecialValueFor("speed")
self.knock_distance = self.ability:GetSpecialValueFor("knock_distance")
self.knock_height = self.ability:GetSpecialValueFor("knock_distance")
self.knock_duration = self.ability:GetSpecialValueFor("knock_duration")
self.knock_radius = self.ability:GetSpecialValueFor("knock_radius")
self.knock_stun = self.ability:GetSpecialValueFor("stun")

self.main_ability = self.parent:FindAbilityByName("troll_warlord_berserkers_rage_custom")

if not self.main_ability then 
	self:Destroy()
	return
end

self.targets = {}

if self:ApplyHorizontalMotionController() == false then
    self:Destroy()
end

end

function modifier_troll_warlord_rampage_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DISABLE_TURNING,
  MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
}
end


function modifier_troll_warlord_rampage_custom:OrderEvent( params )


if params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION then
	self:SetDirection( params.pos )
elseif
	params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
then
	self:SetDirection( params.pos )
elseif 
	(params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
	params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target
then
	self:SetDirection( params.target:GetOrigin() )
elseif
	params.order_type==DOTA_UNIT_ORDER_STOP or 
	params.order_type==DOTA_UNIT_ORDER_CAST_TARGET or
	params.order_type==DOTA_UNIT_ORDER_CAST_POSITION or
	params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
then
	self:Destroy()
end	

end


function modifier_troll_warlord_rampage_custom:SetDirection( location )
local dir = ((location-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
self.target_angle = VectorToAngles( dir ).y
self.face_target = false
end



function modifier_troll_warlord_rampage_custom:TurnLogic( dt )
if self.face_target then return end
local angle_diff = AngleDiff( self.current_angle, self.target_angle )
local turn_speed = self.turn_speed*dt

local sign = -1
if angle_diff<0 then sign = 1 end

if math.abs( angle_diff )<1.1*turn_speed then
	self.current_angle = self.target_angle
	self.face_target = true
else
	self.current_angle = self.current_angle + sign*turn_speed
end

local angles = self.parent:GetAnglesAsVector()
self.parent:SetLocalAngles( angles.x, self.current_angle, angles.z )
end

function modifier_troll_warlord_rampage_custom:OnDestroy()
if not IsServer() then return end
self.parent:InterruptMotionControllers( true )

local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)
ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
end


function modifier_troll_warlord_rampage_custom:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end

if self.parent:IsStunned() or self.parent:IsHexed() or self.parent:IsRooted() then 
	self:Destroy()
	return
end

for _,enemy in pairs(self.parent:FindTargets(self.knock_radius)) do 
	if not self.targets[enemy] then 

		self.targets[enemy] = true

		enemy:EmitSound("Troll.Rampage_hit")
		local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, enemy)
		ParticleManager:SetParticleControlEnt(hit_effect, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), false) 
		ParticleManager:SetParticleControlEnt(hit_effect, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), false) 
		ParticleManager:Delete(hit_effect, 1)

		local direction = enemy:GetOrigin()-self.parent:GetOrigin()
		direction.z = 0
		direction = direction:Normalized()

		self.main_ability:ProcRoot(enemy, false, true)

		local knockbackProperties =
		{
			center_x = self.parent:GetOrigin().x,
			center_y = self.parent:GetOrigin().y,
			center_z = self.parent:GetOrigin().z,
			duration = self.knock_duration,
			knockback_duration = self.knock_duration,
			knockback_distance = self.knock_distance,
			knockback_height = self.knock_height,
			should_stun = 0,
		}
		enemy:AddNewModifier( self.parent, self.ability, "modifier_knockback", knockbackProperties )
		self:Destroy()
		return
	end
end 


self:TurnLogic( dt )
local nextpos = me:GetOrigin() + me:GetForwardVector() * self.speed * dt
me:SetOrigin(nextpos)
end

function modifier_troll_warlord_rampage_custom:OnHorizontalMotionInterrupted()
self:Destroy()
end

function modifier_troll_warlord_rampage_custom:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
	[MODIFIER_STATE_DISARMED] = true
}
end






modifier_troll_warlord_berserkers_rage_custom_ranged_slow = class({})
function modifier_troll_warlord_berserkers_rage_custom_ranged_slow:IsHidden() return true end
function modifier_troll_warlord_berserkers_rage_custom_ranged_slow:IsPurgable() return true end
function modifier_troll_warlord_berserkers_rage_custom_ranged_slow:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow_move = self.ability:GetSpecialValueFor("slow_move")*-1
self.slow_attack = self.ability:GetSpecialValueFor("slow_attack")*-1
end

function modifier_troll_warlord_berserkers_rage_custom_ranged_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_troll_warlord_berserkers_rage_custom_ranged_slow:GetModifierAttackSpeedBonus_Constant()
return self.slow_attack
end

function modifier_troll_warlord_berserkers_rage_custom_ranged_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow_move
end


function modifier_troll_warlord_berserkers_rage_custom_ranged_slow:GetEffectName()
return "particles/items2_fx/sange_maim.vpcf"
end





modifier_troll_warlord_berserkers_rage_legendary_charge = class({})
function modifier_troll_warlord_berserkers_rage_legendary_charge:IsHidden() return true end
function modifier_troll_warlord_berserkers_rage_legendary_charge:IsPurgable() return false end

function modifier_troll_warlord_berserkers_rage_legendary_charge:OnCreated(params)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1.5)
self.parent:GenericParticle("particles/troll_warlord/rage_jump_dustd.vpcf")
self.parent:EmitSound("Troll.Rage_jump")
self.parent:EmitSound("Troll.Rage_jump2")


local effect_cast = ParticleManager:CreateParticle( "particles/troll_warlord/rage_jump.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:SetParticleControlEnt( effect_cast, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
self:AddParticle( effect_cast, false, false, -1, false, false )

self.origin = self.parent:GetAbsOrigin()
self.point = GetGroundPosition(Vector(params.x, params.y, 0), nil)
self.dir = (self.point - self.origin):Normalized()
self.speed = self.parent:GetTalentValue("modifier_troll_rage_legendary", "speed")
self.max_range = self.parent:GetTalentValue("modifier_troll_rage_legendary", "range")

self.speed_current = 0.1
self.slow_time = 0.25
self.speed_k = (1 - self.speed_current)/self.slow_time

if self:ApplyHorizontalMotionController() == false then
    self:Destroy()
end

end


function modifier_troll_warlord_berserkers_rage_legendary_charge:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local pos = self.parent:GetAbsOrigin()
GridNav:DestroyTreesAroundPoint(pos, 80, false)

local speed = self.speed*dt*self.speed_current
self.speed_current = math.min(1, self.speed_current + self.speed_k*dt)
self.parent:SetAbsOrigin(GetGroundPosition(pos + self.dir*speed, nil))

if (self.parent:GetAbsOrigin() - self.origin):Length2D() >= self.max_range then
	self:Destroy()
	return
end

end

function modifier_troll_warlord_berserkers_rage_legendary_charge:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_DISABLE_TURNING
}
end

function modifier_troll_warlord_berserkers_rage_legendary_charge:GetModifierDisableTurning() return 1 end

function modifier_troll_warlord_berserkers_rage_legendary_charge:OnDestroy()
if not IsServer() then return end
self.parent:InterruptMotionControllers( true )

local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)

ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)

self.parent:AddNewModifier(self.parent, self.ability, "modifier_troll_warlord_berserkers_rage_legendary_agility", {duration = self.parent:GetTalentValue("modifier_troll_rage_legendary", "duration")})

Timers:CreateTimer(0.1, function()
	if self.parent and not self.parent:IsNull() then
		self.parent:EmitSound("Troll.Rage_jump_end")
		self.parent:GenericParticle("particles/troll_warlord/rage_jump_dustd.vpcf")
	end
end)

end

function modifier_troll_warlord_berserkers_rage_legendary_charge:GetStatusEffectName()
return "particles/troll_warlord/rage_jump_status.vpcf"
end

function modifier_troll_warlord_berserkers_rage_legendary_charge:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end


function modifier_troll_warlord_berserkers_rage_legendary_charge:OnHorizontalMotionInterrupted()
self:Destroy()
end




modifier_troll_warlord_berserkers_rage_legendary_agility = class({})
function modifier_troll_warlord_berserkers_rage_legendary_agility:IsHidden() return false end
function modifier_troll_warlord_berserkers_rage_legendary_agility:IsPurgable() return false end
function modifier_troll_warlord_berserkers_rage_legendary_agility:OnCreated()
self.parent = self:GetParent()

if not IsServer() then return end
self.parent:AddPercentStat({agi = self.parent:GetTalentValue("modifier_troll_rage_legendary", "agility")/100}, self)

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_juggernaut/jugg_agility_boost.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
self:AddParticle( effect_cast, false, false, -1, false, false )
end



modifier_troll_warlord_berserkers_rage_aoe_damage = class({})
function modifier_troll_warlord_berserkers_rage_aoe_damage:IsHidden() return true end
function modifier_troll_warlord_berserkers_rage_aoe_damage:IsPurgable() return false end
function modifier_troll_warlord_berserkers_rage_aoe_damage:OnCreated()
self.damage = self:GetParent():GetTalentValue("modifier_troll_rage_1", "damage") - 100
end

function modifier_troll_warlord_berserkers_rage_aoe_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_troll_warlord_berserkers_rage_aoe_damage:GetModifierDamageOutgoing_Percentage()
return self.damage
end



modifier_troll_warlord_berserkers_rage_custom_proc_damage = class({})
function modifier_troll_warlord_berserkers_rage_custom_proc_damage:IsHidden() return true end
function modifier_troll_warlord_berserkers_rage_custom_proc_damage:IsPurgable() return false end
function modifier_troll_warlord_berserkers_rage_custom_proc_damage:OnCreated()
self.damage = self:GetParent():GetTalentValue("modifier_troll_rage_4", "damage") - 100
end

function modifier_troll_warlord_berserkers_rage_custom_proc_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_troll_warlord_berserkers_rage_custom_proc_damage:GetModifierDamageOutgoing_Percentage()
return self.damage
end




modifier_troll_warlord_berserkers_rage_custom_agi_perma = class({})
function modifier_troll_warlord_berserkers_rage_custom_agi_perma:IsHidden() return not self:GetCaster():HasTalent("modifier_troll_rage_4") end
function modifier_troll_warlord_berserkers_rage_custom_agi_perma:IsPurgable() return false end
function modifier_troll_warlord_berserkers_rage_custom_agi_perma:RemoveOnDeath() return false end
function modifier_troll_warlord_berserkers_rage_custom_agi_perma:GetTexture() return "buffs/blink_agility" end
function modifier_troll_warlord_berserkers_rage_custom_agi_perma:OnCreated()
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_troll_rage_4", "max", true)

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_troll_warlord_berserkers_rage_custom_agi_perma:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()
self.parent:CalculateStatBonus(true)
end

function modifier_troll_warlord_berserkers_rage_custom_agi_perma:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self.parent:HasTalent("modifier_troll_rage_4") then return end

self.parent:GenericParticle("particles/general/patrol_refresh.vpcf")

self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 

function modifier_troll_warlord_berserkers_rage_custom_agi_perma:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATS_AGILITY_BONUS
}
end

function modifier_troll_warlord_berserkers_rage_custom_agi_perma:GetModifierBonusStats_Agility()
if not self.parent:HasTalent("modifier_troll_rage_4") then return end
return self:GetStackCount()*self.parent:GetTalentValue("modifier_troll_rage_4", "agi")/self.max
end



modifier_troll_warlord_berserkers_rage_custom_unslow = class({})
function modifier_troll_warlord_berserkers_rage_custom_unslow:IsHidden() return true end
function modifier_troll_warlord_berserkers_rage_custom_unslow:IsPurgable() return false end
function modifier_troll_warlord_berserkers_rage_custom_unslow:OnCreated()
self.parent = self:GetParent()
self.incoming = self.parent:GetTalentValue("modifier_troll_rage_5", "damage_reduce")

if not IsServer() then return end
self.parent:GenericParticle("particles/troll_warlord/rage_unslow.vpcf", self)
self:StartIntervalThink(0.1)
end


function modifier_troll_warlord_berserkers_rage_custom_unslow:OnIntervalThink()
if not IsServer() then return end

self.parent:EmitSound("Troll.Rage_unslow")
self.parent:GenericParticle("particles/brist_lowhp_.vpcf")
self:StartIntervalThink(-1)
end

function modifier_troll_warlord_berserkers_rage_custom_unslow:CheckState()
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true
}
end

function modifier_troll_warlord_berserkers_rage_custom_unslow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_troll_warlord_berserkers_rage_custom_unslow:GetModifierIncomingDamage_Percentage()
return self.incoming
end



modifier_troll_warlord_berserkers_rage_custom_attack_slow = class({})
function modifier_troll_warlord_berserkers_rage_custom_attack_slow:IsHidden() return true end
function modifier_troll_warlord_berserkers_rage_custom_attack_slow:IsPurgable() return true end
function modifier_troll_warlord_berserkers_rage_custom_attack_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_troll_rage_6", "slow")
end

function modifier_troll_warlord_berserkers_rage_custom_attack_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_troll_warlord_berserkers_rage_custom_attack_slow:GetModifierAttackSpeedBonus_Constant()
return self.slow
end



modifier_troll_warlord_berserkers_rage_custom_break_cd = class({})
function modifier_troll_warlord_berserkers_rage_custom_break_cd:IsHidden() return true end
function modifier_troll_warlord_berserkers_rage_custom_break_cd:IsPurgable() return false end
function modifier_troll_warlord_berserkers_rage_custom_break_cd:RemoveOnDeath() return false end
function modifier_troll_warlord_berserkers_rage_custom_break_cd:OnCreated()
self.RemoveForDuel = true
end