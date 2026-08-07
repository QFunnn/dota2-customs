--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_courier"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringIncludes
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = c()
k.name = "modifier_courier"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.offset = 0
end
function k.prototype.OnCreated(self)
	local l = self:GetParent()
	local m, n = KeyValues:GetUnitData(l, "Skin", "Model")
	if IsServer() then
		if m ~= nil and m ~= "" then
			l:GameTimer(1, function()
				if IsValid(l) then
					l:SetMaterialGroup(tostring(m))
				end
			end)
		end
	end
	if n ~= nil and n ~= "" and e(n, "flying") then
		self.offset = 100
	end
end
function k.prototype.EventListener(self)
	return {
		dungeon_start = function(o, p)
			self.parent:SetModelScale(self.parent:GetModelScale() * 0.8)
		end,
	}
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_VISUAL_Z_DELTA }
end
function k.prototype.GetVisualZDelta(self)
	return self.offset
end
k = f(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
return g