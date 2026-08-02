--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/shredder"
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
		["29"] = 13,
		["30"] = 21,
		["31"] = 13,
		["32"] = 21,
		["34"] = 21,
		["35"] = 30,
		["36"] = 13,
		["37"] = 35,
		["38"] = 36,
		["39"] = 35,
		["40"] = 38,
		["41"] = 39,
		["42"] = 40,
		["43"] = 41,
		["44"] = 42,
		["45"] = 43,
		["46"] = 48,
		["47"] = 50,
		["48"] = 52,
		["49"] = 53,
		["50"] = 38,
		["51"] = 55,
		["52"] = 56,
		["53"] = 57,
		["54"] = 58,
		["55"] = 59,
		["56"] = 60,
		["59"] = 63,
		["60"] = 64,
		["61"] = 65,
		["62"] = 66,
		["65"] = 55,
		["66"] = 75,
		["67"] = 76,
		["69"] = 75,
		["70"] = 79,
		["71"] = 80,
		["72"] = 79,
		["73"] = 84,
		["74"] = 85,
		["75"] = 84,
		["76"] = 87,
		["77"] = 88,
		["78"] = 88,
		["79"] = 88,
		["80"] = 91,
		["81"] = 91,
		["82"] = 91,
		["83"] = 88,
		["84"] = 92,
		["85"] = 92,
		["86"] = 92,
		["87"] = 88,
		["88"] = 88,
		["89"] = 87,
		["90"] = 95,
		["91"] = 96,
		["92"] = 97,
		["93"] = 98,
		["94"] = 99,
		["95"] = 100,
		["96"] = 101,
		["99"] = 95,
		["100"] = 105,
		["101"] = 106,
		["102"] = 107,
		["104"] = 105,
		["105"] = 110,
		["106"] = 111,
		["107"] = 110,
		["108"] = 113,
		["109"] = 114,
		["110"] = 115,
		["111"] = 116,
		["112"] = 117,
		["113"] = 118,
		["114"] = 119,
		["115"] = 120,
		["116"] = 121,
		["118"] = 123,
		["119"] = 124,
		["120"] = 125,
		["127"] = 132,
		["128"] = 133,
		["129"] = 134,
		["130"] = 134,
		["131"] = 134,
		["132"] = 134,
		["133"] = 135,
		["134"] = 136,
		["135"] = 137,
		["136"] = 138,
		["137"] = 138,
		["138"] = 138,
		["139"] = 138,
		["140"] = 138,
		["141"] = 138,
		["143"] = 140,
		["147"] = 113,
		["148"] = 21,
		["149"] = 13,
		["150"] = 13,
		["151"] = 13,
		["152"] = 13,
		["153"] = 13,
		["154"] = 13,
		["155"] = 13,
		["156"] = 13,
		["157"] = 21,
		["159"] = 21,
		["160"] = 149,
		["161"] = 150,
		["162"] = 149,
		["163"] = 150,
		["164"] = 152,
		["165"] = 153,
		["166"] = 154,
		["167"] = 155,
		["170"] = 158,
		["171"] = 159,
		["173"] = 161,
		["174"] = 162,
		["175"] = 163,
		["176"] = 163,
		["177"] = 163,
		["178"] = 164,
		["179"] = 165,
		["180"] = 166,
		["182"] = 163,
		["183"] = 163,
		["184"] = 169,
		["185"] = 171,
		["186"] = 172,
		["187"] = 173,
		["188"] = 176,
		["189"] = 177,
		["190"] = 177,
		["191"] = 177,
		["192"] = 177,
		["193"] = 177,
		["194"] = 177,
		["195"] = 177,
		["196"] = 181,
		["197"] = 182,
		["198"] = 182,
		["199"] = 182,
		["200"] = 182,
		["201"] = 182,
		["202"] = 182,
		["203"] = 182,
		["204"] = 189,
		["205"] = 190,
		["206"] = 191,
		["207"] = 192,
		["208"] = 192,
		["209"] = 192,
		["210"] = 192,
		["211"] = 192,
		["212"] = 192,
		["213"] = 192,
		["214"] = 192,
		["215"] = 192,
		["216"] = 193,
		["217"] = 193,
		["218"] = 193,
		["219"] = 193,
		["220"] = 193,
		["221"] = 194,
		["222"] = 195,
		["223"] = 195,
		["224"] = 195,
		["225"] = 195,
		["226"] = 195,
		["227"] = 196,
		["228"] = 196,
		["229"] = 196,
		["230"] = 196,
		["231"] = 196,
		["233"] = 198,
		["234"] = 198,
		["235"] = 198,
		["236"] = 198,
		["237"] = 198,
		["239"] = 200,
		["240"] = 200,
		["241"] = 200,
		["242"] = 200,
		["243"] = 200,
		["244"] = 201,
		["245"] = 182,
		["246"] = 203,
		["247"] = 204,
		["248"] = 182,
		["249"] = 206,
		["250"] = 207,
		["251"] = 208,
		["252"] = 209,
		["254"] = 213,
		["255"] = 217,
		["256"] = 218,
		["259"] = 223,
		["260"] = 224,
		["262"] = 182,
		["263"] = 182,
		["264"] = 152,
		["265"] = 150,
		["266"] = 149,
		["267"] = 150,
		["269"] = 150,
		["270"] = 231,
		["271"] = 240,
		["272"] = 231,
		["273"] = 240,
		["274"] = 246,
		["275"] = 247,
		["276"] = 248,
		["277"] = 249,
		["278"] = 251,
		["279"] = 252,
		["280"] = 253,
		["281"] = 254,
		["283"] = 246,
		["284"] = 257,
		["285"] = 258,
		["286"] = 259,
		["287"] = 260,
		["288"] = 261,
		["289"] = 262,
		["290"] = 263,
		["291"] = 264,
		["294"] = 257,
		["295"] = 268,
		["296"] = 269,
		["297"] = 270,
		["298"] = 271,
		["299"] = 272,
		["300"] = 273,
		["301"] = 274,
		["305"] = 268,
		["306"] = 279,
		["307"] = 280,
		["308"] = 281,
		["309"] = 281,
		["310"] = 281,
		["311"] = 281,
		["312"] = 281,
		["313"] = 281,
		["314"] = 282,
		["315"] = 282,
		["316"] = 282,
		["317"] = 282,
		["318"] = 282,
		["319"] = 283,
		["320"] = 283,
		["321"] = 283,
		["322"] = 283,
		["323"] = 283,
		["324"] = 284,
		["325"] = 284,
		["326"] = 284,
		["327"] = 284,
		["328"] = 284,
		["329"] = 286,
		["330"] = 286,
		["331"] = 286,
		["332"] = 286,
		["333"] = 286,
		["334"] = 287,
		["335"] = 288,
		["336"] = 288,
		["337"] = 288,
		["338"] = 288,
		["339"] = 288,
		["340"] = 288,
		["341"] = 288,
		["342"] = 288,
		["343"] = 279,
		["344"] = 290,
		["345"] = 291,
		["346"] = 292,
		["347"] = 293,
		["348"] = 294,
		["349"] = 295,
		["352"] = 298,
		["353"] = 299,
		["354"] = 299,
		["355"] = 299,
		["356"] = 299,
		["357"] = 299,
		["358"] = 299,
		["359"] = 299,
		["360"] = 299,
		["361"] = 299,
		["362"] = 308,
		["363"] = 309,
		["364"] = 310,
		["366"] = 290,
		["367"] = 313,
		["368"] = 314,
		["369"] = 315,
		["371"] = 313,
		["372"] = 240,
		["373"] = 231,
		["374"] = 231,
		["375"] = 231,
		["376"] = 231,
		["377"] = 231,
		["378"] = 231,
		["379"] = 231,
		["380"] = 231,
		["381"] = 231,
		["382"] = 240,
		["384"] = 240,
		["385"] = 320,
		["386"] = 328,
		["387"] = 320,
		["388"] = 328,
		["389"] = 329,
		["390"] = 330,
		["391"] = 331,
		["392"] = 332,
		["394"] = 334,
		["395"] = 335,
		["396"] = 335,
		["397"] = 335,
		["398"] = 335,
		["399"] = 335,
		["400"] = 335,
		["401"] = 336,
		["402"] = 336,
		["403"] = 336,
		["404"] = 336,
		["405"] = 336,
		["406"] = 337,
		["407"] = 337,
		["408"] = 337,
		["409"] = 337,
		["410"] = 337,
		["411"] = 338,
		["412"] = 338,
		["413"] = 338,
		["414"] = 338,
		["415"] = 338,
		["416"] = 339,
		["417"] = 339,
		["418"] = 339,
		["419"] = 339,
		["420"] = 339,
		["421"] = 341,
		["422"] = 341,
		["423"] = 341,
		["424"] = 341,
		["425"] = 341,
		["426"] = 342,
		["427"] = 342,
		["428"] = 342,
		["429"] = 342,
		["430"] = 342,
		["431"] = 342,
		["432"] = 342,
		["433"] = 342,
		["435"] = 329,
		["436"] = 345,
		["437"] = 346,
		["438"] = 347,
		["440"] = 345,
		["441"] = 328,
		["442"] = 320,
		["443"] = 320,
		["444"] = 320,
		["445"] = 320,
		["446"] = 320,
		["447"] = 320,
		["448"] = 320,
		["449"] = 320,
		["450"] = 328,
		["452"] = 328,
		["453"] = 352,
		["454"] = 364,
		["455"] = 352,
		["456"] = 364,
		["457"] = 366,
		["458"] = 367,
		["459"] = 366,
		["460"] = 369,
		["461"] = 370,
		["462"] = 369,
		["463"] = 364,
		["464"] = 352,
		["465"] = 352,
		["466"] = 352,
		["467"] = 352,
		["468"] = 352,
		["469"] = 352,
		["470"] = 352,
		["471"] = 352,
		["472"] = 352,
		["473"] = 352,
		["474"] = 352,
		["475"] = 352,
		["476"] = 364,
		["478"] = 364,
		["479"] = 377,
		["480"] = 378,
		["481"] = 377,
		["482"] = 378,
		["483"] = 379,
		["484"] = 380,
		["485"] = 379,
		["486"] = 378,
		["487"] = 377,
		["488"] = 378,
		["490"] = 378,
		["491"] = 383,
		["492"] = 391,
		["493"] = 383,
		["494"] = 391,
		["495"] = 395,
		["496"] = 396,
		["497"] = 397,
		["498"] = 395,
		["499"] = 399,
		["500"] = 400,
		["501"] = 401,
		["502"] = 401,
		["503"] = 401,
		["504"] = 402,
		["505"] = 403,
		["507"] = 401,
		["508"] = 401,
		["510"] = 399,
		["511"] = 408,
		["512"] = 409,
		["513"] = 408,
		["514"] = 414,
		["515"] = 415,
		["516"] = 414,
		["517"] = 417,
		["518"] = 418,
		["519"] = 419,
		["520"] = 420,
		["521"] = 421,
		["522"] = 422,
		["523"] = 423,
		["524"] = 424,
		["525"] = 425,
		["526"] = 426,
		["527"] = 427,
		["528"] = 428,
		["530"] = 430,
		["531"] = 431,
		["533"] = 433,
		["534"] = 434,
		["536"] = 436,
		["537"] = 437,
		["540"] = 440,
		["543"] = 417,
		["544"] = 391,
		["545"] = 383,
		["546"] = 383,
		["547"] = 383,
		["548"] = 383,
		["549"] = 383,
		["550"] = 383,
		["551"] = 383,
		["552"] = 383,
		["553"] = 391,
		["555"] = 391,
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
g.shredder_talent = c()
local q = g.shredder_talent
q.name = "shredder_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_shredder_talent"
end
q = e({ j(nil) }, q)
g.shredder_talent = q
g.modifier_shredder_talent = c()
local r = g.modifier_shredder_talent
r.name = "modifier_shredder_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tl8_record = -1
end
function r.prototype.GetTexture(self)
	return "reactive_armor"
