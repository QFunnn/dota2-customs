--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_26"
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
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 21,
		["29"] = 12,
		["30"] = 21,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["35"] = 30,
		["36"] = 26,
		["37"] = 33,
		["38"] = 34,
		["39"] = 35,
		["40"] = 36,
		["41"] = 36,
		["42"] = 36,
		["44"] = 36,
		["45"] = 37,
		["46"] = 38,
		["48"] = 41,
		["49"] = 42,
		["50"] = 43,
		["51"] = 43,
		["52"] = 43,
		["53"] = 43,
		["55"] = 33,
		["56"] = 46,
		["57"] = 47,
		["58"] = 48,
		["59"] = 48,
		["60"] = 48,
		["61"] = 48,
		["62"] = 48,
		["63"] = 48,
		["64"] = 46,
		["65"] = 50,
		["66"] = 51,
		["67"] = 51,
		["68"] = 53,
		["69"] = 53,
		["70"] = 53,
		["71"] = 51,
		["72"] = 51,
		["73"] = 51,
		["74"] = 50,
		["75"] = 58,
		["76"] = 59,
		["77"] = 60,
		["78"] = 61,
		["79"] = 62,
		["81"] = 64,
		["83"] = 66,
		["84"] = 66,
		["85"] = 66,
		["87"] = 66,
		["88"] = 67,
		["89"] = 68,
		["90"] = 69,
		["91"] = 70,
		["93"] = 73,
		["94"] = 74,
		["95"] = 75,
		["96"] = 75,
		["97"] = 75,
		["98"] = 75,
		["99"] = 76,
		["100"] = 77,
		["101"] = 58,
		["102"] = 79,
		["103"] = 80,
		["104"] = 80,
		["105"] = 80,
		["106"] = 80,
		["107"] = 80,
		["108"] = 80,
		["110"] = 80,
		["111"] = 81,
		["112"] = 82,
		["113"] = 79,
		["114"] = 84,
		["115"] = 85,
		["116"] = 84,
		["117"] = 21,
		["118"] = 12,
		["119"] = 12,
		["120"] = 12,
		["121"] = 12,
		["122"] = 12,
		["123"] = 12,
		["124"] = 12,
		["125"] = 12,
		["126"] = 12,
		["127"] = 21,
		["129"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_26 = c()
local n = g.item_equipment_26
n.name = "item_equipment_26"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_26"
end
n = e({ j(nil) }, n)
g.item_equipment_26 = n
g.modifier_item_equipment_26 = c()
local o = g.modifier_item_equipment_26
o.name = "modifier_item_equipment_26"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
	self.round = self:GetAbilitySpecialValueFor("round")
	self.stack_regen = self:GetAbilitySpecialValueFor("stack_regen")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:loadData(q, "e_26_s")
		if r == nil then
			r = 0
		end
		local s = r
		if s == 0 then
			PlayerData:saveData(q, "e_26_s", 0)
		end
		local t = self:GetAbility()
		t:SetCurrentCharges(s)
		PlayerData:getHero(q):setItemCharge("item_equipment_26", t:GetCurrentCharges())
	end
end
function o.prototype.OnIntervalThink(self)
	local u = self:GetParent()
	Heal(u, self.hp_regen + self:GetStackCount() * self.stack_regen, self:GetAbility():GetAbilityName(), "Ability")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 },
	}
end
function o.prototype.OnRoundStart(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	local v = PlayerData:loadData(q, "e_26_r")
	if v == nil then
		v = 1
	else
		v = v + 1
	end
	local w = PlayerData:loadData(q, "e_26_s")
	if w == nil then
		w = 0
	end
	local s = w
	if v >= self.round then
		v = 0
		s = s + 1
		PlayerData:saveData(q, "e_26_s", s)
	end
	local t = self:GetAbility()
	t:SetCurrentCharges(s)
	PlayerData:getHero(q):setItemCharge("item_equipment_26", t:GetCurrentCharges())
	self:SetStackCount(s)
	PlayerData:saveData(q, "e_26_r", v)
end
function o.prototype.OnBattleStart(self)
	local x = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "e_26_s")
	if x == nil then
		x = 0
	end
	local s = x
	self:SetStackCount(s)
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	o
)
g.modifier_item_equipment_26 = o
return g