--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_108"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 12,
		["19"] = 13,
		["20"] = 14,
		["21"] = 15,
		["23"] = 12,
		["24"] = 18,
		["25"] = 19,
		["26"] = 20,
		["27"] = 21,
		["28"] = 22,
		["29"] = 23,
		["30"] = 24,
		["31"] = 24,
		["32"] = 24,
		["33"] = 24,
		["34"] = 24,
		["36"] = 18,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["40"] = 30,
		["41"] = 30,
		["42"] = 30,
		["43"] = 30,
		["44"] = 30,
		["46"] = 27,
		["47"] = 33,
		["48"] = 34,
		["49"] = 35,
		["52"] = 36,
		["53"] = 37,
		["54"] = 38,
		["55"] = 38,
		["56"] = 38,
		["57"] = 38,
		["58"] = 38,
		["59"] = 38,
		["60"] = 38,
		["61"] = 38,
		["62"] = 43,
		["63"] = 43,
		["64"] = 43,
		["65"] = 43,
		["66"] = 43,
		["67"] = 45,
		["68"] = 46,
		["69"] = 47,
		["70"] = 48,
		["71"] = 49,
		["72"] = 50,
		["74"] = 52,
		["75"] = 53,
		["76"] = 53,
		["77"] = 53,
		["78"] = 53,
		["79"] = 53,
		["80"] = 54,
		["81"] = 55,
		["82"] = 56,
		["83"] = 57,
		["84"] = 58,
		["85"] = 58,
		["86"] = 58,
		["87"] = 58,
		["88"] = 58,
		["89"] = 58,
		["90"] = 58,
		["91"] = 58,
		["92"] = 63,
		["93"] = 63,
		["94"] = 63,
		["95"] = 63,
		["96"] = 63,
		["100"] = 33,
		["101"] = 69,
		["102"] = 70,
		["103"] = 69,
		["104"] = 6,
		["105"] = 5,
		["106"] = 6,
		["108"] = 6,
		["109"] = 74,
		["110"] = 81,
		["111"] = 74,
		["112"] = 81,
		["113"] = 82,
		["114"] = 83,
		["115"] = 82,
		["116"] = 85,
		["117"] = 86,
		["118"] = 87,
		["119"] = 87,
		["120"] = 87,
		["121"] = 86,
		["122"] = 86,
		["123"] = 86,
		["124"] = 85,
		["125"] = 91,
		["126"] = 92,
		["129"] = 93,
		["130"] = 94,
		["131"] = 94,
		["132"] = 94,
		["133"] = 94,
		["134"] = 94,
		["135"] = 94,
		["136"] = 91,
		["137"] = 96,
		["138"] = 97,
		["139"] = 96,
		["140"] = 81,
		["141"] = 74,
		["142"] = 74,
		["143"] = 74,
		["144"] = 74,
		["145"] = 74,
		["146"] = 74,
		["147"] = 74,
		["148"] = 81,
		["150"] = 81,
		["151"] = 102,
		["152"] = 110,
		["153"] = 102,
		["154"] = 110,
		["155"] = 112,
		["156"] = 113,
		["157"] = 112,
		["158"] = 115,
		["159"] = 116,
		["160"] = 116,
		["161"] = 118,
		["162"] = 118,
		["163"] = 118,
		["164"] = 116,
		["165"] = 119,
		["166"] = 119,
		["167"] = 119,
		["168"] = 116,
		["169"] = 116,
		["170"] = 115,
		["171"] = 122,
		["172"] = 123,
		["173"] = 122,
		["174"] = 125,
		["175"] = 126,
		["176"] = 125,
		["177"] = 128,
		["178"] = 129,
		["181"] = 130,
		["182"] = 131,
		["184"] = 128,
		["185"] = 110,
		["186"] = 102,
		["187"] = 102,
		["188"] = 102,
		["189"] = 102,
		["190"] = 102,
		["191"] = 102,
		["192"] = 102,
		["193"] = 102,
		["194"] = 110,
		["196"] = 110,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_108 = c()
local n = g.trait_108
n.name = "trait_108"
d(n, i)
function n.prototype.Spawn(self)
	if IsServer() then
		self.record = 0
		self.completed = false
	end
end
function n.prototype.UpdateSpecialValue(self)
	if IsServer() then
		local o = self:GetLevel()
		self.count = self:GetLevelSpecialValueFor("count", o)
		self.gold = self:GetLevelSpecialValueFor("gold", o)
		self.playerID = self:GetCaster():GetPlayerOwnerID()
		PlayerData:getplayerData(self.playerID)
			:modifyArtifactExtraStringData(self:entindex(), "trait_task_progress", tostring(self.record))
	end
end
function n.prototype.UpdateProgress(self, p)
	if IsServer() and self.record < self.count then
		self.record = math.min(self.count, self.record + p)
		PlayerData:getplayerData(self.playerID)
			:modifyArtifactExtraStringData(self:entindex(), "trait_task_progress", tostring(self.record))
	end
end
function n.prototype.CheckTaskProgess(self)
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
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
					int_gold = self.gold,
				}
			)
			PlayerData:getplayerData(self.playerID):modifyArtifactExtraData(self:entindex(), "bonus_gold", self.gold)
			local q = self:GetLevel() + 1
			local r = self:GetLevelSpecialValueFor("count", q)
			if r ~= self.count then
				self:SetLevel(q)
				self.record = 0
				self:UpdateSpecialValue()
			else
				self.completed = true
				PlayerData:getplayerData(self.playerID)
					:modifyArtifactExtraStringData(self:entindex(), "trait_task_progress", "#activity_completed")
				local s = self.playerID
				local t = "156"
				PlayerData:getHero(s):learnAbility(t, true)
				local u = KeyValues.AbilityUpgradesKvs[t]
				Notification:combatToPlayer(
					s,
					{
						message = "notify_artifact_ability_" .. tostring(u.rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. t,
					}
				)
				PlayerData:getplayerData(s):addArtifactAbilities(self:entindex(), t, true)
			end
		end
	end
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_108"
end
n = e({ j(nil) }, n)
g.trait_108 = n
g.modifier_trait_108 = c()
local v = g.modifier_trait_108
v.name = "modifier_trait_108"
d(v, l)
function v.prototype.OnCreated(self, w)
	self:GetAbility():UpdateSpecialValue()
end
function v.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 },
	}
end
function v.prototype.OnTraitInit(self, w)
	if w.hero:IsCustomIllusion() then
		return
	end
	w.hero:RemoveModifierByName("modifier_trait_108_buff")
	w.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_108_buff", {})
end
function v.prototype.OnRoundStart(self, w)
	self:GetAbility():CheckTaskProgess()
end
v = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	v
)
g.modifier_trait_108 = v
g.modifier_trait_108_buff = c()
local x = g.modifier_trait_108_buff
x.name = "modifier_trait_108_buff"
d(x, l)
function x.prototype.GetAbilitySpecialValue(self)
	self.state = false
end
function x.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
	}
end
function x.prototype.OnBattleStartBefore(self, w)
	self.state = true
end
function x.prototype.OnBattleEnd(self, w)
	self.state = false
end
function x.prototype.OnIceGained(self, w)
	if not self.state then
		return
	end
	if IsValid(self:GetAbility()) and w.iStackCount > 0 then
		self:GetAbility():UpdateProgress(w.iStackCount)
	end
end
x = e(
	{
		m(
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
	x
)
g.modifier_trait_108_buff = x
return g