--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_blink_tracker", "abilities/queen_of_pain/custom_queenofpain_blink", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_blink_legendary_attacks", "abilities/queen_of_pain/custom_queenofpain_blink", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_blink_legendary_attacks_damage", "abilities/queen_of_pain/custom_queenofpain_blink", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_blink_speed_attacks", "abilities/queen_of_pain/custom_queenofpain_blink", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_blink_legendary_tracker", "abilities/queen_of_pain/custom_queenofpain_blink", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_blink_damage", "abilities/queen_of_pain/custom_queenofpain_blink", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_blink_attacks_slow", "abilities/queen_of_pain/custom_queenofpain_blink", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_blink_root", "abilities/queen_of_pain/custom_queenofpain_blink", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_blink_shield", "abilities/queen_of_pain/custom_queenofpain_blink", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_blink_spell_block", "abilities/queen_of_pain/custom_queenofpain_blink", LUA_MODIFIER_MOTION_NONE)




custom_queenofpain_blink = class({})



function custom_queenofpain_blink:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "queenofpain_blink", self)
end

function custom_queenofpain_blink:CreateTalent(name)
if name == "modifier_queen_blink_7" then
	self:UpdateLegendary()
end

if name == "modifier_queen_blink_5" then
	self:ToggleAutoCast()
end

end

function custom_queenofpain_blink:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queen_blink_start.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queen_blink_end.vpcf", context )
PrecacheResource( "particle","particles/qop_attack_.vpcf", context )
PrecacheResource( "particle","particles/qop_marker.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/ascetic_cap.vpcf", context ) 
PrecacheResource( "particle","particles/shadow_fiend/requiem_refresh.vpcf", context ) 
PrecacheResource( "particle","particles/queen_of_pain/blink_legendary_stack.vpcf", context ) 
PrecacheResource( "particle","particles/queen_of_pain/blink_attack.vpcf", context )
PrecacheResource( "particle","particles/queen_of_pain/blink_root.vpcf", context )
PrecacheResource( "particle","particles/shadow_fiend/requiem_block.vpcf", context )
end


function custom_queenofpain_blink:GetIntrinsicModifierName() 
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_blink_tracker" 
end


function custom_queenofpain_blink:GetCastPoint(iLevel)
local bonus = 1
if self:GetCaster():HasTalent("modifier_queen_blink_1") then 
	bonus = 1 + self:GetCaster():GetTalentValue("modifier_queen_blink_1", "cast")/100
end
return self.BaseClass.GetCastPoint(self)*bonus
end

function custom_queenofpain_blink:GetCooldown(iLevel)
local upgrade_cooldown = 0	
if self:GetCaster():HasTalent("modifier_queen_blink_1") then 
	upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_queen_blink_1", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown 
end

function custom_queenofpain_blink:GetManaCost(iLevel)
local caster = self:GetCaster()
if caster:HasTalent("modifier_queen_blink_6") then
	return 0
end
if caster:HasModifier("modifier_queenofpain_blood_pact") then 
	return 0
end
return self.BaseClass.GetManaCost(self,iLevel)
end 

function custom_queenofpain_blink:GetHealthCost(level)
local caster = self:GetCaster()
if caster:HasModifier("modifier_queenofpain_blood_pact") then 
	return caster:GetTalentValue("modifier_queen_scream_7", "cost")*caster:GetMaxHealth()/100
end

end 

function custom_queenofpain_blink:GetCastRange(vLocation, hTarget)
local range = self:GetSpecialValueFor("blink_range") 
if IsClient() then 
	return range
else
	return 99999
end

end

function custom_queenofpain_blink:GetBehavior()
local bonus = 0
local caster = self:GetCaster()
if caster:HasShard() or caster:HasTalent("modifier_queen_blink_7") or caster:HasTalent("modifier_queen_blink_5") then
    bonus = DOTA_ABILITY_BEHAVIOR_AOE
end
if caster:HasTalent("modifier_queen_blink_5") then
	bonus = bonus + DOTA_ABILITY_BEHAVIOR_AUTOCAST
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + bonus
end

function custom_queenofpain_blink:GetAOERadius() 
local caster = self:GetCaster()
if caster:HasTalent("modifier_queen_blink_7") or caster:HasTalent("modifier_queen_blink_5") then 
	return caster:GetTalentValue("modifier_queen_blink_7", "aoe", true)
