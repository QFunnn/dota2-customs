--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_140"
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
		["28"] = 23,
		["29"] = 12,
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 24,
		["34"] = 29,
		["35"] = 30,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["39"] = 33,
		["40"] = 33,
		["41"] = 33,
		["42"] = 33,
		["43"] = 33,
		["45"] = 29,
		["46"] = 23,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 12,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 23,
		["60"] = 23,
		["61"] = 38,
		["62"] = 46,
		["63"] = 38,
		["64"] = 46,
		["65"] = 50,
		["66"] = 51,
		["67"] = 52,
		["68"] = 53,
		["69"] = 50,
		["70"] = 55,
		["71"] = 56,
		["72"] = 57,
		["74"] = 59,
		["75"] = 59,
		["76"] = 59,
		["77"] = 59,
		["78"] = 59,
		["79"] = 60,
		["80"] = 60,
		["81"] = 60,
		["82"] = 60,
		["83"] = 60,
		["84"] = 60,
		["85"] = 60,
		["86"] = 60,
		["87"] = 60,
		["88"] = 61,
		["89"] = 61,
		["90"] = 61,
		["91"] = 61,
		["92"] = 61,
		["93"] = 61,
		["94"] = 61,
		["95"] = 61,
		["97"] = 55,
		["98"] = 64,
		["99"] = 65,
		["100"] = 64,
		["101"] = 69,
		["102"] = 70,
		["103"] = 71,
		["104"] = 71,
		["105"] = 70,
		["106"] = 69,
		["107"] = 74,
		["108"] = 75,
		["109"] = 74,
		["110"] = 77,
		["111"] = 78,
		["112"] = 79,
		["113"] = 80,
		["114"] = 81,
		["115"] = 82,
		["118"] = 85,
		["119"] = 85,
		["120"] = 85,
		["121"] = 85,
		["122"] = 85,
		["123"] = 85,
		["125"] = 77,
		["126"] = 46,
		["127"] = 38,
		["128"] = 38,
		["129"] = 38,
		["130"] = 38,
		["131"] = 38,
		["132"] = 38,
		["133"] = 38,
		["134"] = 38,
		["135"] = 46,
		["137"] = 46,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_140 = c()
local n = g.item_equipment_140
n.name = "item_equipment_140"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_140"
end
n = e({ j(nil) }, n)
g.item_equipment_140 = n
g.modifier_item_equipment_140 = c()
local o = g.modifier_item_equipment_140
o.name = "modifier_item_equipment_140"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self, p)
	local q = self:GetParent()
	local r = q:GetEnemy()
	if IsInjurable(q, r) then
		r:AddNewModifier(q, self:GetAbility(), "modifier_item_equipment_140_debuff", nil)
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
				GetEffectName = "particles/items2_fx/radiance_owner.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	o
)
g.modifier_item_equipment_140 = o
g.modifier_item_equipment_140_debuff = c()
local s = g.modifier_item_equipment_140_debuff
s.name = "modifier_item_equipment_140_debuff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.damage_factor = self:GetAbilitySpecialValueFor("damage_factor")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.tick = self:GetAbilitySpecialValueFor("tick")
end
function s.prototype.OnCreated(self, p)
	if IsServer() then
		self:StartIntervalThink(self.tick)
	else
		local t = ParticleManager:CreateParticle(
			"particles/items2_fx/radiance.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(t, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, false)
		self:AddParticle(t, false, false, -1, false, false)
	end
end
function s.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_MISS] = self.chance }
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function s.prototype.OnBattleEnd(self, p)
	self:Destroy()
end
function s.prototype.OnIntervalThink(self)
	if IsServer() then
		local u = self:GetCaster()
		local q = self:GetParent()
		if not IsInjurable(u, q) then
			self:StartIntervalThink(-1)
			return
		end
		u:DealDamage(q, self:GetAbility(), GetEvasion(u) * self.damage_factor, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	end
end
s = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	s
)
g.modifier_item_equipment_140_debuff = s
return g