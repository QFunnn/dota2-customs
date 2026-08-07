--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/ancient_apparition"
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
		["17"] = 6,
		["18"] = 7,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 8,
		["24"] = 7,
		["25"] = 6,
		["26"] = 7,
		["28"] = 7,
		["29"] = 13,
		["30"] = 21,
		["31"] = 13,
		["32"] = 21,
		["33"] = 28,
		["34"] = 29,
		["35"] = 30,
		["36"] = 31,
		["37"] = 33,
		["38"] = 28,
		["39"] = 35,
		["40"] = 36,
		["41"] = 36,
		["42"] = 36,
		["43"] = 39,
		["44"] = 39,
		["45"] = 39,
		["46"] = 36,
		["47"] = 36,
		["48"] = 35,
		["49"] = 43,
		["50"] = 44,
		["51"] = 45,
		["52"] = 46,
		["53"] = 47,
		["54"] = 50,
		["55"] = 50,
		["56"] = 50,
		["57"] = 50,
		["58"] = 50,
		["59"] = 51,
		["60"] = 51,
		["61"] = 51,
		["62"] = 51,
		["63"] = 51,
		["64"] = 52,
		["65"] = 52,
		["66"] = 52,
		["67"] = 52,
		["68"] = 52,
		["69"] = 53,
		["71"] = 43,
		["72"] = 56,
		["73"] = 57,
		["74"] = 56,
		["75"] = 59,
		["76"] = 60,
		["77"] = 61,
		["78"] = 62,
		["80"] = 64,
		["81"] = 59,
		["82"] = 66,
		["83"] = 67,
		["84"] = 68,
		["87"] = 69,
		["88"] = 70,
		["89"] = 71,
		["92"] = 74,
		["93"] = 75,
		["94"] = 75,
		["95"] = 75,
		["96"] = 75,
		["97"] = 75,
		["98"] = 75,
		["99"] = 75,
		["100"] = 76,
		["101"] = 77,
		["102"] = 78,
		["103"] = 78,
		["104"] = 78,
		["105"] = 78,
		["106"] = 78,
		["107"] = 78,
		["109"] = 66,
		["110"] = 81,
		["111"] = 82,
		["112"] = 83,
		["113"] = 84,
		["114"] = 85,
		["115"] = 85,
		["116"] = 85,
		["117"] = 85,
		["118"] = 85,
		["119"] = 85,
		["121"] = 81,
		["122"] = 21,
		["123"] = 13,
		["124"] = 13,
		["125"] = 13,
		["126"] = 13,
		["127"] = 13,
		["128"] = 13,
		["129"] = 13,
		["130"] = 13,
		["131"] = 21,
		["133"] = 21,
		["134"] = 93,
		["135"] = 94,
		["136"] = 93,
		["137"] = 94,
		["138"] = 97,
		["139"] = 98,
		["140"] = 99,
		["141"] = 101,
		["142"] = 102,
		["143"] = 103,
		["144"] = 104,
		["146"] = 106,
		["147"] = 107,
		["149"] = 109,
		["150"] = 110,
		["151"] = 111,
		["153"] = 113,
		["156"] = 116,
		["157"] = 117,
		["158"] = 118,
		["159"] = 120,
		["160"] = 121,
		["161"] = 122,
		["162"] = 123,
		["163"] = 124,
		["164"] = 125,
		["165"] = 125,
		["166"] = 125,
		["167"] = 125,
		["168"] = 125,
		["169"] = 125,
		["170"] = 125,
		["171"] = 125,
		["172"] = 133,
		["173"] = 134,
		["174"] = 135,
		["175"] = 136,
		["177"] = 125,
		["178"] = 125,
		["180"] = 97,
		["181"] = 156,
		["182"] = 157,
		["183"] = 156,
		["184"] = 94,
		["185"] = 93,
		["186"] = 94,
		["188"] = 94,
		["190"] = 162,
		["191"] = 170,
		["192"] = 162,
		["193"] = 170,
		["194"] = 173,
		["195"] = 174,
		["196"] = 173,
		["197"] = 176,
		["198"] = 178,
		["199"] = 176,
		["200"] = 180,
		["201"] = 181,
		["202"] = 181,
		["203"] = 181,
		["204"] = 184,
		["205"] = 184,
		["206"] = 184,
		["207"] = 181,
		["208"] = 181,
		["209"] = 180,
		["210"] = 187,
		["211"] = 188,
		["212"] = 189,
		["214"] = 187,
		["215"] = 192,
		["216"] = 193,
		["217"] = 194,
		["219"] = 192,
		["220"] = 197,
		["221"] = 198,
		["222"] = 198,
		["223"] = 198,
		["224"] = 198,
		["225"] = 198,
		["226"] = 198,
		["228"] = 198,
		["229"] = 197,
		["230"] = 200,
		["231"] = 201,
		["232"] = 201,
		["233"] = 201,
		["234"] = 201,
		["235"] = 201,
		["236"] = 200,
		["237"] = 203,
		["238"] = 204,
		["241"] = 207,
		["242"] = 208,
		["243"] = 209,
		["244"] = 210,
		["245"] = 211,
		["246"] = 212,
		["249"] = 203,
		["250"] = 170,
		["251"] = 162,
		["252"] = 162,
		["253"] = 162,
		["254"] = 162,
		["255"] = 162,
		["256"] = 162,
		["257"] = 162,
		["258"] = 162,
		["259"] = 170,
		["261"] = 170,
		["262"] = 218,
		["263"] = 227,
		["264"] = 218,
		["265"] = 227,
		["267"] = 227,
		["268"] = 233,
		["269"] = 218,
		["270"] = 234,
		["271"] = 235,
		["272"] = 236,
		["273"] = 237,
		["274"] = 239,
		["275"] = 234,
		["276"] = 241,
		["277"] = 242,
		["278"] = 243,
		["279"] = 244,
		["280"] = 245,
		["281"] = 246,
		["283"] = 248,
		["284"] = 248,
		["285"] = 248,
		["286"] = 248,
		["287"] = 248,
		["288"] = 248,
		["289"] = 249,
		["290"] = 249,
		["291"] = 249,
		["292"] = 249,
		["293"] = 249,
		["294"] = 249,
		["295"] = 249,
		["296"] = 249,
		["298"] = 241,
		["299"] = 252,
		["300"] = 253,
		["301"] = 254,
		["302"] = 255,
		["303"] = 256,
		["305"] = 252,
		["306"] = 259,
		["307"] = 260,
		["309"] = 259,
		["310"] = 263,
		["311"] = 264,
		["312"] = 265,
		["315"] = 268,
		["316"] = 269,
		["317"] = 270,
		["318"] = 271,
		["321"] = 274,
		["322"] = 275,
		["323"] = 276,
		["324"] = 277,
		["325"] = 278,
		["327"] = 280,
		["328"] = 281,
		["329"] = 282,
		["330"] = 283,
		["331"] = 283,
		["332"] = 283,
		["333"] = 283,
		["334"] = 283,
		["335"] = 283,
		["336"] = 283,
		["337"] = 283,
		["338"] = 283,
		["339"] = 292,
		["340"] = 292,
		["341"] = 292,
		["342"] = 292,
		["343"] = 292,
		["344"] = 292,
		["345"] = 293,
		["347"] = 263,
		["348"] = 296,
		["349"] = 297,
		["350"] = 298,
		["351"] = 299,
		["352"] = 300,
		["353"] = 301,
		["356"] = 304,
		["357"] = 305,
		["358"] = 306,
		["359"] = 306,
		["360"] = 306,
		["361"] = 306,
		["362"] = 306,
		["363"] = 306,
		["364"] = 306,
		["365"] = 306,
		["366"] = 306,
		["368"] = 296,
		["369"] = 227,
		["370"] = 218,
		["371"] = 218,
		["372"] = 218,
		["373"] = 218,
		["374"] = 218,
		["375"] = 218,
		["376"] = 218,
		["377"] = 218,
		["378"] = 218,
		["379"] = 227,
		["381"] = 227,
		["383"] = 320,
		["384"] = 328,
		["385"] = 320,
		["386"] = 328,
		["387"] = 332,
		["388"] = 333,
		["389"] = 332,
		["390"] = 335,
		["391"] = 336,
		["392"] = 337,
		["393"] = 338,
		["394"] = 335,
		["395"] = 340,
		["396"] = 341,
		["397"] = 342,
		["399"] = 340,
		["400"] = 345,
		["401"] = 346,
		["402"] = 347,
		["404"] = 345,
		["405"] = 350,
		["406"] = 351,
		["407"] = 352,
		["408"] = 353,
		["409"] = 354,
		["410"] = 355,
		["411"] = 356,
		["412"] = 357,
		["413"] = 358,
		["414"] = 359,
		["415"] = 362,
		["416"] = 363,
		["420"] = 367,
		["421"] = 368,
		["424"] = 350,
		["425"] = 328,
		["426"] = 320,
		["427"] = 320,
		["428"] = 320,
		["429"] = 320,
		["430"] = 320,
		["431"] = 320,
		["432"] = 320,
		["433"] = 320,
		["434"] = 328,
		["436"] = 328,
		["438"] = 375,
		["439"] = 384,
		["440"] = 375,
		["441"] = 384,
		["442"] = 391,
		["443"] = 392,
		["444"] = 393,
		["445"] = 395,
		["446"] = 396,
		["447"] = 391,
		["448"] = 398,
		["449"] = 399,
		["450"] = 400,
		["452"] = 398,
		["453"] = 403,
		["454"] = 404,
		["455"] = 405,
		["457"] = 403,
		["458"] = 408,
		["459"] = 409,
		["460"] = 410,
		["461"] = 410,
		["462"] = 409,
		["463"] = 408,
		["464"] = 413,
		["465"] = 414,
		["466"] = 415,
		["467"] = 416,
		["468"] = 416,
		["469"] = 416,
		["470"] = 416,
		["471"] = 416,
		["472"] = 416,
		["475"] = 413,
		["476"] = 420,
		["477"] = 421,
		["478"] = 420,
		["479"] = 426,
		["480"] = 427,
		["481"] = 428,
		["483"] = 426,
		["484"] = 384,
		["485"] = 375,
		["486"] = 375,
		["487"] = 375,
		["488"] = 375,
		["489"] = 375,
		["490"] = 375,
		["491"] = 375,
		["492"] = 375,
		["493"] = 375,
		["494"] = 384,
		["496"] = 384,
		["498"] = 434,
		["499"] = 442,
		["500"] = 434,
		["501"] = 442,
		["503"] = 442,
		["504"] = 445,
		["505"] = 434,
		["506"] = 446,
		["507"] = 447,
		["508"] = 449,
		["509"] = 446,
		["510"] = 451,
		["511"] = 452,
		["512"] = 453,
		["513"] = 454,
		["514"] = 454,
		["515"] = 454,
		["516"] = 454,
		["517"] = 454,
		["518"] = 454,
		["519"] = 455,
		["521"] = 451,
		["522"] = 458,
		["523"] = 459,
		["524"] = 460,
		["525"] = 460,
		["526"] = 460,
		["527"] = 460,
		["528"] = 460,
		["529"] = 460,
		["530"] = 461,
		["532"] = 458,
		["533"] = 464,
		["534"] = 465,
		["535"] = 464,
		["536"] = 442,
		["537"] = 434,
		["538"] = 434,
		["539"] = 434,
		["540"] = 434,
		["541"] = 434,
		["542"] = 434,
		["543"] = 434,
		["544"] = 434,
		["545"] = 442,
		["547"] = 442,
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
g.ancient_apparition_talent = c()
local q = g.ancient_apparition_talent
q.name = "ancient_apparition_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_ancient_apparition_talent"
end
q = e({ j(nil) }, q)
g.ancient_apparition_talent = q
g.modifier_ancient_apparition_talent = c()
local r = g.modifier_ancient_apparition_talent
r.name = "modifier_ancient_apparition_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("ancient_apparition_talent_5", "interval")
	self.ice_count = self:GetAbilitySpecialValueFor("ice_count")
		+ self:GetAbilityTalentValue("ancient_apparition_talent_2", "ice_stack")
	self.buff_count = self:GetAbilitySpecialValueFor("buff_count")
		+ self:GetAbilityTalentValue("ancient_apparition_talent_2", "dead_ice_bonus_stack")
	self.tl1_ice_damage = self:GetAbilityTalentValue("ancient_apparition_talent_1", "ice_damage")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	local t = self:GetParent()
	local u = t:GetEnemy()
	if IsValid(u) then
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ancient_apparition/ancient_ice_vortex.vpcf",
			PATTACH_CUSTOMORIGIN,
			u,
			t
		)
		ParticleManager:SetParticleControl(v, 0, u:GetAbsOrigin() + Vector(0, 0, 64))
		ParticleManager:SetParticleControl(v, 5, Vector(300, 0, 0))
		EmitSoundOnLocationWithCaster(u:GetAbsOrigin(), "Hero_Ancient_Apparition.IceVortexCast", t)
		self.particleID = v
	end
