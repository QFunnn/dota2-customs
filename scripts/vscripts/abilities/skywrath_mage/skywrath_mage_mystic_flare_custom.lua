--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skywrath_mage_mystic_flare_custom_thinker", "abilities/skywrath_mage/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_mystic_flare_custom_tracker", "abilities/skywrath_mage/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_mystic_flare_custom_perma", "abilities/skywrath_mage/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_mystic_flare_custom_legendary_caster", "abilities/skywrath_mage/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_mystic_flare_custom_legendary_move", "abilities/skywrath_mage/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_mystic_flare_custom_damage_inc", "abilities/skywrath_mage/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_mystic_flare_custom_miss_chance", "abilities/skywrath_mage/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_mystic_flare_custom_cd_count", "abilities/skywrath_mage/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_mystic_flare_custom_arcana_hit", "abilities/skywrath_mage/skywrath_mage_mystic_flare_custom", LUA_MODIFIER_MOTION_NONE)

skywrath_mage_mystic_flare_custom = class({})
	
function skywrath_mage_mystic_flare_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "skywrath_mage_mystic_flare", self)
end

function skywrath_mage_mystic_flare_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/skywrath/flare_base.vpcf", context )
PrecacheResource( "particle", "particles/skywrath/seal_legendary_self.vpcf", context )
PrecacheResource( "particle", "particles/skywrath/seal_legendary_self_v2.vpcf", context )
PrecacheResource( "particle", "particles/skywrath/flare_legendary_shields.vpcf", context )
PrecacheResource( "particle", "particles/skywrath/flare_mark.vpcf", context )
PrecacheResource( "particle", "particles/items3_fx/black_powder_blind_debuff.vpcf", context )
PrecacheResource( "particle", "particles/lc_odd_proc_.vpcf", context )
end




function skywrath_mage_mystic_flare_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_skywrath_mage_mystic_flare_custom_tracker"
end

function skywrath_mage_mystic_flare_custom:GetAOERadius()
return self:GetSpecialValueFor("radius") + self:GetCaster():GetTalentValue("modifier_sky_flare_1", "radius")
end

function skywrath_mage_mystic_flare_custom:OnAbilityPhaseStart()
local caster = self:GetCaster()

if caster:HasTalent("modifier_sky_flare_7") then 
	if caster.current_model == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then 
		return true
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_TELEPORT, math.min(1, 7.85/self:GetCaster():GetTalentValue("modifier_sky_flare_7", "channel")))
else
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
end

return true
end

function skywrath_mage_mystic_flare_custom:OnAbilityPhaseInterrupted()
local caster = self:GetCaster()

local gesture = ACT_DOTA_CAST_ABILITY_4
if self:GetCaster():HasTalent("modifier_sky_flare_7") then

	if caster.current_model == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then 
		return 
	end 
	gesture = ACT_DOTA_TELEPORT
end
caster:FadeGesture(gesture)
end


function skywrath_mage_mystic_flare_custom:OnSpellStart(new_target)
local caster = self:GetCaster()

local target_point = self:GetCursorPosition()    

local duration = self:GetSpecialValueFor("duration")

if caster:HasTalent("modifier_sky_flare_7") then 
	duration = caster:GetTalentValue("modifier_sky_flare_7", "channel")
end

caster:EmitSound("Hero_SkywrathMage.MysticFlare.Cast")
self.thinker = CreateModifierThinker(caster, self, "modifier_skywrath_mage_mystic_flare_custom_thinker", {duration = duration}, target_point, caster:GetTeamNumber(), false)

if caster:HasTalent("modifier_sky_flare_6") then 
	caster:AddNewModifier(caster, self, "modifier_generic_debuff_immune", {duration = caster:GetTalentValue("modifier_sky_flare_6", "bkb"), effect = 1})
end

if caster:HasTalent("modifier_sky_flare_7") then 
	caster:AddNewModifier(caster, self, "modifier_skywrath_mage_mystic_flare_custom_legendary_caster", {duration = duration, thinker = self.thinker:entindex()})
end

end



modifier_skywrath_mage_mystic_flare_custom_thinker = class({})
function modifier_skywrath_mage_mystic_flare_custom_thinker:IsHidden() return false end
function modifier_skywrath_mage_mystic_flare_custom_thinker:IsPurgable() return true end
function modifier_skywrath_mage_mystic_flare_custom_thinker:OnCreated()

self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.parent_loc = self.parent:GetAbsOrigin()