end
function r.prototype.GetAbilitySpecialValue(self)
	self.stack_add = self:GetAbilitySpecialValueFor("stack_add")
	self.stack_max = self:GetAbilitySpecialValueFor("stack_max")
		+ self:GetAbilityTalentValue("shredder_talent_2", "bonus_max")
	self.regen_factor = self:GetAbilitySpecialValueFor("regen_factor")
		+ self:GetAbilityTalentValue("shredder_talent_7", "regen_factor")
	self.chaos_factor = self:GetAbilitySpecialValueFor("chaos_factor")
		+ self:GetAbilityTalentValue("shredder_talent_4", "chaos_factor")
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("shredder_talent_6", "interval_reduce")
	self.tl7_physical_reduce = self:GetAbilityTalentValue("shredder_talent_7", "regen_factor")
	self.tl8_count = self:GetAbilityTalentValue("shredder_talent_8", "count")
	self.s_count = self:GetAbilityTalentValue("shredder_shard", "count")
	self.s_shield = self:GetAbilityTalentValue("shredder_shard", "shield")
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		local s = self:GetParent()
		local t = s:GetEnemy()
		if not IsInjurable(s, t) then
			self:StartIntervalThink(-1)
			return
		end
		local u = self:GetStackCount()
		if u > 0 then
			AddChaos(s, u * self.chaos_factor, "shredder_talent", "Ability")
			Heal(s, self.regen_factor * u, "shredder_talent", "Ability")
		end
	end
