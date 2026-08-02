--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_spawn_interact_book"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_spawn_interact_book"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		l:SetForwardVector(vec3_bottom)
		l:SetHullRadius(128)
		self:StartIntervalThink(0.1)
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() and IsValid(self.entity) then
		self.entity:RemoveSelf()
	end
end
function j.prototype.OnIntervalThink(self)
	local l = self:GetParent()
	self.entity = SpawnEntityFromTableSynchronous(
		"dota_prop_customtexture",
		{
			angles = "0 -90 0",
			model = "models/eom/props/campsite/bg_bookcase/bg_bookstand_01.vmdl",
			scales = "1.68 1.68 1.68",
			origin = l:GetAbsOrigin(),
		}
	)
	self:StartIntervalThink(-1)
end
function j.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_VISUAL_Z_DELTA] = 180, [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_CAPTURE }
end
function j.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	j
)
return f