end
function r.prototype.OnBattleStart(self, s)
	self:StartIntervalThink(self.interval)
end
function r.prototype.OnBattleEnd(self, s)
	if self.particleID then
		ParticleManager:DestroyParticle(self.particleID, false)
		ParticleManager:ReleaseParticleIndex(self.particleID)
	end
	self:StartIntervalThink(-1)
end
function r.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	if t:PassivesDisabled() then
		return
	end
	local u = t:GetEnemy()
	if not IsInjurable(u, t) then
		self:StartIntervalThink(-1)
		return
	end
	local w = self:GetAbility()
	AddIce(t, u, self.ice_count, "ancient_apparition_talent", "Ability")
	self:AddDeathMistFrost(self.buff_count)
	if self.tl1_ice_damage > 0 then
		t:DealDamage(u, w, GetIce(u) * self.tl1_ice_damage * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	end
end
function r.prototype.AddDeathMistFrost(self, x)
	local t = self:GetParent()
	local u = t:GetEnemy()
	if IsInjurable(t, u) then
		u:AddNewModifier(t, self:GetAbility(), "modifier_ancient_death_mist_frost", { iStackCount = x })
	end
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
g.modifier_ancient_apparition_talent = r
g.ancient_apparition_ult = c()
local y = g.ancient_apparition_ult
y.name = "ancient_apparition_ult"
d(y, o)
function y.prototype.OnSpellStart(self, z)
	local A = self:GetCaster()
	local B = A:GetEnemy()
	local C = self:GetSpecialValueFor("duration")
	local D = self:GetSpecialValueFor("buff_count") + self:GetTalentValue("ancient_apparition_talent_6", "ult_stack")
	if self.stack_count == nil then
		self.stack_count = 0
	end
	if not IsValid(self.talentModifier) then
		self.talentModifier = A:FindModifierByName("modifier_ancient_apparition_talent")
	end
	if IsValid(self.talentModifier) then
		if type(z) == "number" then
			self.talentModifier:AddDeathMistFrost(z)
		else
			self.talentModifier:AddDeathMistFrost(D)
		end
	end
	self.stack_count = self.stack_count + 1
	A:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	A:EmitSound("Hero_Ancient_Apparition.IceBlastRelease.Cast")
	if IsInjurable(B) then
		local E = B:GetAbsOrigin() - A:GetAbsOrigin()
		E.z = 0
		E = E:Normalized()
		local F = (B:GetAbsOrigin() - A:GetAbsOrigin()):Length2D()
		Projectile:CreateLinearProjectile({
			EffectName = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_final.vpcf",
			hCaster = A,
			vSpawnOrigin = A:GetAbsOrigin(),
			vDirection = E,
			flDistance = F,
			flRadius = 0,
			iMoveSpeed = 1500,
			OnProjectileDestroy = function(G, H)
				if IsValid(self) and IsInjurable(A, B) then
					EmitSoundOnLocationWithCaster(G, "Hero_Ancient_Apparition.IceBlast.Target", A)
					B:AddNewModifier(A, self, "modifier_ancient_apparition_ult_debuff", { duration = C })
				end
			end,
		})
	end
end
function y.prototype.GetIntrinsicModifierName(self)
	return "modifier_ancient_ult"
end
y = e({ p(nil) }, y)
g.ancient_apparition_ult = y
g.modifier_ancient_ult = c()
local I = g.modifier_ancient_ult
I.name = "modifier_ancient_ult"
d(I, l)
function I.prototype.GetTexture(self)
	return "modifier_ancient_ult"
end
function I.prototype.GetAbilitySpecialValue(self)
	self.tl7_stack_win = self:GetAbilityTalentValue("ancient_apparition_talent_7", "stack_win")
end
function I.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function I.prototype.OnBattleStartBefore(self, s)
	if self.tl7_stack_win > 0 then
		self:SetStackCount(self:LoadStack())
	end
end
function I.prototype.OnBattleStart(self, s)
	if self:HasTalent("ancient_apparition_talent_6") then
		self:GetAbility():OnSpellStart()
	end
end
function I.prototype.LoadStack(self)
	local J = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "ancient_apparition_talent_7")
	if J == nil then
		J = 0
	end
	return J
