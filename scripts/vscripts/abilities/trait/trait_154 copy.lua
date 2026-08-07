--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/abilities/trait/trait_154 copy.ts"
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
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 11,
		["27"] = 18,
		["28"] = 11,
		["29"] = 18,
		["30"] = 20,
		["31"] = 21,
		["32"] = 20,
		["33"] = 26,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 30,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 30,
		["44"] = 26,
		["45"] = 18,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 18,
		["55"] = 18,
		["56"] = 36,
		["57"] = 43,
		["58"] = 36,
		["59"] = 43,
		["61"] = 43,
		["62"] = 46,
		["63"] = 36,
		["64"] = 47,
		["65"] = 48,
		["66"] = 49,
		["67"] = 47,
		["68"] = 52,
		["69"] = 53,
		["70"] = 52,
		["71"] = 58,
		["72"] = 59,
		["73"] = 60,
		["75"] = 62,
		["76"] = 58,
		["77"] = 65,
		["78"] = 66,
		["79"] = 67,
		["80"] = 67,
		["81"] = 66,
		["82"] = 65,
		["83"] = 70,
		["84"] = 71,
		["85"] = 72,
		["86"] = 73,
		["88"] = 70,
		["89"] = 43,
		["90"] = 36,
		["91"] = 36,
		["92"] = 36,
		["93"] = 36,
		["94"] = 36,
		["95"] = 36,
		["96"] = 36,
		["97"] = 43,
		["99"] = 43,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_154 = d()
local o = h.trait_154
o.name = "trait_154"
e(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_154"
end
o = f({ k(nil) }, o)
h.trait_154 = o
h.modifier_trait_154 = d()
local p = h.modifier_trait_154
p.name = "modifier_trait_154"
e(p, m)
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function p.prototype.OnBattleStart(self, q)
	if IsServer() then
		local r = self.parent:GetPlayerOwnerID()
		local s = PlayerData:getHero(r).hero
		s:AddNewModifier(s, self:GetAbility(), "modifier_trait_154_buf", {})
	end
end
p = f(
	{ n(
		nil,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_154 = p
h.modifier_trait_154_buf = d()
local t = h.modifier_trait_154_buf
t.name = "modifier_trait_154_buf"
e(t, m)
function t.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.cur_ult_cnt = 0
end
function t.prototype.GetAbilitySpecialValue(self)
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.max_ult_cnt = self:GetAbilitySpecialValueFor("max_ult_cnt")
end
function t.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS }
end
function t.prototype.EOM_GetModifierManaRegenBonus(self, q)
	if IsServer() then
		self:SetStackCount(self.mana_regen)
	end
	return self:GetStackCount()
end
function t.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function t.prototype.OnCustomAbilityFullyCast(self, u)
	self.cur_ult_cnt = self.cur_ult_cnt + 1
	if self.cur_ult_cnt >= self.max_ult_cnt then
		self.parent:RemoveModifierByName("modifier_trait_154_buf")
	end
end
t = f(
	{ n(
		nil,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
h.modifier_trait_154_buf = t
return h