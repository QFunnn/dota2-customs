--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_134"
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
		["20"] = 7,
		["22"] = 6,
		["23"] = 10,
		["24"] = 11,
		["25"] = 10,
		["26"] = 14,
		["27"] = 15,
		["28"] = 16,
		["29"] = 17,
		["30"] = 18,
		["33"] = 19,
		["36"] = 22,
		["37"] = 23,
		["38"] = 24,
		["39"] = 24,
		["41"] = 23,
		["42"] = 26,
		["43"] = 27,
		["44"] = 28,
		["45"] = 14,
		["46"] = 30,
		["47"] = 31,
		["48"] = 32,
		["49"] = 33,
		["51"] = 35,
		["52"] = 30,
		["53"] = 38,
		["54"] = 39,
		["55"] = 38,
		["56"] = 5,
		["57"] = 4,
		["58"] = 5,
		["60"] = 5,
		["61"] = 43,
		["62"] = 51,
		["63"] = 43,
		["64"] = 51,
		["65"] = 54,
		["66"] = 55,
		["67"] = 54,
		["68"] = 58,
		["69"] = 59,
		["70"] = 58,
		["71"] = 62,
		["72"] = 63,
		["73"] = 62,
		["74"] = 51,
		["75"] = 43,
		["76"] = 43,
		["77"] = 43,
		["78"] = 43,
		["79"] = 43,
		["80"] = 43,
		["81"] = 43,
		["82"] = 43,
		["83"] = 51,
		["85"] = 51,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_134 = c()
local n = g.item_artifact_134
n.name = "item_artifact_134"
d(n, i)
function n.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("charges"))
	end
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_134"
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster():GetPlayerOwnerID()
	local p = PlayerData:getplayerData(o)
	local q = self:GetSpecialValueFor("limit")
	if not p then
		return
	end
	if p.health >= q then
		return
	end
	local r = p.health
	PlayerData:eachPlayer(function(s, t)
		if t.health > r then
			r = t.health
		end
	end)
	local u = math.min(q, r)
	PlayerData:modifyHealth(o, u - p.health)
	self:SpendCharge()
end
function n.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() <= 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function n.prototype.GetCustomCastError(self)
	return self.error
end
n = e({ j(nil) }, n)
g.item_artifact_134 = n
g.modifier_item_artifact_134 = c()
local v = g.modifier_item_artifact_134
v.name = "modifier_item_artifact_134"
d(v, l)
function v.prototype.GetAbilitySpecialValue(self)
	self.player_damage_bonus = self:GetAbilitySpecialValueFor("player_damage_bonus")
end
function v.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PLAYER_DAMAGE_REDUCE }
end
function v.prototype.EOM_GetModifierPlayerDamageReduce(self)
	return -self.player_damage_bonus
end
v = e(
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
			}
		),
	},
	v
)
g.modifier_item_artifact_134 = v
return g