end
function I.prototype.SaveStack(self, x)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "ancient_apparition_talent_7", x)
end
function I.prototype.OnBattleEnd(self, s)
	if s.isNeutral then
		return
	end
	if self.tl7_stack_win > 0 then
		local K = self:GetParent():GetPlayerOwnerID()
		if K == s.winPlayerID and K ~= s.illusionPlayerID then
			local L = self:GetStackCount() + 1
			self:SetStackCount(L)
			self:SaveStack(L)
		end
	end
end
I = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	I
)
g.modifier_ancient_ult = I
g.modifier_ancient_apparition_ult_debuff = c()
local M = g.modifier_ancient_apparition_ult_debuff
M.name = "modifier_ancient_apparition_ult_debuff"
d(M, l)
function M.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 0.1
end
function M.prototype.GetAbilitySpecialValue(self)
	self.kill_threshold = self:GetAbilitySpecialValueFor("kill_threshold")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.tl7_stack_win = self:GetAbilityTalentValue("ancient_apparition_talent_7", "stack_win")
end
function M.prototype.OnCreated(self, s)
	if IsServer() then
		self.killed = false
		self:StartThink(self.tick)
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
	else
		local N = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent(),
			self:GetCaster()
		)
		self:AddParticle(N, false, false, -1, false, false)
	end
