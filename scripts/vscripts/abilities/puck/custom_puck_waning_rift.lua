--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_puck_waning_rift", "abilities/puck/custom_puck_waning_rift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_waning_rift_legendary_charge", "abilities/puck/custom_puck_waning_rift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_waning_rift_legendary_damage", "abilities/puck/custom_puck_waning_rift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_waning_rift_tracker", "abilities/puck/custom_puck_waning_rift", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_puck_waning_rift_break", "abilities/puck/custom_puck_waning_rift", LUA_MODIFIER_MOTION_NONE)


custom_puck_waning_rift = class({})


function custom_puck_waning_rift:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_puck/puck_waning_rift.vpcf", context )
PrecacheResource( "particle","particles/puck_silence_damage.vpcf", context )
PrecacheResource( "particle","particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf", context )
PrecacheResource( "particle","particles/puck_silence_charges.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/rune_arcane_owner.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_keeper_of_the_light/keeper_chakra_magic.vpcf", context )
PrecacheResource( "particle","particles/puck/rift_prepare_radius.vpcf", context )
PrecacheResource( "particle","particles/puck/rift_legendary_damage.vpcf", context )
PrecacheResource( "particle","particles/puck/rift_blink_start.vpcf", context )
PrecacheResource( "particle","particles/puck/rift_blint_end.vpcf", context )
PrecacheResource( "particle","particles/puck/rift_legendary_max.vpcf", context )
PrecacheResource( "particle","particles/puck/rift_legendary_start.vpcf", context )
PrecacheResource( "particle","particles/puck/orb_stack.vpcf", context )
end


function custom_puck_waning_rift:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_puck_waning_rift_tracker"
end

function custom_puck_waning_rift:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_puck_rift_2") then 
	upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_puck_rift_2", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function custom_puck_waning_rift:GetManaCost(level)
if self:GetCaster():HasModifier("modifier_custom_puck_waning_rift_legendary_charge") then
	return 0
end
return self.BaseClass.GetManaCost(self,level) 
end

function custom_puck_waning_rift:GetCastRange(vLocation, hTarget)
if IsClient() then
	if not self:GetCaster():HasTalent("modifier_puck_rift_7") then
		return self:GetMaxRange()
	else
		return 0
	end
end
return 99999
end

function custom_puck_waning_rift:GetBehavior()

if self:GetCaster():HasTalent("modifier_puck_rift_7") and not self:GetCaster():HasModifier("modifier_custom_puck_waning_rift_legendary_charge") then
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end

function custom_puck_waning_rift:GetAOERadius()
return self:GetRadius()
end

function custom_puck_waning_rift:GetRadius()
return self:GetSpecialValueFor("radius") + self:GetCaster():GetTalentValue("modifier_puck_rift_5", "radius")
end



function custom_puck_waning_rift:GetMaxRange(bonus)
local range = self:GetSpecialValueFor("max_distance")
local caster = self:GetCaster()
if caster:HasModifier("modifier_custom_puck_waning_rift_legendary_charge") then 
	range = range + caster:GetTalentValue("modifier_puck_rift_7", "range")*caster:GetUpgradeStack("modifier_custom_puck_waning_rift_legendary_charge")/100
end
if bonus then 
	range = range + caster:GetCastRangeBonus()
end
return range
end


function custom_puck_waning_rift:OnSpellStart(self_cast)
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_custom_puck_waning_rift_legendary_charge")

if caster:HasTalent("modifier_puck_rift_7") and not mod and not self_cast then
	self:EndCd(0)
	self:StartCooldown(0.1)
	caster:AddNewModifier(caster, self, "modifier_custom_puck_waning_rift_legendary_charge", {duration = caster:GetTalentValue("modifier_puck_rift_7", "duration_max")})
	return
end

caster:EmitSound("Hero_Puck.Waning_Rift")

