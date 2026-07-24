--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_pangolier_innate_custom", "abilities/pangolier/pangolier_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_pangolier_innate_custom_armor", "abilities/pangolier/pangolier_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_pangolier_innate_custom_damage", "abilities/pangolier/pangolier_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_pangolier_innate_custom_cd", "abilities/pangolier/pangolier_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_pangolier_innate_custom_effect", "abilities/pangolier/pangolier_innate_custom", LUA_MODIFIER_MOTION_NONE )


pangolier_innate_custom = class({})


function pangolier_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_pangolier_innate_custom"
end


function pangolier_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/pangolier/innate_proc.vpcf", context )
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_pangolier.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_pangolier", context)
end


modifier_pangolier_innate_custom = class({})
function modifier_pangolier_innate_custom:IsHidden() return true end
function modifier_pangolier_innate_custom:IsPurgable() return false end
function modifier_pangolier_innate_custom:RemoveOnDeath() return false end
function modifier_pangolier_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.chance = self.ability:GetSpecialValueFor("chance")
self.radius = self.ability:GetSpecialValueFor("radius")
self.cd = self.ability:GetSpecialValueFor("cd")

self.parent:AddAttackEvent_inc(self)
end

function modifier_pangolier_innate_custom:AttackEvent_inc(params)
if not IsServer() then return end 
if self.parent:PassivesDisabled() then return end
if not params.attacker:IsUnit() then return end
if params.no_attack_cooldown and not params.attacker:HasModifier("modifier_alchemist_chemical_rage_custom_legendary") then return end
if self.parent ~= params.target then return end
if self.parent:HasModifier("modifier_pangolier_innate_custom_cd") then return end
if not RollPseudoRandomPercentage(self.chance, 842, self.parent) then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_innate_custom_cd", {duration = self.cd})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_innate_custom_armor", {duration = 1})

if not self.parent:HasModifier("modifier_pangolier_gyroshell_custom_heal") then 
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_innate_custom_effect", {duration = 1})
end

local target = params.attacker

if (self.parent:GetAbsOrigin() - target:GetAbsOrigin()):Length2D() <= self.radius then 

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_innate_custom_damage", {duration = FrameTime()})
	self.parent:PerformAttack(target, true, true, true, true, false, false, true)
	self.parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, 2.5)

	local lucky = self.parent:FindAbilityByName("pangolier_lucky_shot_custom")
	if lucky and lucky:GetLevel() > 0 then 
		lucky:ProcPassive(target)
	end

	self.parent:RemoveModifierByName("modifier_pangolier_innate_custom_damage")

	target:EmitSound("Pangolier.Innate_attack")
	local particle = ParticleManager:CreateParticle("particles/pangolier/innate_proc.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
	ParticleManager:SetParticleControlEnt( particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex(particle)
end


end




modifier_pangolier_innate_custom_armor = class({})
function modifier_pangolier_innate_custom_armor:IsHidden() return true end
function modifier_pangolier_innate_custom_armor:IsPurgable() return false end
function modifier_pangolier_innate_custom_armor:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.armor = self.ability:GetSpecialValueFor("armor")
self.parent:AddDamageEvent_inc(self)
end


function modifier_pangolier_innate_custom_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end


function modifier_pangolier_innate_custom_armor:GetModifierPhysicalArmorBonus()
return self.armor
end


function modifier_pangolier_innate_custom_armor:DamageEvent_inc(params)
if not IsServer() then return end 
if self.parent ~= params.unit then return end
if not params.attacker:IsUnit() then return end

self.parent:EmitSound("Juggernaut.Parry")
self.parent:EmitSound("Pangolier.Innate_armor")

for i = 1,2 do
	local particle = ParticleManager:CreateParticle( "particles/jugg_parry.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", self.parent:GetAbsOrigin(), true )
	ParticleManager:SetParticleControl( particle, 1, self.parent:GetAbsOrigin() )
end

self:Destroy()
end



modifier_pangolier_innate_custom_damage = class({})
function modifier_pangolier_innate_custom_damage:IsHidden() return false end
function modifier_pangolier_innate_custom_damage:IsPurgable() return false end
function modifier_pangolier_innate_custom_damage:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
--self.damage = self.ability:GetSpecialValueFor("damage") - 100
end

function modifier_pangolier_innate_custom_damage:DeclareFunctions()
return
{
--	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_pangolier_innate_custom_damage:GetModifierDamageOutgoing_Percentage()
--return self.damage
end




modifier_pangolier_innate_custom_cd = class({})
function modifier_pangolier_innate_custom_cd:IsHidden() return true end
function modifier_pangolier_innate_custom_cd:IsPurgable() return false end


modifier_pangolier_innate_custom_effect = class({})
function modifier_pangolier_innate_custom_effect:IsHidden() return true end
function modifier_pangolier_innate_custom_effect:IsPurgable() return false end
function modifier_pangolier_innate_custom_effect:GetEffectName() return "particles/pangolier/innate_shield.vpcf" end
function modifier_pangolier_innate_custom_effect:GetStatusEffectName() return "particles/status_fx/status_effect_shredder_whirl.vpcf" end
function modifier_pangolier_innate_custom_effect:StatusEffectPriority() return MODIFIER_PRIORITY_ULTRA  end