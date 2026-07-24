--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_void_dissimilate", "abilities/void_spirit/void_spirit_dissimilate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_dissimilate_slow_thinker", "abilities/void_spirit/void_spirit_dissimilate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_dissimilate_slow", "abilities/void_spirit/void_spirit_dissimilate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_dissimilate_resist", "abilities/void_spirit/void_spirit_dissimilate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_dissimilate_heal", "abilities/void_spirit/void_spirit_dissimilate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_dissimilate_speed", "abilities/void_spirit/void_spirit_dissimilate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_dissimilate_tracker", "abilities/void_spirit/void_spirit_dissimilate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_dissimilate_legendary", "abilities/void_spirit/void_spirit_dissimilate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_dissimilate_spell", "abilities/void_spirit/void_spirit_dissimilate_custom", LUA_MODIFIER_MOTION_NONE)



void_spirit_dissimilate_custom = class({})



function void_spirit_dissimilate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/items3_fx/blink_arcane_start.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_2.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_dmg.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_exit.vpcf", context )
PrecacheResource( "particle","particles/void_astral_slow.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
PrecacheResource( "particle","particles/void_step_speed.vpcf", context )
PrecacheResource( "particle","particles/void_spirit/dissimilate_stack.vpcf", context )

end

function void_spirit_dissimilate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_void_dissimilate_tracker"
end

function void_spirit_dissimilate_custom:GetBehavior()
local bonus = DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
if self:GetCaster():HasTalent("modifier_void_astral_5") then 
  bonus = 0
end 
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + bonus
end

function void_spirit_dissimilate_custom:GetCastPoint(iLevel)
local k = 1
if self:GetCaster():HasTalent("modifier_void_astral_3") then 
    k = k + self:GetCaster():GetTalentValue("modifier_void_astral_3", "cast")/100
end
return self.BaseClass.GetCastPoint(self)*k
end

function void_spirit_dissimilate_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel)
end

function void_spirit_dissimilate_custom:GetDamage()
local caster = self:GetCaster()
return self:GetSpecialValueFor("AbilityDamage") + caster:GetTalentValue("modifier_void_astral_1", "damage")*caster:GetIntellect(false)/100
end


function void_spirit_dissimilate_custom:OnSpellStart()

local caster = self:GetCaster()
local duration = self:GetSpecialValueFor( "phase_duration" )

if caster:HasTalent("modifier_void_astral_legendary") then 
	duration = caster:GetTalentValue("modifier_void_astral_legendary", "duration")
end

caster:AddNewModifier(caster, self, "modifier_custom_void_dissimilate",{ duration = duration })
caster:EmitSound("Hero_VoidSpirit.Dissimilate.Cast")

