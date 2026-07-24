--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_troll_warlord_whirling_axes_melee_custom", "abilities/troll_warlord/troll_warlord_whirling_axes_melee_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_whirling_axes_melee_custom_thinker", "abilities/troll_warlord/troll_warlord_whirling_axes_melee_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_whirling_axes_melee_custom_thinker_axe", "abilities/troll_warlord/troll_warlord_whirling_axes_melee_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_whirling_axes_tracker", "abilities/troll_warlord/troll_warlord_whirling_axes_melee_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_whirling_axes_melee_quest", "abilities/troll_warlord/troll_warlord_whirling_axes_melee_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_whirling_axes_melee_custom_stack", "abilities/troll_warlord/troll_warlord_whirling_axes_melee_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_whirling_axes_buff", "abilities/troll_warlord/troll_warlord_whirling_axes_melee_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_whirling_axes_legendary_stack", "abilities/troll_warlord/troll_warlord_whirling_axes_melee_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_troll_warlord_whirling_axes_attack", "abilities/troll_warlord/troll_warlord_whirling_axes_melee_custom", LUA_MODIFIER_MOTION_NONE)


troll_warlord_whirling_axes_melee_custom = class({})

function troll_warlord_whirling_axes_melee_custom:GetAbilityTextureName()
    return wearables_system:GetAbilityIconReplacement(self.caster, "troll_warlord_whirling_axes_melee", self)
end

function troll_warlord_whirling_axes_melee_custom:CreateTalent()
self:UpdateUI()
end

function troll_warlord_whirling_axes_melee_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_melee.vpcf", context )
PrecacheResource( "particle","particles/sf_refresh_a.vpcf", context ) 
PrecacheResource( "particle","particles/troll_warlord/refresh_ranged.vpcf", context )
PrecacheResource( "particle","particles/troll_warlord/axes_melle_stack.vpcf", context )
PrecacheResource( "particle","particles/troll_warlord/axes_ranged_stack.vpcf", context )
PrecacheResource( "particle","particles/rare_orb_patrol.vpcf", context )
PrecacheResource( "particle","particles/jugg_parry.vpcf", context )
end


function troll_warlord_whirling_axes_melee_custom:GetAbilityTargetFlags()
if self:GetCaster():HasScepter() then 
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
else 
	return DOTA_UNIT_TARGET_FLAG_NONE
end

end

function troll_warlord_whirling_axes_melee_custom:GetBehavior()	
local bonus = 0
if self:GetCaster():HasTalent("modifier_troll_axes_6") then
	bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + bonus
end

function troll_warlord_whirling_axes_melee_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_troll_warlord_whirling_axes_tracker"
end


function troll_warlord_whirling_axes_melee_custom:UpdateUI()
local mod = self:GetCaster():FindModifierByName("modifier_troll_warlord_whirling_axes_tracker")
if mod then
	mod:UpdateUI()
end

end

function troll_warlord_whirling_axes_melee_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_troll_axes_1") then
	bonus = self:GetCaster():GetTalentValue("modifier_troll_axes_1", "cd")
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end

function troll_warlord_whirling_axes_melee_custom:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_troll_axes_1") then
	bonus = self:GetCaster():GetTalentValue("modifier_troll_axes_1", "mana")
end
return self.BaseClass.GetManaCost(self, level) + bonus
end


function troll_warlord_whirling_axes_melee_custom:LegendaryProc(index)
local caster = self:GetCaster()
if not caster:HasTalent("modifier_troll_axes_legendary") then return 0 end

local tracker = caster:FindModifierByName("modifier_troll_warlord_whirling_axes_tracker")
if not tracker then return end
if index ~= tracker:GetStackCount() then return end

caster:AddNewModifier(caster, self, "modifier_troll_warlord_whirling_axes_legendary_stack", {duration = caster:GetTalentValue("modifier_troll_axes_legendary", "duration", true), stack = tracker:GetStackCount()})
tracker:UpdateUI()
end


function troll_warlord_whirling_axes_melee_custom:ProcHit(target, stun)

local caster = self:GetCaster()

if caster:HasTalent("modifier_troll_axes_4") then
	target:AddNewModifier(caster, caster:BkbAbility(self, caster:HasScepter()), "modifier_troll_warlord_whirling_axes_melee_custom_stack", {duration = caster:GetTalentValue("modifier_troll_axes_4", "duration")})
