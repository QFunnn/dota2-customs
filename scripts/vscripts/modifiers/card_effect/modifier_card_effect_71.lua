--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_71"
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
		["12"] = 12,
		["13"] = 3,
		["14"] = 12,
		["15"] = 15,
		["16"] = 16,
		["17"] = 17,
		["18"] = 15,
		["19"] = 19,
		["20"] = 20,
		["22"] = 19,
		["23"] = 23,
		["24"] = 24,
		["25"] = 23,
		["26"] = 29,
		["27"] = 30,
		["28"] = 31,
		["29"] = 32,
		["30"] = 33,
		["31"] = 34,
		["32"] = 35,
		["35"] = 29,
		["36"] = 12,
		["37"] = 3,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 3,
		["46"] = 12,
		["48"] = 12,
		["49"] = 41,
		["50"] = 50,
		["51"] = 41,
		["52"] = 50,
		["53"] = 53,
		["54"] = 54,
		["55"] = 55,
		["57"] = 53,
		["58"] = 58,
		["59"] = 59,
		["60"] = 58,
		["61"] = 63,
		["62"] = 64,
		["63"] = 63,
		["64"] = 67,
		["65"] = 68,
		["66"] = 67,
		["67"] = 73,
		["68"] = 74,
		["69"] = 73,
		["70"] = 50,
		["71"] = 41,
		["72"] = 41,
		["73"] = 41,
		["74"] = 41,
		["75"] = 41,
		["76"] = 41,
		["77"] = 41,
		["78"] = 41,
		["79"] = 41,
		["80"] = 50,
		["82"] = 50,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_card_effect_71 = c()
local k = g.modifier_card_effect_71
k.name = "modifier_card_effect_71"
d(k, i)
function k.prototype.GetAbilitySpecialValue(self)
	self.reduce = self:GetEffectCardValueFor("reduce")
	self.duration = self:GetEffectCardValueFor("duration")
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
	end
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = { -1, -1 } }
end
function k.prototype.OnConfirmBattle(self, l)
	if IsServer() then
		local m = PlayerData:getHero(self.parent:GetPlayerOwnerID())
		local n = m.hero:GetEnemy()
		if IsInjurable(n, self.parent) then
			n:AddNewModifier(
				self.caster,
				nil,
				"modifier_card_effect_71_buff",
				{ duration = self.duration, reduce = self.reduce }
			)
			self.parent:RemoveModifierByName("modifier_card_effect_71")
		end
	end
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
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	k
)
g.modifier_card_effect_71 = k
g.modifier_card_effect_71_buff = c()
local o = g.modifier_card_effect_71_buff
o.name = "modifier_card_effect_71_buff"
d(o, i)
function o.prototype.OnCreated(self, l)
	if IsServer() then
		self:SetStackCount(l.reduce)
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function o.prototype.EOM_GetModifierIncomingDamagePercentage(self, l)
	return self:GetStackCount()
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent } }
end
function o.prototype.OnBattleEnd(self, l)
	self.parent:RemoveModifierByName("modifier_card_effect_71_buff")
end
o = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_card_effect_71_buff = o
return g