end
function r.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE }
end
function r.prototype.EOM_GetModifierIncomingPhysicalDamagePercentage(self, v)
	return self:GetStackCount() * self.tl7_physical_reduce * -1
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), self:GetParent() },
	}
end
function r.prototype.OnBattleStartBefore(self, v)
	if IsServer() then
		self.s_enable = self.s_count > 0
		self:SetStackCount(0)
		self.ult_ability = self:GetParent():FindAbilityByName("shredder_ult")
		if self.tl8_count > 0 then
			self.tl8_record = 0
		end
	end
end
function r.prototype.OnBattleStart(self, v)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function r.prototype.OnBattleEnd(self, v)
	self:StartIntervalThink(-1)
end
function r.prototype.OnCustomTakeDamage(self, w)
	if w.attacker == self:GetParent() then
		if self.tl8_record >= 0 then
			if w.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS then
				self.tl8_record = self.tl8_record + 1
				if self.tl8_record >= self.tl8_count then
					self.tl8_record = 0
					if IsValid(self.ult_ability) then
						self.ult_ability:OnSpellStart(true)
					else
						self.ult_ability = self:GetParent():FindAbilityByName("shredder_ult")
						if IsValid(self.ult_ability) then
							self.ult_ability:OnSpellStart(true)
						end
					end
				end
			end
		end
	else
		if not self:GetParent():PassivesDisabled() then
			if self:GetStackCount() < self.stack_max then
				local x = math.min(self:GetStackCount() + self.stack_add, self.stack_max)
				if self.s_enable and x >= self.s_count then
					self.s_enable = false
					x = self.stack_max
					AddShield(self:GetParent(), self.s_shield, self:GetAbility():GetAbilityName(), "Ability")
				end
				self:SetStackCount(x)
			end
		end
	end
