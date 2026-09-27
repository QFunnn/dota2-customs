--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_archer_debuff", "abilities/creeps_lane/npc_archer_silence", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_archer_passive", "abilities/creeps_lane/npc_archer_silence", LUA_MODIFIER_MOTION_NONE)

npc_archer_silence = class({})

function npc_archer_silence:Precache(context)
	PrecacheResource("particle", "particles/econ/items/drow/drow_bow_monarch/drow_frost_arrow_monarch.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_drow/drow_base_attack.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_silenced.vpcf", context)
end

function npc_archer_silence:GetIntrinsicModifierName()
	return "modifier_archer_passive"
end

modifier_archer_passive = class(mod_hidden)
function modifier_archer_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")

	if not IsServer() then
		return
	end
	self.parent:AddAttackStartEvent_out(self)
	self.parent:AddAttackRecordEvent_out(self)
end

function modifier_archer_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_archer_passive:AttackRecordEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end

	self.frost = not params.target:IsBuilding() and self.ability:IsFullyCastable()

	if self.frost then
		self.parent:SetRangedProjectileName("particles/econ/items/drow/drow_bow_monarch/drow_frost_arrow_monarch.vpcf")
	else
		self.parent:SetRangedProjectileName("particles/units/heroes/hero_drow/drow_base_attack.vpcf")
	end
end

function modifier_archer_passive:AttackStartEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if not self.frost then
		return
	end

	self.parent:EmitSound("Hero_DrowRanger.FrostArrows")
	self.ability:UseResources(false, false, false, true)
end

function modifier_archer_passive:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end
	if not self.frost then
		return
	end
	if params.target:TriggerSpellAbsorb(self.ability) then
		return
	end

	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_archer_debuff",
		{ duration = self.ability.duration * (1 - params.target:GetStatusResistance()) }
	)
end

modifier_archer_debuff = class(mod_visible)
function modifier_archer_debuff:IsPurgable()
	return true
end
function modifier_archer_debuff:GetTexture()
	return "drow_ranger_silence"
end
function modifier_archer_debuff:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end
function modifier_archer_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_archer_debuff:CheckState()
	return { [MODIFIER_STATE_SILENCED] = true }
end
function modifier_archer_debuff:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow
end

function modifier_archer_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_archer_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_archer_debuff:OnTooltip()
	return self.slow
end