--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_147"
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
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 16,
		["22"] = 17,
		["23"] = 18,
		["24"] = 19,
		["26"] = 16,
		["27"] = 22,
		["28"] = 23,
		["29"] = 22,
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["35"] = 29,
		["36"] = 29,
		["37"] = 29,
		["38"] = 29,
		["39"] = 29,
		["40"] = 29,
		["42"] = 25,
		["43"] = 32,
		["44"] = 33,
		["45"] = 34,
		["46"] = 35,
		["47"] = 36,
		["48"] = 36,
		["49"] = 36,
		["50"] = 36,
		["51"] = 36,
		["52"] = 36,
		["53"] = 36,
		["54"] = 37,
		["55"] = 37,
		["56"] = 37,
		["57"] = 37,
		["58"] = 37,
		["59"] = 37,
		["60"] = 37,
		["61"] = 32,
		["62"] = 6,
		["63"] = 5,
		["64"] = 6,
		["66"] = 6,
		["67"] = 42,
		["68"] = 49,
		["69"] = 42,
		["70"] = 49,
		["71"] = 53,
		["72"] = 54,
		["73"] = 55,
		["74"] = 56,
		["75"] = 53,
		["76"] = 59,
		["77"] = 60,
		["78"] = 59,
		["79"] = 65,
		["80"] = 66,
		["81"] = 67,
		["82"] = 68,
		["83"] = 69,
		["85"] = 71,
		["88"] = 65,
		["89"] = 76,
		["90"] = 77,
		["91"] = 78,
		["92"] = 79,
		["93"] = 79,
		["94"] = 79,
		["95"] = 79,
		["96"] = 80,
		["97"] = 80,
		["98"] = 80,
		["99"] = 80,
		["100"] = 80,
		["101"] = 80,
		["102"] = 80,
		["103"] = 81,
		["104"] = 82,
		["105"] = 82,
		["106"] = 82,
		["107"] = 82,
		["108"] = 82,
		["109"] = 82,
		["110"] = 82,
		["111"] = 82,
		["112"] = 76,
		["113"] = 89,
		["114"] = 90,
		["115"] = 91,
		["116"] = 92,
		["117"] = 93,
		["119"] = 95,
		["120"] = 95,
		["121"] = 95,
		["122"] = 95,
		["123"] = 96,
		["124"] = 96,
		["125"] = 96,
		["126"] = 96,
		["127"] = 96,
		["128"] = 96,
		["129"] = 96,
		["130"] = 97,
		["131"] = 98,
		["132"] = 99,
		["133"] = 100,
		["134"] = 100,
		["135"] = 100,
		["136"] = 100,
		["137"] = 100,
		["138"] = 100,
		["139"] = 100,
		["140"] = 100,
		["141"] = 105,
		["142"] = 105,
		["143"] = 105,
		["144"] = 105,
		["145"] = 105,
		["146"] = 105,
		["147"] = 105,
		["148"] = 105,
		["149"] = 89,
		["150"] = 49,
		["151"] = 42,
		["152"] = 42,
		["153"] = 42,
		["154"] = 42,
		["155"] = 42,
		["156"] = 42,
		["157"] = 42,
		["158"] = 49,
		["160"] = 49,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_147 = c()
local n = g.trait_147
n.name = "trait_147"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_147"
end
function n.prototype.Spawn(self)
	if IsServer() then
		self.addHpStack = 0
		self.lossHpState = 0
	end
end
function n.prototype.loadAddHpStack(self)
	return self.addHpStack
end
function n.prototype.saveAddHpStack(self, o)
	if IsServer() then
		self.addHpStack = self.addHpStack + o
		self.add_hp = self:GetSpecialValueFor("add_hp")
		PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:entindex(), "KeyWord_Health", self.addHpStack * self.add_hp, true, true)
	end
end
function n.prototype.saveLossHpState(self, p)
	self.lossHpState = self.lossHpState + p
	self.loss_hp = self:GetSpecialValueFor("loss_hp")
	self.add_gold = self:GetSpecialValueFor("add_gold")
	PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID())
		:modifyArtifactExtraData(self:entindex(), "KeyWord_HpLoss", self.lossHpState * self.loss_hp, true, true)
	PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID())
		:modifyArtifactExtraData(self:entindex(), "bonus_gold", self.lossHpState * self.add_gold, true, true)
end
n = e({ j(nil) }, n)
g.trait_147 = n
g.modifier_trait_147 = c()
local q = g.modifier_trait_147
q.name = "modifier_trait_147"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.loss_hp = self:GetAbilitySpecialValueFor("loss_hp")
	self.add_gold = self:GetAbilitySpecialValueFor("add_gold")
	self.add_hp = self:GetAbilitySpecialValueFor("add_hp")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function q.prototype.OnRoundStart(self, r)
	local s = self:GetParent()
	if PlayerData:isAlivePlayer(s:GetPlayerOwnerID()) then
		if PlayerData:PRD(self.parent, 50, "modifier_trait_147") then
			self:ResultLossHp()
		else
			self:ResultAddHP()
		end
	end
end
function q.prototype.ResultAddHP(self)
	local s = self:GetParent()
	local t = s:GetPlayerOwnerID()
	PlayerData:modifyHealth(s:GetPlayerOwnerID(), self.add_hp)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, s, self.add_hp, s:GetPlayerOwner())
	self:GetAbility():saveAddHpStack(1)
	Notification:combatToPlayer(
		t,
		{
			message = "notify_bonus_hp",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			int_hp = self.add_hp,
		}
	)
end
function q.prototype.ResultLossHp(self)
	local s = self:GetParent()
	local u = self.loss_hp
	if s:GetHealth() <= self.loss_hp then
		u = s:GetHealth() - 1
	end
	PlayerData:modifyHealth(s:GetPlayerOwnerID(), -u)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, s, -u, s:GetPlayerOwner())
	local t = s:GetPlayerOwnerID()
	PlayerData:modifyGold(t, self.add_gold)
	self:GetAbility():saveLossHpState(1)
	Notification:combatToPlayer(
		t,
		{
			message = "notify_bonus_losshp",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			int_hp = u,
		}
	)
	Notification:combatToPlayer(
		t,
		{
			message = "notify_bonus_gold",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			int_gold = self.add_gold,
		}
	)
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_147 = q
return g