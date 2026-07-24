--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_primal_beast_uproar_custom", "abilities/primal_beast/primal_beast_uproar_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_uproar_custom_buff", "abilities/primal_beast/primal_beast_uproar_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_uproar_custom_debuff", "abilities/primal_beast/primal_beast_uproar_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_uproar_custom_legendary", "abilities/primal_beast/primal_beast_uproar_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_uproar_custom_root", "abilities/primal_beast/primal_beast_uproar_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_uproar_custom_proc", "abilities/primal_beast/primal_beast_uproar_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_uproar_custom_shield", "abilities/primal_beast/primal_beast_uproar_custom", LUA_MODIFIER_MOTION_NONE )

primal_beast_uproar_custom = class({})



function primal_beast_uproar_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_meepo/meepo_ransack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_roar_aoe.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_roar.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_uproar_magic_resist.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_primal_beast/primal_beast_status_effect_slow.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_legion_commander_duel.vpcf", context )
PrecacheResource( "particle","particles/beast_grave.vpcf", context )
PrecacheResource( "particle","particles/beast_hands.vpcf", context )
PrecacheResource( "particle","particles/items_fx/black_king_bar_avatar.vpcf", context )
PrecacheResource( "particle","particles/beast_root.vpcf", context )
PrecacheResource( "particle","particles/beast_proc.vpcf", context )
PrecacheResource( "particle","particles/beast_blood.vpcf", context )
PrecacheResource( "particle","particles/jugg_parry.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_bloodrage.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_beserkers_call.vpcf", context )
PrecacheResource( "particle","particles/primal_beast/uproar_legendary.vpcf", context )
end


function primal_beast_uproar_custom:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_primal_beast_uproar_6") then 
	bonus = DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL + bonus
end

function primal_beast_uproar_custom:GetCastRange(vLocation, hTarget)
local caster = self:GetCaster()
local radius = self:GetSpecialValueFor("radius")
if caster:HasTalent("modifier_primal_beast_uproar_5") then 
	radius = caster:GetTalentValue("modifier_primal_beast_uproar_5", "radius")
end
return radius - caster:GetCastRangeBonus()
end

function primal_beast_uproar_custom:GetAbilityTextureName(  )
local stack = self:GetCaster():GetModifierStackCount( "modifier_primal_beast_uproar_custom", self:GetCaster() )
if stack==0 then
	return "primal_beast_uproar_none"
elseif stack >= self:GetSpecialValueFor("stack_limit") then
	return "primal_beast_uproar_max"
else
	return "primal_beast_uproar_mid"
end

end

function primal_beast_uproar_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_primal_beast_uproar_custom"
end

function primal_beast_uproar_custom:CastFilterResult()
if self:GetCaster():GetModifierStackCount( "modifier_primal_beast_uproar_custom", self:GetCaster() ) < 1 then
	return UF_FAIL_CUSTOM
end
if self:GetCaster():HasModifier("modifier_primal_beast_uproar_custom_buff") then
	return UF_FAIL_CUSTOM
end
return UF_SUCCESS
end

function primal_beast_uproar_custom:GetCustomCastError( hTarget )
if self:GetCaster():GetModifierStackCount( "modifier_primal_beast_uproar_custom", self:GetCaster() ) < 1 then
	return "#dota_hud_error_no_uproar_stacks"
end
if self:GetCaster():HasModifier("modifier_primal_beast_uproar_custom_buff") then
	return "#dota_hud_error_already_roared"
end
return ""
end


function primal_beast_uproar_custom:OnSpellStart()

local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("roar_duration") + caster:GetTalentValue("modifier_primal_beast_uproar_2", "duration")
local radius = self:GetSpecialValueFor("radius")
local slow = self:GetSpecialValueFor("slow_duration") + caster:GetTalentValue("modifier_primal_beast_uproar_2", "duration")

local stack = 0
local modifier = caster:FindModifierByName( "modifier_primal_beast_uproar_custom" )
if modifier then
	stack = modifier:GetStackCount()
	modifier:ResetStack()
end