end
r = e(
	{
		m(
			a,
			{
				IsHidden = false,
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
g.modifier_shredder_talent = r
g.shredder_ult = c()
local y = g.shredder_ult
y.name = "shredder_ult"
d(y, o)
function y.prototype.OnSpellStart(self, z)
	local A = self:GetCaster()
	local B = A:GetEnemy()
	if not IsInjurable(A, B) then
		return
	end
	if self.casteTimer ~= nil then
		self:StopTimer(self.casteTimer)
	end
	A:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
	A:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0, 0.1, 1.5)
	self.casteTimer = self:GameTimer(0.3, function()
		if IsValid(A) then
			A:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
			self.casteTimer = nil
		end
	end)
	local C = self:GetSpecialValueFor("duration")
	local D = self:GetTalentValue("shredder_talent_3", "duration")
	local E = B:GetAbsOrigin() - A:GetAbsOrigin()
	local F = E:Length2D()
	local G = 900
	local H = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{ origin = A:GetAbsOrigin(), model = "models/development/invisiblebox.vmdl" }
	)
	H:EmitSound("Hero_Shredder.Chakram.Cast")
	Projectile:CreateLinearProjectile({
		hCaster = A,
		vSpawnOrigin = A:GetAbsOrigin(),
		vDirection = E,
		flDistance = F,
		flRadius = 0,
		iMoveSpeed = G,
		OnProjectileCreated = function(I)
			local J = I
			local K = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_shredder/shredder_chakram_stay.vpcf",
				PATTACH_CUSTOMORIGIN,
				A
			)
			ParticleManager:SetParticleControlEnt(K, 0, H, PATTACH_ABSORIGIN_FOLLOW, nil, H:GetAbsOrigin(), true)
			ParticleManager:SetParticleControl(K, 1, Vector(200, 200, 200))
			if z then
				ParticleManager:SetParticleControl(K, 15, Vector(32, 118, 255))
				ParticleManager:SetParticleControl(K, 16, Vector(1, 0, 0))
			else
				ParticleManager:SetParticleControl(K, 16, Vector(0, 0, 0))
			end
			ParticleManager:SetParticleControl(K, 61, Vector(0, 0, 0))
			J._iParticleID = K
		end,
		OnProjectileThink = function(L, I)
			H:SetAbsOrigin(L)
		end,
		OnProjectileDestroy = function()
			if IsValid(self) and IsInjurable(B, A) then
				if z then
					B:AddNewModifier(A, self, "modifier_shredder_ult_talent_8_debuff", { duration = C })
				end
				B:AddNewModifier(A, self, "modifier_shredder_ult_debuff", { duration = C, isTalent = z })
				if D > 0 then
					B:AddNewModifier(A, self, "modifier_shredder_talent_3_debuff", { duration = C })
				end
			end
			if IsValid(H) then
				UTIL_Remove(H)
			end
		end,
	})
end
y = e({ p(nil) }, y)
g.shredder_ult = y
g.modifier_shredder_ult_debuff = c()
local M = g.modifier_shredder_ult_debuff
M.name = "modifier_shredder_ult_debuff"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.chaos_count = self:GetAbilitySpecialValueFor("chaos_count")
	self.tl1_bonus_damage = self:GetAbilityTalentValue("shredder_talent_1", "bonus_damage")
	if self.tl1_bonus_damage > 0 then
		self.damage = self.damage * (1 + self.tl1_bonus_damage * 0.01)
		self.chaos_count = self.chaos_count * (1 + self.tl1_bonus_damage * 0.01)
	end
end
function M.prototype.OnCreated(self, v)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
		self:GetParent():EmitSound("Hero_Shredder.Chakram")
		local N = (v and v.isTalent) ~= 1
		if N then
			self:CreateParticle()
		end
	end
end
function M.prototype.OnRefresh(self, v)
	if IsServer() then
		self:IncrementStackCount()
		if self.particleID == nil then
			local N = (v and v.isTalent) ~= 1
			if N then
				self:CreateParticle()
			end
		end
	end
end
function M.prototype.CreateParticle(self)
	local s = self:GetParent()
	local K = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_shredder/shredder_chakram_stay.vpcf",
		PATTACH_CUSTOMORIGIN,
		s,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(K, 0, s:GetAbsOrigin())
	ParticleManager:SetParticleControl(K, 1, Vector(200, 200, 200))
	ParticleManager:SetParticleControl(K, 16, Vector(0, 0, 0))
	ParticleManager:SetParticleControl(K, 61, Vector(0, 0, 0))
	self.particleID = K
	self:AddParticle(K, false, false, -1, false, false)
end
function M.prototype.OnIntervalThink(self)
	if IsServer() then
		local s = self:GetParent()
		local A = self:GetCaster()
		if not IsInjurable(A, s) then
			self:Destroy()
			return
		end
		local u = self:GetStackCount()
		DamageSystem:dealDamage({
			attacker = A,
			target = s,
			ability = self:GetAbility(),
			damage = self.damage * u,
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		})
		AddChaos(A, self.chaos_count * u, "shredder_ult", "Ability")
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_shredder/shredder_chakram_hit.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			s
		)
		ParticleManager:ReleaseParticleIndex(K)
	end
