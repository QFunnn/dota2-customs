--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_enigma_innate_custom", "abilities/enigma/enigma_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_innate_custom_debuff", "abilities/enigma/enigma_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_innate_custom_bonus_effect", "abilities/enigma/enigma_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_innate_custom_bonus_cd", "abilities/enigma/enigma_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_innate_custom_scepter_stats", "abilities/enigma/enigma_innate_custom", LUA_MODIFIER_MOTION_NONE )

enigma_innate_custom = class({})
enigma_innate_custom.talents = {}

function enigma_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_enigma.vsndevts", context )
PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_gravity_effect.vpcf", context )
PrecacheResource( "particle", "particles/enigma/shard_disarm.vpcf", context )
PrecacheResource( "particle", "particles/enigma/innate_shard_damage.vpcf", context )
dota1x6:PrecacheShopItems("npc_dota_hero_enigma", context)
end

function enigma_innate_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
  	r1_heal_reduce = 0,

  	h1_range = 0,

  	h3_cdr = 0,
  	h3_mana = 0,

  	has_e4 = 0,
  	e4_damage_reduce = caster:GetTalentValue("modifier_enigma_midnight_4", "damage_reduce", true),

  	has_h4 = 0,
  	h4_duration = caster:GetTalentValue("modifier_enigma_hero_4", "duration", true),
		h4_damage_reduce = caster:GetTalentValue("modifier_enigma_hero_4", "damage_reduce", true),
		h4_slow = caster:GetTalentValue("modifier_enigma_hero_4", "slow", true),
		h4_cd = caster:GetTalentValue("modifier_enigma_hero_4", "cd", true),
  }
end

if caster:HasTalent("modifier_enigma_hero_1") then
	self.talents.h1_range = caster:GetTalentValue("modifier_enigma_hero_1", "range")
end

if caster:HasTalent("modifier_enigma_hero_3") then
	self.talents.h3_cdr = caster:GetTalentValue("modifier_enigma_hero_3", "cdr")
	self.talents.h3_mana = caster:GetTalentValue("modifier_enigma_hero_3", "mana")
end

if caster:HasTalent("modifier_enigma_hero_4") then
	self.talents.has_h4 = 1
end

if caster:HasTalent("modifier_enigma_blackhole_1") then
	self.talents.r1_heal_reduce = caster:GetTalentValue("modifier_enigma_blackhole_1", "heal_reduce")
end

if caster:HasTalent("modifier_enigma_midnight_4") then
	self.talents.has_e4 = 1
end

end

function enigma_innate_custom:OnInventoryContentsChanged()
if not IsServer() then return end
if self:IsStolen() then return end
if self.scepter_init then return end
local caster = self:GetCaster()
if not caster:HasScepter() then return end

self.scepter_init = true
caster:AddDeathEvent(self.tracker, true)
end

function enigma_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_enigma_innate_custom"
end

modifier_enigma_innate_custom = class(mod_hidden)
function modifier_enigma_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.ability.scepter_stats = self.ability:GetSpecialValueFor("scepter_stats") 
self.ability.scepter_max = self.ability:GetSpecialValueFor("scepter_max")   

self.ability.radius = self.ability:GetSpecialValueFor("radius")           
self.ability.health = self.ability:GetSpecialValueFor("health")          
self.ability.reduce = self.ability:GetSpecialValueFor("reduce")           
self.ability.damage_reduction = self.ability:GetSpecialValueFor("damage_reduction")  
self.ability.slow = self.ability:GetSpecialValueFor("slow")           

if not IsServer() then return end
self:StartIntervalThink(0.2)
end

function modifier_enigma_innate_custom:OnIntervalThink()
if not IsServer() then return end
self.active = true
self:StartIntervalThink(-1)
end

function modifier_enigma_innate_custom:IsAura() return not self.parent:PassivesDisabled() and self.active end
function modifier_enigma_innate_custom:GetAuraDuration() return 0.1 end
function modifier_enigma_innate_custom:GetAuraRadius() return self.ability.radius end
function modifier_enigma_innate_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_enigma_innate_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_enigma_innate_custom:GetModifierAura() return "modifier_enigma_innate_custom_debuff" end
function modifier_enigma_innate_custom:GetAuraEntityReject(hEntity)
if hEntity:IsFieldInvun(self.parent) then return true end
return hEntity:IsDebuffImmune() and self.ability.talents.has_h4 == 0
end

function modifier_enigma_innate_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
  MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
}
end

function modifier_enigma_innate_custom:GetModifierPercentageCooldown() 
return self.ability.talents.h3_cdr
end

function modifier_enigma_innate_custom:GetModifierPercentageManacostStacking()
return self.ability.talents.h3_mana
end

function modifier_enigma_innate_custom:GetModifierCastRangeBonusStacking()
return self.ability.talents.h1_range
end

function modifier_enigma_innate_custom:DeathEvent(params)
if not IsServer() then return end
if self.ability:IsStolen() then return end
if not self.parent:HasScepter() then return end
if not params.unit or not params.unit:IsValidKill(self.parent) then return end
if not self.parent:IsAlive() then return end

local attacker = params.attacker
if attacker.owner then
	attacker = attacker.owner
end