local ult = caster:FindAbilityByName("primal_beast_pulverize_custom")
local ult_stack = caster:GetTalentValue("modifier_primal_beast_pulverize_7", "uproar", true)

if ult and stack >= ult_stack and ult:IsTrained() then 
	ult:AddLegendaryStack()
end 

if caster:HasTalent("modifier_primal_beast_uproar_6") then 
	caster:Purge(false, true, false, false, false)
	caster:AddNewModifier(caster, self, "modifier_primal_beast_uproar_custom_shield", {duration = caster:GetTalentValue("modifier_primal_beast_uproar_6", "duration")})
end

self:StartCooldown(duration)
caster:RemoveModifierByName("modifier_primal_beast_uproar_custom_buff")
caster:AddNewModifier( caster, self, "modifier_primal_beast_uproar_custom_buff", { duration = duration, stack = stack } )

local pull_duration = caster:GetTalentValue("modifier_primal_beast_uproar_5", "pull_duration")
local root_duration = caster:GetTalentValue("modifier_primal_beast_uproar_5", "root")
local pull_radius = caster:GetTalentValue("modifier_primal_beast_uproar_5", "radius")

local damage = caster:GetTalentValue("modifier_primal_beast_uproar_3", "cast_damage")
local damageTable = {attacker = caster, ability = self, damage = damage*stack, damage_type = DAMAGE_TYPE_MAGICAL}
local caster_loc = caster:GetAbsOrigin()

for _,enemy in pairs(caster:FindTargets(radius)) do

	if caster:HasTalent("modifier_primal_beast_uproar_3") then 
		damageTable.victim = enemy
		DoDamage(damageTable, "modifier_primal_beast_uproar_3")
	end

	if ult and ult:IsTrained() and stack >= ult_stack then 
		ult:AddStrStack(enemy)
	end

	if caster:HasTalent("modifier_primal_beast_uproar_5") then 

		enemy:Purge(true, false, false, false, false)

		if (enemy:GetAbsOrigin() - caster_loc):Length2D() <= pull_radius then 

			local dir = (caster_loc -  enemy:GetAbsOrigin()):Normalized()
			local point = caster_loc - dir*100

			local distance = (point - enemy:GetAbsOrigin()):Length2D()

			distance = math.max(100, distance)
			point = enemy:GetAbsOrigin() + dir*distance

			local arc = enemy:AddNewModifier( caster,  self,  "modifier_generic_arc",  
			{
			  target_x = point.x,
			  target_y = point.y,
			  distance = distance,
			  duration = pull_duration,
			  height = 0,
			  fix_end = false,
			  isStun = false,
			  activity = ACT_DOTA_FLAIL,
			})

			if arc then 
			  	arc:SetEndCallback(function()
			  		if enemy and not enemy:IsNull() then		
			  			enemy:EmitSound("PBeast.Uproar_root")
						enemy:AddNewModifier(caster, self, "modifier_primal_beast_uproar_custom_root", {duration = root_duration*(1 - enemy:GetStatusResistance()), stack = stack })
					end
				end)
			end  
		else 
  			enemy:EmitSound("PBeast.Uproar_root")
			enemy:AddNewModifier(caster, self, "modifier_primal_beast_uproar_custom_root", {duration = root_duration*(1 - enemy:GetStatusResistance()), stack = stack })
		end
	else 
		enemy:AddNewModifier( caster, self, "modifier_primal_beast_uproar_custom_debuff", { duration = slow*(1 - enemy:GetStatusResistance()), stack = stack } )
	end
end

self:PlayEffects( radius )
self:PlayEffects2()
end


function primal_beast_uproar_custom:PlayEffects( radius )
local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_roar_aoe.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
self:GetCaster():EmitSound("Hero_PrimalBeast.Uproar.Cast")
end

function primal_beast_uproar_custom:PlayEffects2()
local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_roar.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster() )
ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_jaw_fx", Vector(0,0,0), true )
ParticleManager:ReleaseParticleIndex( effect_cast )
end




modifier_primal_beast_uproar_custom = class({})