end
function M.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("Hero_Shredder.Chakram")
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
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	M
)
g.modifier_shredder_ult_debuff = M
g.modifier_shredder_ult_talent_8_debuff = c()
local O = g.modifier_shredder_ult_talent_8_debuff
O.name = "modifier_shredder_ult_talent_8_debuff"
d(O, l)
function O.prototype.OnCreated(self, v)
	if IsServer() then
		local s = self:GetParent()
		s:EmitSound("Hero_Shredder.Chakram")
	else
		local s = self:GetParent()
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_shredder/shredder_chakram_stay.vpcf",
			PATTACH_CUSTOMORIGIN,
			s,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(K, 0, s:GetAbsOrigin())
		ParticleManager:SetParticleControl(K, 1, Vector(200, 200, 200))
		ParticleManager:SetParticleControl(K, 15, Vector(32, 118, 255))
		ParticleManager:SetParticleControl(K, 16, Vector(1, 0, 0))
		ParticleManager:SetParticleControl(K, 61, Vector(0, 0, 0))
		self:AddParticle(K, false, false, -1, false, false)
	end
end
function O.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("Hero_Shredder.Chakram")
	end
end
O = e(
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
	O
)
g.modifier_shredder_ult_talent_8_debuff = O
g.modifier_shredder_talent_3_debuff = c()
local P = g.modifier_shredder_talent_3_debuff
P.name = "modifier_shredder_talent_3_debuff"
d(P, l)
function P.prototype.GetAbilitySpecialValue(self)
	self.damage_pct = self:GetAbilityTalentValue("shredder_talent_3", "damage_pct")
