--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
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
		["94"] = 98,
		["95"] = 98,
		["96"] = 98,
		["97"] = 99,
		["98"] = 100,
		["99"] = 101,
		["102"] = 95,
		["103"] = 105,
		["104"] = 106,
		["105"] = 107,
		["107"] = 105,
		["108"] = 110,
		["109"] = 111,
		["110"] = 110,
		["111"] = 113,
		["112"] = 114,
		["113"] = 115,
		["114"] = 116,
		["115"] = 117,
		["116"] = 118,
		["117"] = 119,
		["118"] = 120,
		["119"] = 121,
		["121"] = 123,
		["122"] = 124,
		["123"] = 125,
		["130"] = 132,
		["131"] = 133,
		["132"] = 134,
		["133"] = 134,
		["134"] = 134,
		["135"] = 134,
		["136"] = 135,
		["137"] = 136,
		["138"] = 137,
		["139"] = 138,
		["140"] = 138,
		["141"] = 138,
		["142"] = 138,
		["143"] = 138,
		["144"] = 138,
		["146"] = 140,
		["150"] = 113,
		["151"] = 21,
		["152"] = 13,
		["153"] = 13,
		["154"] = 13,
		["155"] = 13,
		["156"] = 13,
		["157"] = 13,
		["158"] = 13,
		["159"] = 13,
		["160"] = 21,
		["162"] = 21,
		["163"] = 149,
		["164"] = 150,
		["165"] = 149,
		["166"] = 150,
		["167"] = 152,
		["168"] = 153,
		["169"] = 154,
		["170"] = 155,
		["173"] = 158,
		["174"] = 159,
		["176"] = 161,
		["177"] = 162,
		["178"] = 163,
		["179"] = 163,
		["180"] = 163,
		["181"] = 164,
		["182"] = 165,
		["183"] = 166,
		["185"] = 163,
		["186"] = 163,
		["187"] = 169,
		["188"] = 171,
		["189"] = 172,
		["190"] = 173,
		["191"] = 176,
		["192"] = 177,
		["193"] = 177,
		["194"] = 177,
		["195"] = 177,
		["196"] = 177,
		["197"] = 177,
		["198"] = 177,
		["199"] = 181,
		["200"] = 182,
		["201"] = 182,
		["202"] = 182,
		["203"] = 182,
		["204"] = 182,
		["205"] = 182,
		["206"] = 182,
		["207"] = 189,
		["208"] = 190,
		["209"] = 191,
		["210"] = 192,
		["211"] = 192,
		["212"] = 192,
		["213"] = 192,
		["214"] = 192,
		["215"] = 192,
		["216"] = 192,
		["217"] = 192,
		["218"] = 192,
		["219"] = 193,
		["220"] = 193,
		["221"] = 193,
		["222"] = 193,
		["223"] = 193,
		["224"] = 194,
		["225"] = 195,
		["226"] = 195,
		["227"] = 195,
		["228"] = 195,
		["229"] = 195,
		["230"] = 196,
		["231"] = 196,
		["232"] = 196,
		["233"] = 196,
		["234"] = 196,
		["236"] = 198,
		["237"] = 198,
		["238"] = 198,
		["239"] = 198,
		["240"] = 198,
		["242"] = 200,
		["243"] = 200,
		["244"] = 200,
		["245"] = 200,
		["246"] = 200,
		["247"] = 201,
		["248"] = 182,
		["249"] = 203,
		["250"] = 204,
		["251"] = 182,
		["252"] = 206,
		["253"] = 207,
		["254"] = 208,
		["255"] = 209,
		["257"] = 213,
		["258"] = 217,
		["259"] = 218,
		["262"] = 223,
		["263"] = 224,
		["265"] = 182,
		["266"] = 182,
		["267"] = 152,
		["268"] = 150,
		["269"] = 149,
		["270"] = 150,
		["272"] = 150,
		["273"] = 231,
		["274"] = 240,
		["275"] = 231,
		["276"] = 240,
		["277"] = 246,
		["278"] = 247,
		["279"] = 248,
		["280"] = 249,
		["281"] = 251,
		["282"] = 252,
		["283"] = 253,
		["284"] = 254,
		["286"] = 246,
		["287"] = 257,
		["288"] = 258,
		["289"] = 259,
		["290"] = 260,
		["291"] = 261,
		["292"] = 262,
		["293"] = 263,
		["294"] = 264,
		["297"] = 257,
		["298"] = 268,
		["299"] = 269,
		["300"] = 270,
		["301"] = 271,
		["302"] = 272,
		["303"] = 273,
		["304"] = 274,
		["308"] = 268,
		["309"] = 279,
		["310"] = 280,
		["311"] = 281,
		["312"] = 281,
		["313"] = 281,
		["314"] = 281,
		["315"] = 281,
		["316"] = 281,
		["317"] = 282,
		["318"] = 282,
		["319"] = 282,
		["320"] = 282,
		["321"] = 282,
		["322"] = 283,
		["323"] = 283,
		["324"] = 283,
		["325"] = 283,
		["326"] = 283,
		["327"] = 284,
		["328"] = 284,
		["329"] = 284,
		["330"] = 284,
		["331"] = 284,
		["332"] = 286,
		["333"] = 286,
		["334"] = 286,
		["335"] = 286,
		["336"] = 286,
		["337"] = 287,
		["338"] = 288,
		["339"] = 288,
		["340"] = 288,
		["341"] = 288,
		["342"] = 288,
		["343"] = 288,
		["344"] = 288,
		["345"] = 288,
		["346"] = 279,
		["347"] = 290,
		["348"] = 291,
		["349"] = 292,
		["350"] = 293,
		["351"] = 294,
		["352"] = 295,
		["355"] = 298,
		["356"] = 299,
		["357"] = 299,
		["358"] = 299,
		["359"] = 299,
		["360"] = 299,
		["361"] = 299,
		["362"] = 299,
		["363"] = 299,
		["364"] = 299,
		["365"] = 308,
		["366"] = 309,
		["367"] = 310,
		["369"] = 290,
		["370"] = 313,
		["371"] = 314,
		["372"] = 315,
		["374"] = 313,
		["375"] = 240,
		["376"] = 231,
		["377"] = 231,
		["378"] = 231,
		["379"] = 231,
		["380"] = 231,
		["381"] = 231,
		["382"] = 231,
		["383"] = 231,
		["384"] = 231,
		["385"] = 240,
		["387"] = 240,
		["388"] = 320,
		["389"] = 328,
		["390"] = 320,
		["391"] = 328,
		["392"] = 329,
		["393"] = 330,
		["394"] = 331,
		["395"] = 332,
		["397"] = 334,
		["398"] = 335,
		["399"] = 335,
		["400"] = 335,
		["401"] = 335,
		["402"] = 335,
		["403"] = 335,
		["404"] = 336,
		["405"] = 336,
		["406"] = 336,
		["407"] = 336,
		["408"] = 336,
		["409"] = 337,
		["410"] = 337,
		["411"] = 337,
		["412"] = 337,
		["413"] = 337,
		["414"] = 338,
		["415"] = 338,
		["416"] = 338,
		["417"] = 338,
		["418"] = 338,
		["419"] = 339,
		["420"] = 339,
		["421"] = 339,
		["422"] = 339,
		["423"] = 339,
		["424"] = 341,
		["425"] = 341,
		["426"] = 341,
		["427"] = 341,
		["428"] = 341,
		["429"] = 342,
		["430"] = 342,
		["431"] = 342,
		["432"] = 342,
		["433"] = 342,
		["434"] = 342,
		["435"] = 342,
		["436"] = 342,
		["438"] = 329,
		["439"] = 345,
		["440"] = 346,
		["441"] = 347,
		["443"] = 345,
		["444"] = 328,
		["445"] = 320,
		["446"] = 320,
		["447"] = 320,
		["448"] = 320,
		["449"] = 320,
		["450"] = 320,
		["451"] = 320,
		["452"] = 320,
		["453"] = 328,
		["455"] = 328,
		["456"] = 352,
		["457"] = 364,
		["458"] = 352,
		["459"] = 364,
		["460"] = 366,
		["461"] = 367,
		["462"] = 366,
		["463"] = 369,
		["464"] = 370,
		["465"] = 369,
		["466"] = 364,
		["467"] = 352,
		["468"] = 352,
		["469"] = 352,
		["470"] = 352,
		["471"] = 352,
		["472"] = 352,
		["473"] = 352,
		["474"] = 352,
		["475"] = 352,
		["476"] = 352,
		["477"] = 352,
		["478"] = 352,
		["479"] = 364,
		["481"] = 364,
		["482"] = 377,
		["483"] = 378,
		["484"] = 377,
		["485"] = 378,
		["486"] = 379,
		["487"] = 380,
		["488"] = 379,
		["489"] = 378,
		["490"] = 377,
		["491"] = 378,
		["493"] = 378,
		["494"] = 383,
		["495"] = 391,
		["496"] = 383,
		["497"] = 391,
		["498"] = 395,
		["499"] = 396,
		["500"] = 397,
		["501"] = 395,
		["502"] = 399,
		["503"] = 400,
		["504"] = 401,
		["505"] = 401,
		["506"] = 401,
		["507"] = 402,
		["508"] = 403,
		["510"] = 401,
		["511"] = 401,
		["513"] = 399,
		["514"] = 408,
		["515"] = 409,
		["516"] = 408,
		["517"] = 414,
		["518"] = 415,
		["519"] = 414,
		["520"] = 417,
		["521"] = 418,
		["522"] = 419,
		["523"] = 420,
		["524"] = 421,
		["525"] = 422,
		["526"] = 423,
		["527"] = 424,
		["528"] = 425,
		["529"] = 426,
		["530"] = 427,
		["531"] = 428,
		["533"] = 430,
		["534"] = 431,
		["536"] = 433,
		["537"] = 434,
		["539"] = 436,
		["540"] = 437,
		["543"] = 440,
		["546"] = 417,
		["547"] = 391,
		["548"] = 383,
		["549"] = 383,
		["550"] = 383,
		["551"] = 383,
		["552"] = 383,
		["553"] = 383,
		["554"] = 383,
		["555"] = 383,
		["556"] = 391,
		["558"] = 391,
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
		self:SetStackCount(math.min(self:GetAbilityTalentValue("shredder_talent_2", "start_shield"), self.stack_max))
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