if caster:GetName() == "npc_dota_hero_puck" then
	caster:EmitSound("puck_puck_ability_rift_0"..RandomInt(1, 3))
end


local max_range = self:GetMaxRange(true)
local point = self:GetCursorPosition()
local old_pos = caster:GetAbsOrigin()

if (point == old_pos) then 
	point = old_pos + caster:GetForwardVector()*10
end

local vec = point - old_pos

if vec:Length2D() > max_range then 
	point = old_pos + vec:Normalized()*max_range
end

if caster:HasTalent("modifier_puck_rift_6") then 
	caster:Purge(false, true, false, false, false)
end

if not caster:IsRooted() and not caster:IsLeashed() and not self_cast then
	FindClearSpaceForUnit(caster, point, true)
	vec.z = 0
	caster:FaceTowards(point + vec:Normalized()*10)
	caster:SetForwardVector(vec:Normalized())
end


local radius = self:GetRadius()
local damage = self:GetSpecialValueFor("damage") + caster:GetTalentValue("modifier_puck_rift_1", "damage")*caster:GetAverageTrueAttackDamage(nil)/100
local silence = self:GetSpecialValueFor("silence_duration") + caster:GetTalentValue("modifier_puck_rift_3", "duration")
local creeps_k = self:GetSpecialValueFor("creeps_damage")/100 + 1

local legendary_duration = caster:GetTalentValue("modifier_puck_rift_7", "effect_duration")

local knock_duration = caster:GetTalentValue("modifier_puck_rift_5", "knock_duration")
local knock_range = caster:GetTalentValue("modifier_puck_rift_5", "knock_range")

local break_duration = caster:GetTalentValue("modifier_puck_rift_6", "duration")

