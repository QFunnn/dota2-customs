--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_razor_static_link_custom", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_target", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_caster", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_attacking", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_legendary", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_legendary_no_damage", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_legendary_swap", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_legendary_target", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_spell", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_heal", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_armor", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_perma", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_static_link_custom_leash", "abilities/razor/razor_static_link_custom", LUA_MODIFIER_MOTION_NONE)

razor_static_link_custom = class({})

function razor_static_link_custom:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "razor_static_link", self)
end

function razor_static_link_custom:CreateTalent()
self:ToggleAutoCast()
end

function razor_static_link_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	
PrecacheResource( "particle","particles/items_fx/immunity_sphere_buff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_razor/razor_static_link.vpcf", context )
PrecacheResource( "particle","particles/razor/link_stun.vpcf", context )
PrecacheResource( "particle","particles/items_fx/immunity_sphere.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_razor/razor_static_link_buff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_razor/razor_static_link_debuff.vpcf", context )
PrecacheResource( "particle","particles/econ/items/razor/razor_arcana/razor_arcana_static_link_debuff.vpcf", context )
PrecacheResource( "particle","particles/razor/static_link_beam_custombeam.vpcf", context )
PrecacheResource( "particle","particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field.vpcf", context )
PrecacheResource( "particle","particles/razor/link_purge.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_nullifier.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf", context )
PrecacheResource( "particle","particles/rare_orb_patrol.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_invoker/invoker_deafening_blast_disarm_debuff.vpcf", context )
end




function razor_static_link_custom:GetBehavior()
local bonus = 0
if self:GetCaster():HasTalent("modifier_razor_link_6") then 
	bonus = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end 
return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + bonus
end

function razor_static_link_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_razor_link_2") then
	bonus = self:GetCaster():GetTalentValue("modifier_razor_link_2", "cd")
end
return self.BaseClass.GetCooldown( self, level ) + bonus
end

function razor_static_link_custom:GetCastPoint(iLevel)
local bonus = 0
if self:GetCaster():HasShard() then 
    bonus = self:GetSpecialValueFor("shard_cast")
end
return self.BaseClass.GetCastPoint(self) + bonus
end

function razor_static_link_custom:GetManaCost(level)
if self:GetCaster():HasShard() then 
  return self:GetSpecialValueFor("shard_mana")
end
return self.BaseClass.GetManaCost(self,level) 
end


function razor_static_link_custom:GetCastRange(vLocation, hTarget)
local bonus = 0
if self:GetCaster():HasTalent("modifier_razor_link_2") then 
	bonus = self:GetCaster():GetTalentValue("modifier_razor_link_2", "range")
end
return self:GetSpecialValueFor("AbilityCastRange") + bonus
end


function razor_static_link_custom:OnSpellStart(new_target)
local caster = self:GetCaster()
local target = self:GetCursorTarget()

if new_target then 
	target = new_target
end 

if not caster:HasTalent("modifier_razor_link_5") then 
	if target:TriggerSpellAbsorb(self) then return end
end 

local duration = self:GetSpecialValueFor("drain_length") + caster:GetTalentValue("modifier_razor_link_6", "link_duration")

caster:EmitSound("Ability.static.start")
caster:AddNewModifier(caster, self, "modifier_razor_static_link_custom", {target = target:entindex(), duration = duration})
end 


modifier_razor_static_link_custom = class({})
function modifier_razor_static_link_custom:IsHidden() return true end
function modifier_razor_static_link_custom:IsPurgable() return false end 
function modifier_razor_static_link_custom:OnCreated(table)

self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.status = self.caster:GetTalentValue("modifier_razor_link_5", "status")

if not IsServer() then return end
self.target = EntIndexToHScript(table.target)

self.ability:EndCd()

if not self.target or self.target:IsNull() then 
	self:Destroy()
	return
end 

self.caster:AddOrderEvent(self)

self.legendary = self.caster:FindAbilityByName("razor_static_link_custom_legendary")

