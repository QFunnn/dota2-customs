--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ogre_root", "abilities/creeps_lane/npc_ogre_root", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ogre_unit", "abilities/creeps_lane/npc_ogre_root", LUA_MODIFIER_MOTION_NONE)

npc_ogre_root = class({})

function npc_ogre_root:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf", context)
end

function npc_ogre_root:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.hits = self:GetLevelSpecialValueFor("hits", 1)
end

function npc_ogre_root:OnSpellStart()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	target:AddNewModifier(self.caster, self, "modifier_ogre_root", {})
end

modifier_ogre_root = class(mod_visible)
function modifier_ogre_root:IsPurgable()
	return true
end
function modifier_ogre_root:GetEffectName()
	return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
end
function modifier_ogre_root:CheckState()
	return { [MODIFIER_STATE_ROOTED] = true }
end
function modifier_ogre_root:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.RemoveForDuel = true
	self.parent:EmitSound("Hero_Crystal.frostbite")

	local unit = CreateUnitByName(
		"npc_dota_frostbite_s",
		self.parent:GetAbsOrigin(),
		false,
		self.caster,
		nil,
		DOTA_TEAM_CUSTOM_5
	)
	unit:AddNewModifier(unit, self.ability, "modifier_ogre_unit", { target = self.parent:entindex() })
end

modifier_ogre_unit = class(mod_hidden)
function modifier_ogre_unit:OnCreated(table)
	self.ability = self:GetAbility()

	self.pips = self.ability.hits

	if not IsServer() then
		return
	end
	self.parent = self:GetParent()

	self.hits = self.pips
	self.target = EntIndexToHScript(table.target)

	self.parent:AddAttackEvent_inc(self, true)
	self:StartIntervalThink(FrameTime())
end

function modifier_ogre_unit:OnIntervalThink()
	if not IsServer() then
		return
	end

	if IsValid(self.target) and self.target:IsAlive() and self.target:HasModifier("modifier_ogre_root") then
		self.parent:SetAbsOrigin(self.target:GetAbsOrigin() + self.target:GetForwardVector() * 64)
	else
		self.parent:Destroy()
	end
end

function modifier_ogre_unit:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_HEALTHBAR_PIPS,
	}
end

function modifier_ogre_unit:GetModifierHealthBarPips()
	return self.pips
end

function modifier_ogre_unit:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_ogre_unit:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_ogre_unit:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_ogre_unit:AttackEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.target then
		return
	end

	self.hits = self.hits - 1

	if self.hits <= 0 then
		self.target:RemoveModifierByName("modifier_ogre_root")
		self.parent:Kill(nil, params.attacker)
	else
		self.parent:SetHealth(self.hits)
	end
end