function modifier_primal_beast_uproar_custom:IsHidden() return self:GetStackCount() < 1 end
function modifier_primal_beast_uproar_custom:IsPurgable() return false end
function modifier_primal_beast_uproar_custom:RemoveOnDeath() return false end
function modifier_primal_beast_uproar_custom:DestroyOnExpire() return false end
function modifier_primal_beast_uproar_custom:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddRecordDestroyEvent(self)
self.parent:AddDamageEvent_inc(self)
self.parent:AddDamageEvent_out(self)
self.parent:AddAttackEvent_out(self)
self.parent:AddSpellEvent(self)

self.damage_count = 0
self.damage_attack_count = 0

self.damage_limit = self.ability:GetSpecialValueFor( "damage_limit" )
self.stack_limit = self.ability:GetSpecialValueFor( "stack_limit" )
self.duration = self.ability:GetSpecialValueFor( "stack_duration" )

self.records = {}

self.status_resist = self.parent:GetTalentValue("modifier_primal_beast_uproar_2", "status")

self.legendary_max = self.parent:GetTalentValue("modifier_primal_beast_uproar_7", "max", true)

self.speed_duration = self.parent:GetTalentValue("modifier_primal_beast_uproar_4", "duration", true)
self.heal_creeps = self.parent:GetTalentValue("modifier_primal_beast_uproar_4", "creeps", true)
self.speed_heal = self.parent:GetTalentValue("modifier_primal_beast_uproar_4", "heal", true)/100
self.speed_stun = self.parent:GetTalentValue("modifier_primal_beast_uproar_4", "stun", true)
if not IsServer() then return end
self:SetHasCustomTransmitterData(true)
self:UpdateTalent()
end

function modifier_primal_beast_uproar_custom:OnRefresh( kv )
self.damage = self.ability:GetSpecialValueFor( "bonus_damage" )
end

function modifier_primal_beast_uproar_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_primal_beast_uproar_custom:GetModifierStatusResistanceStacking()
return self.status_resist
end

function modifier_primal_beast_uproar_custom:UpdateTalent(name)
self.status_resist = self.parent:GetTalentValue("modifier_primal_beast_uproar_2", "status")
self:SendBuffRefreshToClients()
end


function modifier_primal_beast_uproar_custom:AddCustomTransmitterData() 
return 
{
  status_resist = self.status_resist,
} 
end

function modifier_primal_beast_uproar_custom:HandleCustomTransmitterData(data)
self.status_resist = data.status_resist
end




function modifier_primal_beast_uproar_custom:RecordDestroyEvent(params)
if not IsServer() then return end
if not self.records[params.record] then return end

self.records[params.record] = nil
end