if self.caster:HasTalent("modifier_razor_link_7") and self.legendary and self.legendary:IsHidden() then 
	self.caster:SwapAbilities(self.ability:GetName(), self.legendary:GetName(), false, true)
	self.legendary:StartCooldown(1)
end 

self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_attacking", {target = self.target:entindex()})

self.sound_ability = wearables_system:GetSoundReplacement(self.caster, "Ability.static.loop", self)

self.caster:EmitSound(self.sound_ability)
self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)

self.total_duration = self.ability:GetSpecialValueFor("drain_length")
self.total_damage = self.ability:GetSpecialValueFor("drain_rate") * self.total_duration

if self.caster:HasTalent("modifier_razor_link_6") then 
	self.total_duration = self.total_duration + self.caster:GetTalentValue("modifier_razor_link_6", "link_duration")
end 

local mod = self.caster:FindModifierByName("modifier_razor_static_link_custom_perma")
if mod and self.caster:HasTalent("modifier_razor_link_4") then 
	self.total_damage = self.total_damage + mod:GetStackCount()*self.caster:GetTalentValue("modifier_razor_link_4", "damage")
end 

if self.target:IsCreep() then 
	self.total_damage = self.total_damage*(1 + self.ability:GetSpecialValueFor("creeps_damage")/100)
end 

self.damage_rate = self.total_damage/self.total_duration
self.sphere = nil

