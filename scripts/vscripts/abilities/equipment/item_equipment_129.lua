--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_129"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 28,
		["36"] = 28,
		["37"] = 30,
		["38"] = 30,
		["39"] = 30,
		["40"] = 28,
		["41"] = 28,
		["42"] = 27,
		["43"] = 33,
		["44"] = 34,
		["47"] = 37,
		["48"] = 33,
		["49"] = 39,
		["50"] = 40,
		["53"] = 43,
		["54"] = 44,
		["55"] = 45,
		["56"] = 46,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 47,
		["62"] = 47,
		["63"] = 47,
		["64"] = 47,
		["65"] = 47,
		["66"] = 48,
		["67"] = 49,
		["68"] = 49,
		["69"] = 49,
		["70"] = 49,
		["71"] = 50,
		["72"] = 50,
		["73"] = 50,
		["74"] = 50,
		["75"] = 51,
		["76"] = 51,
		["77"] = 51,
		["78"] = 51,
		["79"] = 52,
		["80"] = 55,
		["82"] = 39,
		["83"] = 20,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 11,
		["89"] = 11,
		["90"] = 11,
		["91"] = 11,
		["92"] = 11,
		["93"] = 20,
		["95"] = 20,
		["96"] = 60,
		["97"] = 67,
		["98"] = 60,
		["99"] = 67,
		["100"] = 72,
		["101"] = 73,
		["102"] = 74,
		["103"] = 75,
		["104"] = 76,
		["105"] = 72,
		["106"] = 78,
		["107"] = 79,
		["108"] = 80,
		["109"] = 81,
		["111"] = 78,
		["112"] = 84,
		["113"] = 85,
		["114"] = 86,
		["117"] = 89,
		["118"] = 90,
		["119"] = 91,
		["120"] = 92,
		["121"] = 92,
		["122"] = 92,
		["123"] = 92,
		["124"] = 92,
		["125"] = 92,
		["127"] = 84,
		["128"] = 67,
		["129"] = 60,
		["130"] = 60,
		["131"] = 60,
		["132"] = 60,
		["133"] = 60,
		["134"] = 60,
		["135"] = 60,
		["136"] = 67,
		["138"] = 67,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_129 = c()
local n = g.item_equipment_129
n.name = "item_equipment_129"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_129"
end
n = e({ j(nil) }, n)
g.item_equipment_129 = n
g.modifier_item_equipment_129 = c()
local o = g.modifier_item_equipment_129
o.name = "modifier_item_equipment_129"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function o.prototype.OnBattleStartBefore(self, p)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end
function o.prototype.OnCustomTakeDamage(self, q)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	local s = self:GetAbility()
	if self:GetStackCount() > 0 and r:GetHealthPercent() <= self.threshold then
		local t = ParticleManager:CreateParticle("particles/items5_fx/magic_lamp.vpcf", PATTACH_CUSTOMORIGIN, r)
		ParticleManager:SetParticleControlEnt(t, 0, r, PATTACH_POINT_FOLLOW, "attach_hitloc", r:GetAbsOrigin(), true)
		r:EmitSound("DOTA_Item.MagicLamp.Cast")
		ReduceIce(r, GetIce(r))
		ReducePoison(r, GetPoison(r))
		ReduceInjury(r, GetInjury(r))
		r:AddNewModifier(r, s, "modifier_item_equipment_129_buff", { duration = self.duration })
		self:DecrementStackCount()
	end
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
g.modifier_item_equipment_129 = o
g.modifier_item_equipment_129_buff = c()
local u = g.modifier_item_equipment_129_buff
u.name = "modifier_item_equipment_129_buff"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.tick = self:GetAbilitySpecialValueFor("tick")
	self.regen = self:GetAbilitySpecialValueFor("regen")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.count = Round(self.duration / self.tick)
end
function u.prototype.OnCreated(self, p)
	if IsServer() then
		self:OnIntervalThink()
		self:StartIntervalThink(self.tick)
	end
end
function u.prototype.OnIntervalThink(self)
	if IsServer() then
		if self.count <= 0 then
			return
		end
		self.count = self.count - 1
		local r = self:GetParent()
		local s = self:GetAbility()
		Heal(r, self.regen, s:GetAbilityName(), "Ability")
	end
end
u = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	u
)
g.modifier_item_equipment_129_buff = u
return g