function modifier_primal_beast_uproar_custom:SpellEvent(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_primal_beast_uproar_4") then return end
if params.unit~=self.parent then return end
if params.ability:IsItem() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_primal_beast_uproar_custom_proc", {duration = self.speed_duration})
end


function modifier_primal_beast_uproar_custom:AttackEvent_out(params)
if not IsServer() then return end 
if self.parent ~= params.attacker then return end 
if not params.target:IsUnit() then return end 


local speed_mod = self.parent:FindModifierByName("modifier_primal_beast_uproar_custom_proc")
if speed_mod then
	speed_mod:DecrementStackCount()
	if speed_mod:GetStackCount() <= 0 then
		speed_mod:Destroy()
	end
	self.records[params.record] = true
end

local mod = self.parent:FindModifierByName("modifier_primal_beast_uproar_custom_legendary")
if mod then 
	if self:GetStackCount() < self:GetMax() then
		self:IncrementStackCount()
	end
	self:SetDuration( self.duration, true )
	self:StartIntervalThink(self.duration)
end

end


function modifier_primal_beast_uproar_custom:DamageEvent_out(params)
if not IsServer() then return end

if params.record and self.records[params.record] and self.parent:CheckLifesteal(params, 2) then 
	local heal = params.damage*self.speed_heal
	if params.unit:IsCreep() then 
		heal = heal/self.heal_creeps
	end
	self.parent:GenericHeal(heal, self.ability, false, nil, "modifier_primal_beast_uproar_4")
	params.unit:EmitSound("PBeast.Uproar_proc_attack")
	params.unit:AddNewModifier(self.parent, self.parent:BkbAbility(nil, true), "modifier_bashed", {duration = self.speed_stun*(1 - params.unit:GetStatusResistance())})
end

end

function modifier_primal_beast_uproar_custom:DamageEvent_inc(params)
if not IsServer() then return end
if params.unit ~= self.parent then return end
if not params.attacker:IsUnit() then return end

local damage = params.damage
local stack_limit = self:GetMax()

local final = self.damage_count + damage

if final >= self.damage_limit then 

	local delta = math.floor(final/self.damage_limit)

  for i = 1, delta do 
		if not self.parent:HasModifier( "modifier_primal_beast_uproar_custom_buff" ) or self.parent:HasModifier("modifier_primal_beast_uproar_custom_legendary") then

			if self:GetStackCount() < stack_limit then
				self:IncrementStackCount()
				if self:GetStackCount() == self.stack_limit then
					self.parent:EmitSound("Hero_PrimalBeast.Uproar.MaxStacks")
				end
			end
			self:SetDuration( self.duration, true )
			self:StartIntervalThink(self.duration)
		end
	end

	self.damage_count = final - delta*self.damage_limit
else 
  self.damage_count = final
end 

end


function modifier_primal_beast_uproar_custom:GetMax()
local stack_limit = self.stack_limit
	
if self.parent:HasModifier("modifier_primal_beast_uproar_custom_legendary") then 
	stack_limit = self.legendary_max
end

return stack_limit
end


function modifier_primal_beast_uproar_custom:OnIntervalThink()
self:ResetStack()
end

function modifier_primal_beast_uproar_custom:ResetStack()
self:SetStackCount(0)
self:StartIntervalThink(-1)
end




modifier_primal_beast_uproar_custom_buff = class({})
function modifier_primal_beast_uproar_custom_buff:IsPurgable() return false end
function modifier_primal_beast_uproar_custom_buff:IsHidden() return false end
function modifier_primal_beast_uproar_custom_buff:GetTexture() return "primal_beast_uproar" end

function modifier_primal_beast_uproar_custom_buff:OnCreated( kv )
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.magic_max = self.caster:GetTalentValue("modifier_primal_beast_uproar_1", "max")
self.magic = self.caster:GetTalentValue("modifier_primal_beast_uproar_1", "magic")
self.movespeed = self.caster:GetTalentValue("modifier_primal_beast_uproar_1", "movespeed")

self.damage = self.ability:GetSpecialValueFor( "bonus_damage_per_stack" ) + self.parent:GetTalentValue("modifier_primal_beast_uproar_3", "damage")
self.armor = self.ability:GetSpecialValueFor( "roared_bonus_armor" )
if not IsServer() then return end
self:SetStackCount(kv.stack)
self:PlayEffects()
end


function modifier_primal_beast_uproar_custom_buff:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_primal_beast_uproar_custom_buff:GetModifierPreAttack_BonusDamage()
return self.damage * self:GetStackCount()
end

function modifier_primal_beast_uproar_custom_buff:GetModifierMagicalResistanceBonus()
if not self.caster:HasTalent("modifier_primal_beast_uproar_1") then return end
return self.magic * math.min(self:GetStackCount(), self.magic_max)
end

function modifier_primal_beast_uproar_custom_buff:GetModifierMoveSpeedBonus_Percentage()
if not self.caster:HasTalent("modifier_primal_beast_uproar_1") then return end
return self.movespeed * math.min(self:GetStackCount(), self.magic_max)
end

function modifier_primal_beast_uproar_custom_buff:GetModifierPhysicalArmorBonus()
return self.armor * self:GetStackCount()
end

function modifier_primal_beast_uproar_custom_buff:PlayEffects()
local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_uproar_magic_resist.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
ParticleManager:SetParticleControlEnt( effect_cast, 2, self:GetParent(), PATTACH_OVERHEAD_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
self:AddParticle( effect_cast, false, false, -1, false, false )
end





modifier_primal_beast_uproar_custom_debuff = class({})

function modifier_primal_beast_uproar_custom_debuff:IsHidden() return false end
function modifier_primal_beast_uproar_custom_debuff:IsPurgable() return true end
function modifier_primal_beast_uproar_custom_debuff:GetTexture() return "primal_beast_uproar" end

function modifier_primal_beast_uproar_custom_debuff:OnCreated( kv )
self.ability = self:GetAbility()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.slow = -self.ability:GetSpecialValueFor( "move_slow_per_stack" )
if not IsServer() then return end
self:SetStackCount(kv.stack)
end

function modifier_primal_beast_uproar_custom_debuff:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_primal_beast_uproar_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.slow * self:GetStackCount()
end

function modifier_primal_beast_uproar_custom_debuff:GetStatusEffectName()
return "particles/units/heroes/hero_primal_beast/primal_beast_status_effect_slow.vpcf"
end

function modifier_primal_beast_uproar_custom_debuff:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL
end









primal_beast_blood_frenzy_custom = class({})

function primal_beast_blood_frenzy_custom:CreateTalent()
self:SetHidden(false)
end

function primal_beast_blood_frenzy_custom:GetCooldown(iLevel)
return self:GetCaster():GetTalentValue("modifier_primal_beast_uproar_7", "cd")
end

function primal_beast_blood_frenzy_custom:OnSpellStart()
local caster = self:GetCaster()

caster:EmitSound("PBeast.Uproar_legendary")
caster:AddNewModifier(caster, self, "modifier_primal_beast_uproar_custom_legendary", {duration = caster:GetTalentValue("modifier_primal_beast_uproar_7", "duration")})
end




modifier_primal_beast_uproar_custom_legendary = class({})
function modifier_primal_beast_uproar_custom_legendary:IsHidden() return false end
function modifier_primal_beast_uproar_custom_legendary:IsPurgable() return false end
function modifier_primal_beast_uproar_custom_legendary:GetStatusEffectName() return "particles/status_fx/status_effect_legion_commander_duel.vpcf" end
function modifier_primal_beast_uproar_custom_legendary:StatusEffectPriority() return MODIFIER_PRIORITY_SUPER_ULTRA  end

function modifier_primal_beast_uproar_custom_legendary:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.parent:GetTalentValue("modifier_primal_beast_uproar_7", "speed")

self.max_time = self:GetRemainingTime()

if not IsServer() then return end 
self.RemoveForDuel = true

self.uproar = self.parent:FindAbilityByName("primal_beast_uproar_custom")
self.mod = self.parent:FindModifierByName("modifier_primal_beast_uproar_custom")
if self.uproar then 
	self.uproar:SetActivated(false)
end

self.ability:EndCd()

local effect_cast = ParticleManager:CreateParticle( "particles/beast_hands.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( effect_cast, 2, self.parent, PATTACH_OVERHEAD_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
self:AddParticle( effect_cast, false, false, -1, false, false )

self.parent:GenericParticle("particles/primal_beast/uproar_legendary.vpcf", self)

self.parent:EmitSound("Hero_PrimalBeast.Uproar.Cast")
self:OnIntervalThink()
self:StartIntervalThink(0.03)
end


function modifier_primal_beast_uproar_custom_legendary:OnIntervalThink()
if not IsServer() then return end
local stack = 0
if self.mod and not self.mod:IsNull() then 
	stack = self.mod:GetStackCount()
end

self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = stack, style = "BeastUproar", priority = 1})
end

function modifier_primal_beast_uproar_custom_legendary:OnDestroy()
if not IsServer() then return end
self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "BeastUproar", priority = 1})