if self.caster:HasTalent("modifier_razor_link_5") then 
	self.sphere = ParticleManager:CreateParticle("particles/items_fx/immunity_sphere_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(self.sphere, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	self:AddParticle( self.sphere, false, false, -1, false, false )
end 

self.max_range = self.ability:GetSpecialValueFor("AbilityCastRange") + self.caster:GetTalentValue("modifier_razor_link_2", "range") + self.caster:GetCastRangeBonus() + self.ability:GetSpecialValueFor("drain_range_buffer")
self.duration = self.ability:GetSpecialValueFor("drain_duration")
self.vision_radius = self.ability:GetSpecialValueFor("vision_radius")
self.target_damage = self.ability:GetSpecialValueFor("target_damage")/100
self.damage_count = 0 
self.spell_count = 0
self.spell_inc = 0
self.armor_count = 0
self.armor_inc = 0

self.spell_duration = self.caster:GetTalentValue("modifier_razor_link_3", "duration")
self.heal_duration = self.caster:GetTalentValue("modifier_razor_link_4", "duration")
self.armor_duration = self.caster:GetTalentValue("modifier_razor_link_1", "duration")

self.interval = 0.03

self.target:RemoveModifierByName("modifier_razor_static_link_custom_target")
self.caster:RemoveModifierByName("modifier_razor_static_link_custom_caster")
self.target:RemoveModifierByName("modifier_razor_static_link_custom_spell")
self.caster:RemoveModifierByName("modifier_razor_static_link_custom_armor")
self.target:RemoveModifierByName("modifier_razor_static_link_custom_armor")

self.target_mod = self.target:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_target", {})
self.caster_mod = self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_caster", {})

if self.caster:HasTalent("modifier_razor_link_1") then
	self.armor_inc = (self.caster:GetTalentValue("modifier_razor_link_1", "armor")/self.total_duration)
	self.caster_mod_armor = self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_armor", {})
	self.target_mod_armor = self.target:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_armor", {})
end

if self.caster:HasTalent("modifier_razor_link_3") then 
	self.spell_inc = self.caster:GetTalentValue("modifier_razor_link_3", "spell")/self.total_duration
	self.target_mod_spell = self.target:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_spell", {})
end 

if self.caster:HasTalent("modifier_razor_link_4") then 
	self.heal_mod = self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_heal", {})
end

if self.caster:HasShard() then 
	self.leash_mod = self.target:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_leash", {duration = (1 - self.target:GetStatusResistance())*self.ability:GetSpecialValueFor("shard_leash")})
end 

local particleFile = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_razor/razor_static_link.vpcf", self)

self.particle = ParticleManager:CreateParticle(particleFile, PATTACH_POINT_FOLLOW, self.caster)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_static", self.caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.particle, 1, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.target:GetAbsOrigin(), true)
self:AddParticle( self.particle, false, false, -1, false, false )

if self.caster:HasTalent("modifier_razor_link_6") and self.ability:GetAutoCastState() == true then 
	local dir = ( self.caster:GetAbsOrigin() - self.target:GetAbsOrigin())

	local distance = math.min(self.caster:GetTalentValue("modifier_razor_link_6", "knock_distance_max"), dir:Length2D()*self.caster:GetTalentValue("modifier_razor_link_6", "knock_distance")/100)
	local point = self.target:GetAbsOrigin() + distance*dir:Normalized()
	local duration =  self.caster:GetTalentValue("modifier_razor_link_6", "knock_duration")

	self.target:EmitSound("Razor.Link_pull")
	local knockbackProperties =
	{
      target_x = point.x,
      target_y = point.y,
      distance = distance,
      speed = distance/duration,
      height = 0,
      fix_end = true,
      isStun = false,
      activity = ACT_DOTA_FLAIL,
	}
	self.target:AddNewModifier( self.caster, self.ability, "modifier_generic_arc", knockbackProperties )
end 


self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end


function modifier_razor_static_link_custom:OnIntervalThink()
if not IsServer() then return end

if not self.target or self.target:IsNull() or not self.target:IsAlive() or 
	(self.target:GetAbsOrigin() - self.caster:GetAbsOrigin()):Length2D() > self.max_range then 

	self:Destroy()
	return
end 

AddFOWViewer(self.caster:GetTeamNumber(), self.target:GetAbsOrigin(), self.vision_radius, self.interval*2, true)

self.damage_count = self.damage_count + self.damage_rate*self.interval
self.spell_count = self.spell_count + self.spell_inc*self.interval
self.armor_count = self.armor_count + self.armor_inc*self.interval

if self.target_mod and not self.target_mod:IsNull() then 
	self.target_mod:SetStackCount(self.damage_count*self.target_damage)
end 

if self.caster_mod and not self.caster_mod:IsNull() then 
	self.caster_mod:SetStackCount(self.damage_count)
end 

if self.caster_mod_armor and not self.caster_mod_armor:IsNull() then 
	self.caster_mod_armor:SetStackCount(self.armor_count)
end 

if self.target_mod_armor and not self.target_mod_armor:IsNull() then 
	self.target_mod_armor:SetStackCount(self.armor_count)
end 

if self.target_mod_spell and not self.target_mod_spell:IsNull() then 
	self.target_mod_spell:SetStackCount(self.spell_count)
end 

end 


function modifier_razor_static_link_custom:OnDestroy()

if self.target_mod and not self.target_mod:IsNull() then 
	self.target_mod:SetDuration(self.duration, true)
end 

if self.caster_mod and not self.caster_mod:IsNull() then 
	self.caster_mod:SetDuration(self.duration, true)
end 

if self.target_mod_armor and not self.target_mod_armor:IsNull() then 
	self.target_mod_armor:SetDuration(self.armor_duration, true)
end 

if self.caster_mod_armor and not self.caster_mod_armor:IsNull() then 
	self.caster_mod_armor:SetDuration(self.armor_duration, true)
end 

if self.target_mod_spell and not self.target_mod_spell:IsNull() then 
	self.target_mod_spell:SetDuration(self.spell_duration, true)
end 

if self.leash_mod and not self.leash_mod:IsNull() then 
	self.leash_mod:Destroy()
end 

if self.heal_mod and not self.heal_mod:IsNull() then
	self.heal_mod:SetDuration(self.heal_duration, true)
end

if not IsServer() then return end

self.ability:StartCd()

if (self:GetRemainingTime() <= 0.1 or not self.target or self.target:IsNull() or not self.target:IsAlive()) then 
	if self.caster:GetQuest() == "Razor.Quest_6" and self.target:IsRealHero() then 
		self.caster:UpdateQuest(1)
	end 

	if self.target and not self.target:IsNull() and self.target:IsRealHero() then 
		self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_perma", {}) 
	end 

	if self.caster:HasTalent("modifier_razor_link_6") then
		local effect_cast = ParticleManager:CreateParticle( "particles/razor/link_stun.vpcf", PATTACH_OVERHEAD_FOLLOW, self.target )
		ParticleManager:SetParticleControl( effect_cast, 0,  self.target:GetOrigin() )
		ParticleManager:SetParticleControl( effect_cast, 1, self.target:GetOrigin() )
		ParticleManager:ReleaseParticleIndex(effect_cast)

		self.target:EmitSound("Generic.Fear")
		self.target:AddNewModifier(self.caster, self:GetAbility(), "modifier_nevermore_requiem_fear", {duration  = self.caster:GetTalentValue("modifier_razor_link_6", "stun") * (1 - self.target:GetStatusResistance())})
	end 
end 

self.caster:RemoveModifierByName("modifier_razor_static_link_custom_attacking")

self.caster:StopSound(self.sound_ability)
self.caster:EmitSound("Ability.static.end")

if self.caster:HasTalent("modifier_razor_link_7")then 
	local mod = self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_legendary_swap", {duration = self.caster:GetTalentValue("modifier_razor_link_7", "swap")})

	if not mod then 

		self.legendary = self.caster:FindAbilityByName("razor_static_link_custom_legendary")

		if self.caster:HasTalent("modifier_razor_link_7") and self.legendary and self.ability:IsHidden() then 
			self.caster:SwapAbilities(self.ability:GetName(), self.legendary:GetName(), true, false)
		end 
	end 
end 

end

function modifier_razor_static_link_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
  	MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	MODIFIER_PROPERTY_ABSORB_SPELL,
}

