--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
		["33"] = 25,
		["34"] = 26,
		["35"] = 13,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 31,
		["40"] = 28,
		["41"] = 34,
		["42"] = 35,
		["43"] = 36,
		["44"] = 37,
		["45"] = 38,
		["46"] = 39,
		["48"] = 34,
		["49"] = 43,
		["50"] = 44,
		["51"] = 45,
		["52"] = 45,
		["53"] = 45,
		["54"] = 44,
		["55"] = 46,
		["56"] = 46,
		["57"] = 46,
		["58"] = 44,
		["59"] = 44,
		["60"] = 43,
		["61"] = 50,
		["62"] = 51,
		["63"] = 52,
		["64"] = 52,
		["65"] = 52,
		["66"] = 52,
		["67"] = 52,
		["68"] = 52,
		["69"] = 50,
		["70"] = 55,
		["71"] = 56,
		["73"] = 56,
		["75"] = 56,
		["76"] = 57,
		["78"] = 55,
		["79"] = 61,
		["80"] = 62,
		["81"] = 63,
		["82"] = 64,
		["83"] = 65,
		["85"] = 61,
		["86"] = 69,
		["87"] = 70,
		["90"] = 71,
		["91"] = 72,
		["92"] = 73,
		["93"] = 74,
		["94"] = 75,
		["95"] = 76,
		["96"] = 77,
		["97"] = 78,
		["98"] = 79,
		["102"] = 69,
		["103"] = 85,
		["104"] = 86,
		["105"] = 87,
		["106"] = 88,
		["109"] = 89,
		["111"] = 89,
		["112"] = 89,
		["113"] = 89,
		["114"] = 92,
		["115"] = 92,
		["116"] = 92,
		["117"] = 89,
		["118"] = 89,
		["120"] = 85,
		["121"] = 20,
		["122"] = 13,
		["123"] = 13,
		["124"] = 13,
		["125"] = 13,
		["126"] = 13,
		["127"] = 13,
		["128"] = 13,
		["129"] = 20,
		["131"] = 20,
		["133"] = 98,
		["134"] = 106,
		["135"] = 98,
		["136"] = 106,
		["137"] = 110,
		["138"] = 111,
		["139"] = 112,
		["140"] = 110,
		["141"] = 115,
		["142"] = 116,
		["143"] = 117,
		["144"] = 117,
		["145"] = 116,
		["146"] = 115,
		["147"] = 121,
		["148"] = 122,
		["149"] = 122,
		["152"] = 123,
		["153"] = 123,
		["154"] = 124,
		["157"] = 125,
		["158"] = 121,
		["159"] = 106,
		["160"] = 98,
		["161"] = 98,
		["162"] = 98,
		["163"] = 98,
		["164"] = 98,
		["165"] = 98,
		["166"] = 98,
		["167"] = 98,
		["168"] = 106,
		["170"] = 106,
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
	self.rewarded = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.cardProgress = self:GetAbilitySpecialValueFor("card_progress")
	self.targetProgress = self:GetAbilitySpecialValueFor("progress")
	self.equipmentName = "item_equipment_92"
end
function o.prototype.OnCreated(self)
	if IsServer() then
		self.strikeCount = 0
		self.rewarded = false
		self:SetStackCount(0)
		self:UpdateProgressDisplay()
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 },
	}
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
		self:AddProgress(self.cardProgress)
	end
end
function o.prototype.OnMonkeyKingUlt(self, r, s)
	self.strikeCount = self.strikeCount + 1
	if r > 0 and self.strikeCount >= r then
		self.strikeCount = self.strikeCount % r
		self:AddProgress(s)
	end
end
function o.prototype.AddProgress(self, t)
	if not IsServer() or self.rewarded or t <= 0 then
		return
	end
	self:SetStackCount(self:GetStackCount() + t)
	self:UpdateProgressDisplay()
	if self.targetProgress > 0 and self:GetStackCount() >= self.targetProgress then
		self.rewarded = true
		local u = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if u then
			local v = u:exchangeItem(self.equipmentName, 1)
			if not v then
				u:addItemForPlayer(self.equipmentName)
			end
		end
	end
end
function o.prototype.UpdateProgressDisplay(self)
	local w = self:GetParent():GetPlayerOwnerID()
	local x = self:GetAbility()
	if not IsServer() or not x or w < 0 or self.targetProgress <= 0 then
		return
	end
	local y = PlayerData:getplayerData(w)
	if y ~= nil then
		y:modifyArtifactExtraStringData(
			x:entindex(),
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
local z = g.modifier_trait_200_battle
z.name = "modifier_trait_200_battle"
d(z, l)
function z.prototype.GetAbilitySpecialValue(self)
	self.attackCount = self:GetAbilitySpecialValueFor("attack_count")
	self.attackProgress = self:GetAbilitySpecialValueFor("attack_progress")
end
function z.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function z.prototype.OnCustomAbilityFullyCast(self, p)
	local A = p.ability
	if (A and A:GetAbilityName()) ~= "monkey_king_ult" then
		return
	end
	local B = self:GetCaster()
	local C = B and B:FindModifierByName("modifier_trait_200")
	if not IsValid(C) then
		return
	end
	C:OnMonkeyKingUlt(self.attackCount, self.attackProgress)
end
z = e(
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
	z
)
g.modifier_trait_200_battle = z
return g