--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_15"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 25,
		["34"] = 26,
		["35"] = 25,
		["36"] = 30,
		["37"] = 31,
		["38"] = 31,
		["39"] = 31,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 30,
		["44"] = 20,
		["45"] = 11,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 11,
		["54"] = 20,
		["56"] = 20,
		["57"] = 36,
		["58"] = 45,
		["59"] = 36,
		["60"] = 45,
		["61"] = 47,
		["62"] = 48,
		["63"] = 47,
		["64"] = 50,
		["65"] = 51,
		["66"] = 52,
		["67"] = 52,
		["68"] = 51,
		["69"] = 50,
		["70"] = 55,
		["71"] = 56,
		["72"] = 57,
		["73"] = 58,
		["74"] = 59,
		["75"] = 60,
		["76"] = 60,
		["77"] = 60,
		["78"] = 60,
		["79"] = 60,
		["80"] = 60,
		["81"] = 61,
		["82"] = 62,
		["83"] = 62,
		["84"] = 62,
		["85"] = 62,
		["86"] = 62,
		["87"] = 62,
		["88"] = 62,
		["89"] = 62,
		["90"] = 62,
		["91"] = 63,
		["92"] = 64,
		["95"] = 55,
		["96"] = 68,
		["97"] = 69,
		["98"] = 70,
		["99"] = 70,
		["100"] = 70,
		["101"] = 70,
		["102"] = 70,
		["103"] = 70,
		["104"] = 70,
		["105"] = 70,
		["106"] = 70,
		["107"] = 70,
		["108"] = 70,
		["109"] = 70,
		["111"] = 68,
		["112"] = 45,
		["113"] = 36,
		["114"] = 36,
		["115"] = 36,
		["116"] = 36,
		["117"] = 36,
		["118"] = 36,
		["119"] = 36,
		["120"] = 36,
		["121"] = 36,
		["122"] = 45,
		["124"] = 45,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_15 = c()
local n = g.item_equipment_15
n.name = "item_equipment_15"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_15"
end
n = e({ j(nil) }, n)
g.item_equipment_15 = n
g.modifier_item_equipment_15 = c()
local o = g.modifier_item_equipment_15
o.name = "modifier_item_equipment_15"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function o.prototype.OnBattleStart(self)
	self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_item_equipment_15_buff",
		{ duration = self.duration }
	)
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
g.modifier_item_equipment_15 = o
g.modifier_item_equipment_15_buff = c()
local p = g.modifier_item_equipment_15_buff
p.name = "modifier_item_equipment_15_buff"
d(p, l)
function p.prototype.GetAbilitySpecialValue(self)
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_LOSS] = { self:GetParent(), -1 } }
end
function p.prototype.OnShieldLoss(self, q)
	if q.iCount then
		local r = self:GetParent()
		local s = r:GetEnemy()
		if IsInjurable(s, r) then
			r:DealDamage(s, self:GetAbility(), q.iCount * self.damage_pct * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
			local t = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_templar_assassin/templar_assassin_psi_blade.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				r
			)
			ParticleManager:SetParticleControlEnt(t, 1, s, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_invalid, false)
			ParticleManager:ReleaseParticleIndex(t)
			EmitSoundOn("Hero_TemplarAssassin.PsiBlade", s)
		end
	end
end
function p.prototype.OnCreated(self, q)
	if IsClient() then
		self:AddParticle(
			ParticleManager:CreateParticle(
				"particles/items5_fx/force_field.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				self:GetParent()
			),
			false,
			false,
			0,
			false,
			false
		)
	end
end
p = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	p
)
g.modifier_item_equipment_15_buff = p
return g