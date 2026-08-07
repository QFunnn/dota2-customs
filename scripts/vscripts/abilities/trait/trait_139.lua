--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_139"
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
		["30"] = 21,
		["31"] = 22,
		["32"] = 23,
		["33"] = 23,
		["34"] = 22,
		["35"] = 21,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["39"] = 28,
		["40"] = 28,
		["41"] = 28,
		["42"] = 28,
		["43"] = 28,
		["44"] = 26,
		["45"] = 19,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 19,
		["55"] = 19,
		["56"] = 32,
		["57"] = 40,
		["58"] = 32,
		["59"] = 40,
		["60"] = 50,
		["61"] = 51,
		["62"] = 52,
		["63"] = 53,
		["64"] = 54,
		["65"] = 55,
		["66"] = 50,
		["67"] = 57,
		["68"] = 58,
		["69"] = 59,
		["70"] = 60,
		["71"] = 61,
		["73"] = 57,
		["74"] = 65,
		["75"] = 66,
		["76"] = 65,
		["77"] = 70,
		["78"] = 71,
		["79"] = 71,
		["80"] = 73,
		["81"] = 73,
		["82"] = 73,
		["83"] = 71,
		["84"] = 71,
		["85"] = 70,
		["86"] = 76,
		["87"] = 77,
		["88"] = 78,
		["89"] = 76,
		["90"] = 80,
		["91"] = 81,
		["92"] = 82,
		["93"] = 80,
		["94"] = 84,
		["95"] = 85,
		["96"] = 86,
		["97"] = 87,
		["98"] = 88,
		["99"] = 89,
		["100"] = 90,
		["101"] = 91,
		["102"] = 93,
		["103"] = 93,
		["104"] = 93,
		["105"] = 93,
		["106"] = 93,
		["107"] = 93,
		["111"] = 84,
		["112"] = 100,
		["113"] = 101,
		["114"] = 100,
		["115"] = 105,
		["116"] = 106,
		["117"] = 105,
		["118"] = 40,
		["119"] = 32,
		["120"] = 32,
		["121"] = 32,
		["122"] = 32,
		["123"] = 32,
		["124"] = 32,
		["125"] = 32,
		["126"] = 32,
		["127"] = 40,
		["129"] = 40,
		["130"] = 111,
		["131"] = 122,
		["132"] = 111,
		["133"] = 122,
		["134"] = 124,
		["135"] = 125,
		["136"] = 124,
		["137"] = 127,
		["138"] = 128,
		["139"] = 129,
		["140"] = 130,
		["142"] = 132,
		["143"] = 133,
		["144"] = 133,
		["145"] = 133,
		["146"] = 133,
		["147"] = 133,
		["148"] = 134,
		["150"] = 127,
		["151"] = 137,
		["152"] = 138,
		["153"] = 139,
		["154"] = 139,
		["155"] = 138,
		["156"] = 137,
		["157"] = 142,
		["158"] = 143,
		["159"] = 144,
		["160"] = 145,
		["161"] = 145,
		["162"] = 145,
		["163"] = 145,
		["164"] = 145,
		["165"] = 145,
		["167"] = 142,
		["168"] = 122,
		["169"] = 111,
		["170"] = 111,
		["171"] = 111,
		["172"] = 111,
		["173"] = 111,
		["174"] = 111,
		["175"] = 111,
		["176"] = 111,
		["177"] = 111,
		["178"] = 111,
		["179"] = 111,
		["180"] = 122,
		["182"] = 122,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_139 = c()
local n = g.trait_139
n.name = "trait_139"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_139"
end
n = e({ j(nil) }, n)
g.trait_139 = n
g.modifier_trait_139 = c()
local o = g.modifier_trait_139
o.name = "modifier_trait_139"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_139_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_139_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_139 = o
g.modifier_trait_139_buff = c()
local q = g.modifier_trait_139_buff
q.name = "modifier_trait_139_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.gain_reduce = self:GetAbilitySpecialValueFor("gain_reduce")
	self.fury = self:GetAbilitySpecialValueFor("fury")
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
end
function q.prototype.OnCreated(self, p)
	if IsServer() then
		self.enable = true
		self.cacheAS = 0
		self.max = self.threshold / 100
	end
end
function q.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SECT_ORIGINAL_GAIN_PERCENTAGE] = -self.gain_reduce }
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function q.prototype.OnBattleStartBefore(self, p)
	self.enable = true
	self:StartIntervalThink(0.1)
end
function q.prototype.OnBattleEnd(self, p)
	self.enable = false
	self:StartIntervalThink(-1)
end
function q.prototype.OnIntervalThink(self)
	if IsServer() then
		local r = self:GetParent()
		local s = GetFury(self:GetParent())
		self:SetStackCount(math.floor(s / self.fury) * self.attackspeed)
		if self.enable then
			local t = r:GetAttackSpeed(false)
			if t >= self.max then
				r:AddNewModifier(r, self:GetAbility(), "modifier_trait_139_buff_overload", { duration = self.duration })
			end
		end
	end
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function q.prototype.EOM_GetModifierAttackSpeedBonus(self, p)
	return self:GetStackCount()
end
q = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	q
)
g.modifier_trait_139_buff = q
g.modifier_trait_139_buff_overload = c()
local u = g.modifier_trait_139_buff_overload
u.name = "modifier_trait_139_buff_overload"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.fury_pct = self:GetAbilitySpecialValueFor("fury_pct")
end
function u.prototype.OnCreated(self, p)
	local r = self:GetParent()
	if IsServer() then
		r:EmitSound("Hero_Lina.DragonSlave.FireHair")
	else
		local v = ParticleManager:CreateParticle("particles/sect/fury_inner_fire.vpcf", PATTACH_ABSORIGIN, r)
		ParticleManager:SetParticleControl(v, 1, Vector(300, 300, 300))
		ParticleManager:ReleaseParticleIndex(v)
	end
end
function u.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function u.prototype.OnCustomAttackLanded(self, w)
	local s = GetFury(w.attacker)
	if s > 0 then
		w.attacker:DealDamage(
			w.target,
			self:GetAbility(),
			s * self.fury_pct * 0.01,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		)
	end
end
u = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetEffectName = "particles/units/heroes/hero_clinkz/clinkz_death_pact_buff.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
				StatusEffectPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
				GetStatusEffectName = "particles/status_fx/status_effect_beserkers_call.vpcf",
			}
		),
	},
	u
)
g.modifier_trait_139_buff_overload = u
return g