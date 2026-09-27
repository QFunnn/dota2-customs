--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_golem_passive", "abilities/creeps_lane/npc_golem_passive", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_golem_passive_model", "abilities/creeps_lane/npc_golem_passive", LUA_MODIFIER_MOTION_NONE)

npc_golem_passive = class({})

function npc_golem_passive:Precache(context)
	PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_golem_a/neutral_creep_golem_a.vmdl", context)
	PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_golem_b/n_creep_golem_b.vmdl", context)
end

function npc_golem_passive:GetIntrinsicModifierName()
	return "modifier_golem_passive"
end

modifier_golem_passive = class(mod_hidden)
function modifier_golem_passive:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.chance = self.ability:GetSpecialValueFor("chance")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")

	self.hidden = self.parent:GetUnitName() ~= "npc_golem_large"
	if self.hidden then
		self.owner_name = self.parent:GetUnitName() == "npc_golem_small" and "npc_golem_medium" or "npc_golem_large"
	end

	self:StartIntervalThink(0.1)
	self:OnIntervalThink(true)
end

function modifier_golem_passive:OnIntervalThink(first)
	if not IsServer() then
		return
	end

	if self.hidden then
		self.parent:AddNoDraw()
		if not self.golem_owner and self.parent.ally then
			for _, unit in ipairs(self.parent.ally) do
				if
					IsValid(unit)
					and unit:IsAlive()
					and (unit.golem_count or 0) < 2
					and unit:GetUnitName() == self.owner_name
				then
					unit.golem_count = (unit.golem_count or 0) + 1
					self.golem_owner = unit
					break
				end
			end
		end
		if not first then
			if not IsValid(self.golem_owner) or not self.golem_owner:IsAlive() then
				self.hidden = false
			else
				self.parent:SetAbsOrigin(self.golem_owner:GetAbsOrigin())
			end
		end
	end

	if self.hidden then
		return
	end

	self.parent:RemoveNoDraw()
	if self.parent:GetUnitName() ~= "npc_golem_large" then
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_golem_passive_model", {})
	end
	self:StartIntervalThink(-1)
end

function modifier_golem_passive:CheckState()
	if not self.hidden then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return
	end
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end

function modifier_golem_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_golem_passive:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end
	if not RollPseudoRandomPercentage(self.ability.chance, 1, self.parent) then
		return
	end
	if params.target:IsBuilding() then
		return
	end

	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_stunned",
		{ duration = self.ability.duration * (1 - params.target:GetStatusResistance()) }
	)
	params.target:EmitSound("Creep.Tiny_craggy")
	params.target:EmitSound("Creep.Tiny_craggy_stun")
end

modifier_golem_passive_model = class(mod_hidden)
function modifier_golem_passive_model:RemoveOnDeath()
	return false
end
function modifier_golem_passive_model:OnCreated()
	self.parent = self:GetParent()

	self.model = "models/creeps/neutral_creeps/n_creep_golem_a/neutral_creep_golem_a.vmdl"
	if self.parent:GetUnitName() == "npc_golem_small" then
		self.model = "models/creeps/neutral_creeps/n_creep_golem_b/n_creep_golem_b.vmdl"
	end
end

function modifier_golem_passive_model:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_golem_passive_model:GetModifierModelChange()
	return self.model
end