--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_135"
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
		["32"] = 21,
		["33"] = 27,
		["34"] = 12,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 32,
		["40"] = 33,
		["41"] = 28,
		["42"] = 35,
		["43"] = 36,
		["44"] = 37,
		["45"] = 37,
		["46"] = 37,
		["47"] = 37,
		["48"] = 37,
		["49"] = 38,
		["50"] = 38,
		["51"] = 38,
		["52"] = 38,
		["53"] = 38,
		["54"] = 39,
		["55"] = 39,
		["56"] = 39,
		["57"] = 40,
		["58"] = 41,
		["59"] = 39,
		["60"] = 39,
		["62"] = 35,
		["63"] = 45,
		["64"] = 46,
		["65"] = 47,
		["66"] = 45,
		["67"] = 49,
		["68"] = 50,
		["69"] = 51,
		["70"] = 51,
		["71"] = 51,
		["72"] = 50,
		["73"] = 50,
		["74"] = 53,
		["75"] = 53,
		["76"] = 53,
		["77"] = 50,
		["78"] = 50,
		["79"] = 49,
		["80"] = 56,
		["81"] = 57,
		["84"] = 60,
		["85"] = 61,
		["87"] = 56,
		["88"] = 64,
		["89"] = 65,
		["90"] = 66,
		["91"] = 67,
		["92"] = 67,
		["93"] = 67,
		["94"] = 67,
		["95"] = 67,
		["96"] = 64,
		["97"] = 69,
		["98"] = 70,
		["99"] = 69,
		["100"] = 72,
		["101"] = 73,
		["102"] = 72,
		["103"] = 21,
		["104"] = 12,
		["105"] = 12,
		["106"] = 12,
		["107"] = 12,
		["108"] = 12,
		["109"] = 12,
		["110"] = 12,
		["111"] = 12,
		["112"] = 12,
		["113"] = 21,
		["115"] = 21,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_135 = c()
local n = g.item_equipment_135
n.name = "item_equipment_135"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_135"
end
n = e({ j(nil) }, n)
g.item_equipment_135 = n
g.modifier_item_equipment_135 = c()
local o = g.modifier_item_equipment_135
o.name = "modifier_item_equipment_135"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.enable = true
end
function o.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.mana_loss = self:GetAbilitySpecialValueFor("mana_loss")
	self.tick = self:GetAbilitySpecialValueFor("tick")
	self.purge_pct = self:GetAbilitySpecialValueFor("purge_pct")
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
end
function o.prototype.OnIntervalThink(self)
	if IsServer() then
		ReduceDebuff(self:GetParent(), nil, self.purge_pct)
		local p = ParticleManager:CreateParticle(
			"particles/items_fx/disperser_buff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		GameTimer(0.1, function()
			ParticleManager:DestroyParticle(p, false)
			ParticleManager:ReleaseParticleIndex(p)
		end)
	end
end
function o.prototype.OnThink(self, q)
	self.enable = true
	self:StartThink(-1)
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function o.prototype.OnCustomAttackLanded(self, r)
	if not self.enable then
		return
	end
	if self:PRD(self.chance) then
		self:EquipmentEffect(r.target)
	end
end
function o.prototype.EquipmentEffect(self, s)
	self.enable = false
	self:StartThink(self.cooldown)
	ReduceMana(s, self.mana_loss, self:GetAbility())
end
function o.prototype.OnBattleStart(self)
	self:StartIntervalThink(self.tick)
end
function o.prototype.OnBattleEnd(self, t)
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
g.modifier_item_equipment_135 = o
return g