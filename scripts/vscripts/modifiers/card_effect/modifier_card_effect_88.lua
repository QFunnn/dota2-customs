--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_88"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringReplace
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 3,
		["13"] = 12,
		["14"] = 3,
		["15"] = 12,
		["16"] = 19,
		["17"] = 20,
		["18"] = 19,
		["19"] = 22,
		["20"] = 23,
		["21"] = 22,
		["22"] = 25,
		["23"] = 26,
		["24"] = 27,
		["25"] = 28,
		["26"] = 29,
		["27"] = 30,
		["28"] = 31,
		["29"] = 32,
		["30"] = 33,
		["32"] = 25,
		["33"] = 36,
		["34"] = 37,
		["35"] = 38,
		["36"] = 39,
		["37"] = 40,
		["38"] = 41,
		["39"] = 41,
		["40"] = 41,
		["41"] = 41,
		["42"] = 43,
		["43"] = 43,
		["44"] = 43,
		["45"] = 43,
		["46"] = 41,
		["47"] = 41,
		["48"] = 41,
		["49"] = 41,
		["50"] = 36,
		["51"] = 48,
		["52"] = 49,
		["53"] = 48,
		["54"] = 54,
		["55"] = 55,
		["56"] = 54,
		["57"] = 57,
		["58"] = 58,
		["59"] = 59,
		["60"] = 60,
		["62"] = 57,
		["63"] = 63,
		["64"] = 64,
		["65"] = 65,
		["66"] = 66,
		["67"] = 66,
		["68"] = 66,
		["69"] = 66,
		["70"] = 66,
		["72"] = 63,
		["73"] = 69,
		["74"] = 70,
		["75"] = 71,
		["76"] = 72,
		["77"] = 72,
		["78"] = 72,
		["79"] = 72,
		["80"] = 72,
		["82"] = 69,
		["83"] = 75,
		["84"] = 76,
		["85"] = 77,
		["88"] = 78,
		["89"] = 79,
		["90"] = 80,
		["91"] = 80,
		["92"] = 80,
		["93"] = 80,
		["94"] = 82,
		["95"] = 82,
		["96"] = 82,
		["97"] = 82,
		["98"] = 80,
		["99"] = 80,
		["100"] = 80,
		["101"] = 80,
		["102"] = 85,
		["103"] = 87,
		["104"] = 88,
		["105"] = 89,
		["106"] = 90,
		["107"] = 91,
		["108"] = 92,
		["110"] = 94,
		["114"] = 75,
		["115"] = 12,
		["116"] = 3,
		["117"] = 3,
		["118"] = 3,
		["119"] = 3,
		["120"] = 3,
		["121"] = 3,
		["122"] = 3,
		["123"] = 3,
		["124"] = 3,
		["125"] = 12,
		["127"] = 12,
		["128"] = 101,
		["129"] = 109,
		["130"] = 101,
		["131"] = 109,
		["132"] = 110,
		["133"] = 111,
		["134"] = 112,
		["135"] = 112,
		["136"] = 111,
		["137"] = 110,
		["138"] = 115,
		["139"] = 116,
		["140"] = 117,
		["141"] = 118,
		["143"] = 115,
		["144"] = 109,
		["145"] = 101,
		["146"] = 101,
		["147"] = 101,
		["148"] = 101,
		["149"] = 101,
		["150"] = 101,
		["151"] = 101,
		["152"] = 101,
		["153"] = 109,
		["155"] = 109,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
h.modifier_card_effect_88 = c()
local l = h.modifier_card_effect_88
l.name = "modifier_card_effect_88"
d(l, j)
function l.prototype.getCountValue(self, m)
	return BUFF_VALUE["ShieldCampaignGoal" .. tostring(m)] or 0
end
function l.prototype.getGoldValue(self, m)
	return BUFF_VALUE["CampaignGold" .. tostring(m)] or 0
end
function l.prototype.OnCreated(self, n)
	if IsServer() then
		self.record = 0
		self.completed = false
		self.level = 1
		self.count = self:getCountValue(self.level)
		self.gold = self:getGoldValue(self.level)
		self.playerID = self.parent:GetPlayerOwnerID()
		self:AddAbility()
	end
end
function l.prototype.AddAbility(self)
	local o = self.playerID
	local p = "106"
	PlayerData:getHero(o):learnAbility(p, true)
	local q = KeyValues.AbilityUpgradesKvs[p]
	Notification:combatToPlayer(
		o,
		{
			message = "notify_artifact_ability_" .. tostring(q.rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. e(self:GetName(), "modifier_", ""),
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. p,
		}
	)
end
function l.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
	}
end
function l.prototype.OnBattleEndStateEnd(self, n)
	self:CheckTaskProgess()
end
function l.prototype.OnBattleStartBefore(self, n)
	if not self.completed then
		local r = PlayerData:getHero(self.parent:GetPlayerOwnerID()).hero
		r:AddNewModifier(r, nil, "modifier_card_effect88_buff", nil)
	end
end
function l.prototype.UpdateSpecialValue(self)
	if IsServer() then
		self.playerID = self:GetCaster():GetPlayerOwnerID()
		PlayerData:getplayerData(self.playerID)
			:modifyArtifactExtraStringData(self.parent:entindex(), "trait_task_progress", tostring(self.record))
	end
end
function l.prototype.UpdateProgress(self, s)
	if IsServer() and self.record < self.count then
		self.record = math.min(self.count, self.record + s)
		PlayerData:getplayerData(self.playerID)
			:modifyArtifactExtraStringData(self:GetParent():entindex(), "trait_task_progress", tostring(self.record))
	end
end
function l.prototype.CheckTaskProgess(self)
	if IsServer() then
		if self.completed then
			return
		end
		if self.record >= self.count then
			PlayerData:modifyGold(self.playerID, self.gold)
			Notification:combatToPlayer(
				self.playerID,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. e(self:GetName(), "modifier_", ""),
					int_gold = self.gold,
				}
			)
			self.level = self.level + 1
			local t = self:getCountValue(self.level)
			if t > self.count then
				self.gold = self:getGoldValue(self.level)
				self.record = 0
				self.count = t
				self:UpdateSpecialValue()
			else
				self.completed = true
			end
		end
	end
end
l = f(
	{
		k(
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
	l
)
h.modifier_card_effect_88 = l
h.modifier_card_effect88_buff = c()
local u = h.modifier_card_effect88_buff
u.name = "modifier_card_effect88_buff"
d(u, j)
function u.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent(), -1 } }
end
function u.prototype.OnShieldGained(self, n)
	if n.iStackCount > 0 then
		local v = PlayerResource:GetSelectedHeroEntity(self.parent:GetPlayerOwnerID())
		v:FindModifierByName("modifier_card_effect_88"):UpdateProgress(n.iStackCount)
	end
end
u = f(
	{
		k(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	u
)
h.modifier_card_effect88_buff = u
return h