end
function M.prototype.OnRefresh(self, s)
	if IsServer() then
		self.killed = false
		self:StartThink(self.tick)
		self:IncrementStackCount()
	end
end
function M.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function M.prototype.OnThink(self, O)
	if self.killed then
		self:StartThink(-1)
		return
	end
	local t = self:GetParent()
	local A = self:GetCaster()
	if not IsInjurable(A, t) then
		self:Destroy()
		return
	end
	local P = self.kill_threshold
	local Q = self.tl7_stack_win
	if Q > 0 then
		local R = A:GetModifierStackCount("modifier_ancient_ult", A) or 0
		P = P + R * Q
	end
	local w = self:GetAbility()
	if t:GetHealthPercent() <= P then
		self.killed = true
		DamageSystem:dealDamage({
			attacker = A,
			target = t,
			ability = w,
			damage = t:GetHealth(),
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		})
		local N = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_death.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent(),
			self:GetCaster()
		)
		ParticleManager:ReleaseParticleIndex(N)
	end
end
function M.prototype.OnIntervalThink(self)
	if IsServer() then
		local A = self:GetCaster()
		local t = self:GetParent()
		if not IsInjurable(A, t) then
			self:Destroy()
			return
		end
		local w = self:GetAbility()
		t:EmitSound("Hero_Ancient_Apparition.IceBlastRelease.Tick")
		DamageSystem:dealDamage({
			attacker = A,
			target = t,
			ability = w,
			damage = self.damage * self:GetStackCount(),
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		})
	end