end

end

function troll_warlord_whirling_axes_melee_custom:GetDamage()
local caster = self:GetCaster()
return self:GetSpecialValueFor("damage") + caster:GetTalentValue("modifier_troll_axes_3", "damage")*caster:GetAverageTrueAttackDamage(nil)/100
end


function troll_warlord_whirling_axes_melee_custom:OnSpellStart()
local caster = self:GetCaster()
local caster_location = caster:GetAbsOrigin()

caster:EmitSound("Hero_TrollWarlord.WhirlingAxes.Melee")
caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)

if caster:HasScepter() then
	caster:Purge(false, true, false, false, false)
end

if not caster:HasModifier("modifier_troll_warlord_berserkers_rage_custom") and not caster:HasTalent("modifier_troll_rage_legendary") then 
	local ability = caster:FindAbilityByName("troll_warlord_berserkers_rage_custom")
	if ability and ability:IsTrained() then 
		ability:ToggleAbility()
	end 
end 

if caster:HasTalent("modifier_troll_axes_3") then 
	caster:AddNewModifier(caster, self, "modifier_troll_warlord_whirling_axes_attack", {duration = caster:GetTalentValue("modifier_troll_axes_3", "duration")})
end

local whirl_duration = self:GetSpecialValueFor("whirl_duration")


if caster:HasTalent("modifier_troll_axes_legendary") then
	self:LegendaryProc(0)
end

if caster:HasTalent("modifier_troll_axes_6") then 
	caster:RemoveModifierByName("modifier_troll_warlord_whirling_axes_buff")
	caster:AddNewModifier(caster, self ,"modifier_troll_warlord_whirling_axes_buff", {duration = whirl_duration})
end

caster:AddNewModifier(caster, self, "modifier_troll_warlord_whirling_axes_melee_custom_thinker", {duration = whirl_duration, damage = damage})
end



modifier_troll_warlord_whirling_axes_melee_custom_thinker = class({})
function modifier_troll_warlord_whirling_axes_melee_custom_thinker:IsHidden() return true end
function modifier_troll_warlord_whirling_axes_melee_custom_thinker:IsPurgable() return false end
function modifier_troll_warlord_whirling_axes_melee_custom_thinker:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_troll_warlord_whirling_axes_melee_custom_thinker:OnCreated(params)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.blind_duration = self.ability:GetSpecialValueFor("blind_duration")
self.hit_radius = self.ability:GetSpecialValueFor("hit_radius")
self.max_range = self.ability:GetSpecialValueFor("max_range")
self.axe_movement_speed = self.ability:GetSpecialValueFor("axe_movement_speed")
self.whirl_duration = self.ability:GetSpecialValueFor("whirl_duration")

self.damage = self.ability:GetDamage()

self.max = 2

local start_radius = 100
local forward_vector = self.caster:GetForwardVector()
local caster_location = self.caster:GetAbsOrigin()
local front_position = caster_location + forward_vector * start_radius

self.axes = {}

for i = 1,self.max do
	local pos = GetGroundPosition(RotatePosition(caster_location, QAngle(0, 90 * i, 0), front_position), nil)
	pos.z = pos.z + 75

	self.axes[i] = CreateUnitByName("npc_dota_troll_warlord_axe", pos, false, self.caster, self.caster, self.caster:GetTeamNumber() )
	self.axes[i]:SetAbsOrigin(pos)
	self.axes[i]:AddNewModifier(self.caster, self.ability, "modifier_troll_warlord_whirling_axes_melee_custom_thinker_axe", {})
	self.axes[i].current_radius = start_radius

    local particle_name = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_troll_warlord/troll_warlord_whirling_axe_melee.vpcf", self)

	self.axes[i].particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, self.axes[i])
	ParticleManager:SetParticleControl(self.axes[i].particle, 0, self.axes[i]:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.axes[i].particle, 1, self.axes[i]:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.axes[i].particle, 4, Vector(self.whirl_duration + 0.1,0,0))
end

self.interval = 0.01
self.targets = {}
self:StartIntervalThink(self.interval)
end



function modifier_troll_warlord_whirling_axes_melee_custom_thinker:OnIntervalThink()
if not IsServer() then return end

local elapsed_time = self:GetElapsedTime()
local caster_location = self.caster:GetAbsOrigin()

