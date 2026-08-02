--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFind
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 4,
		["16"] = 5,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["23"] = 6,
		["24"] = 11,
		["25"] = 12,
		["26"] = 13,
		["27"] = 14,
		["28"] = 15,
		["29"] = 15,
		["30"] = 15,
		["31"] = 19,
		["32"] = 20,
		["33"] = 22,
		["34"] = 23,
		["35"] = 23,
		["36"] = 23,
		["37"] = 23,
		["38"] = 24,
		["39"] = 25,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 27,
		["46"] = 15,
		["47"] = 15,
		["48"] = 11,
		["49"] = 31,
		["50"] = 32,
		["51"] = 33,
		["52"] = 34,
		["54"] = 36,
		["55"] = 31,
		["56"] = 38,
		["57"] = 39,
		["58"] = 38,
		["59"] = 41,
		["60"] = 42,
		["61"] = 41,
		["62"] = 5,
		["63"] = 4,
		["64"] = 5,
		["66"] = 5,
		["67"] = 46,
		["68"] = 55,
		["69"] = 46,
		["70"] = 55,
		["72"] = 55,
		["73"] = 56,
		["74"] = 46,
		["75"] = 60,
		["76"] = 61,
		["77"] = 62,
		["78"] = 60,
		["79"] = 64,
		["80"] = 65,
		["81"] = 66,
		["82"] = 67,
		["84"] = 64,
		["85"] = 70,
		["86"] = 71,
		["89"] = 72,
		["90"] = 73,
		["91"] = 74,
		["92"] = 75,
		["94"] = 75,
		["96"] = 70,
		["97"] = 77,
		["98"] = 78,
		["99"] = 77,
		["100"] = 82,
		["101"] = 83,
		["102"] = 84,
		["104"] = 82,
		["105"] = 55,
		["106"] = 46,
		["107"] = 46,
		["108"] = 46,
		["109"] = 46,
		["110"] = 46,
		["111"] = 46,
		["112"] = 46,
		["113"] = 46,
		["114"] = 46,
		["115"] = 55,
		["117"] = 55,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_4 = c()
local o = h.item_artifact_4
o.name = "item_artifact_4"
d(o, j)
function o.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function o.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	self:SpendCharge()
	local q = p:GetPlayerOwnerID()
	PlayerData:requestSectSelection(
		q,
		{ title = "为选择的流派增加经验", sects = AbilityShop.pickList, ability_name = "item_artifact_4" },
		function(r, q, s)
			if IsValid(self) and IsValid(self:GetCaster()) then
				local t = self:GetCaster():FindAllModifiersByName("modifier_item_artifact_4")
				local u = e(t, function(r, v)
					return IsValid(v) and v:GetAbility() == self
				end)
				if u then
					u:SetSpecifySect(s)
				end
				PlayerData:getHero(q):addSectExp(s, self:GetSpecialValueFor("exp"))
			end
		end
	)
end
function o.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() == 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function o.prototype.GetCustomCastError(self)
	return self.error
end
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_4"
end
o = f({ k(nil) }, o)
h.item_artifact_4 = o
h.modifier_item_artifact_4 = c()
local w = h.modifier_item_artifact_4
w.name = "modifier_item_artifact_4"
d(w, m)
function w.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.specify_sect = {}
end
function w.prototype.GetAbilitySpecialValue(self)
	self.max_exp_reduce = self:GetAbilitySpecialValueFor("max_exp_reduce")
	self.charges = 1
end
function w.prototype.OnCreated(self, x)
	if IsServer() then
		self.specify_sect = {}
		self.counter = 0
	end
end
function w.prototype.SetSpecifySect(self, s)
	if self.counter >= self.charges then
		return
	end
	self.counter = self.counter + 1
	self.specify_sect[s] = (self.specify_sect[s] or 0) + 1
	local q = self:GetParent():GetPlayerOwnerID()
	local y = PlayerData:getHero(q)
	if y ~= nil then
		y:addSectExp(s, 0)
	end
end
function w.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SECT_EXP_REDUCE }
end
function w.prototype.EOM_GetModifierSectExpReduce(self, x)
	if x and x.sect and self.specify_sect[x.sect] ~= nil then
		return self.max_exp_reduce * self.specify_sect[x.sect]
	end
end
w = f(
	{
		n(
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
	w
)
h.modifier_item_artifact_4 = w
return h