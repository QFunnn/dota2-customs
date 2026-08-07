--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_85"
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
		["26"] = 11,
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 24,
		["35"] = 29,
		["36"] = 30,
		["37"] = 29,
		["38"] = 34,
		["39"] = 35,
		["40"] = 36,
		["41"] = 36,
		["42"] = 35,
		["43"] = 34,
		["44"] = 39,
		["45"] = 40,
		["46"] = 41,
		["47"] = 42,
		["48"] = 43,
		["49"] = 44,
		["50"] = 45,
		["51"] = 45,
		["52"] = 45,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["56"] = 48,
		["57"] = 49,
		["58"] = 49,
		["59"] = 49,
		["60"] = 49,
		["61"] = 49,
		["62"] = 49,
		["63"] = 49,
		["65"] = 51,
		["69"] = 39,
		["70"] = 20,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 20,
		["82"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_85 = c()
local n = g.item_equipment_85
n.name = "item_equipment_85"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_85"
end
n = e({ j(nil) }, n)
g.item_equipment_85 = n
g.modifier_item_equipment_85 = c()
local o = g.modifier_item_equipment_85
o.name = "modifier_item_equipment_85"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.convert_pct = self:GetAbilitySpecialValueFor("convert_pct")
	self.damage_limit = self:GetAbilitySpecialValueFor("damage_limit")
	self.max = self:GetAbilitySpecialValueFor("max")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function o.prototype.OnCustomTakeDamage(self, p)
	if IsServer() then
		local q = self:GetAbility()
		if IsValid(q) and p and q:IsCooldownReady() then
			local r = p.damage
			if r >= self.damage_limit then
				local s = math.min(math.floor(r * self.convert_pct * 0.01), self.max)
				if s > 0 then
					local t = self:GetParent()
					local u = p.target
					AddInjury(t, u, s, q:GetAbilityName(), "Ability")
				end
				q:StartCooldown(-1)
			end
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
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	o
)
g.modifier_item_equipment_85 = o
return g