local rift_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_waning_rift.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(rift_particle, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(rift_particle, 1, Vector(radius, 0, 0))
ParticleManager:ReleaseParticleIndex(rift_particle)

local damageTable = {damage = damage, damage_type= self:GetAbilityDamageType(), attacker = caster, ability = self }
local origin = caster:GetAbsOrigin()
local fear = caster:GetTalentValue("modifier_puck_rift_5", "fear")
local fear_health = caster:GetTalentValue("modifier_puck_rift_5", "health")
local enemies = caster:FindTargets(radius)

for _,enemy in pairs(enemies) do
	damageTable.victim = enemy

	if caster:HasTalent("modifier_puck_rift_6") then 
		enemy:AddNewModifier(caster, self, "modifier_custom_puck_waning_rift_break", {duration = (1 - enemy:GetStatusResistance())*break_duration})
	end

	if (mod and mod.max and mod:GetStackCount() >= mod.max) or self_cast then 
		enemy:AddNewModifier(caster, self, "modifier_custom_puck_waning_rift_legendary_damage", {duration = legendary_duration})
	end

	enemy:AddNewModifier(caster, self, "modifier_custom_puck_waning_rift", {duration = silence * (1 - enemy:GetStatusResistance())})

	local real_damage = damage
	if enemy:IsCreep() then
		real_damage = real_damage * creeps_k
	end
	damageTable.damage = real_damage

	DoDamage(damageTable)

	if caster:HasTalent("modifier_puck_rift_5") then
		local enemy_direction = (enemy:GetOrigin() - origin):Normalized()
		local point = origin + enemy_direction*(radius + 10) 
		local distance = math.min(knock_range, (point - enemy:GetAbsOrigin()):Length2D())

		local knock = enemy:AddNewModifier(caster, self,
		"modifier_generic_knockback",
		{
			duration = knock_duration,
			distance = distance,
			height = 0,
			direction_x = enemy_direction.x,
			direction_y = enemy_direction.y,
		})

		if enemy:GetHealthPercent() <= fear_health then
			enemy:GenericParticle("particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf")
			enemy:EmitSound("Generic.Fear")
			enemy:AddNewModifier(caster, self, "modifier_nevermore_requiem_fear", {duration = fear * (1 - enemy:GetStatusResistance())})
		end
	end
end


if (mod and mod.max and mod:GetStackCount() >= mod.max) or self_cast then 
	EmitSoundOnLocationWithCaster(old_pos, "Puck.Rift_Legendary", caster)

	local effect = ParticleManager:CreateParticle("particles/puck/rift_blink_start.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, old_pos)
	ParticleManager:ReleaseParticleIndex(effect)

	caster:GenericParticle("particles/puck/rift_blint_end.vpcf")
	local max = caster:GetTalentValue("modifier_puck_rift_7", "max")

	if #enemies > 0 then
		local shift_mod = caster:FindModifierByName("modifier_custom_puck_phase_shift_tracker")
		local orb_mod = caster:FindModifierByName("modifier_puck_coil_orb_tracker")

		for i = 1, max do
			if shift_mod then
				shift_mod:PuckAttackProc()
			end

			if orb_mod then
				orb_mod:PuckAttackProc()
			end
		end
	end
end

if mod or self_cast then 
	self:StartCd()
end

if mod and not self_cast then 
	mod:Destroy()
end

end





modifier_custom_puck_waning_rift = class({})

function modifier_custom_puck_waning_rift:IsHidden() return false end
function modifier_custom_puck_waning_rift:IsPurgable() return true end
function modifier_custom_puck_waning_rift:CheckState()
return 
{
	[MODIFIER_STATE_SILENCED] = true
}
end

function modifier_custom_puck_waning_rift:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
}
end

function modifier_custom_puck_waning_rift:GetModifierLifestealRegenAmplify_Percentage() 
if not self.caster:HasTalent("modifier_puck_rift_4") then return end
return self.heal_reduce
end
function modifier_custom_puck_waning_rift:GetModifierHealChange() 
if not self.caster:HasTalent("modifier_puck_rift_4") then return end
return self.heal_reduce
end
function modifier_custom_puck_waning_rift:GetModifierHPRegenAmplify_Percentage()
if not self.caster:HasTalent("modifier_puck_rift_4") then return end
return self.heal_reduce
end

function modifier_custom_puck_waning_rift:GetModifierMoveSpeedBonus_Percentage()
if not self.caster:HasTalent("modifier_puck_rift_3") then return end
return self.slow
end


function modifier_custom_puck_waning_rift:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow = self.caster:GetTalentValue("modifier_puck_rift_3", "slow")

self.damage = self.caster:GetTalentValue("modifier_puck_rift_4", "damage")/100
self.heal_reduce = self.caster:GetTalentValue("modifier_puck_rift_4", "heal_reduce")

self.heal = self.caster:GetTalentValue("modifier_puck_rift_1", "heal")/100

if not IsServer() then return end
self.parent:GenericParticle("particles/generic_gameplay/generic_silenced.vpcf", self ,true)

if self.caster:GetQuest() == "Puck.Quest_6" and self.parent:IsRealHero() and not self.caster:QuestCompleted() then 
	self:StartIntervalThink(0.1)
end

end

function modifier_custom_puck_waning_rift:OnIntervalThink()
if not IsServer() then return end
self.caster:UpdateQuest(0.1)
end



function modifier_custom_puck_waning_rift:OnDestroy()
if not IsServer() then return end
if not self.parent:IsAlive() then return end

if self:GetStackCount() > 0 and self.caster:HasTalent("modifier_puck_rift_4") then 
	
	local effect_cast = ParticleManager:CreateParticle( "particles/puck_silence_damage.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(),true)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	self.parent:EmitSound("Puck.Rift_Damage")

	local damage = DoDamage({ victim = self.parent, attacker = self.caster, ability = self.ability, damage = self:GetStackCount(), damage_type = DAMAGE_TYPE_MAGICAL}, "modifier_puck_rift_4")
	self.parent:SendNumber(6, damage)
end

end




modifier_custom_puck_waning_rift_tracker = class({})
function modifier_custom_puck_waning_rift_tracker:IsHidden() return true end
function modifier_custom_puck_waning_rift_tracker:IsPurgable() return false end
function modifier_custom_puck_waning_rift_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal_creeps = self.parent:GetTalentValue("modifier_puck_rift_1", "creeps", true)

self.parent:AddDamageEvent_out(self)
end

function modifier_custom_puck_waning_rift_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
}
end

function modifier_custom_puck_waning_rift_tracker:GetModifierCastRangeBonusStacking()
if not self.parent:HasTalent("modifier_puck_rift_2") then return end 
return self.parent:GetTalentValue("modifier_puck_rift_2", "range")
end


function modifier_custom_puck_waning_rift_tracker:DamageEvent_out(params)
if not IsServer() then return end 
if self.parent ~= params.attacker then return end
if not params.unit:IsUnit() then return end

local mod = params.unit:FindModifierByName("modifier_custom_puck_waning_rift")

if not mod then return end


if self.parent:HasTalent("modifier_puck_rift_1") and mod.heal and self.parent:CheckLifesteal(params, 0) then 
	local heal = params.damage*mod.heal
	if params.unit:IsCreep() then
		heal = heal/self.heal_creeps
	end
	self.parent:GenericHeal(heal, self.ability, true, nil, "modifier_puck_rift_1")
end

if self.parent:HasTalent("modifier_puck_rift_4") and mod.damage then
	local damage = params.damage*mod.damage
	mod:SetStackCount(mod:GetStackCount() + damage)
end

end


modifier_custom_puck_waning_rift_legendary_charge = class({})
function modifier_custom_puck_waning_rift_legendary_charge:IsHidden() return false end
function modifier_custom_puck_waning_rift_legendary_charge:IsPurgable() return false end
function modifier_custom_puck_waning_rift_legendary_charge:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.RemoveForDuel = true

self.slow = self.parent:GetTalentValue("modifier_puck_rift_7", "slow")
self.duration = self.parent:GetTalentValue("modifier_puck_rift_7", "duration")

self.max = 100
self.interval = 0.05
self.stack_inc = (self.max/self.duration)*self.interval
self.stack = 0
self.visual = 5

if not IsServer() then return end

self.parent:EmitSound("Puck.Rift_Legendary_charge")
self.parent:EmitSound("Puck.Rift_Legendary_charge_start")

self.min_radius = self.ability:GetMaxRange(true)
self.max_radius = self.ability:GetSpecialValueFor("max_distance") + self.parent:GetCastRangeBonus() + self.parent:GetTalentValue("modifier_puck_rift_7", "range")
self.speed = (self.max_radius - self.min_radius)/self.duration
self.parent:GenericParticle("particles/puck/rift_legendary_start.vpcf", self)
self.effect_cast = self.parent:GenericParticle("particles/puck/orb_stack.vpcf", self, true)
for i = 1,self.visual do  
  ParticleManager:SetParticleControl(self.effect_cast, i, Vector(0, 0, 0)) 
end

self.particle = ParticleManager:CreateParticleForPlayer("particles/puck/rift_prepare_radius.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent:GetPlayerOwner())
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(self.ability:GetMaxRange(true), self.speed, 1))
self:AddParticle(self.particle, false, false, -1, false, false)

self:StartIntervalThink(self.interval)
end

function modifier_custom_puck_waning_rift_legendary_charge:OnIntervalThink()
if not IsServer() then return end

local radius = self.ability:GetMaxRange(true)

if self.stack < self.max then 
	self.stack = self.stack + self.stack_inc
	self:SetStackCount(self.stack)
else 
	if self.particle then 
		ParticleManager:SetParticleControl(self.particle, 1, Vector(self.ability:GetMaxRange(true), self.speed, 0))
	end

	if not self.hands then 
		self.parent:EmitSound("Puck.Rift_Legendary_charge_end")
		self.hands = self.parent:GenericParticle("particles/puck/rift_legendary_max.vpcf", self)
	end
end

if self.effect_cast then 
	for i = 1,self.visual do 
	  if i <= math.floor(self:GetStackCount()/(self.max/self.visual)) then 
	    ParticleManager:SetParticleControl(self.effect_cast, i, Vector(1, 0, 0)) 
	  else 
	    ParticleManager:SetParticleControl(self.effect_cast, i, Vector(0, 0, 0)) 
	  end
	end
end

self.parent:UpdateUIshort({max_time = self.duration, time = math.min(self.duration, self:GetElapsedTime()), active = self:GetElapsedTime() >= self.duration, stack = tostring(math.floor(self.stack)).."%", priority = 1, style = "PuckRift"})
AddFOWViewer(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), radius*1.2, self.interval*2, false)
end