end

function modifier_razor_static_link_custom:GetModifierStatusResistanceStacking() 
if not self.caster:HasTalent("modifier_razor_link_5") then return end 
return self.status
end

function modifier_razor_static_link_custom:GetAbsorbSpell(params) 
if params.ability:GetCaster():GetTeamNumber() == self.caster:GetTeamNumber() then return end
if self.sphere == nil then return end

local particle = ParticleManager:CreateParticle("particles/items_fx/immunity_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:SetParticleControlEnt(particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

self.caster:EmitSound("DOTA_Item.LinkensSphere.Activate")

if self.sphere then 
	ParticleManager:DestroyParticle(self.sphere, false)
	ParticleManager:ReleaseParticleIndex(self.sphere)
	self.sphere = nil
end

return 1 
end


function modifier_razor_static_link_custom:GetOverrideAnimation()
return ACT_DOTA_OVERRIDE_ABILITY_2
end


function modifier_razor_static_link_custom:OrderEvent( params )

if params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET and params.target  then
	if params.target ~= self.target then 
		self.caster:RemoveModifierByName("modifier_razor_static_link_custom_attacking")
	end

	if params.target == self.target then 
		self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_attacking", {target = self.target:entindex()})
	end 
end 

if params.order_type == DOTA_UNIT_ORDER_STOP or params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION  then 
	--self.caster:RemoveModifierByName("modifier_razor_static_link_custom_attacking")
end 

end



modifier_razor_static_link_custom_attacking = class({})
function modifier_razor_static_link_custom_attacking:IsHidden() return true end
function modifier_razor_static_link_custom_attacking:IsPurgable() return false end 
function modifier_razor_static_link_custom_attacking:OnCreated(table)
if not IsServer() then return end

self.target = EntIndexToHScript(table.target)

if not self.target or self.target:IsNull() then 
	self:Destroy()
	return
end 


self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.attack_count = 0
self.attack_max = 1/self.caster:GetAttacksPerSecond(true)

self.interval = 0.03
self:OnIntervalThink()
self:StartIntervalThink(self.interval)

end 

function modifier_razor_static_link_custom_attacking:OnIntervalThink()
if not IsServer() then return end 

if not self.target or self.target:IsNull() or not self.target:IsAlive()  then 

	self:Destroy()
	return
end 

self.attack_count = self.attack_count + self.interval
self.attack_max = 1/self.caster:GetAttacksPerSecond(true)


local dir = (self.target:GetAbsOrigin() - self.caster:GetAbsOrigin())

if self.attack_count >= self.attack_max --and dir:Length2D() <= self.caster:Script_GetAttackRange()
 and not self.caster:IsStunned() and not self.caster:IsHexed() and not dota1x6:CheckDisarm(self.caster) and not self.caster:IsChanneling() then 

	self.attack_count = 0

	self.caster:FadeGesture(ACT_DOTA_ATTACK)
	self.caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, self.caster:GetDisplayAttackSpeed() / 100)
	self.caster:PerformAttack(self.target, true, true, false, false, true, false, false)
