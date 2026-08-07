--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_57"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIndexOf
local g = b.__TS__ObjectKeys
local h = b.__TS__ArrayFilter
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 4,
		["18"] = 5,
		["19"] = 4,
		["20"] = 5,
		["21"] = 6,
		["22"] = 7,
		["23"] = 6,
		["24"] = 5,
		["25"] = 4,
		["26"] = 5,
		["28"] = 5,
		["29"] = 11,
		["30"] = 19,
		["31"] = 11,
		["32"] = 19,
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["36"] = 26,
		["37"] = 27,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 27,
		["45"] = 27,
		["46"] = 27,
		["47"] = 27,
		["48"] = 27,
		["49"] = 27,
		["50"] = 27,
		["51"] = 27,
		["52"] = 27,
		["53"] = 27,
		["54"] = 27,
		["55"] = 27,
		["56"] = 27,
		["57"] = 27,
		["58"] = 27,
		["59"] = 27,
		["60"] = 27,
		["61"] = 27,
		["62"] = 27,
		["63"] = 27,
		["64"] = 27,
		["65"] = 27,
		["66"] = 27,
		["67"] = 27,
		["68"] = 27,
		["69"] = 27,
		["70"] = 26,
		["71"] = 28,
		["72"] = 28,
		["73"] = 28,
		["74"] = 28,
		["75"] = 28,
		["76"] = 28,
		["77"] = 28,
		["78"] = 28,
		["79"] = 28,
		["80"] = 28,
		["81"] = 28,
		["82"] = 28,
		["83"] = 28,
		["84"] = 28,
		["85"] = 28,
		["86"] = 28,
		["87"] = 28,
		["88"] = 28,
		["89"] = 28,
		["90"] = 28,
		["91"] = 28,
		["92"] = 28,
		["93"] = 28,
		["94"] = 28,
		["95"] = 28,
		["96"] = 28,
		["97"] = 28,
		["98"] = 28,
		["99"] = 28,
		["100"] = 28,
		["101"] = 28,
		["102"] = 28,
		["103"] = 28,
		["104"] = 26,
		["105"] = 29,
		["106"] = 29,
		["107"] = 29,
		["108"] = 29,
		["109"] = 29,
		["110"] = 29,
		["111"] = 29,
		["112"] = 29,
		["113"] = 29,
		["114"] = 29,
		["115"] = 29,
		["116"] = 29,
		["117"] = 29,
		["118"] = 29,
		["119"] = 29,
		["120"] = 29,
		["121"] = 29,
		["122"] = 29,
		["123"] = 29,
		["124"] = 29,
		["125"] = 29,
		["126"] = 29,
		["127"] = 29,
		["128"] = 29,
		["129"] = 29,
		["130"] = 29,
		["131"] = 29,
		["132"] = 29,
		["133"] = 29,
		["134"] = 29,
		["135"] = 29,
		["136"] = 29,
		["137"] = 29,
		["138"] = 26,
		["139"] = 30,
		["140"] = 30,
		["141"] = 30,
		["142"] = 30,
		["143"] = 30,
		["144"] = 30,
		["145"] = 30,
		["146"] = 30,
		["147"] = 30,
		["148"] = 30,
		["149"] = 30,
		["150"] = 30,
		["151"] = 30,
		["152"] = 30,
		["153"] = 30,
		["154"] = 30,
		["155"] = 30,
		["156"] = 30,
		["157"] = 30,
		["158"] = 30,
		["159"] = 30,
		["160"] = 30,
		["161"] = 30,
		["162"] = 30,
		["163"] = 30,
		["164"] = 30,
		["165"] = 30,
		["166"] = 30,
		["167"] = 30,
		["168"] = 30,
		["169"] = 30,
		["170"] = 30,
		["171"] = 30,
		["172"] = 26,
		["173"] = 23,
		["174"] = 43,
		["175"] = 44,
		["176"] = 43,
		["177"] = 49,
		["178"] = 50,
		["179"] = 51,
		["180"] = 52,
		["181"] = 53,
		["182"] = 54,
		["183"] = 54,
		["184"] = 54,
		["185"] = 54,
		["187"] = 55,
		["188"] = 55,
		["189"] = 56,
		["190"] = 57,
		["191"] = 57,
		["192"] = 57,
		["193"] = 58,
		["194"] = 59,
		["195"] = 60,
		["196"] = 61,
		["197"] = 57,
		["198"] = 57,
		["199"] = 65,
		["202"] = 66,
		["203"] = 68,
		["204"] = 69,
		["205"] = 70,
		["206"] = 70,
		["207"] = 70,
		["208"] = 70,
		["209"] = 72,
		["210"] = 72,
		["211"] = 72,
		["212"] = 72,
		["213"] = 72,
		["214"] = 72,
		["215"] = 72,
		["216"] = 72,
		["217"] = 55,
		["222"] = 49,
		["223"] = 19,
		["224"] = 11,
		["225"] = 11,
		["226"] = 11,
		["227"] = 11,
		["228"] = 11,
		["229"] = 11,
		["230"] = 11,
		["231"] = 11,
		["232"] = 19,
		["234"] = 19,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseItem
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.item_artifact_57 = c()
local q = j.item_artifact_57
q.name = "item_artifact_57"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_57"
end
q = e({ m(nil) }, q)
j.item_artifact_57 = q
j.modifier_item_artifact_57 = c()
local r = j.modifier_item_artifact_57
r.name = "modifier_item_artifact_57"
d(r, o)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.config = GetRandomElement({
		{ 1, 2, 3, 4, 6, 7, 9, 10, 11, 12, 14, 15, 16, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 31, 33, 34, 35, 36, 37, 38, 39, 40, 41 },
		{ 1, 3, 4, 5, 6, 7, 8, 10, 11, 12, 14, 15, 16, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 31, 33, 34, 35, 36, 37, 38, 39, 40, 41 },
		{ 1, 2, 4, 5, 6, 7, 8, 10, 11, 12, 14, 15, 16, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 31, 33, 34, 35, 36, 37, 38, 39, 40, 41 },
		{ 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 14, 15, 16, 18, 19, 20, 21, 23, 24, 25, 26, 27, 28, 31, 33, 34, 35, 36, 37, 38, 39, 40, 41 },
	})
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function r.prototype.OnBattleEnd(self, s)
	local t = self:GetParent():GetPlayerOwnerID()
	local u = s.illusionPlayerID ~= nil and s.illusionPlayerID == t
	if t == s.losePlayerID and not u and s.isNeutral == nil then
		self:IncrementStackCount()
		if f(self.config, self:GetStackCount()) ~= -1 then
			do
				local v = 0
				while v < self.count do
					local w = PlayerData:getHero(t):getAbilityUpgradeData()
					local x = PlayerData:getHero(s.winPlayerID and s.winPlayerID or s.illusionPlayerID)
					local y = h(g(x and x:getAbilityUpgradeData() or {}), function(z, A)
						local B = KeyValues.AbilityUpgradesKvs[A]
						local C = SECT_ABILITY_LEVEL[B.rarity]
						return w[A] == nil or w[A].level < C
					end)
					if #y <= 0 then
						return
					end
					local D = GetRandomElement(y)
					PlayerData:getHero(s.losePlayerID):learnAbility(D, true)
					self:GetAbility():SetCurrentCharges(self:GetAbility():GetCurrentCharges() + 1)
					PlayerData:getplayerData(t):addArtifactAbilities(self:GetAbility():entindex(), D)
					Notification:combatToPlayer(
						s.losePlayerID,
						{
							message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[D].rarity),
							string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_57",
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. D,
						}
					)
					v = v + 1
				end
			end
		end
	end
end
r = e(
	{
		p(
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
	r
)
j.modifier_item_artifact_57 = r
return j