if caster:HasTalent("modifier_void_astral_3") then 
	local effect = ParticleManager:CreateParticle("particles/items3_fx/blink_arcane_start.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, caster:GetAbsOrigin())
	ParticleManager:Delete(effect, 1)
end

end




modifier_custom_void_dissimilate = class({})
function modifier_custom_void_dissimilate:IsHidden() return false end
function modifier_custom_void_dissimilate:IsPurgable() return false end
function modifier_custom_void_dissimilate:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.portals = self.ability:GetSpecialValueFor( "portals_per_ring" )
self.angle = self.ability:GetSpecialValueFor( "angle_per_ring_portal" )
self.radius = self.ability:GetSpecialValueFor( "damage_radius" )
self.distance = self.ability:GetSpecialValueFor( "first_ring_distance_offset" )
self.target_radius = self.ability:GetSpecialValueFor( "destination_fx_radius" )

self.RemoveForDuel = true

if not IsServer() then return end

self.ability:EndCd()
self.parent:AddOrderEvent(self)

if self.parent:HasTalent("modifier_void_astral_legendary") and not self.ability:IsHidden() then 
	self.parent:SwapAbilities("void_spirit_dissimilate_custom_cancel", "void_spirit_dissimilate_custom", true, false)
	local ability = self.parent:FindAbilityByName("void_spirit_dissimilate_custom_cancel")
	if ability then 
		ability:StartCooldown(0.3)
	end
end

local origin = self.parent:GetOrigin()
local direction = self.parent:GetForwardVector()
local zero = Vector(0,0,0)

self.selected = 1

self.points = {}
self.effects = {}
self.thinkers = {}

table.insert( self.points, origin )
table.insert( self.effects, self:PlayEffects1( origin, true ) )

if self.parent:HasTalent("modifier_void_astral_5") then 
	local thinker = CreateModifierThinker(self.parent, self.ability, "modifier_custom_void_dissimilate_slow_thinker", {radius = self.radius}, origin, self.parent:GetTeamNumber(), false)
	table.insert( self.thinkers, thinker )	
end

for i=1,self.portals do
	local new_direction = RotatePosition( zero, QAngle( 0, self.angle*i, 0 ), direction )

	local point = GetGroundPosition( origin + new_direction * self.distance, nil )

	table.insert( self.points, point )
	table.insert( self.effects, self:PlayEffects1( point, false ) )
	AddFOWViewer(self.parent:GetTeamNumber(), point, self.radius, self:GetRemainingTime(), false)

	if self.parent:HasTalent("modifier_void_astral_5") then 
		local thinker = CreateModifierThinker(self.parent, self.ability, "modifier_custom_void_dissimilate_slow_thinker", {radius = self.radius}, point, self.parent:GetTeamNumber(), false)
		table.insert( self.thinkers, thinker )	
	end
end

if self.parent:HasTalent("modifier_void_astral_5") then 
	for i=1,self.portals do
		local new_direction = RotatePosition( zero, QAngle( 0, self.angle*i, 0 ), direction )

		local point = GetGroundPosition( origin + new_direction * self.distance*2, nil )

		table.insert( self.points, point )
		table.insert( self.effects, self:PlayEffects1( point, false ) )
		AddFOWViewer(self.parent:GetTeamNumber(), point, self.radius, self:GetRemainingTime(), false)

		local thinker = CreateModifierThinker(self.parent, self.ability, "modifier_custom_void_dissimilate_slow_thinker", {radius = self.radius}, point, self.parent:GetTeamNumber(), false)
		table.insert( self.thinkers, thinker )	
	end
end


self.parent:NoDraw(self)
self.parent:AddNoDraw()

if self.parent:HasTalent("modifier_void_astral_legendary") then
	self:StartIntervalThink(self.parent:GetTalentValue("modifier_void_astral_legendary", "interval")  - FrameTime())
end

end

function modifier_custom_void_dissimilate:OnIntervalThink()
if not IsServer() then return end
self:IncrementStackCount()
end


function modifier_custom_void_dissimilate:OnDestroy()
if not IsServer() then return end

self.parent:RemoveNoDraw()

if self.parent:HasTalent("modifier_void_astral_legendary") and self.ability:IsHidden() then 
	self.parent:SwapAbilities("void_spirit_dissimilate_custom_cancel", "void_spirit_dissimilate_custom", false, true)
end

for _,effect in pairs(self.effects) do 
	local insta = 1
	if self:GetRemainingTime() > 0.1 then
		insta = 2
	end
	ParticleManager:Delete(effect, insta)
end

local stun_duration = self.parent:GetTalentValue("modifier_void_astral_4", "stun")
local point = self.points[self.selected]
local damage = self.ability:GetDamage()
local old_pos = self.parent:GetAbsOrigin()

FindClearSpaceForUnit(self.parent, point, true )

for _,thinker in pairs(self.thinkers) do 
	UTIL_Remove( thinker )
end

local legendary_duration = self.parent:GetTalentValue("modifier_void_astral_legendary", "effect_duration")
local hit_heroes = false

local enemies = self.parent:FindTargets(self.radius, point)
for _,enemy in pairs(enemies) do

	if enemy:IsRealHero() then
		hit_heroes = true
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_void_dissimilate_spell", {})
		if self.parent:GetQuest() == "Void.Quest_6" and point == old_pos then 
			self.parent:UpdateQuest(1)
		end
	end

	local step = self.parent:FindAbilityByName("void_spirit_astral_step_custom")
	if step then
		step:AutoStack(enemy)
	end

	if self:GetStackCount() > 0 then
		enemy:AddNewModifier(self.parent, self.ability, "modifier_custom_void_dissimilate_legendary", {duration = legendary_duration, stack = self:GetStackCount()})
	end

	if self.parent:HasTalent("modifier_void_astral_4") then 
		enemy:AddNewModifier(self.parent, self.ability, "modifier_stunned", {duration = (1 - enemy:GetStatusResistance())*stun_duration})
	end

	DoDamage({ victim = enemy, attacker = self.parent, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability, })
end


if #enemies > 0 then
	local shield = self.parent:FindAbilityByName("void_spirit_resonant_pulse_custom")
	if shield then
		shield:LegendaryStack()
	end

	if self.parent:HasTalent("modifier_void_astral_6") then
		self.parent:CdItems(self.parent:GetTalentValue("modifier_void_astral_6", "cd_items"))
	end
end

if self.parent:HasTalent("modifier_void_astral_3") then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_void_dissimilate_speed", {duration = self.parent:GetTalentValue("modifier_void_astral_3", "duration")})
end

self.ability:StartCd()
self:PlayEffects2( point, #enemies )


if hit_heroes == false and self.parent:HasTalent("modifier_void_astral_6") then
	self.parent:CdAbility(self.ability, self.parent:GetTalentValue("modifier_void_astral_6", "cd_self"))
end

end



function modifier_custom_void_dissimilate:OrderEvent( params)

if params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION then
	self:SetValidTarget( params.pos )
elseif 
	(params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
	params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target
then
	self:SetValidTarget( params.target:GetOrigin() )
end

end


function modifier_custom_void_dissimilate:CheckState()
local state = 
{
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_ROOTED] = true,
	[MODIFIER_STATE_OUT_OF_GAME] = true,
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true
}

if not self.parent:HasTalent("modifier_void_astral_legendary") then
	state[MODIFIER_STATE_MUTED] = true
	state[MODIFIER_STATE_SILENCED] = true
end

return state
end

function modifier_custom_void_dissimilate:SetValidTarget( location )
local max_dist = (location-self.points[1]):Length2D()
local max_point = 1
for i,point in pairs(self.points) do
	local dist = (location-point):Length2D()
	if dist<max_dist then
		max_dist = dist
		max_point = i
	end
end

local old_select = self.selected
self.selected = max_point
self:ChangeEffects( old_select, self.selected )
end


function modifier_custom_void_dissimilate:PlayEffects1( point, main )
local particle_cast = "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate.vpcf"
if self.parent:HasTalent("modifier_void_astral_legendary") then 
	particle_cast = "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_2.vpcf"
end
local radius = self.radius + 25

local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self.parent)
ParticleManager:SetParticleControl( effect_cast, 0, point )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 0, 1 ) )