end 

dir.z = 0

if not self.caster:IsCurrentlyHorizontalMotionControlled() and not self.caster:IsCurrentlyVerticalMotionControlled() then
	self.caster:SetForwardVector(dir:Normalized())
	self.caster:FaceTowards(self.target:GetAbsOrigin())

end 

end 

function modifier_razor_static_link_custom_attacking:DeclareFunctions()
	local funcs = {
    	MODIFIER_PROPERTY_DISABLE_TURNING,
	}

	return funcs
end

function modifier_razor_static_link_custom_attacking:GetModifierDisableTurning()
	return 1
end


function modifier_razor_static_link_custom_attacking:CheckState()
return
{
	[MODIFIER_STATE_DISARMED] = true
}
end




modifier_razor_static_link_custom_caster = class({})
function modifier_razor_static_link_custom_caster:IsHidden() return false end 
function modifier_razor_static_link_custom_caster:IsPurgable() return false end
function modifier_razor_static_link_custom_caster:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_razor_static_link_custom_caster:OnCreated()
if not IsServer() then return end
self.RemoveForDuel = true
local particle_name = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_razor/razor_static_link_buff.vpcf", self)
self.particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
self:AddParticle( self.particle, false, false, -1, false, false )
end 


function modifier_razor_static_link_custom_caster:OnStackCountChanged(iStackCount)
if not IsServer() then return end 
if not self.particle then return end 

ParticleManager:SetParticleControl(self.particle, 1, Vector(self:GetStackCount(), 0, 0))
end 

function modifier_razor_static_link_custom_caster:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end 


function modifier_razor_static_link_custom_caster:GetModifierPreAttack_BonusDamage()
return self:GetStackCount()
end


modifier_razor_static_link_custom_target = class({})
function modifier_razor_static_link_custom_target:IsHidden() return false end 
function modifier_razor_static_link_custom_target:IsPurgable() return false end
function modifier_razor_static_link_custom_target:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_razor_static_link_custom_target:OnCreated()
if not IsServer() then return end

self.RemoveForDuel = true
local particle_name = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_razor/razor_static_link_debuff.vpcf", self)
self.particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
self:AddParticle( self.particle, false, false, -1, false, false )
end 


function modifier_razor_static_link_custom_target:OnStackCountChanged(iStackCount)
if not IsServer() then return end 
if not self.particle then return end 

ParticleManager:SetParticleControl(self.particle, 1, Vector(self:GetStackCount(), 0, 0))
end 

function modifier_razor_static_link_custom_target:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end 


function modifier_razor_static_link_custom_target:GetModifierPreAttack_BonusDamage()
return self:GetStackCount()*-1
end




modifier_razor_static_link_custom_legendary = class({})

function modifier_razor_static_link_custom_legendary:IsHidden() return true end
function modifier_razor_static_link_custom_legendary:IsPurgable() return false end 
function modifier_razor_static_link_custom_legendary:IsDebuff() return false end

function modifier_razor_static_link_custom_legendary:OnCreated(table)
if not IsServer() then return end

self.target = EntIndexToHScript(table.target)

if not self.target or self.target:IsNull() then 
	self:Destroy()
	return
end 

