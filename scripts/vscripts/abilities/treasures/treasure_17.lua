--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_17"
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
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 10,
		["27"] = 17,
		["28"] = 10,
		["29"] = 17,
		["30"] = 18,
		["31"] = 19,
		["32"] = 20,
		["33"] = 20,
		["34"] = 19,
		["35"] = 18,
		["36"] = 23,
		["37"] = 24,
		["38"] = 25,
		["39"] = 25,
		["40"] = 25,
		["41"] = 25,
		["42"] = 25,
		["43"] = 25,
		["44"] = 23,
		["45"] = 17,
		["46"] = 10,
		["47"] = 10,
		["48"] = 10,
		["49"] = 10,
		["50"] = 10,
		["51"] = 10,
		["52"] = 10,
		["53"] = 17,
		["55"] = 17,
		["56"] = 28,
		["57"] = 35,
		["58"] = 28,
		["59"] = 35,
		["60"] = 38,
		["61"] = 39,
		["62"] = 40,
		["63"] = 38,
		["64"] = 42,
		["65"] = 46,
		["66"] = 42,
		["67"] = 50,
		["68"] = 51,
		["69"] = 52,
		["70"] = 53,
		["72"] = 50,
		["73"] = 56,
		["74"] = 57,
		["75"] = 58,
		["76"] = 59,
		["78"] = 56,
		["79"] = 62,
		["80"] = 63,
		["81"] = 64,
		["82"] = 64,
		["83"] = 64,
		["84"] = 64,
		["85"] = 65,
		["86"] = 65,
		["87"] = 65,
		["88"] = 65,
		["89"] = 65,
		["90"] = 65,
		["92"] = 62,
		["93"] = 68,
		["94"] = 69,
		["95"] = 70,
		["97"] = 68,
		["98"] = 35,
		["99"] = 28,
		["100"] = 28,
		["101"] = 28,
		["102"] = 28,
		["103"] = 28,
		["104"] = 28,
		["105"] = 28,
		["106"] = 35,
		["108"] = 35,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_17 = c()
local n = g.treasure_17
n.name = "treasure_17"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_17"
end
n = e({ j(nil) }, n)
g.treasure_17 = n
g.modifier_treasure_17 = c()
local o = g.modifier_treasure_17
o.name = "modifier_treasure_17"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_treasure_17_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_17_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_17 = o
g.modifier_treasure_17_buff = c()
local q = g.modifier_treasure_17_buff
q.name = "modifier_treasure_17_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.interval = self:GetAbilitySpecialValueFor("time")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function q.prototype.OnBattleStart(self, p)
	if IsServer() then
		self:stun()
		self:StartIntervalThink(self.interval)
	end
end
function q.prototype.OnIntervalThink(self)
	if IsServer() then
		self:stun()
		self:StartIntervalThink(-1)
	end
end
function q.prototype.stun(self)
	local r = self:GetParent():GetEnemy()
	if IsInjurable(self:GetParent(), r) then
		AddStun(self:GetParent(), r, self:GetParent():GetDummyAbility(), self.duration)
	end
end
function q.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_17_buff = q
return g