--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_scar_custom"
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
		["12"] = 4,
		["13"] = 12,
		["14"] = 4,
		["15"] = 12,
		["17"] = 12,
		["18"] = 13,
		["19"] = 4,
		["20"] = 14,
		["21"] = 15,
		["22"] = 14,
		["23"] = 18,
		["24"] = 19,
		["25"] = 20,
		["26"] = 21,
		["27"] = 22,
		["28"] = 23,
		["29"] = 24,
		["32"] = 18,
		["33"] = 29,
		["34"] = 30,
		["35"] = 31,
		["36"] = 33,
		["37"] = 34,
		["38"] = 34,
		["39"] = 34,
		["40"] = 34,
		["41"] = 35,
		["42"] = 36,
		["45"] = 29,
		["46"] = 40,
		["47"] = 41,
		["48"] = 40,
		["49"] = 45,
		["50"] = 46,
		["51"] = 45,
		["52"] = 48,
		["53"] = 49,
		["54"] = 48,
		["55"] = 51,
		["56"] = 52,
		["57"] = 51,
		["58"] = 54,
		["59"] = 55,
		["60"] = 54,
		["61"] = 12,
		["62"] = 4,
		["63"] = 4,
		["64"] = 4,
		["65"] = 4,
		["66"] = 4,
		["67"] = 4,
		["68"] = 4,
		["69"] = 4,
		["70"] = 12,
		["72"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_scar_custom = c()
local k = g.modifier_scar_custom
k.name = "modifier_scar_custom"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.max_stack = 0
end
function k.prototype.GetTexture(self)
	return "life_stealer_open_wounds_ti9"
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		local m = GetScarMaxHealthPercentage(self.parent)
		self.max_stack = math.floor(self.parent:GetMaxHealth() * m * 0.01)
		self:SetStackCount(l.stack or 0)
		if self:GetStackCount() >= self.max_stack then
			FireModifierEvent(
				EOMModifierEvents.MODIFIER_EVENT_ON_SCAR_ENOUGH,
				{ stack = self.max_stack, target = self.parent },
				self.parent
			)
		end
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		local m = GetScarMaxHealthPercentage(self.parent)
		self.max_stack = math.floor(self.parent:GetMaxHealth() * m * 0.01)
		self:SetStackCount(math.min(self.max_stack, (l.stack or 0) + self:GetStackCount()))
		if self:GetStackCount() >= self.max_stack then
			FireModifierEvent(
				EOMModifierEvents.MODIFIER_EVENT_ON_SCAR_ENOUGH,
				{ stack = self.max_stack, target = self.parent },
				self.parent
			)
		end
	end
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function k.prototype.EOM_GetModifierHealthBonus(self, l)
	return -self:GetStackCount()
end
function k.prototype.GetMaxStack(self)
	return self.max_stack
end
function k.prototype.GetScarPct(self)
	return self.max_stack > 0 and self:GetStackCount() / self.max_stack * 100 or 0
end
function k.prototype.Reset(self)
	self:SetStackCount(0)
end
k = e(
	{
		j(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	k
)
g.modifier_scar_custom = k
return g