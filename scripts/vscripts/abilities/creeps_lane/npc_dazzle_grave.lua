--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dazzle_grave", "abilities/creeps_lane/npc_dazzle_grave", LUA_MODIFIER_MOTION_NONE)

npc_dazzle_grave = class({})

function npc_dazzle_grave:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/dazzle/dazzle_dark_light_weapon/dazzle_dark_shallow_grave.vpcf",
		context
	)
end

function npc_dazzle_grave:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

function npc_dazzle_grave:OnSpellStart()
	self:GetCursorTarget():AddNewModifier(self.caster, self, "modifier_dazzle_grave", { duration = self.duration })
end

modifier_dazzle_grave = class(mod_visible)
function modifier_dazzle_grave:OnCreated()
	self.parent = self:GetParent()

	if not IsServer() then
		return
	end
	self.parent:EmitSound("Hero_Dazzle.Shallow_Grave")
	self.parent:GenericParticle(
		"particles/econ/items/dazzle/dazzle_dark_light_weapon/dazzle_dark_shallow_grave.vpcf",
		self
	)
end

function modifier_dazzle_grave:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_dazzle_grave:GetMinHealth()
	if self.parent:HasModifier("modifier_death") then
		return
	end
	return 1
end