self.radius = self.ability:GetSpecialValueFor("radius") + self.caster:GetTalentValue("modifier_sky_flare_1", "radius")
self.damage = self.ability:GetSpecialValueFor("damage") + self.caster:GetTalentValue("modifier_sky_flare_1", "damage")
self.damage_interval = self.ability:GetSpecialValueFor("damage_interval")
self.duration = self:GetRemainingTime()
self.damage_per_instance = self.damage / (1 / self.damage_interval)

self.stun_damage = self.caster:GetTalentValue("modifier_sky_flare_4", "damage")/100
self.stun_max = self.caster:GetTalentValue("modifier_sky_flare_4", "max")
self.stun_duration = self.caster:GetTalentValue("modifier_sky_flare_4", "stun")

self.miss_duration = self.caster:GetTalentValue("modifier_sky_flare_6", "duration")

self.hero_max = self.caster:GetTalentValue("modifier_sky_flare_5", "duration", true) - self.damage_interval

if not IsServer() then return end

self.cd_inc = self.caster:GetTalentValue("modifier_sky_flare_5", "cd", true)
self.cd_mod = self.caster:AddNewModifier(self.caster, self.ability, "modifier_skywrath_mage_mystic_flare_custom_cd_count", {duration = self.duration + 0.5})
self.ability:EndCd()
self.count = 0
self.damage_bonus = 0
self.legendary_damage = 0
self.hero_timer = 0

self.sound = wearables_system:GetSoundReplacement(self.caster, "Hero_SkywrathMage.MysticFlare", self)

if self.caster:HasTalent("modifier_sky_flare_7") then 
	self.damage_bonus = self.caster:GetTalentValue("modifier_sky_flare_7", "damage")/100 - 1
	self.legendary_damage = self.caster:GetTalentValue("modifier_sky_flare_7", "damage_inc")/100
	self.sound = "Sky.Flare_legendary"
end

self.hit_targets = {}

local particle = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/skywrath/flare_base.vpcf", self)

self.core_particle_fx = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, self.parent)        
ParticleManager:SetParticleControl(self.core_particle_fx, 0 , self.parent_loc)
ParticleManager:SetParticleControl(self.core_particle_fx, 1, Vector(self.radius, self.duration, self.damage_interval))
self:AddParticle(self.core_particle_fx, false, false, -1, false, false) 

self.parent:EmitSound(self.sound)
self:StartIntervalThink(self.damage_interval)
end

function modifier_skywrath_mage_mystic_flare_custom_thinker:OnIntervalThink()
if not IsServer() then return end       

if self.caster:HasTalent("modifier_sky_flare_7") then 
	self.damage_bonus = self.damage_bonus + self.legendary_damage*self.damage_interval
end

self.parent_loc = self.parent:GetAbsOrigin()

AddFOWViewer(self.caster:GetTeamNumber(), self.parent_loc, self.radius*3, self.damage_interval*2, false)
local targets = self.caster:FindTargets(self.radius, self.parent_loc)

local damage = self.damage_per_instance*(1 + self.damage_bonus)
local damageTable = {attacker = self.caster, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability}
  
if #targets > 0 then 
	EmitSoundOnLocationWithCaster(self.parent_loc, "Hero_SkywrathMage.MysticFlare.Target", self.caster)
end

local hit_hero = false

for _,target in pairs (targets) do 

	if target:IsRealHero() then 
		hit_hero = true
	end

	if not self.hit_targets[target:entindex()] then 
		self.hit_targets[target:entindex()] = 0

		if self.caster:HasTalent("modifier_sky_flare_6") then 
			target:AddNewModifier(self.caster, self.ability, "modifier_skywrath_mage_mystic_flare_custom_miss_chance", {duration = self.miss_duration})
		end
	end

	local real_damage = damage
	local mod = target:FindModifierByName("modifier_skywrath_mage_mystic_flare_custom_damage_inc")
	if mod then 
		mod:SetDuration(self:GetRemainingTime() + 0.5, true)
		real_damage = real_damage*(1 + mod:GetStackCount()*self.stun_damage)
		
		if mod:GetStackCount() >= self.stun_max and self.hit_targets[target:entindex()] and self.hit_targets[target:entindex()] == 0 then
			self.hit_targets[target:entindex()] = 1 
			target:GenericParticle("particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_end.vpcf")
			target:EmitSound("Sky.Flare_stun")
			target:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.stun_duration})
		end
	end

	damageTable.damage = real_damage        
	damageTable.victim = target


	if self.caster.current_model == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then 
		target:AddNewModifier(self.caster, self.ability, "modifier_skywrath_mage_mystic_flare_custom_arcana_hit", {duration = 1})
	end

	DoDamage(damageTable)             
