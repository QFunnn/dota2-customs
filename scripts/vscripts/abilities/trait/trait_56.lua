--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_56"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 25,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 28,
		["38"] = 28,
		["39"] = 28,
		["40"] = 28,
		["41"] = 28,
		["42"] = 28,
		["44"] = 25,
		["45"] = 39,
		["46"] = 40,
		["47"] = 41,
		["48"] = 42,
		["49"] = 42,
		["50"] = 42,
		["51"] = 42,
		["52"] = 42,
		["53"] = 42,
		["54"] = 42,
		["56"] = 39,
		["57"] = 53,
		["58"] = 54,
		["59"] = 55,
		["60"] = 55,
		["61"] = 54,
		["62"] = 53,
		["63"] = 58,
		["64"] = 59,
		["65"] = 60,
		["66"] = 60,
		["67"] = 60,
		["68"] = 60,
		["69"] = 60,
		["70"] = 60,
		["71"] = 58,
		["72"] = 19,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 19,
		["82"] = 19,
		["83"] = 65,
		["84"] = 72,
		["85"] = 65,
		["86"] = 72,
		["88"] = 72,
		["89"] = 74,
		["90"] = 65,
		["91"] = 75,
		["92"] = 76,
		["93"] = 75,
		["94"] = 78,
		["95"] = 79,
		["96"] = 79,
		["97"] = 81,
		["98"] = 81,
		["99"] = 81,
		["100"] = 79,
		["101"] = 79,
		["102"] = 78,
		["103"] = 84,
		["104"] = 85,
		["105"] = 84,
		["106"] = 87,
		["107"] = 88,
		["108"] = 89,
		["109"] = 90,
		["110"] = 91,
		["111"] = 92,
		["112"] = 93,
		["113"] = 94,
		["114"] = 95,
		["115"] = 96,
		["116"] = 97,
		["117"] = 97,
		["118"] = 97,
		["119"] = 97,
		["120"] = 97,
		["121"] = 98,
		["122"] = 99,
		["123"] = 100,
		["124"] = 101,
		["127"] = 87,
		["128"] = 72,
		["129"] = 65,
		["130"] = 65,
		["131"] = 65,
		["132"] = 65,
		["133"] = 65,
		["134"] = 65,
		["135"] = 65,
		["136"] = 72,
		["138"] = 72,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_56 = c()
local n = g.trait_56
n.name = "trait_56"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_56"
end
n = e({ j(nil) }, n)
g.trait_56 = n
g.modifier_trait_56 = c()
local o = g.modifier_trait_56
o.name = "modifier_trait_56"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.hp_percent = self:GetAbilitySpecialValueFor("hp_percent")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		AbilityUpgrades:AddAbilityMechanicsUpgrade(
			q,
			{
				ability_name = "sect_wisp",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "trait_56",
				values = { trait_56 = self.hp_percent },
				description = "trait_56",
			}
		)
	end
end
function o.prototype.OnRemoved(self, r)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		AbilityUpgrades:RemoveAbilityMechanicsUpgrade(
			q,
			{
				ability_name = "sect_wisp",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "trait_56",
				values = { trait_56 = self.hp_percent },
				description = "trait_56",
			}
		)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_56_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_56_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_56 = o
g.modifier_trait_56_buff = c()
local s = g.modifier_trait_56_buff
s.name = "modifier_trait_56_buff"
d(s, l)
function s.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.enable = true
end
function s.prototype.GetAbilitySpecialValue(self)
	self.hp_percent = self:GetAbilitySpecialValueFor("hp_percent")
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { -1, self:GetParent() },
	}
end
function s.prototype.OnBattleStartBefore(self, p)
	self.enable = true
end
function s.prototype.OnWispDie(self, p)
	print("OnWispDie000", p.remove, self.enable)
	if not p.remove and self.enable and IsValid(p.wisp) then
		print("OnWispDie111", p.remove, self.enable)
		local t = self:GetParent()
		local u = p.wisp:GetMaxHealth() * self.hp_percent * 0.01
		local v = SummonWisp(t, u)
		if IsValid(v) then
			local w = v:GetAbsOrigin()
			local x = ParticleManager:CreateParticle(
				"particles/econ/items/wisp/wisp_relocate_teleport_ti7.vpcf",
				PATTACH_CUSTOMORIGIN,
				v,
				t
			)
			ParticleManager:SetParticleControl(x, 0, w + Vector(0, 0, 32))
			ParticleManager:SetParticleControl(x, 1, w)
			ParticleManager:ReleaseParticleIndex(x)
			v:EmitSound("Hero_Wisp.TeleportOut")
			self.enable = false
		end
	end
end
s = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	s
)
g.modifier_trait_56_buff = s
return g