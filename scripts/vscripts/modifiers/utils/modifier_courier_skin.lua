--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_courier_skin"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["15"] = 15,
		["16"] = 16,
		["17"] = 17,
		["18"] = 18,
		["19"] = 19,
		["20"] = 20,
		["21"] = 21,
		["22"] = 27,
		["23"] = 28,
		["24"] = 29,
		["25"] = 29,
		["26"] = 29,
		["27"] = 29,
		["28"] = 29,
		["29"] = 29,
		["30"] = 29,
		["31"] = 29,
		["33"] = 32,
		["35"] = 15,
		["36"] = 35,
		["37"] = 36,
		["38"] = 37,
		["39"] = 38,
		["40"] = 39,
		["41"] = 40,
		["42"] = 41,
		["43"] = 42,
		["45"] = 44,
		["47"] = 46,
		["49"] = 35,
		["50"] = 49,
		["51"] = 50,
		["52"] = 49,
		["53"] = 55,
		["54"] = 56,
		["55"] = 55,
		["56"] = 58,
		["57"] = 59,
		["58"] = 58,
		["59"] = 11,
		["60"] = 3,
		["61"] = 3,
		["62"] = 3,
		["63"] = 3,
		["64"] = 3,
		["65"] = 3,
		["66"] = 3,
		["67"] = 3,
		["68"] = 11,
		["70"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_courier_skin = c()
local k = g.modifier_courier_skin
k.name = "modifier_courier_skin"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = self:GetParent()
		self.courierID = l.courierID
		local n = KeyValues.CosmeticsKV[l.courierID]
		self.Model = n.resource
		self.ModelScale = n.model_scale
		if n.ambient ~= nil then
			local o = ParticleManager:CreateParticle(n.ambient, PATTACH_ABSORIGIN, m)
			self:AddParticle(o, false, false, -1, false, false)
		end
		self:StartIntervalThink(0.03)
	end
end
function k.prototype.OnIntervalThink(self)
	if IsServer() then
		local m = self:GetParent()
		local n = KeyValues.CosmeticsKV[self.courierID]
		self.Model = n.resource
		self.ModelScale = n.model_scale
		if n.Skin then
			m:SetSkin(n.Skin)
		else
			m:SetSkin(0)
		end
		self:StartIntervalThink(-1)
	end
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE, MODIFIER_PROPERTY_MODEL_SCALE }
end
function k.prototype.GetModifierModelChange(self)
	return self.Model
end
function k.prototype.GetModifierModelScale(self)
	return self.ModelScale
end
k = e(
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
g.modifier_courier_skin = k
return g