self.ability:StartCd()

if self.uproar and not self.uproar:IsNull() then
	self.uproar:SetActivated(true)
	if self.mod and not self.mod:IsNull() and self.mod:GetStackCount() > 0 then 
		if self.parent:IsAlive() then
			self.parent:GenericHeal(self.parent:GetMaxHealth()*self.mod:GetStackCount()*self.parent:GetTalentValue("modifier_primal_beast_uproar_7", "heal")/100, self.ability, nil, nil, "modifier_primal_beast_uproar_7")
			self.uproar:OnSpellStart()
		else 
			self.mod:ResetStack()
		end
	end
end

end

function modifier_primal_beast_uproar_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_primal_beast_uproar_custom_legendary:GetModifierAttackSpeedBonus_Constant()
return self.speed
end






modifier_primal_beast_uproar_custom_root = class({})
function modifier_primal_beast_uproar_custom_root:IsHidden() return true end
function modifier_primal_beast_uproar_custom_root:IsPurgable() return true end
function modifier_primal_beast_uproar_custom_root:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.stack = table.stack
end

function modifier_primal_beast_uproar_custom_root:OnDestroy()
if not IsServer() then return end

local duration = (self.ability:GetSpecialValueFor("slow_duration") + self.caster:GetTalentValue("modifier_primal_beast_uproar_2", "duration"))*(1 - self.parent:GetStatusResistance())
self.parent:AddNewModifier( self.caster, self.ability, "modifier_primal_beast_uproar_custom_debuff", {duration = duration, stack = self.stack})
end