if main then
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, 0, 0 ) )
end

self:AddParticle(effect_cast, false, false, -1,false, false )
EmitSoundOnLocationWithCaster( point, "Hero_VoidSpirit.Dissimilate.Portals", self.parent )

return effect_cast
end

function modifier_custom_void_dissimilate:ChangeEffects( old, new )
	ParticleManager:SetParticleControl( self.effects[old], 2, Vector( 0, 0, 0 ) )
	ParticleManager:SetParticleControl( self.effects[new], 2, Vector( 1, 0, 0 ) )
end


function modifier_custom_void_dissimilate:PlayEffects2( point, hit )
local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_dmg.vpcf", PATTACH_WORLDORIGIN, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, point )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.target_radius, 0, 0 ) )
ParticleManager:Delete( effect_cast, 0 )

effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_exit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:Delete( effect_cast, 0 )

self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
self.parent:EmitSound("Hero_VoidSpirit.Dissimilate.TeleportIn")

if hit>0 then
	self.parent:EmitSound("Hero_VoidSpirit.Dissimilate.Stun")
end

end







modifier_custom_void_dissimilate_tracker = class({})
function modifier_custom_void_dissimilate_tracker:IsHidden() return true end
function modifier_custom_void_dissimilate_tracker:IsPurgable() return false end
function modifier_custom_void_dissimilate_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.resist_duration = self.parent:GetTalentValue("modifier_void_astral_1", "duration", true)

self.heal_duration = self.parent:GetTalentValue("modifier_void_astral_2", "duration", true)

self.legendary_damage = self.parent:GetTalentValue("modifier_void_astral_legendary", "damage", true)/100
self.legendary_radius = self.parent:GetTalentValue("modifier_void_astral_legendary", "radius", true)

self.cdr = self.parent:GetTalentValue("modifier_void_astral_6", "cdr", true)
if not IsServer() then return end
self:UpdateTalent()
end

function modifier_custom_void_dissimilate_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end

function modifier_custom_void_dissimilate_tracker:GetModifierPercentageCooldown()
if not self.parent:HasTalent("modifier_void_astral_6") then return end 
return self.cdr
end


function modifier_custom_void_dissimilate_tracker:UpdateTalent(name)

if name == "modifier_void_astral_1" or self.parent:HasTalent("modifier_void_astral_1") then
	self.parent:AddAttackEvent_out(self)
end

if name == "modifier_void_astral_legendary" or self.parent:HasTalent("modifier_void_astral_legendary") then
	self.parent:AddAttackEvent_out(self)