for i = 1,self.max do
	if self.axes[i] and not self.axes[i]:IsNull() then

		local currentRadius	= self.axes[i].current_radius 

		local deltaRadius = self.axe_movement_speed / self.whirl_duration/2 * self.interval
		if elapsed_time >= self.whirl_duration * 0.5 then
			currentRadius = currentRadius - deltaRadius
		else
			currentRadius = currentRadius + deltaRadius
		end
		currentRadius = math.min( currentRadius, (self.max_range - self.hit_radius))
		self.axes[i].current_radius = currentRadius

		local rotation_angle = elapsed_time * 360 + -90 + 180*(i - 1)

		local relPos = Vector( 0, currentRadius, 0 )
		relPos = RotatePosition( Vector(0,0,0), QAngle( 0, -rotation_angle, 0 ), relPos )
		local absPos = GetGroundPosition( relPos + caster_location, nil )
		absPos.z = absPos.z + 75
		self.axes[i]:SetAbsOrigin( absPos )

		if self.axes[i].particle then
			ParticleManager:SetParticleControl(self.axes[i].particle, 1, absPos)
		end

		for _, unit in pairs(self.caster:FindTargets(self.hit_radius, absPos)) do
			if not self.targets[unit] then

				self.targets[unit] = true

				unit:AddNewModifier(self.caster, self.caster:BkbAbility(self.ability, self.caster:HasScepter()), "modifier_troll_warlord_whirling_axes_melee_custom", {duration = self.blind_duration})

				self.ability:ProcHit(unit)

				if self.caster:GetQuest() == "Troll.Quest_6" and unit:IsRealHero() then 
					local mod = unit:FindModifierByName("modifier_troll_warlord_whirling_axes_ranged_quest")
					if mod then 
						mod:Destroy()
						self.caster:UpdateQuest(1)
					else 
						unit:AddNewModifier(self.caster, self.ability, "modifier_troll_warlord_whirling_axes_melee_quest", {duration = self.caster.quest.number})
					end
				end

				DoDamage({victim = unit, attacker = self.caster, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability})
				unit:EmitSound("Hero_TrollWarlord.WhirlingAxes.Target")
			end
		end
	end
end

end


function modifier_troll_warlord_whirling_axes_melee_custom_thinker:OnDestroy()
if not IsServer() then return end

for i = 1, self.max do
	if self.axes[i].particle then
		ParticleManager:Delete(self.axes[i].particle, 1)
		self.axes[i].particle = nil
	end

	if self.axes[i] and not self.axes[i]:IsNull() then
		self.axes[i]:RemoveModifierByName("modifier_troll_warlord_whirling_axes_melee_custom_thinker_axe")
		UTIL_Remove(self.axes[i])
	end
end

end



modifier_troll_warlord_whirling_axes_melee_custom_thinker_axe = class({})
function modifier_troll_warlord_whirling_axes_melee_custom_thinker_axe:IsHidden() return true end
function modifier_troll_warlord_whirling_axes_melee_custom_thinker_axe:IsPurgable() return false end
function modifier_troll_warlord_whirling_axes_melee_custom_thinker_axe:OnCreated()
self.parent = self:GetParent()

end

function modifier_troll_warlord_whirling_axes_melee_custom_thinker_axe:CheckState()
return 
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_NO_HEALTH_BAR]  = true,
	[MODIFIER_STATE_OUT_OF_GAME]  = true,
	[MODIFIER_STATE_INVULNERABLE] = true  
}
end




modifier_troll_warlord_whirling_axes_melee_custom = class({})
function modifier_troll_warlord_whirling_axes_melee_custom:IsPurgable() return not self:GetCaster():HasScepter() end
function modifier_troll_warlord_whirling_axes_melee_custom:GetTexture() return "troll_warlord_whirling_axes_melee" end
function modifier_troll_warlord_whirling_axes_melee_custom:OnCreated(params)
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.damage_reduce = self.caster:GetTalentValue("modifier_troll_axes_2", "damage_reduce")

self.ability = self.caster:FindAbilityByName("troll_warlord_whirling_axes_melee_custom")
if not self.ability then self:Destroy() return end

self.miss_chance = self.ability:GetSpecialValueFor("blind_pct")

