--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_break", "neutrals/woda_neutral_break", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_break_debuff", "neutrals/woda_neutral_break", LUA_MODIFIER_MOTION_NONE)

woda_neutral_break = class({})

function woda_neutral_break:GetIntrinsicModifierName()
	return "modifier_woda_neutral_break"
end

modifier_woda_neutral_break = class({})

function modifier_woda_neutral_break:IsPurgable() return false end
function modifier_woda_neutral_break:IsHidden() return true end

function modifier_woda_neutral_break:DeclareFunctions()
	return 
	{
		 
	}
end

function modifier_woda_neutral_break:OnCreated()
	if not IsServer() then return end
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_woda_neutral_break:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target:IsMagicImmune() then return end
	params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_woda_neutral_break_debuff", {duration = self.duration * (1 - params.target:GetStatusResistance())})
end

modifier_woda_neutral_break_debuff = class({})

function modifier_woda_neutral_break_debuff:IsPurgable() return false end

function modifier_woda_neutral_break_debuff:CheckState()
	return {
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}
end

function modifier_woda_neutral_break_debuff:GetEffectName()
	return "particles/generic_gameplay/generic_break.vpcf"
end

function modifier_woda_neutral_break_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end