function modifier_primal_beast_uproar_custom_root:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true
}
end

function modifier_primal_beast_uproar_custom_root:GetEffectName()
return "particles/beast_root.vpcf"
end






modifier_primal_beast_uproar_custom_proc = class({})
function modifier_primal_beast_uproar_custom_proc:IsHidden() return false end
function modifier_primal_beast_uproar_custom_proc:IsPurgable() return false end
function modifier_primal_beast_uproar_custom_proc:GetTexture() return "buffs/spray_slow" end
function modifier_primal_beast_uproar_custom_proc:OnCreated(table)

self.parent = self:GetParent()
self.speed = self.parent:GetTalentValue("modifier_primal_beast_uproar_4", "speed")
self.max = self.parent:GetTalentValue("modifier_primal_beast_uproar_4", "attacks")
self:SetStackCount(self.max)

if not IsServer() then return end
self.parent:GenericParticle("particles/beast_proc.vpcf")
self.parent:EmitSound("PBeast.Uproar_proc")
end

function modifier_primal_beast_uproar_custom_proc:OnRefresh()
if not IsServer() then return end
self:SetStackCount(self.max)
end

function modifier_primal_beast_uproar_custom_proc:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_primal_beast_uproar_custom_proc:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_primal_beast_uproar_custom_proc:GetEffectName()
return "particles/beast_blood.vpcf"
end

function modifier_primal_beast_uproar_custom_proc:GetStatusEffectName()
return "particles/status_fx/status_effect_bloodrage.vpcf"
end

function modifier_primal_beast_uproar_custom_proc:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end








modifier_primal_beast_uproar_custom_shield = class({})
function modifier_primal_beast_uproar_custom_shield:IsHidden() return true end
function modifier_primal_beast_uproar_custom_shield:IsPurgable() return false end
function modifier_primal_beast_uproar_custom_shield:OnCreated(table)
self.parent = self:GetParent()
self.shield_talent = "modifier_primal_beast_uproar_6"
self.max_shield = self.parent:GetTalentValue("modifier_primal_beast_uproar_6", "shield")*(self.parent:GetMaxHealth() - self.parent:GetHealth())/100

if not IsServer() then return end
self:SetStackCount(self.max_shield)
self.parent:GenericParticle("particles/items2_fx/vindicators_axe_armor.vpcf", self)
end


function modifier_primal_beast_uproar_custom_shield:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end


function modifier_primal_beast_uproar_custom_shield:GetModifierIncomingDamageConstant( params )
if self:GetStackCount() == 0 then return end

if IsClient() then 
  if params.report_max then 
  	return self.max_shield
  else 
	  return self:GetStackCount()
	end 
end

if not IsServer() then return end

self:GetParent():EmitSound("Juggernaut.Parry")
local particle = ParticleManager:CreateParticle( "particles/jugg_parry.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControl( particle, 1, self.parent:GetAbsOrigin() )
ParticleManager:ReleaseParticleIndex(particle)

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end