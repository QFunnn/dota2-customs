--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/nian_scene"
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
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["22"] = 6,
		["23"] = 11,
		["24"] = 12,
		["25"] = 11,
		["26"] = 5,
		["27"] = 4,
		["28"] = 5,
		["30"] = 5,
		["31"] = 16,
		["32"] = 25,
		["33"] = 16,
		["34"] = 25,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["40"] = 27,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["46"] = 38,
		["49"] = 33,
		["50"] = 42,
		["51"] = 43,
		["52"] = 42,
		["53"] = 47,
		["54"] = 48,
		["55"] = 47,
		["56"] = 54,
		["57"] = 55,
		["58"] = 56,
		["61"] = 54,
		["62"] = 25,
		["63"] = 16,
		["64"] = 16,
		["65"] = 16,
		["66"] = 16,
		["67"] = 16,
		["68"] = 16,
		["69"] = 16,
		["70"] = 16,
		["71"] = 16,
		["72"] = 25,
		["74"] = 25,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.nian_scene = c()
local n = g.nian_scene
n.name = "nian_scene"
d(n, i)
function n.prototype.Spawn(self)
	if IsServer() then
		self:SetLevel(1)
	end
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_nian_scene"
end
n = e({ j(nil) }, n)
g.nian_scene = n
g.modifier_nian_scene = c()
local o = g.modifier_nian_scene
o.name = "modifier_nian_scene"
d(o, l)
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.count = RandomInt(3, 6)
		self:StartIntervalThink(0)
	end
end
function o.prototype.OnIntervalThink(self)
	if IsServer() then
		if self:GetParent():GetSequence() ~= "No model!" then
			self:GetCaster():RemoveGesture(ACT_DOTA_SPAWN)
			self:GetCaster():StartGesture(ACT_DOTA_IDLE_RARE)
			self:StartIntervalThink(-1)
		end
	end
end
function o.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_NO_HEALTH_BAR] = true }
end
function o.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_HEALTH_BAR] = true, [MODIFIER_STATE_INVULNERABLE] = true }
end
function o.prototype.OnStackCountChanged(self, q)
	if IsServer() then
		if self:GetStackCount() == 1 then
		end
	end
end
o = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetEffectName = "particles/units/courier/5203001_ambient.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	o
)
g.modifier_nian_scene = o
return g