end
M = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	M
)
g.modifier_ancient_apparition_ult_debuff = M
g.modifier_ancient_death_mist_frost = c()
local S = g.modifier_ancient_death_mist_frost
S.name = "modifier_ancient_death_mist_frost"
d(S, l)
function S.prototype.GetTexture(self)
	return "ancient_death_mist_frost"
end
function S.prototype.GetAbilitySpecialValue(self)
	self.stack_count = self:GetAbilitySpecialValueFor("stack_count")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.tl8_mana_regen = self:GetAbilityTalentValue("ancient_apparition_talent_8", "mana_regen")
end
function S.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount(s and s.iStackCount or 0)
	end
end
function S.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount(s and s.iStackCount or 0)
	end
end
function S.prototype.OnStackCountChanged(self, T)
	if IsServer() then
		if self:GetStackCount() >= self.stack_count then
			self:DecrementStackCount(self.stack_count)
			local A = self:GetCaster()
			local t = self:GetParent()
			local w = self:GetAbility()
			if IsInjurable(A, t) then
				t:AddNewModifier(A, w, "modifier_ancient_death_mist_frost_ice", nil)
				A:AddNewModifier(A, w, "modifier_ancient_death_mist_frost_damage", { duration = self.duration })
				if self.tl8_mana_regen > 0 then
					Restore(A, self.tl8_mana_regen)
				end
			end
		end
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end
S = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	S
)
g.modifier_ancient_death_mist_frost = S
g.modifier_ancient_death_mist_frost_damage = c()
local U = g.modifier_ancient_death_mist_frost_damage
U.name = "modifier_ancient_death_mist_frost_damage"
d(U, l)
function U.prototype.GetAbilitySpecialValue(self)
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.ice_damage_pct = self:GetAbilitySpecialValueFor("ice_damage_pct")
	local V = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.g_magic_damage = (V and V:GetAbilityName()) == "trait_198" and V:GetSpecialValueFor("magic_damage") or 0