end

if name == "modifier_void_astral_2" or self.parent:HasTalent("modifier_void_astral_2") then
	self.parent:AddSpellEvent(self)
end

end


function modifier_custom_void_dissimilate_tracker:SpellEvent(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_void_astral_2") then return end
if params.unit~=self.parent then return end
if params.ability:IsItem() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_void_dissimilate_heal", {duration = self.heal_duration})
end


function modifier_custom_void_dissimilate_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local target = params.target

if self.parent:HasTalent("modifier_void_astral_1") then
	target:AddNewModifier(self.parent, self.ability, "modifier_custom_void_dissimilate_resist", {duration = self.resist_duration})
end

if self.parent:HasTalent("modifier_void_astral_legendary") and target:HasModifier("modifier_custom_void_dissimilate_legendary") then	
	target:EmitSound("Hero_VoidSpirit.Dissimilate.Stun")
	if params.no_attack_cooldown then
		self:LegendaryProc(target)
	else
		for _,unit in pairs(self.parent:FindTargets(self.legendary_radius, target:GetAbsOrigin())) do
			self:LegendaryProc(unit)
		end
	end
end


end

function modifier_custom_void_dissimilate_tracker:LegendaryProc(target)
if not IsServer() then return end

local mod = target:FindModifierByName("modifier_custom_void_dissimilate_legendary")
if mod then
	mod:DecrementStackCount()
	if mod:GetStackCount() <= 0 then
		mod:Destroy()
	end

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_dmg.vpcf", PATTACH_WORLDORIGIN, target )
	ParticleManager:SetParticleControl( effect_cast, 0, target:GetAbsOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 100, 0, 0 ) )
	ParticleManager:Delete( effect_cast, 0 )

	effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_exit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:Delete( effect_cast, 0 )

	
	local real_damage = DoDamage({victim = target, attacker = self.parent, ability = self.ability, damage = self.ability:GetDamage()*self.legendary_damage, damage_type = DAMAGE_TYPE_MAGICAL}, "modifier_void_astral_legendary")
end

end



modifier_custom_void_dissimilate_slow_thinker = class({})
function modifier_custom_void_dissimilate_slow_thinker:IsHidden() return true end
function modifier_custom_void_dissimilate_slow_thinker:IsPurgable() return false end
function modifier_custom_void_dissimilate_slow_thinker:IsAura() return true end
function modifier_custom_void_dissimilate_slow_thinker:GetAuraDuration() return 0.2 end
function modifier_custom_void_dissimilate_slow_thinker:GetAuraRadius() return self.radius end
function modifier_custom_void_dissimilate_slow_thinker:OnCreated(table)
self.radius = table.radius
end

function modifier_custom_void_dissimilate_slow_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_custom_void_dissimilate_slow_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO +  DOTA_UNIT_TARGET_BASIC end
function modifier_custom_void_dissimilate_slow_thinker:GetModifierAura() return "modifier_custom_void_dissimilate_slow" end



modifier_custom_void_dissimilate_slow = class({})
function modifier_custom_void_dissimilate_slow:IsPurgable() return true end
function modifier_custom_void_dissimilate_slow:IsHidden() return false end 
function modifier_custom_void_dissimilate_slow:GetEffectName() return "particles/void_astral_slow.vpcf" end
function modifier_custom_void_dissimilate_slow:DeclareFunctions()
return
{
 MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_custom_void_dissimilate_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_void_astral_5", "slow")
end

function modifier_custom_void_dissimilate_slow:GetModifierMoveSpeedBonus_Percentage() 
return self.slow
end





void_spirit_dissimilate_custom_cancel = class({})


function void_spirit_dissimilate_custom_cancel:OnSpellStart()
if not IsServer() then return end

local mod = self:GetCaster():FindModifierByName("modifier_custom_void_dissimilate")

if not mod then return end

mod:Destroy()

end





modifier_custom_void_dissimilate_heal = class({})
function modifier_custom_void_dissimilate_heal:IsHidden() return false end
function modifier_custom_void_dissimilate_heal:IsPurgable() return false end
function modifier_custom_void_dissimilate_heal:GetTexture() return "buffs/arcane_regen" end
function modifier_custom_void_dissimilate_heal:GetEffectName() return "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf" end
function modifier_custom_void_dissimilate_heal:OnCreated(table)
self.parent = self:GetParent()
self.heal = self.parent:GetMaxMana()*(self.parent:GetTalentValue("modifier_void_astral_2", "mana")/100)/self.parent:GetTalentValue("modifier_void_astral_2", "duration")
end

function modifier_custom_void_dissimilate_heal:OnRefresh(table)
self:OnCreated(table)
end


function modifier_custom_void_dissimilate_heal:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
  MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
}
end

