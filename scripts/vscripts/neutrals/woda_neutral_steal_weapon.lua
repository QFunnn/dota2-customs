--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_steal_weapon", "neutrals/woda_neutral_steal_weapon", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_steal_weapon_debuff", "neutrals/woda_neutral_steal_weapon", LUA_MODIFIER_MOTION_NONE)

woda_neutral_steal_weapon = class({})

function woda_neutral_steal_weapon:GetIntrinsicModifierName()
	return "modifier_woda_neutral_steal_weapon"
end

modifier_woda_neutral_steal_weapon = class({})

function modifier_woda_neutral_steal_weapon:IsPurgable() return false end
function modifier_woda_neutral_steal_weapon:IsHidden() return true end

function modifier_woda_neutral_steal_weapon:DeclareFunctions()
	return 
	{
		 
	}
end

function modifier_woda_neutral_steal_weapon:OnCreated()
	if not IsServer() then return end
	self.attack_current = 0
	self.attack_count = self:GetAbility():GetSpecialValueFor("attack_count")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_woda_neutral_steal_weapon:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	self.attack_current = self.attack_current + 1
	if self.attack_current >= self.attack_count then
		if not params.target:IsMagicImmune() then
			params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_woda_neutral_steal_weapon_debuff", {duration = self.duration * (1 - params.target:GetStatusResistance())})
		end
		self.attack_current = 0
	end
end

modifier_woda_neutral_steal_weapon_debuff = class({})

function modifier_woda_neutral_steal_weapon_debuff:IsPurgable() return false end

function modifier_woda_neutral_steal_weapon_debuff:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_woda_neutral_steal_weapon_debuff:GetEffectName()
	return "particles/generic_gameplay/generic_disarm.vpcf"
end

function modifier_woda_neutral_steal_weapon_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end