end
function U.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function U.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function U.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function U.prototype.OnCustomAttackLanded(self, W)
	if self.g_magic_damage > 0 then
		if IsInjurable(W.attacker, W.target) then
			W.attacker:DealDamage(
				W.target,
				W.attacker:FindAbilityByName("ancient_apparition_chilling_touch"),
				self.g_magic_damage,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
		end
	end
end
function U.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_CONSTANT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
	}
end
function U.prototype.EOM_GetModifierOutgoingDamageConstant(self, s)
	if s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		return (self.base_damage + GetIce(s.target) * self.ice_damage_pct * 0.01) * self:GetStackCount()
	end
end
U = e(
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
				IsIndependent = true,
			}
		),
	},
	U
)
g.modifier_ancient_death_mist_frost_damage = U
g.modifier_ancient_death_mist_frost_ice = c()
local X = g.modifier_ancient_death_mist_frost_ice
X.name = "modifier_ancient_death_mist_frost_ice"
d(X, l)
function X.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.max_health = 0
end
function X.prototype.GetAbilitySpecialValue(self)
	self.buff_ice = self:GetAbilitySpecialValueFor("buff_ice")
	self.scar_pct = self:GetAbilityTalentValue("ancient_apparition_shard", "scar_pct")
end
function X.prototype.OnCreated(self, s)
	if IsServer() then
		self.max_health = self:GetParent():GetMaxHealth()
		AddScar(self.parent, self.parent, self:GetAbility(), self.max_health * self.scar_pct * 0.01)
		self:IncrementStackCount()
	end
end
function X.prototype.OnRefresh(self, s)
	if IsServer() then
		AddScar(self.parent, self.parent, self:GetAbility(), self.max_health * self.scar_pct * 0.01)
		self:IncrementStackCount()
	end
end
function X.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_PERMANENT] = self.buff_ice * self:GetStackCount() }
end
X = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	X
)
g.modifier_ancient_death_mist_frost_ice = X
return g