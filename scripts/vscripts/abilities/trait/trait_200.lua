--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["47"] = 34,
		["48"] = 42,
		["49"] = 43,
		["50"] = 44,
		["51"] = 44,
		["52"] = 44,
		["53"] = 43,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 43,
		["58"] = 43,
		["59"] = 42,
		["60"] = 49,
		["61"] = 50,
		["62"] = 51,
		["63"] = 51,
		["64"] = 51,
		["65"] = 51,
		["66"] = 51,
		["67"] = 51,
		["68"] = 49,
		["69"] = 54,
		["70"] = 55,
		["72"] = 55,
		["74"] = 55,
		["75"] = 56,
		["77"] = 54,
		["78"] = 60,
		["79"] = 61,
		["80"] = 62,
		["81"] = 63,
		["82"] = 64,
		["84"] = 60,
		["85"] = 68,
		["86"] = 69,
		["89"] = 70,
		["90"] = 71,
		["91"] = 72,
		["92"] = 73,
		["93"] = 74,
		["94"] = 74,
		["97"] = 68,
		["98"] = 20,
		["99"] = 13,
		["100"] = 13,
		["101"] = 13,
		["102"] = 13,
		["103"] = 13,
		["104"] = 13,
		["105"] = 13,
		["106"] = 20,
		["108"] = 20,
		["110"] = 80,
		["111"] = 88,
		["112"] = 80,
		["113"] = 88,
		["114"] = 92,
		["115"] = 93,
		["116"] = 94,
		["117"] = 92,
		["118"] = 97,
		["119"] = 98,
		["120"] = 99,
		["121"] = 99,
		["122"] = 98,
		["123"] = 97,
		["124"] = 103,
		["125"] = 104,
		["126"] = 104,
		["129"] = 105,
		["130"] = 105,
		["131"] = 106,
		["134"] = 107,
		["135"] = 103,
		["136"] = 88,
		["137"] = 80,
		["138"] = 80,
		["139"] = 80,
		["140"] = 80,
		["141"] = 80,
		["142"] = 80,
		["143"] = 80,
		["144"] = 80,
		["145"] = 88,
		["147"] = 88,
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
	if self.targetProgress > 0 and self:GetStackCount() >= self.targetProgress then
		self.rewarded = true
		local u = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if u ~= nil then
			u:addItemForPlayer(self.equipmentName)
		end
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
local v = g.modifier_trait_200_battle
v.name = "modifier_trait_200_battle"
d(v, l)
function v.prototype.GetAbilitySpecialValue(self)
	self.attackCount = self:GetAbilitySpecialValueFor("attack_count")
	self.attackProgress = self:GetAbilitySpecialValueFor("attack_progress")
end
function v.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function v.prototype.OnCustomAbilityFullyCast(self, p)
	local w = p.ability
	if (w and w:GetAbilityName()) ~= "monkey_king_ult" then
		return
	end
	local x = self:GetCaster()
	local y = x and x:FindModifierByName("modifier_trait_200")
	if not IsValid(y) then
		return
	end
	y:OnMonkeyKingUlt(self.attackCount, self.attackProgress)
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
				RemoveOnDeath = false,
			}
		),
	},
	v
)
g.modifier_trait_200_battle = v
return g