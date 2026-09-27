--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_troll_raise", "abilities/creeps_neutral/neutral_troll_raise", LUA_MODIFIER_MOTION_NONE)

neutral_troll_raise = class({})

function neutral_troll_raise:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_troll_raise"
end

modifier_troll_raise = class(mod_hidden)
function modifier_troll_raise:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.number = self.ability:GetSpecialValueFor("number")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
end

function modifier_troll_raise:StartCast(target)
	if not IsServer() then
		return
	end
	self.target = target

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.4,
			anim = ACT_DOTA_CAST_ABILITY_2,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_troll_raise:EndCast()
	if not IsServer() then
		return
	end

	self.parent:EmitSound("n_creep_TrollWarlord.RaiseDead")

	for i = 1, self.ability.number do
		local skeleton = CreateUnitByName(
			"npc_dota_dark_troll_warlord_skeleton_warrior",
			self.parent:GetAbsOrigin(),
			true,
			nil,
			nil,
			DOTA_TEAM_NEUTRALS
		)
		skeleton:SetOwner(self.parent)
		skeleton:AddNewModifier(self.parent, self.ability, "modifier_kill", { duration = self.ability.duration })

		if IsValid(self.target) then
			skeleton:SetForceAttackTarget(self.target)
		end
	end
end