end
if caster:HasShard() then
	return self:GetSpecialValueFor("shard_radius")
end
return 0
end



function custom_queenofpain_blink:UpdateLegendary()
if not IsServer() then return end
local mod = self:GetCaster():FindModifierByName("modifier_custom_blink_tracker")

if mod then
	mod:UpdateJS()
end

end



function custom_queenofpain_blink:ShardStrike(location)

local caster = self:GetCaster()
local radius = self:GetSpecialValueFor("shard_radius")
local damage = self:GetSpecialValueFor("shard_damage")
local silence = self:GetSpecialValueFor("shard_silence")
local targets = caster:FindTargets(radius, location)
local knock_range = caster:GetTalentValue("modifier_queen_blink_5", "knock_radius", true)
local knock_duration = caster:GetTalentValue("modifier_queen_blink_5", "knock_duration", true)
local knock_root = caster:GetTalentValue("modifier_queen_blink_5", "root", true)

if caster:HasShard() then 
	local blink_shard_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(blink_shard_pfx, 0, location )
	ParticleManager:SetParticleControl(blink_shard_pfx, 1, location )
	ParticleManager:SetParticleControl(blink_shard_pfx, 2, Vector(radius,radius,radius) )
	ParticleManager:ReleaseParticleIndex(blink_shard_pfx)
end

