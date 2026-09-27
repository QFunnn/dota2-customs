--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rogue_passive", "abilities/creeps_lane/npc_rogue_passive", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rogue_debuff", "abilities/creeps_lane/npc_rogue_passive", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rogue_proc", "abilities/creeps_lane/npc_rogue_passive", LUA_MODIFIER_MOTION_NONE)

npc_rogue_passive = class({})

function npc_rogue_passive:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_break.vpcf", context)
end

function npc_rogue_passive:GetIntrinsicModifierName()
	return "modifier_rogue_passive"
end

modifier_rogue_passive = class(mod_hidden)
function modifier_rogue_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.chance = self.ability:GetSpecialValueFor("chance")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")

	if not IsServer() then
		return
	end
	self.parent:AddAttackRecordEvent_out(self)
end

function modifier_rogue_passive:CheckState()
	if not self.parent:HasModifier("modifier_rogue_proc") then
		return
	end
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

function modifier_rogue_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_rogue_passive:AttackRecordEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end

	self.parent:RemoveModifierByName("modifier_rogue_proc")

	if not params.target:IsUnit() then
		return
	end
	if not RollPseudoRandomPercentage(self.ability.chance, 1534, self.parent) then
		return
	end

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_rogue_proc", {})
end

function modifier_rogue_passive:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end
	if not self.parent:HasModifier("modifier_rogue_proc") then
		return
	end

	self.parent:RemoveModifierByName("modifier_rogue_proc")

	params.target:EmitSound("DOTA_Item.SilverEdge.Target")
	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_rogue_debuff",
		{ duration = self.ability.duration * (1 - params.target:GetStatusResistance()) }
	)
end

modifier_rogue_debuff = class(mod_visible)
function modifier_rogue_debuff:IsPurgable()
	return true
end
function modifier_rogue_debuff:GetTexture()
	return "pangolier_heartpiercer"
end
function modifier_rogue_debuff:GetEffectName()
	return "particles/generic_gameplay/generic_break.vpcf"
end
function modifier_rogue_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_rogue_debuff:CheckState()
	return { [MODIFIER_STATE_PASSIVES_DISABLED] = true }
end

modifier_rogue_proc = class(mod_hidden)