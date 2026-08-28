--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_hidan_ritual_of_blood", "heroes/akatsuki/hidan", LUA_MODIFIER_MOTION_NONE)

hidan_ritual_of_blood = class({})

function hidan_ritual_of_blood:GetIntrinsicModifierName()
	return "modifier_hidan_ritual_of_blood"
end

---------------------------------------------------------------------------

modifier_hidan_ritual_of_blood = class({})

function modifier_hidan_ritual_of_blood:IsHidden()
	return false
end
function modifier_hidan_ritual_of_blood:IsPurgable()
	return false
end
function modifier_hidan_ritual_of_blood:IsPermanent()
	return true
end

function modifier_hidan_ritual_of_blood:OnCreated()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1.0)
end

function modifier_hidan_ritual_of_blood:OnIntervalThink()
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local new_level = math.min(math.floor((self:GetParent():GetLevel() - 1) / 6) + 1, ability:GetMaxLevel())
	if ability:GetLevel() ~= new_level then
		ability:SetLevel(new_level)
	end
end

function modifier_hidan_ritual_of_blood:_GetBonus()
	local parent = self:GetParent()
	local max_hp = parent:GetMaxHealth()
	if max_hp <= 0 then
		return 0
	end
	local missing_pct = (max_hp - parent:GetHealth()) / max_hp * 100
	return missing_pct * self:GetAbility():GetSpecialValueFor("bonus_per_pct_missing")
end

function modifier_hidan_ritual_of_blood:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_hidan_ritual_of_blood:GetModifierBaseDamageOutgoing_Percentage()
	return self:_GetBonus()
end

function modifier_hidan_ritual_of_blood:GetModifierConstantHealthRegen()
	local parent = self:GetParent()
	local max_hp = parent:GetMaxHealth()
	if max_hp <= 0 then
		return 0
	end
	local missing_pct = (max_hp - parent:GetHealth()) / max_hp * 100
	return missing_pct * self:GetAbility():GetSpecialValueFor("regen_per_pct_missing")
end

function modifier_hidan_ritual_of_blood:GetModifierSpellAmplify_Percentage()
	return self:_GetBonus()
end