--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_58"
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
		["31"] = 30,
		["32"] = 31,
		["33"] = 32,
		["34"] = 33,
		["35"] = 34,
		["36"] = 35,
		["37"] = 36,
		["38"] = 30,
		["39"] = 38,
		["40"] = 39,
		["41"] = 40,
		["42"] = 40,
		["43"] = 40,
		["44"] = 39,
		["45"] = 39,
		["46"] = 39,
		["47"] = 38,
		["48"] = 44,
		["49"] = 45,
		["50"] = 46,
		["51"] = 47,
		["52"] = 47,
		["53"] = 47,
		["54"] = 47,
		["55"] = 49,
		["58"] = 56,
		["59"] = 57,
		["60"] = 58,
		["61"] = 59,
		["62"] = 60,
		["63"] = 60,
		["64"] = 60,
		["65"] = 60,
		["66"] = 60,
		["67"] = 60,
		["68"] = 60,
		["70"] = 72,
		["71"] = 73,
		["72"] = 74,
		["73"] = 75,
		["76"] = 78,
		["77"] = 79,
		["78"] = 80,
		["81"] = 44,
		["82"] = 84,
		["83"] = 85,
		["84"] = 86,
		["85"] = 87,
		["86"] = 84,
		["87"] = 21,
		["88"] = 12,
		["89"] = 12,
		["90"] = 12,
		["91"] = 12,
		["92"] = 12,
		["93"] = 12,
		["94"] = 12,
		["95"] = 12,
		["96"] = 12,
		["97"] = 21,
		["99"] = 21,
		["100"] = 91,
		["101"] = 99,
		["102"] = 91,
		["103"] = 99,
		["104"] = 104,
		["105"] = 105,
		["106"] = 106,
		["107"] = 107,
		["108"] = 108,
		["109"] = 108,
		["110"] = 108,
		["111"] = 108,
		["112"] = 108,
		["113"] = 108,
		["114"] = 108,
		["115"] = 108,
		["117"] = 104,
		["118"] = 99,
		["119"] = 91,
		["120"] = 91,
		["121"] = 91,
		["122"] = 91,
		["123"] = 91,
		["124"] = 91,
		["125"] = 91,
		["126"] = 91,
		["127"] = 99,
		["129"] = 99,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_58 = c()
local n = g.item_equipment_58
n.name = "item_equipment_58"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_58"
end
n = e({ j(nil) }, n)
g.item_equipment_58 = n
g.modifier_item_equipment_58 = c()
local o = g.modifier_item_equipment_58
o.name = "modifier_item_equipment_58"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.health = self:GetAbilitySpecialValueFor("health")
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.record = 0
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function o.prototype.OnCustomTakeDamage(self, p)
	local q = self:GetParent()
	local r = self:GetAbility()
	local s = math.max(0, p.original_health - q:GetHealth())
	if
		s <= 0
		or p.attacker == p.target
		or not IsInjurable(p.attacker, p.target)
		or bit.band(p.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) == DamageFlags.DAMAGE_FLAG_REFLECTION
	then
		return
	end
	self.record = self.record + s
	if self.record >= self.health then
		self.record = self.record - self.health
		local t = q:HasModifier("modifier_item_equipment_58_buff")
		p.target:DealDamage(
			p.attacker,
			self:GetAbility(),
			t and self.damage * (1 + self.damage_pct * 0.01) or self.damage,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
			DamageFlags.DAMAGE_FLAG_REFLECTION + DamageFlags.DAMAGE_FLAG_HPLOSS
		)
	end
	if q:GetHealthPercent() <= self.threshold then
		if not self.active then
			self.active = true
			q:AddNewModifier(q, r, "modifier_item_equipment_58_buff", {})
		end
	else
		if self.active then
			self.active = false
			q:RemoveModifierByName("modifier_item_equipment_58_buff")
		end
	end
end
function o.prototype.OnBattleStart(self)
	self:SetStackCount(1)
	self.record = 0
	self.active = false
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
g.modifier_item_equipment_58 = o
g.modifier_item_equipment_58_buff = c()
local u = g.modifier_item_equipment_58_buff
u.name = "modifier_item_equipment_58_buff"
d(u, l)
function u.prototype.OnCreated(self, v)
	if IsClient() then
		local q = self:GetParent()
		local w = ParticleManager:CreateParticle("particles/items_fx/blademail.vpcf", PATTACH_INVALID, q)
		self:AddParticle(w, false, true, 10, false, false)
	end
end
u = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = true,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	u
)
g.modifier_item_equipment_58_buff = u
return g