function modifier_custom_void_dissimilate_heal:GetModifierConstantManaRegen()
return self.heal
end
function modifier_custom_void_dissimilate_heal:GetModifierConstantHealthRegen()
return self.heal
end




modifier_custom_void_dissimilate_speed = class({})
function modifier_custom_void_dissimilate_speed:IsHidden() return false end
function modifier_custom_void_dissimilate_speed:IsPurgable() return false end
function modifier_custom_void_dissimilate_speed:GetTexture() return "buffs/remnant_speed" end
function modifier_custom_void_dissimilate_speed:GetEffectName() return "particles/void_step_speed.vpcf" end

function modifier_custom_void_dissimilate_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_custom_void_dissimilate_speed:GetModifierMoveSpeedBonus_Percentage()
return self.speed
end

function modifier_custom_void_dissimilate_speed:OnCreated()
self.speed = self:GetCaster():GetTalentValue("modifier_void_astral_3", "speed")
end



modifier_custom_void_dissimilate_resist = class({})
function modifier_custom_void_dissimilate_resist:IsHidden() return false end
function modifier_custom_void_dissimilate_resist:IsPurgable() return true end
function modifier_custom_void_dissimilate_resist:GetTexture() return "buffs/remnant_lowhp" end
function modifier_custom_void_dissimilate_resist:OnCreated()
self.max = self:GetCaster():GetTalentValue("modifier_void_astral_1", "max")
self.magic = self:GetCaster():GetTalentValue("modifier_void_astral_1", "resist")
if not IsServer() then return end 
self:SetStackCount(1)
end 

function modifier_custom_void_dissimilate_resist:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()
end 

function modifier_custom_void_dissimilate_resist:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_custom_void_dissimilate_resist:GetModifierMagicalResistanceBonus()
return self:GetStackCount()*self.magic
end





modifier_custom_void_dissimilate_legendary = class({})
function modifier_custom_void_dissimilate_legendary:IsHidden() return true end
function modifier_custom_void_dissimilate_legendary:IsPurgable() return false end
function modifier_custom_void_dissimilate_legendary:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

if not IsServer() then return end 
self.effect = self.parent:GenericParticle("particles/void_spirit/dissimilate_stack.vpcf", self, true)
self:SetStackCount(table.stack)
end

function modifier_custom_void_dissimilate_legendary:OnStackCountChanged(iStackCount)
if not self.effect then return end
ParticleManager:SetParticleControl( self.effect, 1, Vector( 0, self:GetStackCount(), 0 ) )
end




modifier_custom_void_dissimilate_spell = class({})
function modifier_custom_void_dissimilate_spell:IsHidden() return not self:GetCaster():HasTalent("modifier_void_astral_4") end
function modifier_custom_void_dissimilate_spell:IsPurgable() return false end
function modifier_custom_void_dissimilate_spell:RemoveOnDeath() return false end
function modifier_custom_void_dissimilate_spell:GetTexture() return "buffs/void_speed" end
function modifier_custom_void_dissimilate_spell:OnCreated()
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_void_astral_4", "max", true)
self.damage = self.parent:GetTalentValue("modifier_void_astral_4", "damage")

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)

self:SetHasCustomTransmitterData(true)
self:UpdateTalent()
end

function modifier_custom_void_dissimilate_spell:UpdateTalent(name)
self.damage = self.parent:GetTalentValue("modifier_void_astral_4", "damage")
self:SendBuffRefreshToClients()
end

function modifier_custom_void_dissimilate_spell:AddCustomTransmitterData() 
return 
{
  damage = self.damage,
} 
end

function modifier_custom_void_dissimilate_spell:HandleCustomTransmitterData(data)
self.damage = data.damage
end

function modifier_custom_void_dissimilate_spell:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()
end

function modifier_custom_void_dissimilate_spell:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self.parent:HasTalent("modifier_void_astral_4") then return end

self.parent:GenericParticle("particles/void_buf2.vpcf")

self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 


function modifier_custom_void_dissimilate_spell:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_custom_void_dissimilate_spell:GetModifierSpellAmplify_Percentage()
if not self.parent:HasTalent("modifier_void_astral_4") then return end
return self:GetStackCount()*self.damage/self.max
end