--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_1"
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
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 26,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 30,
		["35"] = 31,
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
		["47"] = 39,
		["49"] = 42,
		["50"] = 43,
		["51"] = 44,
		["52"] = 44,
		["53"] = 44,
		["54"] = 44,
		["56"] = 33,
		["57"] = 47,
		["58"] = 48,
		["59"] = 48,
		["60"] = 50,
		["61"] = 50,
		["62"] = 50,
		["63"] = 48,
		["64"] = 48,
		["65"] = 48,
		["66"] = 47,
		["67"] = 54,
		["68"] = 55,
		["69"] = 56,
		["70"] = 57,
		["71"] = 58,
		["73"] = 60,
		["75"] = 62,
		["76"] = 62,
		["77"] = 62,
		["79"] = 62,
		["80"] = 63,
		["81"] = 64,
		["82"] = 65,
		["83"] = 66,
		["85"] = 69,
		["86"] = 70,
		["87"] = 71,
		["88"] = 71,
		["89"] = 71,
		["90"] = 71,
		["91"] = 72,
		["92"] = 73,
		["93"] = 54,
		["94"] = 75,
		["95"] = 76,
		["96"] = 76,
		["97"] = 76,
		["98"] = 76,
		["99"] = 76,
		["100"] = 76,
		["102"] = 76,
		["103"] = 77,
		["104"] = 78,
		["107"] = 79,
		["108"] = 75,
		["109"] = 81,
		["110"] = 82,
		["111"] = 81,
		["112"] = 84,
		["113"] = 85,
		["114"] = 86,
		["115"] = 87,
		["118"] = 88,
		["119"] = 88,
		["120"] = 88,
		["121"] = 88,
		["122"] = 88,
		["123"] = 88,
		["124"] = 89,
		["125"] = 84,
		["126"] = 20,
		["127"] = 11,
		["128"] = 11,
		["129"] = 11,
		["130"] = 11,
		["131"] = 11,
		["132"] = 11,
		["133"] = 11,
		["134"] = 11,
		["135"] = 11,
		["136"] = 20,
		["138"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_1 = c()
local n = g.item_equipment_1
n.name = "item_equipment_1"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_1"
end
n = e({ j(nil) }, n)
g.item_equipment_1 = n
g.modifier_item_equipment_1 = c()
local o = g.modifier_item_equipment_1
o.name = "modifier_item_equipment_1"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
	self.mana_restore = self:GetAbilitySpecialValueFor("mana_restore")
	self.round = self:GetAbilitySpecialValueFor("round")
	self.stack = self:GetAbilitySpecialValueFor("stack")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:loadData(q, "e_1_s")
		if r == nil then
			r = 0
		end
		local s = r
		if s == 0 then
			PlayerData:saveData(q, "e_1_s", 1)
			s = s + 1
		end
		local t = self:GetAbility()
		t:SetCurrentCharges(s)
		PlayerData:getHero(q):setItemCharge("item_equipment_1", t:GetCurrentCharges())
	end
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
	local u = PlayerData:loadData(q, "e_1_r")
	if u == nil then
		u = 1
	else
		u = u + 1
	end
	local v = PlayerData:loadData(q, "e_1_s")
	if v == nil then
		v = 0
	end
	local s = v
	if u >= self.round then
		u = 0
		s = s + 1
		PlayerData:saveData(q, "e_1_s", s)
	end
	local t = self:GetAbility()
	t:SetCurrentCharges(s)
	PlayerData:getHero(q):setItemCharge("item_equipment_1", t:GetCurrentCharges())
	self:SetStackCount(s)
	PlayerData:saveData(q, "e_1_r", u)
end
function o.prototype.OnBattleStart(self)
	local w = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "e_1_s")
	if w == nil then
		w = 0
	end
	local s = w
	self:SetStackCount(s)
	if s <= 0 then
		return
	end
	self:StartIntervalThink(self.interval)
end
function o.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
end
function o.prototype.OnIntervalThink(self)
	local x = self:GetParent()
	local s = self:GetStackCount()
	if s <= 0 then
		return
	end
	Heal(x, self.hp_regen * s, self:GetAbility():GetName(), "Ability")
	Restore(x, self.mana_restore * s)
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
g.modifier_item_equipment_1 = o
return g