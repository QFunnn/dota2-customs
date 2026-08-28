--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_200"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["15"] = 6,
		["16"] = 7,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["21"] = 8,
		["22"] = 7,
		["23"] = 6,
		["24"] = 7,
		["26"] = 7,
		["27"] = 13,
		["28"] = 20,
		["29"] = 13,
		["30"] = 20,
		["32"] = 20,
		["33"] = 27,
		["34"] = 28,
		["35"] = 29,
		["36"] = 13,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["40"] = 34,
		["41"] = 35,
		["42"] = 36,
		["43"] = 31,
		["44"] = 39,
		["45"] = 40,
		["46"] = 41,
		["47"] = 42,
		["48"] = 43,
		["49"] = 44,
		["50"] = 45,
		["52"] = 39,
		["53"] = 49,
		["54"] = 50,
		["55"] = 51,
		["56"] = 51,
		["57"] = 51,
		["58"] = 50,
		["59"] = 50,
		["60"] = 53,
		["61"] = 53,
		["62"] = 53,
		["63"] = 50,
		["64"] = 50,
		["65"] = 49,
		["66"] = 57,
		["67"] = 58,
		["68"] = 57,
		["69"] = 61,
		["70"] = 62,
		["71"] = 63,
		["72"] = 63,
		["73"] = 63,
		["74"] = 63,
		["75"] = 63,
		["76"] = 63,
		["77"] = 61,
		["78"] = 66,
		["79"] = 67,
		["81"] = 67,
		["83"] = 67,
		["84"] = 68,
		["86"] = 66,
		["87"] = 72,
		["88"] = 73,
		["91"] = 74,
		["92"] = 75,
		["95"] = 77,
		["96"] = 78,
		["97"] = 79,
		["98"] = 80,
		["100"] = 80,
		["102"] = 80,
		["104"] = 80,
		["106"] = 80,
		["107"] = 81,
		["110"] = 85,
		["113"] = 86,
		["114"] = 87,
		["115"] = 88,
		["116"] = 72,
		["117"] = 91,
		["118"] = 92,
		["119"] = 93,
		["120"] = 94,
		["121"] = 95,
		["123"] = 91,
		["124"] = 99,
		["125"] = 100,
		["128"] = 101,
		["129"] = 102,
		["130"] = 103,
		["131"] = 104,
		["132"] = 105,
		["133"] = 106,
		["134"] = 107,
		["135"] = 108,
		["136"] = 109,
		["140"] = 99,
		["141"] = 115,
		["142"] = 116,
		["143"] = 117,
		["144"] = 118,
		["147"] = 119,
		["149"] = 119,
		["150"] = 119,
		["151"] = 119,
		["152"] = 122,
		["153"] = 122,
		["154"] = 122,
		["155"] = 119,
		["156"] = 119,
		["158"] = 115,
		["159"] = 20,
		["160"] = 13,
		["161"] = 13,
		["162"] = 13,
		["163"] = 13,
		["164"] = 13,
		["165"] = 13,
		["166"] = 13,
		["167"] = 20,
		["169"] = 20,
		["171"] = 128,
		["172"] = 136,
		["173"] = 128,
		["174"] = 136,
		["175"] = 140,
		["176"] = 141,
		["177"] = 142,
		["178"] = 140,
		["179"] = 145,
		["180"] = 146,
		["181"] = 147,
		["182"] = 147,
		["183"] = 146,
		["184"] = 145,
		["185"] = 151,
		["186"] = 152,
		["187"] = 152,
		["190"] = 155,
		["191"] = 151,
		["192"] = 158,
		["193"] = 159,
		["194"] = 159,
		["195"] = 160,
		["198"] = 163,
		["199"] = 158,
		["200"] = 136,
		["201"] = 128,
		["202"] = 128,
		["203"] = 128,
		["204"] = 128,
		["205"] = 128,
		["206"] = 128,
		["207"] = 128,
		["208"] = 128,
		["209"] = 136,
		["211"] = 136,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_200 = c()
