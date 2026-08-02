--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_soap"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMItem
local l = j.registerEOMAbility
local m = c()
m.name = "item_soap"
d(m, k)
function m.prototype.OnCreated(self)
	local n = self:GetCaster()
	self:StartThink(0, function()
		if self:IsCooldownReady() and not n:HasModifier("modifier_item_soap") then
			n:AddNewModifier(n, self, "modifier_item_soap", {})
		end
	end)
end
m = e({ l(nil) }, m)
local o = c()
o.name = "modifier_item_soap"
d(o, h)
function o.prototype.OnCreated(self, p)
	if IsClient() then
		local q = ParticleManager:CreateParticle(
			"particles/units/passive_abilities/soap.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(q, false, false, -1, false, false)
	end
end
function o.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.AVOID_DAMAGE] = function(r, p)
			self:Destroy()
			local s = self:GetAbility()
			if IsValid(s) then
				s:UseCooldown()
			end
			return 1
		end,
	}
end
o = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	o
)
return f