end

if hit_hero and self.hero_timer < self.hero_max then 
	self.hero_timer = self.hero_timer + self.damage_interval
	if self.hero_timer >= self.hero_max then 

		if self.caster:GetQuest() == "Sky.Quest_8" and not self.caster:QuestCompleted() then 
			self.caster:UpdateQuest(1)
		end

		self.caster:AddNewModifier(self.caster, self.ability, "modifier_skywrath_mage_mystic_flare_custom_perma", {})
	end
end

end

function modifier_skywrath_mage_mystic_flare_custom_thinker:OnDestroy()
if not IsServer() then return end

for index,i in pairs(self.hit_targets) do 
	local target = EntIndexToHScript(index)
	if target and not target:IsNull() then 
		target:RemoveModifierByName("modifier_skywrath_mage_mystic_flare_custom_damage_inc")
	end
end

self.ability:StartCd()


if self.cd_mod and not self.cd_mod:IsNull() then 
	local cd = self.cd_mod:GetStackCount()*self.cd_inc
	self.caster:CdAbility(self.ability, cd)
	self.cd_mod:Destroy()
end

self.parent:StopSound(self.sound)
end




modifier_skywrath_mage_mystic_flare_custom_tracker = class({})
function modifier_skywrath_mage_mystic_flare_custom_tracker:IsHidden() return true end
function modifier_skywrath_mage_mystic_flare_custom_tracker:IsPurgable() return false end
function modifier_skywrath_mage_mystic_flare_custom_tracker:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.parent:AddSpellEvent(self)

self.cd_inc = self.parent:GetTalentValue("modifier_sky_flare_5", "cd", true)
end


function modifier_skywrath_mage_mystic_flare_custom_tracker:DeclareFunctions()
return
{
 	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
 	MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
}
end

function modifier_skywrath_mage_mystic_flare_custom_tracker:GetModifierCastRangeBonusStacking()
if not self.parent:HasTalent("modifier_sky_flare_3") then return end 
return self.parent:GetTalentValue("modifier_sky_flare_3", "range")
end

function modifier_skywrath_mage_mystic_flare_custom_tracker:GetModifierPercentageManacostStacking()
if not self.parent:HasTalent("modifier_sky_flare_3") then return end 
return self.parent:GetTalentValue("modifier_sky_flare_3", "mana")
end

function modifier_skywrath_mage_mystic_flare_custom_tracker:SpellEvent(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_sky_flare_5") then return end 
if params.unit ~= self.parent then return end
if params.ability:GetName() == "skywrath_mage_mystic_flare_custom_legendary" then return end

local mod = self.parent:FindModifierByName("modifier_skywrath_mage_mystic_flare_custom_cd_count")
if mod then 
	mod:IncrementStackCount()
else 
	self.parent:CdAbility(self.ability, self.cd_inc)
end

end



modifier_skywrath_mage_mystic_flare_custom_legendary_caster = class({})
function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:IsHidden() return true end
function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:IsPurgable() return false end
function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:OnCreated(table)
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.damage_reduce = self.caster:GetTalentValue("modifier_sky_flare_7", "damage_reduce")
self.move_duration = self.caster:GetTalentValue("modifier_sky_flare_7", "move_duration")

if not IsServer() then return end

self.caster:AddOrderEvent(self)

self.thinker = EntIndexToHScript(table.thinker)

if not self.ability:IsHidden() then 
	self.caster:SwapAbilities(self.ability:GetName(), "skywrath_mage_mystic_flare_custom_legendary", false, true)
end

if self.caster:HasUnequipItem(185391) then  
	self.caster:GenericParticle("particles/skywrath/seal_legendary_self_v2.vpcf", self)
else 
	self.caster:GenericParticle("particles/skywrath/seal_legendary_self.vpcf", self)
end
self.max_time = self:GetRemainingTime()

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end


function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:OnIntervalThink()
if not IsServer() then return end

self.caster:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self:GetRemainingTime(), use_zero = 1, priority = 1, style = "SkyFlare"})
end

function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:OnDestroy()
if not IsServer() then return end

self.caster:UpdateUIshort({hide = 1, hide_full = 1, priority = 1, style = "SkyFlare"})