for _, enemy in pairs(targets) do

	if caster:HasShard() then
		DoDamage({victim = enemy, attacker = caster, ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
		enemy:AddNewModifier(caster, self, "modifier_generic_silence", {duration = (1 - enemy:GetStatusResistance())*silence})
	end

	if caster:HasTalent("modifier_queen_blink_5") then
		caster:RemoveModifierByName("modifier_generic_knockback")
		if self:GetAutoCastState() then

			local enemy_direction = (enemy:GetOrigin() - location):Normalized()
			local point = location + enemy_direction*(knock_range + 10) 
			local distance =(point - enemy:GetAbsOrigin()):Length2D()

			local knock = enemy:AddNewModifier(caster, self,
			"modifier_generic_knockback",
			{
				duration = knock_duration,
				distance = distance,
				height = 0,
				direction_x = enemy_direction.x,
				direction_y = enemy_direction.y,
			})
			if knock then
			  	knock:SetEndCallback(function()
			        if enemy and not enemy:IsNull() and knock:GetRemainingTime() <= 0.1 then
			        	enemy:EmitSound("QoP.Blink_root")
			        	enemy:AddNewModifier(caster, self, "modifier_custom_blink_root", {duration = (1 - enemy:GetStatusResistance())*knock_root})
			        end
			    end)
			end
		else
        	enemy:EmitSound("QoP.Blink_root")
        	enemy:AddNewModifier(caster, self, "modifier_custom_blink_root", {duration = (1 - enemy:GetStatusResistance())*knock_root})
		end
	end
end

end


function custom_queenofpain_blink:OnSpellStart()

local caster = self:GetCaster()
local caster_pos = caster:GetAbsOrigin()
local target_pos = self:GetCursorPosition()

local blink_range = self:GetSpecialValueFor("blink_range") + caster:GetCastRangeBonus()
local distance = (target_pos - caster_pos)


if distance:Length2D() > blink_range then
	target_pos = caster_pos + (distance:Normalized() * blink_range)
end

local start_b = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_queenofpain/queen_blink_start.vpcf", self)
local end_b = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_queenofpain/queen_blink_end.vpcf", self)

if start_b == "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_start.vpcf" then 
	local direction = (target_pos - caster_pos)
    direction = direction:Normalized()

    local particle_one = ParticleManager:CreateParticle(start_b, PATTACH_WORLDORIGIN, nil) 
    ParticleManager:SetParticleControl( particle_one, 0, caster:GetAbsOrigin() )
    ParticleManager:SetParticleControlForward( particle_one, 0, direction:Normalized() )
    ParticleManager:SetParticleControl( particle_one, 1, caster:GetForwardVector() )
    ParticleManager:SetParticleControl( particle_one, 4,Vector(10,1,0) )
    ParticleManager:ReleaseParticleIndex( particle_one )

elseif start_b == "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_v2_start.vpcf" then 
	local direction = (target_pos - caster_pos)
    direction = direction:Normalized()

    local particle_one = ParticleManager:CreateParticle(start_b, PATTACH_WORLDORIGIN, nil) 
    ParticleManager:SetParticleControl( particle_one, 0, caster:GetAbsOrigin() )
    ParticleManager:SetParticleControlForward( particle_one, 0, direction:Normalized() )
    ParticleManager:SetParticleControl( particle_one, 1, caster:GetForwardVector() )
    ParticleManager:SetParticleControl( particle_one, 4,Vector(10,1,0) )
    ParticleManager:ReleaseParticleIndex( particle_one )
else
	local blink_pfx = ParticleManager:CreateParticle(start_b, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(blink_pfx, 0, caster_pos )
	ParticleManager:SetParticleControl(blink_pfx, 1, target_pos )
	ParticleManager:ReleaseParticleIndex(blink_pfx)
end

ProjectileManager:ProjectileDodge(caster)

local sound_out = wearables_system:GetSoundReplacement(caster, "Hero_QueenOfPain.Blink_out", self)
local sound_in = wearables_system:GetSoundReplacement(caster, "Hero_QueenOfPain.Blink_in", self)

caster:EmitSound(sound_in)

if caster:HasTalent("modifier_queen_blink_5") then
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_queenofpain/queen_blink_end_distort.vpcf", PATTACH_WORLDORIGIN, nil) 
	ParticleManager:SetParticleControl(particle, 0, caster_pos )
    ParticleManager:ReleaseParticleIndex(particle)
end

if caster:HasShard() or caster:HasTalent("modifier_queen_blink_5") then 
	caster:EmitSound("Hero_QueenOfPain.Blink_in.Shard")
	self:ShardStrike(caster_pos)
end

FindClearSpaceForUnit(caster, target_pos, true)

if caster:HasShard() or caster:HasTalent("modifier_queen_blink_5") then 
	caster:EmitSound("Hero_QueenOfPain.Blink_Out.Shard")
	self:ShardStrike(target_pos)
end

if caster:HasTalent("modifier_queen_sonic_7") then
	local ability = caster:FindAbilityByName("custom_queenofpain_sonic_wave")
	if ability and ability:IsTrained() then
		ability:CreateFire(caster_pos, target_pos)
	end
end

if caster:GetQuest() == "Queen.Quest_6" then 
	local enemies = FindUnitsInRadius(caster:GetTeamNumber(), target_pos, nil, caster.quest.number, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO  + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)
	if #enemies > 0 then 
		caster:UpdateQuest(1)
	end
end

caster:EmitSound(sound_out)
local blink_end_pfx = ParticleManager:CreateParticle(end_b, PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(blink_end_pfx, 0, target_pos )
ParticleManager:SetParticleControlForward(blink_end_pfx, 0, distance:Normalized())
ParticleManager:ReleaseParticleIndex(blink_end_pfx)

caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)

local mod = caster:FindModifierByName("modifier_custom_blink_legendary_tracker")
if mod then
	caster:AddNewModifier(caster, self, "modifier_custom_blink_legendary_attacks", {stack = mod:GetStackCount()})
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
		
	if mod:GetStackCount() >= caster:GetTalentValue("modifier_queen_blink_7", "max") then
		self:EndCd(0)
		self:StartCooldown(0.3)
		local particle = ParticleManager:CreateParticle("particles/shadow_fiend/requiem_refresh.vpcf", PATTACH_CUSTOMORIGIN, caster)
		ParticleManager:SetParticleControlEnt( particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
		ParticleManager:ReleaseParticleIndex(particle)

		caster:EmitSound("Hero_Rattletrap.Overclock.Cast")	
	end

	mod:Destroy()
end

if caster:HasTalent("modifier_queen_blink_2") then
	caster:RemoveModifierByName("modifier_custom_blink_shield")
	caster:AddNewModifier(caster, self, "modifier_custom_blink_shield", {duration = caster:GetTalentValue("modifier_queen_blink_2", "duration")})
end

if caster:HasTalent("modifier_queen_blink_6") then 
	caster:AddNewModifier(caster, self, "modifier_custom_blink_spell_block", { duration = caster:GetTalentValue("modifier_queen_blink_6", "duration")})
end	

end







modifier_custom_blink_tracker = class({})

function modifier_custom_blink_tracker:IsHidden() return true end
function modifier_custom_blink_tracker:IsPurgable() return false end
function modifier_custom_blink_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}

end

function modifier_custom_blink_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddRecordDestroyEvent(self)
self.parent:AddAttackStartEvent_out(self)
self.parent:AddAttackEvent_out(self)
self.parent:AddSpellEvent(self)

self.legendary_duration = self.parent:GetTalentValue("modifier_queen_blink_7", "duration", true)
self.legendary_max = self.parent:GetTalentValue("modifier_queen_blink_7", "max", true)
self.legendary_spell = self.parent:GetTalentValue("modifier_queen_blink_7", "spell", true)

self.effect_duration = self.parent:GetTalentValue("modifier_queen_blink_4", "effect_duration", true)
self.attack_radius = self.parent:GetTalentValue("modifier_queen_blink_4", "radius", true)
self.attack_duration = self.parent:GetTalentValue("modifier_queen_blink_4", "duration", true)

self.damage_duration = self.parent:GetTalentValue("modifier_queen_blink_3", "duration", true)

self.status_bonus = self.parent:GetTalentValue("modifier_queen_blink_6", "status", true)

self.records = {}

if not IsServer() then return end
self:StartIntervalThink(1)
end

function modifier_custom_blink_tracker:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_queen_blink_2") then return end

self.parent:AddPercentStat({int = self.parent:GetTalentValue("modifier_queen_blink_2", "int")/100}, self)
end

function modifier_custom_blink_tracker:UpdateJS()
if not IsServer() then return end
local stack = 0
local mod = self.parent:FindModifierByName("modifier_custom_blink_legendary_tracker")

if mod then
	stack = mod:GetStackCount()
	if self.effect then 
		ParticleManager:DestroyParticle(self.effect, false)
		ParticleManager:ReleaseParticleIndex(self.effect)
		self.effect = nil
	end
else 
	if not self.effect then 
		self.effect = self.parent:GenericParticle("particles/queen_of_pain/blink_legendary_stack.vpcf", self, true)
		for i = 1,self.legendary_max/2 do 
			ParticleManager:SetParticleControl(self.effect, i, Vector(0, 0, 0))	
		end
	end
end

self.parent:UpdateUIlong({max = self.legendary_max, stack= stack, style = "QopBlink"})
end


function modifier_custom_blink_tracker:GetModifierAttackRangeBonus()
if not self.parent:HasTalent("modifier_queen_blink_3") then return end 
return self.parent:GetTalentValue("modifier_queen_blink_3", "range")
end 

function modifier_custom_blink_tracker:GetModifierStatusResistanceStacking() 
if not self.parent:HasTalent("modifier_queen_blink_6") then return end 
return self.status_bonus
end 

function modifier_custom_blink_tracker:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if params.ability:IsItem() then return end

if self.parent:HasTalent("modifier_queen_blink_4") then
	self.parent:RemoveModifierByName("modifier_custom_blink_speed_attacks")
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_blink_speed_attacks", {duration = self.effect_duration})
end

if not self.parent:HasTalent("modifier_queen_blink_7") then return end
if self.ability == params.ability then return end

for i = 1,self.legendary_spell do
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_blink_legendary_tracker", {duration = self.legendary_duration})
end

end


function modifier_custom_blink_tracker:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if params.no_attack_cooldown then return end

if self.parent:HasTalent("modifier_queen_blink_3") then 
	self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_custom_blink_damage", {duration = self.damage_duration})
end 

local mod = self.parent:FindModifierByName("modifier_custom_blink_speed_attacks")
if mod then
	self.parent:EmitSound("QoP.Blink_attack_start")
	self.records[params.record] = true
	mod:DecrementStackCount()
	if mod:GetStackCount() <= 0 then 
	  mod:Destroy()
	end 
end

if not self.parent:HasTalent("modifier_queen_blink_7") then return end
self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_blink_legendary_tracker", {duration = self.legendary_duration})
end



function modifier_custom_blink_tracker:RecordDestroyEvent(params)
if not params.record then return end
if not self.records[params.record] then return end
self.records[params.record] = nil
end


function modifier_custom_blink_tracker:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
local target = params.target

if not self.parent:HasTalent("modifier_queen_blink_4") then return end
if not params.record or not self.records[params.record] then return end

target:EmitSound("QoP.Blink_attack")

local blink_shard_pfx = ParticleManager:CreateParticle("particles/qop_attack_.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt(blink_shard_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(blink_shard_pfx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(blink_shard_pfx, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(blink_shard_pfx)

local damage = self.parent:GetTalentValue("modifier_queen_blink_4", "damage") * self.parent:GetIntellect(false) / 100
target:SendNumber(4, damage)

for _,enemy in pairs(self.parent:FindTargets(self.attack_radius, target:GetAbsOrigin())) do
	DoDamage({victim = enemy, attacker = self.parent, ability = self.ability, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL}, "modifier_queen_blink_4")
	enemy:AddNewModifier(self.parent, self.ability, "modifier_custom_blink_attacks_slow", {duration = (1 - enemy:GetStatusResistance())*self.attack_duration})
end

self.records[params.record] = nil
end







modifier_custom_blink_legendary_attacks = class({})
function modifier_custom_blink_legendary_attacks:IsHidden() return true end
function modifier_custom_blink_legendary_attacks:IsPurgable() return false end 
function modifier_custom_blink_legendary_attacks:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self:SetStackCount(table.stack)

self.radius = self.parent:GetTalentValue("modifier_queen_blink_7", "aoe")
self.parent:EmitSound("QoP.Blink_legendary")

self.targets = self.parent:FindTargets(self.radius)

if #self.targets == 0 then 
	self:Destroy()
end

for _,target in pairs(self.targets) do
	target:GenericParticle("particles/qop_marker.vpcf", self, true)
end

self:StartIntervalThink(self.parent:GetTalentValue("modifier_queen_blink_7", "interval"))
end

function modifier_custom_blink_legendary_attacks:OnIntervalThink()
if not IsServer() then return end
local array = {}

for _,enemy in pairs(self.targets) do 
	if enemy:IsAlive() and not enemy:IsNull() then 
		array[#array+1] = enemy
	end
end

if #array > 0 then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_blink_legendary_attacks_damage", {duration = FrameTime()})
	self.parent:PerformAttack(array[RandomInt(1, #array)], true, true, true, false, true, false, false)
	self.parent:RemoveModifierByName("modifier_custom_blink_legendary_attacks_damage")
else 
	self:Destroy()
end

self:DecrementStackCount()
if self:GetStackCount() <= 0 then
	self:Destroy()
end

end

modifier_custom_blink_legendary_attacks_damage = class({})
function modifier_custom_blink_legendary_attacks_damage:IsHidden() return true end
function modifier_custom_blink_legendary_attacks_damage:IsPurgable() return false end
function modifier_custom_blink_legendary_attacks_damage:OnCreated()
self.damage = self:GetCaster():GetTalentValue("modifier_queen_blink_7", "damage") - 100
end

function modifier_custom_blink_legendary_attacks_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_custom_blink_legendary_attacks_damage:GetModifierDamageOutgoing_Percentage()
if not IsServer() then return end
return self.damage
end






modifier_custom_blink_speed_attacks = class({})
function modifier_custom_blink_speed_attacks:IsHidden() return false end
function modifier_custom_blink_speed_attacks:IsPurgable() return false end
function modifier_custom_blink_speed_attacks:GetTexture() return "buffs/Crit_damage" end

function modifier_custom_blink_speed_attacks:OnCreated(table)
self.parent = self:GetParent()
self.speed = self.parent:GetTalentValue("modifier_queen_blink_4", "speed")
self:SetStackCount(self.parent:GetTalentValue("modifier_queen_blink_4", "count"))
end

function modifier_custom_blink_speed_attacks:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  	MODIFIER_PROPERTY_PROJECTILE_NAME,
}
end

function modifier_custom_blink_speed_attacks:GetModifierAttackSpeedBonus_Constant()
return self.speed 
end

function modifier_custom_blink_speed_attacks:GetPriority()
return MODIFIER_PRIORITY_HIGH
end

function modifier_custom_blink_speed_attacks:GetModifierProjectileName()
return "particles/queen_of_pain/blink_attack.vpcf"
end



modifier_custom_blink_attacks_slow = class({})
function modifier_custom_blink_attacks_slow:IsHidden() return true end
function modifier_custom_blink_attacks_slow:IsPurgable() return true end
function modifier_custom_blink_attacks_slow:OnCreated()
self.slow = self:GetCaster():GetTalentValue("modifier_queen_blink_4", "slow")
end

function modifier_custom_blink_attacks_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_blink_attacks_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_custom_blink_attacks_slow:GetEffectName()
return "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf"
end

function modifier_custom_blink_attacks_slow:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end






modifier_custom_blink_legendary_tracker = class({})
function modifier_custom_blink_legendary_tracker:IsHidden() return true end
function modifier_custom_blink_legendary_tracker:IsPurgable() return false end
function modifier_custom_blink_legendary_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.parent:GetTalentValue("modifier_queen_blink_7", "max")
self.timer = self.parent:GetTalentValue("modifier_queen_blink_7", "duration")
self.radius = self.parent:GetTalentValue("modifier_queen_blink_7", "radius")

if not IsServer() then return end

self.effect = self.parent:GenericParticle("particles/queen_of_pain/blink_legendary_stack.vpcf", self, true)

self:SetStackCount(1)
self:StartIntervalThink(0.2)
end

function modifier_custom_blink_legendary_tracker:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
end


function modifier_custom_blink_legendary_tracker:OnIntervalThink()
if not IsServer() then return end
local heroes = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )

if #heroes > 0 then 
	self:SetDuration(self.timer, true)
end

end

function modifier_custom_blink_legendary_tracker:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.ability:UpdateLegendary()

if self.effect then 
	for i = 1,self.max/2 do 
		if i <= math.floor(self:GetStackCount()/2) then 
			ParticleManager:SetParticleControl(self.effect, i, Vector(1, 0, 0))	
		else 
			ParticleManager:SetParticleControl(self.effect, i, Vector(0, 0, 0))	
		end
	end
end

end

function modifier_custom_blink_legendary_tracker:OnDestroy()
if not IsServer() then return end
self.ability:UpdateLegendary()
end



modifier_custom_blink_damage = class({})
function modifier_custom_blink_damage:IsHidden() return false end
function modifier_custom_blink_damage:IsPurgable() return false end
function modifier_custom_blink_damage:GetTexture() return "buffs/Shift_attacks" end
function modifier_custom_blink_damage:OnCreated(table)
self.parent = self:GetParent()
self.damage = self.parent:GetTalentValue("modifier_queen_blink_3", "damage")
self.max = self.parent:GetTalentValue("modifier_queen_blink_3", "max")

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_custom_blink_damage:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_custom_blink_damage:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_custom_blink_damage:GetModifierSpellAmplify_Percentage()
 return self.damage*self:GetStackCount()
end




modifier_custom_blink_root = class({})
function modifier_custom_blink_root:IsHidden() return true end
function modifier_custom_blink_root:IsPurgable() return true end
function modifier_custom_blink_root:CheckState() 
return 
{
	[MODIFIER_STATE_ROOTED] = true
} 
end

function modifier_custom_blink_root:OnCreated()
self:StartIntervalThink(0.1)
end

function modifier_custom_blink_root:OnIntervalThink()
if not IsServer() then return end
self:GetParent():GenericParticle("particles/queen_of_pain/blink_root.vpcf", self)
self:StartIntervalThink(-1)
end






modifier_custom_blink_shield = class({})
function modifier_custom_blink_shield:IsHidden() return true end
function modifier_custom_blink_shield:IsPurgable() return false end
function modifier_custom_blink_shield:OnCreated(table)
self.parent = self:GetParent()
self.shield_talent = "modifier_queen_blink_2"
self.max_shield = self.parent:GetTalentValue("modifier_queen_blink_2", "shield")*self.parent:GetIntellect(false)/100

if not IsServer() then return end
self.RemoveForDuel = true
self:SetStackCount(self.max_shield)
end

function modifier_custom_blink_shield:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_custom_blink_shield:GetModifierIncomingDamageConstant( params )

if IsClient() then 
	if params.report_max then 
		return self.max_shield
	else 
     	return self:GetStackCount()
    end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end




modifier_custom_blink_spell_block = class({})
function modifier_custom_blink_spell_block:IsHidden() return true end
function modifier_custom_blink_spell_block:IsPurgable() return false end
function modifier_custom_blink_spell_block:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end 
self.particle = ParticleManager:CreateParticle("particles/shadow_fiend/requiem_block.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle, true, false, -1, false, false)
end

function modifier_custom_blink_spell_block:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSORB_SPELL
}
end

function modifier_custom_blink_spell_block:GetAbsorbSpell(params) 
if not IsServer() then return end
if params.ability:GetCaster():GetTeamNumber() == self.parent:GetTeamNumber() then return end

if self.particle then 
	ParticleManager:DestroyParticle(self.particle, false)
	ParticleManager:ReleaseParticleIndex(self.particle)
end 

self.block = true
self.parent:EmitSound("DOTA_Item.LinkensSphere.Activate")
self:Destroy()
return 1 
end