self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.caster:EmitSound("Razor.Link_legendary_loop1")
self.caster:EmitSound("Razor.Link_legendary_loop2")
self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)

self.radius = self.caster:GetTalentValue("modifier_razor_link_7", "radius")
self.max_range = self.ability:GetSpecialValueFor("AbilityCastRange") +  self.caster:GetCastRangeBonus() + self.ability:GetSpecialValueFor("drain_range_buffer")
self.duration = self.ability:GetSpecialValueFor("drain_duration")
self.damage_rate = self.ability:GetSpecialValueFor("drain_rate")
self.vision_radius = self.ability:GetSpecialValueFor("vision_radius")

self.target_mod = self.target:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_legendary_target", {})

self.particle = ParticleManager:CreateParticle("particles/razor/static_link_beam_custombeam.vpcf", PATTACH_POINT_FOLLOW, self.target)
ParticleManager:SetParticleControlEnt(self.particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_static", self.caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.particle, 1, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.target:GetAbsOrigin(), true)
self:AddParticle( self.particle, false, false, -1, false, false )

self.attack_count = self.caster:GetTalentValue("modifier_razor_link_7", "attack")
self.interval = 0.01

self.damage_interval = self.caster:GetTalentValue("modifier_razor_link_7", "duration")/self.attack_count - 0.01
self.damage_count = 0
self.attacks = 0

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end


function modifier_razor_static_link_custom_legendary:OnIntervalThink()
if not IsServer() then return end

if not self.target or self.target:IsNull() or not self.target:IsAlive() or 
	(self.target:GetAbsOrigin() - self.caster:GetAbsOrigin()):Length2D() > self.max_range then 

	self:Destroy()
	return
end 

if not self.target:IsDebuffImmune() then
	self.target:Purge(true, false, false, false,false)
end

AddFOWViewer(self.caster:GetTeamNumber(), self.target:GetAbsOrigin(), self.vision_radius, self.interval*2, true)

local dir = (self.target:GetAbsOrigin() - self.caster:GetAbsOrigin())
dir.z = 0

if not self.caster:IsCurrentlyHorizontalMotionControlled() and not self.caster:IsCurrentlyVerticalMotionControlled() then
	self.caster:SetForwardVector(dir:Normalized())
	self.caster:FaceTowards(self.target:GetAbsOrigin())
end 
self.damage_count = self.damage_count + self.interval

if self.attacks >= self.attack_count then return end
if self.damage_count < self.damage_interval then return end 

self.damage_count = 0
self.attacks = self.attacks + 1

self.target:GenericParticle("particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field.vpcf")
self.target:EmitSound("Razor.Link_legendary_target")

for _,target in pairs(self.caster:FindTargets(self.radius, self.target:GetAbsOrigin())) do 
	self.caster:PerformAttack(target, true, true, true, true, false, false, true)
end

end 


function modifier_razor_static_link_custom_legendary:OnDestroy()
if not IsServer() then return end 

if self.target_mod and not self.target_mod:IsNull() then 
	self.target_mod:Destroy()
end 

self.caster:RemoveModifierByName("modifier_razor_static_link_custom_attacking")

self.caster:StopSound("Razor.Link_legendary_loop1")
self.caster:StopSound("Razor.Link_legendary_loop2")
self.caster:EmitSound("Ability.static.end")
self.caster:AddNewModifier(self.caster, self.ability, "modifier_razor_static_link_custom_legendary_no_damage", {duration = self.caster:GetTalentValue("modifier_razor_link_7", "lose_duration")})
end 

function modifier_razor_static_link_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    MODIFIER_PROPERTY_DISABLE_TURNING,
}
end

function modifier_razor_static_link_custom_legendary:GetOverrideAnimation()
return ACT_DOTA_OVERRIDE_ABILITY_2
end

function modifier_razor_static_link_custom_legendary:GetModifierDisableTurning()
return 1
end

function modifier_razor_static_link_custom_legendary:CheckState()
return
{
	[MODIFIER_STATE_DISARMED] = true
}
end





