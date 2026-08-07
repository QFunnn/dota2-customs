--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_ability_roshan"
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
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 24,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 30,
		["44"] = 32,
		["45"] = 32,
		["46"] = 32,
		["47"] = 30,
		["48"] = 30,
		["49"] = 29,
		["50"] = 35,
		["51"] = 36,
		["52"] = 37,
		["54"] = 35,
		["55"] = 40,
		["56"] = 41,
		["57"] = 42,
		["58"] = 43,
		["59"] = 44,
		["60"] = 44,
		["61"] = 44,
		["62"] = 44,
		["63"] = 44,
		["64"] = 44,
		["65"] = 44,
		["66"] = 44,
		["67"] = 44,
		["68"] = 53,
		["69"] = 54,
		["71"] = 40,
		["72"] = 57,
		["73"] = 58,
		["74"] = 57,
		["75"] = 20,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 12,
		["84"] = 20,
		["86"] = 20,
		["87"] = 65,
		["88"] = 66,
		["89"] = 65,
		["90"] = 66,
		["91"] = 67,
		["92"] = 68,
		["93"] = 69,
		["94"] = 70,
		["97"] = 73,
		["98"] = 74,
		["99"] = 75,
		["100"] = 76,
		["101"] = 77,
		["102"] = 78,
		["104"] = 80,
		["105"] = 81,
		["106"] = 82,
		["107"] = 83,
		["108"] = 83,
		["109"] = 83,
		["110"] = 84,
		["113"] = 87,
		["114"] = 88,
		["115"] = 88,
		["116"] = 88,
		["117"] = 88,
		["118"] = 88,
		["119"] = 89,
		["120"] = 89,
		["121"] = 89,
		["122"] = 89,
		["123"] = 89,
		["124"] = 90,
		["125"] = 91,
		["126"] = 92,
		["127"] = 92,
		["128"] = 92,
		["129"] = 92,
		["130"] = 92,
		["131"] = 92,
		["132"] = 92,
		["133"] = 92,
		["134"] = 92,
		["135"] = 101,
		["136"] = 83,
		["137"] = 83,
		["138"] = 67,
		["139"] = 107,
		["140"] = 108,
		["141"] = 107,
		["142"] = 66,
		["143"] = 65,
		["144"] = 66,
		["146"] = 66,
		["147"] = 112,
		["148"] = 120,
		["149"] = 112,
		["150"] = 120,
		["151"] = 120,
		["152"] = 112,
		["153"] = 112,
		["154"] = 112,
		["155"] = 112,
		["156"] = 112,
		["157"] = 112,
		["158"] = 112,
		["159"] = 112,
		["160"] = 120,
		["162"] = 120,
		["163"] = 122,
		["164"] = 130,
		["165"] = 122,
		["166"] = 130,
		["167"] = 133,
		["168"] = 134,
		["169"] = 135,
		["170"] = 133,
		["171"] = 137,
		["172"] = 138,
		["173"] = 139,
		["175"] = 137,
		["176"] = 142,
		["177"] = 143,
		["178"] = 144,
		["180"] = 142,
		["181"] = 147,
		["182"] = 148,
		["183"] = 147,
		["184"] = 130,
		["185"] = 122,
		["186"] = 122,
		["187"] = 122,
		["188"] = 122,
		["189"] = 122,
		["190"] = 122,
		["191"] = 122,
		["192"] = 122,
		["193"] = 130,
		["195"] = 130,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.neutral_talent_roshan = c()
local q = g.neutral_talent_roshan
q.name = "neutral_talent_roshan"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_talent_roshan"
end
q = e({ j(nil) }, q)
g.neutral_talent_roshan = q
g.modifier_neutral_talent_roshan = c()
local r = g.modifier_neutral_talent_roshan
r.name = "modifier_neutral_talent_roshan"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnAttackStart(self, s)
	if IsServer() then
		self:GetParent():EmitSound("Roshan.Grunt")
	end
end
function r.prototype.OnCustomAttackLanded(self, s)
	if self:PRD(self.chance) then
		local t = self:GetParent()
		local u = self:GetAbility()
		DamageSystem:dealDamage({
			attacker = t,
			target = s.target,
			ability = u,
			damage = self.damage,
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		})
		AddStun(t, s.target, u, self.duration)
		t:EmitSound("Roshan.Bash")
	end
end
function r.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE] = -15,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = -15,
	}
end
r = e(
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
			}
		),
	},
	r
)
g.modifier_neutral_talent_roshan = r
g.neutral_ult_roshan = c()
local v = g.neutral_ult_roshan
v.name = "neutral_ult_roshan"
d(v, o)
function v.prototype.OnSpellStart(self)
	local w = self:GetCaster()
	local x = w:GetEnemy()
	if not IsInjurable(w, x) then
		return
	end
	local y = 0
	local z = self:GetSpecialValueFor("bonus_pct")
	local A = w:FindModifierByNameAndCaster("modifier_neutral_ult_roshan", w)
	if IsValid(A) then
		y = A:GetStackCount()
		A:IncrementStackCount()
	end
	local B = self:GetSpecialValueFor("duration")
	local C = self:GetSpecialValueFor("damage")
	w:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	self:GameTimer(0.5, function()
		if not IsInjurable(w, x) then
			return
		end
		local D = ParticleManager:CreateParticle("particles/neutral_fx/roshan_slam.vpcf", PATTACH_CUSTOMORIGIN, w)
		ParticleManager:SetParticleControl(D, 0, w:GetAbsOrigin() + w:GetForwardVector() * 72)
		ParticleManager:SetParticleControl(D, 1, Vector(300, 300, 300))
		ParticleManager:ReleaseParticleIndex(D)
		w:EmitSound("Roshan.Slam")
		DamageSystem:dealDamage({
			attacker = w,
			target = x,
			ability = self,
			damage = C * (1 + y * z * 0.01),
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		})
		x:AddNewModifier(w, self, "modifier_neutral_ult_roshan_buff", { duration = B, iStackCounts = y })
	end)
end
function v.prototype.GetIntrinsicModifierName(self)
	return "modifier_neutral_ult_roshan"
end
v = e({ p(nil) }, v)
g.neutral_ult_roshan = v
g.modifier_neutral_ult_roshan = c()
local E = g.modifier_neutral_ult_roshan
E.name = "modifier_neutral_ult_roshan"
d(E, l)
E = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	E
)
g.modifier_neutral_ult_roshan = E
g.modifier_neutral_ult_roshan_buff = c()
local F = g.modifier_neutral_ult_roshan_buff
F.name = "modifier_neutral_ult_roshan_buff"
d(F, l)
function F.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_reduce = self:GetAbilitySpecialValueFor("attackspeed_reduce")
	self.bonus_pct = self:GetAbilitySpecialValueFor("bonus_pct")
end
function F.prototype.OnCreated(self, G)
	if IsServer() then
		self:SetStackCount(G and G.iStackCounts or 0)
	end
end
function F.prototype.OnRefresh(self, G)
	if IsServer() then
		self:SetStackCount(G and G.iStackCounts or 0)
	end
end
function F.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed_reduce
			* (1 + self:GetStackCount() * self.bonus_pct * 0.01)
			* -1,
	}
end
F = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	F
)
g.modifier_neutral_ult_roshan_buff = F
return g