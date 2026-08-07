--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100044"
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
		["11"] = 4,
		["12"] = 12,
		["13"] = 4,
		["14"] = 12,
		["16"] = 12,
		["17"] = 14,
		["18"] = 4,
		["19"] = 15,
		["20"] = 16,
		["21"] = 16,
		["22"] = 16,
		["23"] = 16,
		["24"] = 16,
		["25"] = 17,
		["26"] = 17,
		["27"] = 17,
		["28"] = 17,
		["29"] = 17,
		["30"] = 18,
		["31"] = 18,
		["32"] = 18,
		["33"] = 18,
		["34"] = 18,
		["35"] = 19,
		["36"] = 19,
		["37"] = 19,
		["38"] = 19,
		["39"] = 19,
		["40"] = 20,
		["41"] = 20,
		["42"] = 20,
		["43"] = 20,
		["44"] = 20,
		["45"] = 21,
		["46"] = 21,
		["47"] = 21,
		["48"] = 21,
		["49"] = 21,
		["50"] = 15,
		["51"] = 23,
		["52"] = 24,
		["53"] = 23,
		["54"] = 29,
		["55"] = 30,
		["56"] = 29,
		["57"] = 34,
		["58"] = 35,
		["59"] = 34,
		["60"] = 37,
		["61"] = 38,
		["62"] = 39,
		["63"] = 40,
		["64"] = 40,
		["65"] = 40,
		["66"] = 41,
		["67"] = 42,
		["68"] = 43,
		["70"] = 40,
		["71"] = 40,
		["73"] = 37,
		["74"] = 48,
		["75"] = 49,
		["76"] = 48,
		["77"] = 51,
		["78"] = 52,
		["79"] = 53,
		["80"] = 54,
		["81"] = 55,
		["82"] = 55,
		["83"] = 55,
		["84"] = 55,
		["85"] = 55,
		["86"] = 55,
		["89"] = 58,
		["90"] = 51,
		["91"] = 12,
		["92"] = 4,
		["93"] = 4,
		["94"] = 4,
		["95"] = 4,
		["96"] = 4,
		["97"] = 4,
		["98"] = 4,
		["99"] = 4,
		["100"] = 12,
		["102"] = 12,
		["103"] = 63,
		["104"] = 72,
		["105"] = 63,
		["106"] = 72,
		["108"] = 72,
		["109"] = 73,
		["110"] = 63,
		["111"] = 74,
		["112"] = 75,
		["113"] = 76,
		["115"] = 74,
		["116"] = 79,
		["117"] = 80,
		["118"] = 81,
		["119"] = 79,
		["120"] = 83,
		["121"] = 84,
		["122"] = 85,
		["123"] = 86,
		["124"] = 87,
		["125"] = 88,
		["128"] = 91,
		["131"] = 83,
		["132"] = 95,
		["133"] = 96,
		["134"] = 95,
		["135"] = 100,
		["136"] = 101,
		["137"] = 100,
		["138"] = 103,
		["139"] = 104,
		["140"] = 103,
		["141"] = 108,
		["142"] = 109,
		["143"] = 110,
		["144"] = 112,
		["145"] = 113,
		["146"] = 114,
		["147"] = 115,
		["149"] = 117,
		["151"] = 108,
		["152"] = 120,
		["153"] = 121,
		["154"] = 122,
		["155"] = 123,
		["156"] = 124,
		["157"] = 125,
		["160"] = 120,
		["161"] = 72,
		["162"] = 63,
		["163"] = 63,
		["164"] = 63,
		["165"] = 63,
		["166"] = 63,
		["167"] = 63,
		["168"] = 63,
		["169"] = 63,
		["170"] = 63,
		["171"] = 72,
		["173"] = 72,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100044 = c()
local k = g.modifier_5100044
k.name = "modifier_5100044"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.state = false
end
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_muerta/muerta_base_attack.vpcf",
		"models/eom/hero/muerta_2/particles/muerta_3_base_attack.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_muerta/muerta_base_attack_alt.vpcf",
		"models/eom/hero/muerta_2/particles/muerta_3_base_attack_alt.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_muerta/muerta_ultimate_projectile.vpcf",
		"models/eom/hero/muerta_2/particles/muerta_3_muerta_ultimate_projectile.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_muerta/muerta_ultimate_projectile_alternate.vpcf",
		"models/eom/hero/muerta_2/particles/muerta_3_ultimate_projectile_alternate.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_muerta/muerta_ultimate_form_ethereal.vpcf",
		"models/eom/hero/muerta_2/particles/muerta_2_ultimate_form_fx.vpcf"
	)
	Wearable:registerUnitModelModifier(
		self:GetParent(),
		"models/heroes/muerta/muerta_ult.vmdl",
		"models/eom/hero/muerta_2/muerta_3.vmdl"
	)
end
function k.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = { -1, -1 },
	}
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end
function k.prototype.GetModifierModelScale(self)
	return 15
end
function k.prototype.OnPrepare(self, l)
	if RollPercentage(50) then
		self.state = true
		GameTimer(RandomInt(6, 10), function()
			if IsValid(self) and self.state then
				self:GetParent():StartGesture(ACT_DOTA_TRANSITION)
				self:StartIntervalThink(1.2)
			end
		end)
	end
end
function k.prototype.OnConfirmBattle(self, l)
	self.state = false
end
function k.prototype.OnIntervalThink(self)
	if IsServer() then
		if self.state then
			self:GetParent():EmitSound("Hero_PhantomLancer.SpiritLance.Impact")
			self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_5100044_trans", {})
		end
	end
	self:StartIntervalThink(-1)
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_5100044 = k
g.modifier_5100044_trans = c()
local m = g.modifier_5100044_trans
m.name = "modifier_5100044_trans"
d(m, i)
function m.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.back = false
end
function m.prototype.OnCreated(self, l)
	if IsServer() then
		self:StartThink(RandomInt(8, 15))
	end
end
function m.prototype.OnThink(self, n)
	self:StartThink(-1)
	self:TransBack()
end
function m.prototype.OnIntervalThink(self)
	self:StartIntervalThink(-1)
	if IsServer() then
		if self.back then
			self:GetParent():EmitSound("Hero_PhantomLancer.SpiritLance.Impact")
			self:Destroy()
			return
		else
			self:TransBack()
		end
	end
end
function m.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function m.prototype.GetModifierModelChange(self)
	return "models/eom/hero/muerta_2/muerta_2.vmdl"
end
function m.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = { -1, -1 } }
end
function m.prototype.OnConfirmBattle(self, l)
	local o = GameState:getStateStartEndGameTime()
	local p = o[2]
	local q = 1
	local r = p - GameRules:GetGameTime()
	if r > q then
		self:StartIntervalThink(r - q)
	else
		self:TransBack()
	end
end
function m.prototype.TransBack(self)
	if IsServer() then
		if not self.back then
			self.back = true
			self:GetParent():StartGesture(ACT_DOTA_TRANSITION)
			self:StartIntervalThink(1.2)
		end
	end
end
m = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	m
)
g.modifier_5100044_trans = m
return g