self.caster:FadeGesture(ACT_DOTA_TELEPORT)
self.caster:StartGesture(ACT_DOTA_TELEPORT_END)

if self.thinker and not self.thinker:IsNull() then 
	self.thinker:RemoveModifierByName("modifier_skywrath_mage_mystic_flare_custom_thinker")
end

if self.ability:IsHidden() then 
	self.caster:SwapAbilities(self.ability:GetName(), "skywrath_mage_mystic_flare_custom_legendary", true, false)
end

end

function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
  MODIFIER_PROPERTY_DISABLE_TURNING,
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:GetModifierIgnoreCastAngle()
return 1
end

function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:GetModifierDisableTurning()
return 1
end

function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:GetOverrideAnimation()
if self.caster.current_model == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
	return ACT_DOTA_TELEPORT
end

end

function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end

function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:GetStatusEffectName()
local pfx = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "status_effect_arcana_legendary", self)
if pfx ~= "status_effect_arcana_legendary" then 
	return "particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_gold_dire.vpcf"
else 
	return "particles/econ/items/necrolyte/necro_ti9_immortal/status_effect_necro_ti9_immortal_shroud.vpcf"
end

end

function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end


function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true,
	[MODIFIER_STATE_DISARMED] = true,
}
end


function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:SetPos(x, y)
if not self.thinker or self.thinker:IsNull() then return end

self.thinker:RemoveModifierByName("modifier_skywrath_mage_mystic_flare_custom_legendary_move")
self.thinker:AddNewModifier(self.caster, self.ability, "modifier_skywrath_mage_mystic_flare_custom_legendary_move", {x = x, y = y, duration = self.move_duration})
end


function modifier_skywrath_mage_mystic_flare_custom_legendary_caster:OrderEvent( params )

if params.order_type==DOTA_UNIT_ORDER_STOP or params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION then
  self:Destroy()
end

end











skywrath_mage_mystic_flare_custom_legendary = class({})

function skywrath_mage_mystic_flare_custom_legendary:GetCooldown(iLevel)
return self:GetCaster():GetTalentValue("modifier_sky_flare_7", "move_cd")
end

function skywrath_mage_mystic_flare_custom_legendary:GetAOERadius()
return self:GetSpecialValueFor("radius") + self:GetCaster():GetTalentValue("modifier_sky_flare_1", "radius")
end

function skywrath_mage_mystic_flare_custom_legendary:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()

local vec = point - caster:GetAbsOrigin()
local range = self:GetSpecialValueFor("AbilityCastRange") + caster:GetCastRangeBonus()

if vec:Length2D() > range then 
		point = caster:GetAbsOrigin() + vec:Normalized()*range
end

local mod = caster:FindModifierByName("modifier_skywrath_mage_mystic_flare_custom_legendary_caster")

if not mod then return end

mod:SetPos(point.x, point.y)
end



modifier_skywrath_mage_mystic_flare_custom_legendary_move = class({})
function modifier_skywrath_mage_mystic_flare_custom_legendary_move:IsHidden() return true end
function modifier_skywrath_mage_mystic_flare_custom_legendary_move:IsPurgable() return false end
function modifier_skywrath_mage_mystic_flare_custom_legendary_move:OnCreated(table)
self.parent = self:GetParent()
self.duration = self:GetRemainingTime()

if not IsServer() then return end 
self.parent:EmitSound("Sky.Flare_move")
self.point = GetGroundPosition(Vector(table.x, table.y, 0), nil)
self.vec = self.point - self.parent:GetAbsOrigin()
self.length = self.vec:Length2D()
self.speed = self.length/self.duration
self.interaval = 0.01

self:StartIntervalThink(0.01)
end

function modifier_skywrath_mage_mystic_flare_custom_legendary_move:OnIntervalThink()
if not IsServer() then return end
if not self.parent or self.parent:IsNull() then return end

local pos = self.parent:GetAbsOrigin() + self.vec:Normalized()*self.speed*self.interaval
self.parent:SetAbsOrigin(GetGroundPosition(pos, nil))

if (self.parent:GetAbsOrigin() - self.point):Length2D() <= 10 then 
	self:Destroy()
	return
end

end



modifier_skywrath_mage_mystic_flare_custom_damage_inc = class({})
function modifier_skywrath_mage_mystic_flare_custom_damage_inc:IsHidden() return false end
function modifier_skywrath_mage_mystic_flare_custom_damage_inc:IsPurgable() return false end
function modifier_skywrath_mage_mystic_flare_custom_damage_inc:GetTexture() return "buffs/flare_damage" end
function modifier_skywrath_mage_mystic_flare_custom_damage_inc:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.max = self.caster:GetTalentValue("modifier_sky_flare_4",  "max")