modifier_razor_static_link_custom_legendary_no_damage = class({})
function modifier_razor_static_link_custom_legendary_no_damage:IsDebuff() return true end
function modifier_razor_static_link_custom_legendary_no_damage:IsPurgable() return false end
function modifier_razor_static_link_custom_legendary_no_damage:IsHidden() return false end
function modifier_razor_static_link_custom_legendary_no_damage:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()

self.particle = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_static_link_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
self:AddParticle( self.particle, false, false, -1, false, false )
ParticleManager:SetParticleControl(self.particle, 1, Vector(200, 0, 0))

self.parent:GenericParticle("particles/units/heroes/hero_invoker/invoker_deafening_blast_disarm_debuff.vpcf", self, true)
end

function modifier_razor_static_link_custom_legendary_no_damage:CheckState()
return
{
	[MODIFIER_STATE_DISARMED] = true
}
end



razor_static_link_custom_legendary = class({})

function razor_static_link_custom_legendary:GetBehavior()
local bonus = 0
if self:GetCaster():HasModifier("modifier_razor_static_link_custom") then
	bonus = DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_AOE + bonus
end

function razor_static_link_custom_legendary:GetAOERadius()
return self:GetCaster():GetTalentValue("modifier_razor_link_7", "radius")
end


function razor_static_link_custom_legendary:OnSpellStart()
local caster = self:GetCaster()
self.ability = caster:FindAbilityByName("razor_static_link_custom")

caster:RemoveModifierByName("modifier_razor_static_link_custom")
caster:RemoveModifierByName("modifier_razor_static_link_custom_legendary_swap")

if not self.ability then return end

local target = self:GetCursorTarget()

caster:EmitSound("Razor.Link_legendary_start1")
caster:EmitSound("Razor.Link_legendary_start2")
caster:AddNewModifier(caster, self.ability, "modifier_razor_static_link_custom_legendary", {target = target:entindex(), duration = caster:GetTalentValue("modifier_razor_link_7", "duration")})
end 





modifier_razor_static_link_custom_legendary_swap = class({})
function modifier_razor_static_link_custom_legendary_swap:IsHidden() return true end
function modifier_razor_static_link_custom_legendary_swap:IsPurgable() return false end
function modifier_razor_static_link_custom_legendary_swap:OnDestroy()
if not IsServer() then return end 

self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.legendary = self.caster:FindAbilityByName("razor_static_link_custom_legendary")

if self.caster:HasTalent("modifier_razor_link_7") and self.legendary and self.ability:IsHidden() then 
	self.caster:SwapAbilities(self.ability:GetName(), self.legendary:GetName(), true, false)
end 

end 


modifier_razor_static_link_custom_legendary_target = class({})
function modifier_razor_static_link_custom_legendary_target:IsHidden() return true end
function modifier_razor_static_link_custom_legendary_target:IsPurgable() return false end
function modifier_razor_static_link_custom_legendary_target:GetEffectName()
return "particles/razor/link_purge.vpcf"
end 

function modifier_razor_static_link_custom_legendary_target:GetStatusEffectName()
return "particles/status_fx/status_effect_nullifier.vpcf"
end 

function modifier_razor_static_link_custom_legendary_target:StatusEffectPriority()
return MODIFIER_PRIORITY_SUPER_ULTRA 
end 



modifier_razor_static_link_custom_spell = class({})
function modifier_razor_static_link_custom_spell:IsHidden() return false end
function modifier_razor_static_link_custom_spell:IsPurgable() return false end
function modifier_razor_static_link_custom_spell:GetTexture() return "buffs/link_spell" end
function modifier_razor_static_link_custom_spell:GetEffectName()
return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf"
end

function modifier_razor_static_link_custom_spell:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_razor_static_link_custom_spell:OnCreated()
self.caster = self:GetCaster()

self.slow = self.caster:GetTalentValue("modifier_razor_link_3", "slow")
self.spell = self.caster:GetTalentValue("modifier_razor_link_3", "spell")
self.slow_k = self.slow/self.spell
end

