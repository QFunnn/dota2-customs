--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_envenomed_weapon", "neutrals/woda_neutral_envenomed_weapon", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_envenomed_weapon_debuff", "neutrals/woda_neutral_envenomed_weapon", LUA_MODIFIER_MOTION_NONE)

woda_neutral_envenomed_weapon = class({})

function woda_neutral_envenomed_weapon:GetIntrinsicModifierName()
	return "modifier_woda_neutral_envenomed_weapon"
end

function woda_neutral_envenomed_weapon:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/gnoll_poison_debuff.vpcf", context )
end

modifier_woda_neutral_envenomed_weapon = class({})

function modifier_woda_neutral_envenomed_weapon:IsPurgable() return false end
function modifier_woda_neutral_envenomed_weapon:IsHidden() return true end

function modifier_woda_neutral_envenomed_weapon:DeclareFunctions()
	return 
	{
		 
	}
end

function modifier_woda_neutral_envenomed_weapon:OnCreated()
	if not IsServer() then return end
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_woda_neutral_envenomed_weapon:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target:IsMagicImmune() then return end
	params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_woda_neutral_envenomed_weapon_debuff", {duration = self.duration * (1 - params.target:GetStatusResistance())})
end

modifier_woda_neutral_envenomed_weapon_debuff = class({})

function modifier_woda_neutral_envenomed_weapon_debuff:IsPurgable() return false end

function modifier_woda_neutral_envenomed_weapon_debuff:OnCreated()
	if not IsServer() then return end
	self.damage_percent = self:GetAbility():GetSpecialValueFor("damage_percent")
	self:StartIntervalThink(1)
end

function modifier_woda_neutral_envenomed_weapon_debuff:OnIntervalThink()
	if not IsServer() then return end
	local damage = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self.damage_percent
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_woda_neutral_envenomed_weapon_debuff:GetEffectName()
	return "particles/neutral_fx/gnoll_poison_debuff.vpcf"
end

function modifier_woda_neutral_envenomed_weapon_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end