function modifier_custom_puck_waning_rift_legendary_charge:OnDestroy()
if not IsServer() then return end 

if self:GetRemainingTime() <= 0.1 then 
	self.ability:OnSpellStart(true)
end

self.parent:StopSound("Puck.Rift_Legendary_charge")
self.parent:StopSound("Puck.Rift_Legendary_charge_start")

if self.particle then 
	ParticleManager:DestroyParticle(self.particle, true)
	ParticleManager:ReleaseParticleIndex(self.particle)
end

self.parent:UpdateUIshort({hide = 1, priority = 1, style = "PuckRift"})
end

function modifier_custom_puck_waning_rift_legendary_charge:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_puck_waning_rift_legendary_charge:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end



modifier_custom_puck_waning_rift_legendary_damage = class({})
function modifier_custom_puck_waning_rift_legendary_damage:IsHidden() return true end
function modifier_custom_puck_waning_rift_legendary_damage:IsPurgable() return false end
function modifier_custom_puck_waning_rift_legendary_damage:GetTexture() return "buffs/bolt_items" end
function modifier_custom_puck_waning_rift_legendary_damage:OnCreated()
self.max = self:GetCaster():GetTalentValue("modifier_puck_rift_7", "max")
self.parent = self:GetParent()
self.caster = self:GetCaster()
if not IsServer() then return end

