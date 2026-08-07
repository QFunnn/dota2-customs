--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_125"
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
		["20"] = 5,
		["21"] = 7,
		["22"] = 4,
		["23"] = 8,
		["24"] = 9,
		["25"] = 10,
		["26"] = 11,
		["28"] = 8,
		["29"] = 14,
		["30"] = 15,
		["31"] = 16,
		["32"] = 17,
		["33"] = 18,
		["34"] = 20,
		["35"] = 21,
		["36"] = 21,
		["37"] = 21,
		["38"] = 25,
		["39"] = 26,
		["40"] = 27,
		["41"] = 28,
		["42"] = 29,
		["43"] = 30,
		["44"] = 30,
		["45"] = 30,
		["46"] = 30,
		["47"] = 31,
		["48"] = 32,
		["50"] = 34,
		["51"] = 34,
		["52"] = 34,
		["53"] = 34,
		["55"] = 21,
		["56"] = 21,
		["58"] = 14,
		["59"] = 39,
		["60"] = 40,
		["61"] = 41,
		["62"] = 42,
		["64"] = 44,
		["65"] = 39,
		["66"] = 46,
		["67"] = 47,
		["68"] = 46,
		["69"] = 49,
		["70"] = 50,
		["71"] = 49,
		["72"] = 5,
		["73"] = 4,
		["74"] = 5,
		["76"] = 5,
		["77"] = 54,
		["78"] = 63,
		["79"] = 54,
		["80"] = 63,
		["82"] = 63,
		["83"] = 64,
		["84"] = 54,
		["85"] = 68,
		["86"] = 69,
		["87"] = 70,
		["88"] = 68,
		["89"] = 72,
		["90"] = 73,
		["91"] = 74,
		["92"] = 75,
		["94"] = 72,
		["95"] = 78,
		["96"] = 79,
		["99"] = 80,
		["100"] = 81,
		["101"] = 82,
		["102"] = 83,
		["104"] = 83,
		["106"] = 78,
		["107"] = 85,
		["108"] = 86,
		["109"] = 85,
		["110"] = 90,
		["111"] = 91,
		["112"] = 92,
		["114"] = 90,
		["115"] = 63,
		["116"] = 54,
		["117"] = 54,
		["118"] = 54,
		["119"] = 54,
		["120"] = 54,
		["121"] = 54,
		["122"] = 54,
		["123"] = 54,
		["124"] = 54,
		["125"] = 63,
		["127"] = 63,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_125 = c()
local o = h.item_artifact_125
o.name = "item_artifact_125"
d(o, j)
function o.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.isCreate = false
end
function o.prototype.Spawn(self)
	if IsServer() then
		self.charges = self:GetSpecialValueFor("charges")
		self:SetCurrentCharges(self.charges)
	end
end
function o.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	local q = p:GetPlayerOwnerID()
	local r = AbilityShop.pickList
	if not self.isCreate then
		self.isCreate = true
		PlayerData:requestSectSelection(
			q,
			{ title = "为选择的流派增加经验", sects = r, ability_name = "item_artifact_125" },
			function(s, q, t)
				self.isCreate = false
				if IsValid(self) and IsValid(self:GetCaster()) then
					self:SpendCharge()
					local u = self:GetCaster():FindAllModifiersByName("modifier_item_artifact_125")
					local v = e(u, function(s, w)
						return IsValid(w) and w:GetAbility() == self
					end)
					if v then
						v:SetSpecifySect(t)
					end
					PlayerData:getHero(q):addSectExp(t, self:GetSpecialValueFor("exp"))
				end
			end
		)
	end
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
	return "modifier_item_artifact_125"
end
o = f({ k(nil) }, o)
h.item_artifact_125 = o
h.modifier_item_artifact_125 = c()
local x = h.modifier_item_artifact_125
x.name = "modifier_item_artifact_125"
d(x, m)
function x.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.specify_sect = {}
end
function x.prototype.GetAbilitySpecialValue(self)
	self.max_exp_reduce = self:GetAbilitySpecialValueFor("max_exp_reduce")
	self.charges = self:GetAbilitySpecialValueFor("charges")
end
function x.prototype.OnCreated(self, y)
	if IsServer() then
		self.specify_sect = {}
		self.counter = 0
	end
end
function x.prototype.SetSpecifySect(self, t)
	if self.counter >= self.charges then
		return
	end
	self.counter = self.counter + 1
	self.specify_sect[t] = (self.specify_sect[t] or 0) + 1
	local q = self:GetParent():GetPlayerOwnerID()
	local z = PlayerData:getHero(q)
	if z ~= nil then
		z:addSectExp(t, 0)
	end
end
function x.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SECT_EXP_REDUCE }
end
function x.prototype.EOM_GetModifierSectExpReduce(self, y)
	if y and y.sect and self.specify_sect[y.sect] ~= nil then
		return self.max_exp_reduce * self.specify_sect[y.sect]
	end
end
x = f(
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
	x
)
h.modifier_item_artifact_125 = x
return h