function modifier_razor_static_link_custom_spell:GetModifierSpellAmplify_Percentage() 
return self:GetStackCount()*-1
end

function modifier_razor_static_link_custom_spell:GetModifierMoveSpeedBonus_Percentage() 
return self:GetStackCount()*self.slow_k*-1
end



modifier_razor_static_link_custom_armor = class({})
function modifier_razor_static_link_custom_armor:IsHidden() return false end
function modifier_razor_static_link_custom_armor:IsPurgable() return false end
function modifier_razor_static_link_custom_armor:GetTexture() return "buffs/moment_defence" end
function modifier_razor_static_link_custom_armor:DeclareFunctions()
return
{

  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_razor_static_link_custom_armor:OnCreated()
self.k = 1
if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
	self.k = -1
end
end

function modifier_razor_static_link_custom_armor:GetModifierPhysicalArmorBonus()
return self:GetStackCount()*self.k
end





modifier_razor_static_link_custom_heal = class({})
function modifier_razor_static_link_custom_heal:IsHidden() return false end
function modifier_razor_static_link_custom_heal:IsPurgable() return false end
function modifier_razor_static_link_custom_heal:GetTexture() return "buffs/link_heal" end
function modifier_razor_static_link_custom_heal:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()
if self.parent:IsRealHero() then 
	self.parent:AddDamageEvent_out(self)
end 

self.heal = self.parent:GetTalentValue("modifier_razor_link_4", "heal")/100
self.heal_creeps = self.parent:GetTalentValue("modifier_razor_link_4", "creeps")
end 

function modifier_razor_static_link_custom_heal:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:CheckLifesteal(params) then return end

local heal = self.heal*params.damage
if params.unit:IsCreep() then 
  heal = heal / self.heal_creeps
end

self.parent:GenericHeal(heal, self.ability, true, nil, "modifier_razor_link_4")
end





modifier_razor_static_link_custom_perma = class({})
function modifier_razor_static_link_custom_perma:IsHidden() return not self:GetParent():HasTalent("modifier_razor_link_4") end
function modifier_razor_static_link_custom_perma:IsPurgable() return false end
function modifier_razor_static_link_custom_perma:RemoveOnDeath() return false end
function modifier_razor_static_link_custom_perma:GetTexture() return "buffs/link_damage" end
function modifier_razor_static_link_custom_perma:OnCreated()
self.caster = self:GetParent()
self.max = self.caster:GetTalentValue("modifier_razor_link_4", "max", true)

if not IsServer() then return end 
self:SetStackCount(1)
self:Effect()
end 

function modifier_razor_static_link_custom_perma:OnRefresh(table)
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()
self:Effect()
end 

function modifier_razor_static_link_custom_perma:Effect()
if not IsServer() then return end
if self.caster:HasTalent("modifier_razor_link_4") then 

	self.caster:EmitSound("BS.Thirst_legendary_active")
	local particle_peffect = ParticleManager:CreateParticle("particles/rare_orb_patrol.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
	ParticleManager:SetParticleControl(particle_peffect, 0, self.caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_peffect, 2, self.caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_peffect)

end

end 

function modifier_razor_static_link_custom_perma:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_razor_static_link_custom_perma:OnTooltip()
if not self.caster:HasTalent("modifier_razor_link_4") then return end
return self:GetStackCount()*self.caster:GetTalentValue("modifier_razor_link_4", "damage")
end



modifier_razor_static_link_custom_leash = class({})
function modifier_razor_static_link_custom_leash:IsHidden() return true end
function modifier_razor_static_link_custom_leash:IsPurgable() return false end
function modifier_razor_static_link_custom_leash:OnCreated()
if not IsServer() then return end 
self.parent = self:GetParent()
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end 

function modifier_razor_static_link_custom_leash:OnIntervalThink()
if not IsServer() then return end 
if not self.parent:IsDebuffImmune() then return end
self:Destroy()
end 

function modifier_razor_static_link_custom_leash:CheckState()
return
{
	[MODIFIER_STATE_TETHERED] = true
}
end 