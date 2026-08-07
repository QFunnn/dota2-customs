--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_112"
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
		["33"] = 24,
		["34"] = 29,
		["35"] = 30,
		["36"] = 29,
		["37"] = 35,
		["38"] = 36,
		["39"] = 35,
		["40"] = 41,
		["41"] = 42,
		["42"] = 41,
		["43"] = 45,
		["44"] = 46,
		["47"] = 45,
		["48"] = 52,
		["49"] = 53,
		["50"] = 54,
		["51"] = 55,
		["53"] = 52,
		["54"] = 59,
		["55"] = 60,
		["58"] = 63,
		["61"] = 66,
		["62"] = 68,
		["63"] = 70,
		["64"] = 71,
		["65"] = 72,
		["66"] = 72,
		["67"] = 72,
		["68"] = 73,
		["69"] = 74,
		["70"] = 75,
		["71"] = 76,
		["72"] = 77,
		["75"] = 72,
		["76"] = 72,
		["77"] = 82,
		["78"] = 83,
		["79"] = 83,
		["80"] = 83,
		["81"] = 83,
		["82"] = 84,
		["83"] = 85,
		["85"] = 59,
		["86"] = 20,
		["87"] = 11,
		["88"] = 11,
		["89"] = 11,
		["90"] = 11,
		["91"] = 11,
		["92"] = 11,
		["93"] = 11,
		["94"] = 11,
		["95"] = 11,
		["96"] = 20,
		["98"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_112 = c()
local n = g.item_equipment_112
n.name = "item_equipment_112"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_112"
end
n = e({ j(nil) }, n)
g.item_equipment_112 = n
g.modifier_item_equipment_112 = c()
local o = g.modifier_item_equipment_112
o.name = "modifier_item_equipment_112"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.share_damage_reduce = self:GetAbilitySpecialValueFor("share_damage_reduce")
	self.limit = self:GetAbilitySpecialValueFor("limit")
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_SHARE_PERCENTAGE] = -self.share_damage_reduce }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function o.prototype.OnBattleStart(self, p)
	if not IsServer() then
		return
	end
end
function o.prototype.OnCreated(self, p)
	if not IsServer() then
		self:SetStackCount(self.limit)
		PlayerData:getHero(self:GetParent():GetPlayerOwnerID()):setItemCharge("item_equipment_112", self.limit)
	end
end
function o.prototype.EOM_GetModifierAvoidDamage(self, p)
	if not IsServer() then
		return
	end
	if self:GetStackCount() <= 0 then
		return
	end
	local q = self:GetParent()
	if p.damage >= q:GetHealth() then
		local r = nil
		local s
		EachWisp(q, function(t)
			if IsValid(t) then
				local u = t:GetHealth()
				if u > 0 and (r == nil or u < r) then
					r = u
					s = t
				end
			end
		end)
		self:DecrementStackCount()
		PlayerData:getHero(q:GetPlayerOwnerID()):setItemCharge("item_equipment_112", self:GetStackCount())
		KillWisp(q, s)
		return 1
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
g.modifier_item_equipment_112 = o
return g