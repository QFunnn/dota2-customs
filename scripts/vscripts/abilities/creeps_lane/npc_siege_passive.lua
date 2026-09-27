--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_npc_siege_dmg", "abilities/creeps_lane/npc_siege_passive", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_npc_siege_dmg_death", "abilities/creeps_lane/npc_siege_passive", LUA_MODIFIER_MOTION_NONE)

npc_siege_passive = class({})

function npc_siege_passive:Precache(context)
	PrecacheResource("particle", "particles/siege_fx/siege_good_death_01.vpcf", context)
	PrecacheResource("particle", "particles/siege_fx/siege_bad_death_01.vpcf", context)
end

function npc_siege_passive:GetIntrinsicModifierName()
	return "modifier_npc_siege_dmg"
end

modifier_npc_siege_dmg = class(mod_hidden)
function modifier_npc_siege_dmg:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage")

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_npc_siege_dmg_death", {})
end

function modifier_npc_siege_dmg:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_npc_siege_dmg:GetModifierTotalDamageOutgoing_Percentage(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if not params.target or not params.target:IsBuilding() then
		return
	end
	return self.ability.damage
end

modifier_npc_siege_dmg_death = class(mod_hidden)
function modifier_npc_siege_dmg_death:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
end

function modifier_npc_siege_dmg_death:OnDestroy()
	if not IsServer() then
		return
	end
	if self.parent:IsAlive() then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return
	end

	local effect = self.parent:GetUnitName() == "npc_goodsiege_a" and "particles/siege_fx/siege_good_death_01.vpcf"
		or "particles/siege_fx/siege_bad_death_01.vpcf"

	self.parent:AddNoDraw()

	local particle = ParticleManager:CreateParticle(effect, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControlOrientation(
		particle,
		0,
		self.parent:GetForwardVector(),
		self.parent:GetRightVector(),
		self.parent:GetUpVector()
	)
	ParticleManager:ReleaseParticleIndex(particle)
end