if self.parent == attacker or (self.parent:GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() <= self.ability.radius then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_enigma_innate_custom_scepter_stats", {})
end

end



modifier_enigma_innate_custom_debuff = class(mod_hidden)
function modifier_enigma_innate_custom_debuff:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.damage_reduce = self.ability.damage_reduction + (self.ability.talents.has_e4 == 1 and self.ability.talents.e4_damage_reduce or 0)
self.slow = self.ability.slow
self.heal_reduce = self.ability.talents.r1_heal_reduce
self.health = self.ability.health
self.reduce = 1/self.ability.reduce

if not IsServer() then return end

self.interval = 0.5
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_enigma_innate_custom_debuff:OnIntervalThink()
if not IsServer() then return end

if self.ability.talents.has_h4 == 1 and not self.parent:HasModifier("modifier_enigma_innate_custom_bonus_cd") then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_enigma_innate_custom_bonus_cd", {duration = self.ability.talents.h4_cd})
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_enigma_innate_custom_bonus_effect", {duration = self.ability.talents.h4_duration})
end

if (self.caster:GetHealthPercent() >= self.health or self.parent:HasModifier("modifier_enigma_innate_custom_bonus_effect")) and not self.effect then
	self.effect = self.parent:GenericParticle("particles/units/heroes/hero_enigma/enigma_gravity_effect.vpcf", self)
end

if self.caster:GetHealthPercent() < self.health and not self.parent:HasModifier("modifier_enigma_innate_custom_bonus_effect") and self.effect then
	ParticleManager:DestroyParticle(self.effect, false)
	ParticleManager:ReleaseParticleIndex(self.effect)
	self.effect = nil
end

end

function modifier_enigma_innate_custom_debuff:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_enigma_innate_custom_debuff:GetK()
return self.caster:GetHealthPercent() < self.health and self.reduce or 1
end

function modifier_enigma_innate_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
if self.parent:HasModifier("modifier_enigma_innate_custom_bonus_effect") then
	return self.ability.talents.h4_slow
end
return self.slow*self:GetK()
end

function modifier_enigma_innate_custom_debuff:GetModifierDamageOutgoing_Percentage(params)
if self.parent:HasModifier("modifier_enigma_innate_custom_bonus_effect") then
	return self.ability.talents.h4_damage_reduce
end
return self.damage_reduce*self:GetK()
end

function modifier_enigma_innate_custom_debuff:GetModifierSpellAmplify_Percentage(params)
if self.parent:HasModifier("modifier_enigma_innate_custom_bonus_effect") then
	return self.ability.talents.h4_damage_reduce
end
return self.damage_reduce*self:GetK()
end

function modifier_enigma_innate_custom_debuff:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce*self:GetK()
end

function modifier_enigma_innate_custom_debuff:GetModifierHealChange()
return self.heal_reduce*self:GetK()
end

function modifier_enigma_innate_custom_debuff:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce*self:GetK()
end


modifier_enigma_innate_custom_bonus_cd = class(mod_hidden)

modifier_enigma_innate_custom_bonus_effect = class(mod_hidden)
function modifier_enigma_innate_custom_bonus_effect:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.parent:GenericParticle("particles/enigma/shard_disarm.vpcf", self, true)

if not self.parent:IsRealHero() then return end
self.parent:EmitSound("Enigma.Innate_shard")
self.parent:AddDamageEvent_out(self, true)
end

function modifier_enigma_innate_custom_bonus_effect:DamageEvent_out(params)
if not IsServer() then return end
if params.unit ~= self.caster then return end
if params.attacker ~= self.parent then return end

self.caster:EmitSound("Enigma.Innate_shard_damage")
local effect_cast = ParticleManager:CreateParticle("particles/enigma/innate_shard_damage.vpcf", PATTACH_POINT_FOLLOW, self.caster )
ParticleManager:SetParticleControlEnt( effect_cast, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( 100, 100, 100 ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
end





modifier_enigma_innate_custom_scepter_stats = class(mod_visible)
function modifier_enigma_innate_custom_scepter_stats:RemoveOnDeath() return false end
function modifier_enigma_innate_custom_scepter_stats:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.scepter_max
self.stats = self.ability.scepter_stats
self.model = 1

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_enigma_innate_custom_scepter_stats:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end 
self:IncrementStackCount()

if self:GetStackCount() < self.max then return end

self.parent:GenericParticle("particles/enigma/summon_perma.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")
end 

function modifier_enigma_innate_custom_scepter_stats:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.parent:GenericParticle("particles/ui/purple_orb_point.vpcf")
self.parent:CalculateStatBonus(true)
end

function modifier_enigma_innate_custom_scepter_stats:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
  MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
  MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
  MODIFIER_PROPERTY_MODEL_SCALE,
}
end

function modifier_enigma_innate_custom_scepter_stats:GetModifierBonusStats_Strength()
if not self.parent:HasScepter() then return end
return self:GetStackCount()*self.stats
end

function modifier_enigma_innate_custom_scepter_stats:GetModifierBonusStats_Agility()
if not self.parent:HasScepter() then return end
return self:GetStackCount()*self.stats
end

function modifier_enigma_innate_custom_scepter_stats:GetModifierBonusStats_Intellect()
if not self.parent:HasScepter() then return end
return self:GetStackCount()*self.stats
end

function modifier_enigma_innate_custom_scepter_stats:GetModifierModelScale()
if not self.parent:HasScepter() then return end
return self:GetStackCount()*self.model
end