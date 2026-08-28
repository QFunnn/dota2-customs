--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/modifiers/buff/modifier_poison_deepen.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__Decorate
local g = c.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["12"] = 4,
		["13"] = 13,
		["14"] = 4,
		["15"] = 13,
		["16"] = 18,
		["17"] = 19,
		["18"] = 18,
		["19"] = 21,
		["20"] = 22,
		["21"] = 23,
		["22"] = 24,
		["23"] = 25,
		["24"] = 25,
		["25"] = 25,
		["26"] = 25,
		["27"] = 25,
		["28"] = 29,
		["30"] = 21,
		["31"] = 32,
		["32"] = 33,
		["33"] = 34,
		["34"] = 35,
		["35"] = 35,
		["36"] = 35,
		["37"] = 35,
		["38"] = 35,
		["40"] = 32,
		["41"] = 41,
		["42"] = 42,
		["43"] = 43,
		["44"] = 44,
		["45"] = 45,
		["46"] = 46,
		["49"] = 49,
		["50"] = 50,
		["52"] = 41,
		["53"] = 53,
		["54"] = 54,
		["55"] = 53,
		["56"] = 58,
		["57"] = 59,
		["58"] = 58,
		["59"] = 13,
		["60"] = 4,
		["61"] = 4,
		["62"] = 4,
		["63"] = 4,
		["64"] = 4,
		["65"] = 4,
		["66"] = 4,
		["67"] = 4,
		["68"] = 4,
		["69"] = 13,
		["71"] = 13,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
h.modifier_poison_deepen = d()
local l = h.modifier_poison_deepen
l.name = "modifier_poison_deepen"
e(l, j)
function l.prototype.GetTexture(self)
	return "viper_nethertoxin"
end
function l.prototype.OnCreated(self, m)
	if IsServer() then
		self:IncrementStackCount(m.iStackCount)
		self.tData = {}
		local n = self.tData
		n[#n + 1] = { dieTime = self:GetDieTime(), count = m.iStackCount }
		self:StartIntervalThink(0)
	end
end
function l.prototype.OnRefresh(self, m)
	if IsServer() then
		self:IncrementStackCount(m.iStackCount)
		local o = self.tData
		o[#o + 1] = { dieTime = self:GetDieTime(), count = m.iStackCount }
	end
end
function l.prototype.OnIntervalThink(self)
	local p = GameRules:GetGameTime()
	for q = #self.tData, 1, -1 do
		if self.tData[q].dieTime <= p then
			self:DecrementStackCount(self.tData[q].count)
			table.remove(self.tData, q)
		end
	end
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
function l.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS_TARGET }
end
function l.prototype.EOM_GetModifierPoisonDamageBonusTarget(self)
	return self:GetStackCount()
end
l = f(
	{
		k(
			nil,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				DestroyOnExpire = false,
			}
		),
	},
	l
)
h.modifier_poison_deepen = l
return h