--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_bfury_custom", "abilities/items/item_bfury_custom", LUA_MODIFIER_MOTION_NONE)

item_bfury_custom = class({})

function item_bfury_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/battlefury_cleave.vpcf", context )
end

function item_bfury_custom:GetIntrinsicModifierName()
	return "modifier_item_bfury_custom"
end

function item_bfury_custom:OnSpellStart()
local target = self:GetCursorTarget()

GridNav:DestroyTreesAroundPoint(target:GetAbsOrigin(), 10, true)
end

modifier_item_bfury_custom	= class({})

function modifier_item_bfury_custom:AllowIllusionDuplicate()	return false end
function modifier_item_bfury_custom:IsPurgable()		return false end
function modifier_item_bfury_custom:RemoveOnDeath()	return false end
function modifier_item_bfury_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_bfury_custom:IsHidden()	return true end

function modifier_item_bfury_custom:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.parent:AddAttackEvent_out(self, true)

self.damage_bonus			= self.ability:GetSpecialValueFor("bonus_damage")
self.hp_regen			= self.ability:GetSpecialValueFor("bonus_health_regen")
self.mp_regen	= self.ability:GetSpecialValueFor("bonus_mana_regen")
self.damage_bonus_creep_quelling = self.ability:GetSpecialValueFor("quelling_bonus")

self.damage_bonus_creep_quelling_ranged = self.ability:GetSpecialValueFor("quelling_bonus_ranged")


self.start_width = self.ability:GetSpecialValueFor("cleave_starting_width")
self.end_width = self.ability:GetSpecialValueFor("cleave_ending_width")
self.cleave_distance = self.ability:GetSpecialValueFor("cleave_distance")
self.gold_bonus = self.ability:GetSpecialValueFor("gold_bonus")/100
self.blue_bonus = self.ability:GetSpecialValueFor("blue_bonus")/100

end



function modifier_item_bfury_custom:DeclareFunctions()
local funcs = {
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
}

return funcs
end

function modifier_item_bfury_custom:GetModifierPreAttack_BonusDamage(keys)
	return self.damage_bonus
end

function modifier_item_bfury_custom:GetModifierProcAttack_BonusDamage_Physical( keys )
	if not IsServer() then return end
	if keys.target and not keys.target:IsHero() and not keys.target:IsOther() and not keys.target:IsBuilding() and keys.target:GetTeamNumber() ~= self.parent:GetTeamNumber() then
		
		if self.parent:IsRangedAttacker() then 
			return self.damage_bonus_creep_quelling_ranged
		else 
			return self.damage_bonus_creep_quelling
		end
	end
end

function modifier_item_bfury_custom:GetModifierConstantManaRegen()
	return self.mp_regen
end

function modifier_item_bfury_custom:GetModifierConstantHealthRegen()
	return self.hp_regen
end

function modifier_item_bfury_custom:AttackEvent_out( params )
if not IsServer() then return end
if self.parent:HasModifier("modifier_tidehunter_anchor_smash_caster") then return end
if self.parent:HasModifier("modifier_no_cleave") then return end
if self.parent ~= params.attacker then return end
if self.parent:IsRangedAttacker() then return end
if not params.target:IsUnit() then return end
if params.no_cleave_flag then return end


local k = self.ability:GetSpecialValueFor("cleave_damage_percent")
if params.target:IsCreep() then 
	k = self.ability:GetSpecialValueFor("cleave_damage_percent_creep")
end 


params.target:EmitSound("Hero_Sven.GreatCleave")

DoCleaveAttack(self.parent, params.target, self.ability, params.damage*k/100, self.start_width, self.end_width, self.cleave_distance, "particles/items_fx/battlefury_cleave.vpcf")


end