if not IsServer() then return end
self.particle = self.parent:GenericParticle("particles/skymage/bolt_root_stack.vpcf", self, true)
self:SetStackCount(1)
end

function modifier_skywrath_mage_mystic_flare_custom_damage_inc:OnRefresh(table)
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()

if self:GetStackCount() >= self.max then 

	if self.particle then 
		ParticleManager:DestroyParticle(self.particle, false)
		ParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end

	self.parent:GenericParticle("particles/skywrath/flare_mark.vpcf", self, true)
end

end

function modifier_skywrath_mage_mystic_flare_custom_damage_inc:OnStackCountChanged(iStackCount)
if not IsServer() then return end 

if self.particle then 
	ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
end

end






modifier_skywrath_mage_mystic_flare_custom_miss_chance = class({})
function modifier_skywrath_mage_mystic_flare_custom_miss_chance:IsPurgable() return true end
function modifier_skywrath_mage_mystic_flare_custom_miss_chance:IsHidden() return false end
function modifier_skywrath_mage_mystic_flare_custom_miss_chance:GetTexture() return "buffs/flare_miss" end
function modifier_skywrath_mage_mystic_flare_custom_miss_chance:GetEffectName() return "particles/items3_fx/black_powder_blind_debuff.vpcf" end

function modifier_skywrath_mage_mystic_flare_custom_miss_chance:OnCreated(params)
self.parent = self:GetParent()
self.miss_chance = self:GetCaster():GetTalentValue("modifier_sky_flare_6", "chance")
end

function modifier_skywrath_mage_mystic_flare_custom_miss_chance:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MISS_PERCENTAGE,
}      
end

function modifier_skywrath_mage_mystic_flare_custom_miss_chance:GetModifierMiss_Percentage()
if self.parent:HasModifier("modifier_tower_incoming_speed") then return end
return self.miss_chance
end



modifier_skywrath_mage_mystic_flare_custom_perma = class({})
function modifier_skywrath_mage_mystic_flare_custom_perma:IsHidden() return not self:GetCaster():HasTalent("modifier_sky_flare_5") end
function modifier_skywrath_mage_mystic_flare_custom_perma:IsPurgable() return false end
function modifier_skywrath_mage_mystic_flare_custom_perma:RemoveOnDeath() return false end
function modifier_skywrath_mage_mystic_flare_custom_perma:GetTexture() return "buffs/flare_perma" end
function modifier_skywrath_mage_mystic_flare_custom_perma:OnCreated()
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_sky_flare_5", "max", true)
self.cdr = self.parent:GetTalentValue("modifier_sky_flare_5", "cdr", true)

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_skywrath_mage_mystic_flare_custom_perma:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()
end

function modifier_skywrath_mage_mystic_flare_custom_perma:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self.parent:HasTalent("modifier_sky_flare_5") then return end

local particle_peffect = ParticleManager:CreateParticle("particles/lc_odd_proc_.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)

self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 


function modifier_skywrath_mage_mystic_flare_custom_perma:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end


function modifier_skywrath_mage_mystic_flare_custom_perma:GetModifierPercentageCooldown() 
if not self.parent:HasTalent("modifier_sky_flare_5") then return end
return self:GetStackCount()*self.cdr
end



modifier_skywrath_mage_mystic_flare_custom_cd_count = class({})
function modifier_skywrath_mage_mystic_flare_custom_cd_count:IsHidden() return true end
function modifier_skywrath_mage_mystic_flare_custom_cd_count:IsPurgable() return false end
function modifier_skywrath_mage_mystic_flare_custom_cd_count:RemoveOnDeath() return false end


modifier_skywrath_mage_mystic_flare_custom_arcana_hit = class({})
function modifier_skywrath_mage_mystic_flare_custom_arcana_hit:IsHidden() return true end
function modifier_skywrath_mage_mystic_flare_custom_arcana_hit:IsPurgable() return false end
function modifier_skywrath_mage_mystic_flare_custom_arcana_hit:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()

if not IsServer() then return end 
local part = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_mystic_flare_hit_ambient.vpcf"
if self.caster:HasUnequipItem(185391) then 
	part = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_mystic_flare_hit_ambient_v2.vpcf"
end

self.parent:GenericParticle(part, self)
end