local n = g.trait_200
n.name = "trait_200"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_200"
end
n = e({ j(nil) }, n)
g.trait_200 = n
g.modifier_trait_200 = c()
local o = g.modifier_trait_200
o.name = "modifier_trait_200"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.strikeCount = 0
	self.goldCardCount = 0
	self.rewarded = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.cardProgress = self:GetAbilitySpecialValueFor("card_progress")
	self.targetProgress = self:GetAbilitySpecialValueFor("progress")
	self.attackCount = self:GetAbilitySpecialValueFor("attack_count")
	self.attackProgress = self:GetAbilitySpecialValueFor("attack_progress")
	self.equipmentName = "item_equipment_92"
end
function o.prototype.OnCreated(self)
	if IsServer() then
		self.strikeCount = 0
		self.goldCardCount = 0
		self.rewarded = false
		self:SetStackCount(0)
		self:UpdateProgressDisplay()
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 },
	}
end
function o.prototype.OnPrepare(self)
	self:SyncGoldCardProgress()
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_200_battle")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_200_battle", {})
end
function o.prototype.OnAbilityBuy(self, p)
	local q = KeyValues.AbilityUpgradesKvs[p.abilityname]
	if q ~= nil then
		q = q.rarity
	end
	if q == "sr" then
		self:SyncGoldCardProgress()
	end
end
function o.prototype.SyncGoldCardProgress(self)
	if not IsServer() or self.rewarded then
		return
	end
	local r = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	if not r then
		return
	end
	local s = 0
	local t = r:getAbilityUpgradeData(true, true)
	for u, v in pairs(t) do
		local w = v.level > 0
		if w then
			local x = KeyValues.AbilityUpgradesKvs[u]
			if x ~= nil then
				x = x.rarity
			end
			w = x == "sr"
		end
		if w then
			s = s + v.level
		end
	end
	if s <= self.goldCardCount then
		return
	end
	local y = s - self.goldCardCount
	self.goldCardCount = s
	self:AddProgress(y * self.cardProgress)
end
function o.prototype.OnMonkeyKingUlt(self)
	self.strikeCount = self.strikeCount + 1
	if self.attackCount > 0 and self.strikeCount >= self.attackCount then
		self.strikeCount = self.strikeCount % self.attackCount
		self:AddProgress(self.attackProgress)
	end
end
function o.prototype.AddProgress(self, z)
	if not IsServer() or self.rewarded or z <= 0 then
		return
	end
	self:SetStackCount(self:GetStackCount() + z)
	self:UpdateProgressDisplay()
	if self.targetProgress > 0 and self:GetStackCount() >= self.targetProgress then
		self.rewarded = true
		local r = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if r then
			local A = r:exchangeItem(self.equipmentName, 1)
			if not A then
				r:addItemForPlayer(self.equipmentName)
			end
		end
	end
end
function o.prototype.UpdateProgressDisplay(self)
	local B = self:GetParent():GetPlayerOwnerID()
	local C = self:GetAbility()
	if not IsServer() or not C or B < 0 or self.targetProgress <= 0 then
		return
	end
	local D = PlayerData:getplayerData(B)
	if D ~= nil then
		D:modifyArtifactExtraStringData(
			C:entindex(),
			"trait_task_progress",
			(tostring(math.min(self:GetStackCount(), self.targetProgress)) .. "/") .. tostring(self.targetProgress)
		)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_200 = o
g.modifier_trait_200_battle = c()
local E = g.modifier_trait_200_battle
E.name = "modifier_trait_200_battle"
d(E, l)
function E.prototype.GetAbilitySpecialValue(self)
	self.attackCount = self:GetAbilitySpecialValueFor("attack_count")
	self.attackProgress = self:GetAbilitySpecialValueFor("attack_progress")
end
function E.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function E.prototype.OnCustomAbilityFullyCast(self, p)
	local F = p.ability
	if (F and F:GetAbilityName()) ~= "monkey_king_ult" then
		return
	end
	self:OnMonkeyKingUlt()
end
function E.prototype.OnMonkeyKingUlt(self)
	local G = self:GetCaster()
	local H = G and G:FindModifierByName("modifier_trait_200")
	if not IsValid(H) then
		return
	end
	H:OnMonkeyKingUlt()
end
E = e(
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
	E
)
g.modifier_trait_200_battle = E
return g