if self.parent:IsCreep() then 
	self.miss_chance = self.ability:GetSpecialValueFor("blind_creeps")
end

end


function modifier_troll_warlord_whirling_axes_melee_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MISS_PERCENTAGE,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_troll_warlord_whirling_axes_melee_custom:GetModifierMiss_Percentage()
return self.miss_chance
end

function modifier_troll_warlord_whirling_axes_melee_custom:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end

function modifier_troll_warlord_whirling_axes_melee_custom:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end





modifier_troll_warlord_whirling_axes_attack = class({})
function modifier_troll_warlord_whirling_axes_attack:IsHidden() return false end
function modifier_troll_warlord_whirling_axes_attack:IsPurgable() return true end
function modifier_troll_warlord_whirling_axes_attack:GetTexture() return "buffs/quill_cdr" end
function modifier_troll_warlord_whirling_axes_attack:OnCreated(table)
self.parent = self:GetParent()
self.speed = self.parent:GetTalentValue("modifier_troll_axes_3", "speed")
end

function modifier_troll_warlord_whirling_axes_attack:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_troll_warlord_whirling_axes_attack:GetModifierAttackSpeedBonus_Constant()
return self.speed
end





modifier_troll_warlord_whirling_axes_tracker = class({})
function modifier_troll_warlord_whirling_axes_tracker:IsHidden() return true end
function modifier_troll_warlord_whirling_axes_tracker:IsPurgable() return false end
function modifier_troll_warlord_whirling_axes_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
}
end

function modifier_troll_warlord_whirling_axes_tracker:GetModifierMagicalResistanceBonus()
return self.magic_resist
end

function modifier_troll_warlord_whirling_axes_tracker:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddRecordDestroyEvent(self)

self.magic_resist = self.parent:GetTalentValue("modifier_troll_axes_2", "magic")

self.legendary_duration = self.parent:GetTalentValue("modifier_troll_axes_legendary", "duration", true)
self.legendary_max = self.parent:GetTalentValue("modifier_troll_axes_legendary", "max", true)
self.legendary_stun = self.parent:GetTalentValue("modifier_troll_axes_legendary", "stun", true)
self.legendary_damage = self.parent:GetTalentValue("modifier_troll_axes_legendary", "damage", true)/100
self.legendary_radius = self.parent:GetTalentValue("modifier_troll_axes_legendary", "radius", true)

self.records = {}

if not IsServer() then return end 
self:SetHasCustomTransmitterData(true)
self:UpdateTalent()
end

function modifier_troll_warlord_whirling_axes_tracker:UpdateTalent(name)

if name == "modifier_troll_axes_legendary" or self.parent:HasTalent("modifier_troll_axes_legendary") then
	self.parent:AddAttackStartEvent_out(self)
	self.parent:AddAttackEvent_out(self)
end
 
self.magic_resist = self.parent:GetTalentValue("modifier_troll_axes_2", "magic")
self:SendBuffRefreshToClients()
end

function modifier_troll_warlord_whirling_axes_tracker:AddCustomTransmitterData() 
return 
{
    magic_resist = self.magic_resist,
} 
end

function modifier_troll_warlord_whirling_axes_tracker:HandleCustomTransmitterData(data)
self.magic_resist = data.magic_resist
end

function modifier_troll_warlord_whirling_axes_tracker:RecordDestroyEvent(params)
if not IsServer() then return end
if not self.records[params.record] then return end
self.records[params.record] = nil
end


function modifier_troll_warlord_whirling_axes_tracker:UpdateUI()
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_troll_axes_legendary") then return end 

local stack = 0
local active = self:GetStackCount()
local max = self.legendary_max
local mod = self.parent:FindModifierByName("modifier_troll_warlord_whirling_axes_legendary_stack")

if mod then
	stack = mod.stack
end

self.parent:UpdateUIlong({max = max, stack = stack, no_min = 1, active = active, style = "TrollAxes"})
end 

function modifier_troll_warlord_whirling_axes_tracker:AttackEvent_out(params)
if not self.parent:HasTalent("modifier_troll_axes_legendary") then return end
if self.parent ~= params.attacker then return end
if not self.records[params.record] then return end
local target = params.target

target:EmitSound("BB.Goo_stun")

