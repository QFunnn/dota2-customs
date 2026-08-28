--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_27"
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
		["31"] = 23,
		["32"] = 24,
		["33"] = 23,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 28,
		["38"] = 28,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 26,
		["43"] = 32,
		["44"] = 33,
		["45"] = 34,
		["46"] = 35,
		["47"] = 36,
		["48"] = 37,
		["49"] = 38,
		["51"] = 32,
		["52"] = 42,
		["53"] = 43,
		["54"] = 42,
		["55"] = 21,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 12,
		["64"] = 12,
		["65"] = 21,
		["67"] = 21,
		["68"] = 48,
		["69"] = 57,
		["70"] = 48,
		["71"] = 57,
		["72"] = 59,
		["73"] = 60,
		["74"] = 59,
		["75"] = 62,
		["76"] = 63,
		["77"] = 64,
		["78"] = 65,
		["79"] = 66,
		["80"] = 66,
		["81"] = 66,
		["82"] = 66,
		["83"] = 66,
		["84"] = 67,
		["85"] = 67,
		["86"] = 67,
		["87"] = 67,
		["88"] = 67,
		["89"] = 68,
		["90"] = 68,
		["91"] = 68,
		["92"] = 68,
		["93"] = 68,
		["94"] = 69,
		["95"] = 69,
		["96"] = 69,
		["97"] = 69,
		["98"] = 69,
		["99"] = 69,
		["100"] = 69,
		["101"] = 69,
		["103"] = 62,
		["104"] = 72,
		["105"] = 73,
		["106"] = 72,
		["107"] = 77,
		["108"] = 78,
		["109"] = 79,
		["110"] = 80,
		["111"] = 81,
		["112"] = 82,
		["114"] = 84,
		["116"] = 77,
		["117"] = 57,
		["118"] = 48,
		["119"] = 48,
		["120"] = 48,
		["121"] = 48,
		["122"] = 48,
		["123"] = 48,
		["124"] = 48,
		["125"] = 48,
		["126"] = 48,
		["127"] = 57,
		["129"] = 57,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_equipment_27 = c()
local n = g.item_equipment_27
n.name = "item_equipment_27"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_27"
end
n = e({ j(nil) }, n)
g.item_equipment_27 = n
g.modifier_item_equipment_27 = c()
local o = g.modifier_item_equipment_27
o.name = "modifier_item_equipment_27"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
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
	if self:GetStackCount() >= 1 and q:GetHealthPercent() <= self.threshold then
		self:SetStackCount(0)
		q:EmitSound("DOTA_Item.Pipe.Activate")
		q:AddNewModifier(q, r, "modifier_item_equipment_27_buff", nil)
	end
end
function o.prototype.OnBattleStart(self)
	self:SetStackCount(1)
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
g.modifier_item_equipment_27 = o
g.modifier_item_equipment_27_buff = c()
local s = g.modifier_item_equipment_27_buff
s.name = "modifier_item_equipment_27_buff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.block = self:GetAbilitySpecialValueFor("block")
end
function s.prototype.OnCreated(self, t)
	if IsClient() then
		local q = self:GetParent()
		local u = ParticleManager:CreateParticle("particles/items2_fx/pipe_of_insight_v2.vpcf", PATTACH_CUSTOMORIGIN, q)
		ParticleManager:SetParticleControl(u, 0, q:GetAbsOrigin())
		ParticleManager:SetParticleControl(u, 1, q:GetAbsOrigin() + Vector(0, 0, 96))
		ParticleManager:SetParticleControl(u, 2, Vector(100, 0, 0))
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function s.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PARRY_DAMAGE }
end
function s.prototype.EOM_GetModifierParryDamage(self, t)
	if t.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		local v = math.min(t.damage, self.block)
		self.block = self.block - v
		if self.block <= 0 then
			self:Destroy()
		end
		return v
	end
end
s = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	s
)
g.modifier_item_equipment_27_buff = s
return g