--[[
self.particle = ParticleManager:CreateParticle("particles/puck/rift_legendary_damage.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt( self.particle, 0, self.parent, PATTACH_OVERHEAD_FOLLOW, "", self.parent:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( self.particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "", self.parent:GetOrigin(), true )
self:AddParticle(self.particle, false, false, -1, false, false)
]]
self.parent:EmitSound("Puck.Rift_legendary_damage")

self.count = 0
self:StartIntervalThink(0.2)
end

function modifier_custom_puck_waning_rift_legendary_damage:OnIntervalThink()
if not IsServer() then return end

if self.caster:HasTalent("modifier_puck_shift_4") then
	local mod = self.caster:FindModifierByName("modifier_custom_puck_phase_shift_tracker")
	if mod and mod.proc_chance then
		if RollPseudoRandomPercentage(mod.proc_chance, 5059, self.caster) then 
			mod:ProcDamage(self.parent)
		end
	end
end

self.caster:PerformAttack(self.parent, true, true, true, true, true, false, false)

self.count = self.count + 1
if self.count >= self.max then
	self:Destroy()
	return
end

end


modifier_custom_puck_waning_rift_break = class({})
function modifier_custom_puck_waning_rift_break:IsHidden() return true end
function modifier_custom_puck_waning_rift_break:IsPurgable() return false end
function modifier_custom_puck_waning_rift_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_custom_puck_waning_rift_break:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end
function modifier_custom_puck_waning_rift_break:OnCreated()
self.speed = self:GetCaster():GetTalentValue("modifier_puck_rift_6", "speed")
end

function modifier_custom_puck_waning_rift_break:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_custom_puck_waning_rift_break:GetModifierAttackSpeedBonus_Constant()
return self.speed
end