local stun_pfx = wearables_system:GetParticleReplacementAbility(self.parent, "particles/generic_gameplay/generic_minibash.vpcf", self)
if stun_pfx ~= "particles/generic_gameplay/generic_minibash.vpcf" then
	local immortal_particle = ParticleManager:CreateParticle(stun_pfx, PATTACH_OVERHEAD_FOLLOW, target)
	ParticleManager:SetParticleControl(immortal_particle, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(immortal_particle, 1, self.parent:GetAbsOrigin() )
	ParticleManager:Delete(immortal_particle, 1)
else
	local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControlEnt(hit_effect, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
	ParticleManager:SetParticleControlEnt(hit_effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
	ParticleManager:Delete(hit_effect, 1)
end

local particle = ParticleManager:CreateParticle("particles/troll_hit.vpcf", PATTACH_WORLDORIGIN, nil)	
ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
ParticleManager:Delete(particle, 1)

local damage = self.ability:GetDamage()*self.legendary_damage

for _,unit in pairs(self.parent:FindTargets(self.legendary_radius, target:GetAbsOrigin())) do
	unit:ApplyStun(self, self.parent:HasScepter(), self.parent, (1 - unit:GetStatusResistance())*self.legendary_stun)
	local real_damage = DoDamage({victim = unit, attacker = self.parent, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability}, "modifier_troll_axes_legendary")
	unit:SendNumber(6, real_damage)
end

end


function modifier_troll_warlord_whirling_axes_tracker:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if not self.parent:HasTalent("modifier_troll_axes_legendary") then return end
if params.no_attack_cooldown then return end

local mod = self.parent:FindModifierByName("modifier_troll_warlord_whirling_axes_legendary_stack")
if not mod then return end

if mod:GetStackCount() == 0 then
	local tracker = self.parent:FindModifierByName("modifier_troll_warlord_berserkers_rage_tracker")
 	if not tracker or not tracker:AllowMelle() then
 		--return
 	end
end

if self:GetStackCount() == 1 and not self.parent:IsRangedAttacker() then 
	--return 
end

mod.stack = mod.stack - 1
mod:SetDuration(self.legendary_duration, true)
mod:OnRefresh()

if mod.stack <= 0 then
	mod:Destroy()

	self.records[params.record] = true
	local ability = self.ability
	local effect = "particles/sf_refresh_a.vpcf" 

	if self:GetStackCount() == 1 then
		ability = self.parent:FindAbilityByName("troll_warlord_whirling_axes_ranged_custom")
		effect = "particles/troll_warlord/refresh_ranged.vpcf"
		self:SetStackCount(0)
	else
		self:SetStackCount(1)
	end

	if ability then
		self.parent:CdAbility(ability, ability:GetCooldownTimeRemaining()*self.parent:GetTalentValue("modifier_troll_axes_legendary", "cd")/100)
		self.parent:EmitSound("Troll.Axed_cd")
		local particle = ParticleManager:CreateParticle(effect, PATTACH_CUSTOMORIGIN, self.parent)
		ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
		ParticleManager:Delete(particle, 0)
	end
end

self:UpdateUI()
end


function modifier_troll_warlord_whirling_axes_tracker:CheckState()
local mod = self.parent:FindModifierByName("modifier_troll_warlord_whirling_axes_legendary_stack")
if not mod or not mod.stack or mod.stack > 1 then return end
return
{
	[MODIFIER_STATE_CANNOT_MISS] = true
}
end



modifier_troll_warlord_whirling_axes_melee_quest = class({})
function modifier_troll_warlord_whirling_axes_melee_quest:IsHidden() return true end
function modifier_troll_warlord_whirling_axes_melee_quest:IsPurgable() return false end





modifier_troll_warlord_whirling_axes_buff = class({})
function modifier_troll_warlord_whirling_axes_buff:IsHidden() return false end
function modifier_troll_warlord_whirling_axes_buff:IsPurgable() return false end
function modifier_troll_warlord_whirling_axes_buff:GetTexture() return "buffs/Crit_blood" end
function modifier_troll_warlord_whirling_axes_buff:GetEffectName() return "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf" end
function modifier_troll_warlord_whirling_axes_buff:OnCreated(table)

self.parent = self:GetParent()

self.shield_talent = "modifier_troll_axes_6"
self.shield = self.parent:GetTalentValue("modifier_troll_axes_6", "shield")*(self.parent:GetMaxHealth() - self.parent:GetHealth())/100
self.max_shield = math.max(1,self.shield)
self.move = self.parent:GetTalentValue("modifier_troll_axes_6", "move")

if not IsServer() then return end
self:SetStackCount(self.shield)
end


function modifier_troll_warlord_whirling_axes_buff:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_troll_warlord_whirling_axes_buff:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_troll_warlord_whirling_axes_buff:GetModifierIncomingDamageConstant( params )
if self:GetStackCount() == 0 then return end

if IsClient() then 
  if params.report_max then 
  	return self.max_shield
  else 
	  return self:GetStackCount()
	end 
end

if not IsServer() then return end

self.parent:EmitSound("Juggernaut.Parry")
local particle = ParticleManager:CreateParticle( "particles/jugg_parry.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControl( particle, 1, self.parent:GetAbsOrigin() )
ParticleManager:ReleaseParticleIndex(particle)

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)


return -damage
end








modifier_troll_warlord_whirling_axes_legendary_stack = class({})
function modifier_troll_warlord_whirling_axes_legendary_stack:IsHidden() return true end
function modifier_troll_warlord_whirling_axes_legendary_stack:IsPurgable() return false end
function modifier_troll_warlord_whirling_axes_legendary_stack:OnCreated(params)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max = self.parent:GetTalentValue("modifier_troll_axes_legendary", "max")

if not IsServer() then return end

self:SetStackCount(params.stack)

local particle_cast = "particles/troll_warlord/axes_melle_stack.vpcf"
if self:GetStackCount() == 1 then
	particle_cast = "particles/troll_warlord/axes_ranged_stack.vpcf"
end

self.effect_cast = self.parent:GenericParticle(particle_cast, self, true)

self.stack = self.max
self:OnRefresh()
end

function modifier_troll_warlord_whirling_axes_legendary_stack:OnRefresh()
if not IsServer() then return end

if self.effect_cast then
	for i = 1,self.max do 
        if i <= self.stack then 
            ParticleManager:SetParticleControl(self.effect_cast, i, Vector(1, 0, 0))   
        else 
            ParticleManager:SetParticleControl(self.effect_cast, i, Vector(0, 0, 0))   
        end  
    end
end
end



function modifier_troll_warlord_whirling_axes_legendary_stack:OnDestroy()
if not IsServer() then return end
self.stack = 0
self.ability:UpdateUI()
end



modifier_troll_warlord_whirling_axes_melee_custom_stack = class({})
function modifier_troll_warlord_whirling_axes_melee_custom_stack:IsHidden() return false end
function modifier_troll_warlord_whirling_axes_melee_custom_stack:IsPurgable() return false end
function modifier_troll_warlord_whirling_axes_melee_custom_stack:GetTexture() return "buffs/axes_stack" end
function modifier_troll_warlord_whirling_axes_melee_custom_stack:OnCreated()

self.parent = self:GetParent()
self.caster = self:GetCaster()

self.max = self.caster:GetTalentValue("modifier_troll_axes_4", "max")
self.damage = self.caster:GetTalentValue("modifier_troll_axes_4", "damage")
self.heal = self.caster:GetTalentValue("modifier_troll_axes_4", "heal_reduce")

self:SetStackCount(1)
end

function modifier_troll_warlord_whirling_axes_melee_custom_stack:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()

if self:GetStackCount() >= self.max then
	self.parent:GenericParticle("particles/items4_fx/spirit_vessel_damage.vpcf", self)
	self.parent:EmitSound("Troll.Axes_stack_max")
end

end

function modifier_troll_warlord_whirling_axes_melee_custom_stack:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_troll_warlord_whirling_axes_melee_custom_stack:GetModifierIncomingDamage_Percentage(params)
if IsServer() and (not params.attacker or params.attacker:FindOwner() ~= self.caster) then return end 
return self:GetStackCount()*self.damage
end

function modifier_troll_warlord_whirling_axes_melee_custom_stack:GetModifierLifestealRegenAmplify_Percentage() 
return self:GetStackCount()*self.heal
end

function modifier_troll_warlord_whirling_axes_melee_custom_stack:GetModifierHealChange() 
return self:GetStackCount()*self.heal
end

function modifier_troll_warlord_whirling_axes_melee_custom_stack:GetModifierHPRegenAmplify_Percentage() 
return self:GetStackCount()*self.heal
end