end
function P.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = self.damage_pct }
end
P = e(
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
				GetStatusEffectName = "particles/status_fx/status_effect_shredder_whirl.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_shredder/shredder_whirling_death_debuff.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	P
)
g.modifier_shredder_talent_3_debuff = P
g.shredder_talent_5 = c()
local Q = g.shredder_talent_5
Q.name = "shredder_talent_5"
d(Q, i)
function Q.prototype.GetIntrinsicModifierName(self)
	return "modifier_shredder_talent_5"
end
Q = e({ j(nil) }, Q)
g.shredder_talent_5 = Q
g.modifier_shredder_talent_5 = c()
local R = g.modifier_shredder_talent_5
R.name = "modifier_shredder_talent_5"
d(R, l)
function R.prototype.GetAbilitySpecialValue(self)
	self.bonus_chaos_dmg = self:GetAbilitySpecialValueFor("bonus_chaos_dmg")
	self.convert_pct = self:GetAbilitySpecialValueFor("convert_pct")
end
function R.prototype.OnCreated(self, v)
	if IsServer() then
		self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL_CALCULATED, function(S, v, T, B)
			if T == self:GetParent() then
				self:ConvertToPureDamage(v)
			end
		end)
	end
end
function R.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS }
end
function R.prototype.EOM_GetModifierChaosDamageBonus(self, v)
	return self.bonus_chaos_dmg
end
function R.prototype.ConvertToPureDamage(self, w)
	if w.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS then
		local U = w.damage
		local V = U * self.convert_pct * 0.01
		w.damage = U - V
		if V > 0 then
			local W = shallowcopy(w)
			W.damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE
			W.damage = V
			if W.damage_flags ~= nil then
				if bit.band(W.damage_flags, DamageFlags.DAMAGE_FLAG_NO_CRIT) ~= DamageFlags.DAMAGE_FLAG_NO_CRIT then
					W.damage_flags = W.damage_flags + DamageFlags.DAMAGE_FLAG_NO_CRIT
				end
				if
					bit.band(W.damage_flags, DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING)
					~= DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
				then
					W.damage_flags = W.damage_flags + DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
				end
				if
					bit.band(W.damage_flags, DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING)
					~= DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING
				then
					W.damage_flags = W.damage_flags + DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING
				end
				if bit.band(W.damage_flags, DamageFlags.DAMAGE_FLAG_NO_CRIT) ~= DamageFlags.DAMAGE_FLAG_NO_CRIT then
					W.damage_flags = W.damage_flags + DamageFlags.DAMAGE_FLAG_NO_CRIT
				end
			end
			DamageSystem:dealDamage(W)
		end
	end
end
R = e(
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
	R
)
g.modifier_shredder_talent_5 = R
return g