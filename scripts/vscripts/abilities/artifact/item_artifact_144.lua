--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_144"
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
		["18"] = 5,
		["19"] = 5,
		["20"] = 5,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 7,
		["27"] = 8,
		["28"] = 7,
		["29"] = 8,
		["31"] = 8,
		["32"] = 10,
		["33"] = 11,
		["34"] = 7,
		["35"] = 12,
		["36"] = 13,
		["37"] = 12,
		["38"] = 15,
		["39"] = 16,
		["40"] = 15,
		["41"] = 18,
		["42"] = 19,
		["43"] = 18,
		["44"] = 21,
		["45"] = 22,
		["46"] = 21,
		["47"] = 26,
		["48"] = 27,
		["49"] = 28,
		["52"] = 29,
		["53"] = 30,
		["56"] = 33,
		["57"] = 34,
		["59"] = 35,
		["60"] = 35,
		["61"] = 36,
		["62"] = 37,
		["63"] = 38,
		["65"] = 35,
		["69"] = 42,
		["70"] = 43,
		["71"] = 44,
		["72"] = 45,
		["73"] = 46,
		["74"] = 47,
		["75"] = 47,
		["76"] = 47,
		["77"] = 47,
		["78"] = 47,
		["79"] = 47,
		["80"] = 47,
		["81"] = 47,
		["84"] = 26,
		["85"] = 8,
		["86"] = 7,
		["87"] = 7,
		["88"] = 7,
		["89"] = 7,
		["90"] = 7,
		["91"] = 7,
		["92"] = 7,
		["93"] = 7,
		["94"] = 8,
		["96"] = 8,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_144 = c()
local n = g.item_artifact_144
n.name = "item_artifact_144"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_144"
end
n = e({ j(nil) }, n)
g.item_artifact_144 = n
g.modifier_item_artifact_144 = c()
local o = g.modifier_item_artifact_144
o.name = "modifier_item_artifact_144"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.bonusLevel = 0
	self.resolving = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_DEFAULT_LEVEL_BONUS }
end
function o.prototype.EOM_GetModifierDefaultLevelBonus(self)
	return self.bonusLevel
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function o.prototype.OnHeroLevelUp(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	if self.resolving or p.player_id ~= q then
		return
	end
	local r = PlayerData:getHero(q)
	if not r then
		return
	end
	local s = false
	if p.up_lvl > 0 then
		do
			local t = 0
			while t < p.up_lvl do
				if self:PRD(self.chance) then
					s = true
					self.bonusLevel = self.bonusLevel + 1
				end
				t = t + 1
			end
		end
	end
	self.resolving = true
	r:fixHeroLevel(self:GetParent())
	self.resolving = false
	if s then
		local u = PlayerData:getplayerData(q)
		if u ~= nil then
			u:modifyArtifactExtraData(
				self:GetAbility():entindex(),
				"DOTA_Tooltip_ability_trait_103_effect",
				self.bonusLevel,
				true,
				true
			)
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
			}
		),
	},
	o
)
g.modifier_item_artifact_144 = o
return g