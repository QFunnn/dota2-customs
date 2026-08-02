--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/luna"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__ArraySplice
local h = b.__TS__ArrayConcat
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 3,
		["18"] = 3,
		["19"] = 3,
		["20"] = 5,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 7,
		["27"] = 5,
		["28"] = 8,
		["29"] = 9,
		["30"] = 8,
		["31"] = 11,
		["32"] = 12,
		["33"] = 11,
		["34"] = 6,
		["35"] = 5,
		["36"] = 6,
		["38"] = 6,
		["39"] = 19,
		["40"] = 27,
		["41"] = 19,
		["42"] = 27,
		["44"] = 27,
		["45"] = 38,
		["46"] = 48,
		["47"] = 19,
		["48"] = 57,
		["49"] = 59,
		["50"] = 60,
		["51"] = 61,
		["52"] = 62,
		["53"] = 64,
		["54"] = 67,
		["55"] = 70,
		["56"] = 72,
		["57"] = 76,
		["58"] = 77,
		["59"] = 78,
		["60"] = 80,
		["61"] = 81,
		["62"] = 57,
		["63"] = 83,
		["64"] = 84,
		["65"] = 84,
		["66"] = 84,
		["67"] = 84,
		["68"] = 84,
		["69"] = 83,
		["70"] = 91,
		["71"] = 92,
		["72"] = 91,
		["73"] = 94,
		["74"] = 95,
		["75"] = 94,
		["76"] = 101,
		["77"] = 102,
		["78"] = 103,
		["79"] = 103,
		["80"] = 103,
		["81"] = 103,
		["82"] = 103,
		["83"] = 103,
		["84"] = 104,
		["85"] = 104,
		["86"] = 104,
		["87"] = 104,
		["88"] = 104,
		["89"] = 104,
		["91"] = 101,
		["92"] = 107,
		["93"] = 108,
		["94"] = 109,
		["95"] = 110,
		["96"] = 112,
		["97"] = 116,
		["99"] = 107,
		["100"] = 123,
		["101"] = 124,
		["102"] = 125,
		["103"] = 126,
		["104"] = 127,
		["105"] = 128,
		["106"] = 128,
		["107"] = 128,
		["108"] = 128,
		["109"] = 129,
		["110"] = 131,
		["111"] = 132,
		["112"] = 132,
		["113"] = 132,
		["114"] = 132,
		["115"] = 132,
		["116"] = 137,
		["117"] = 138,
		["118"] = 139,
		["119"] = 140,
		["120"] = 141,
		["121"] = 141,
		["122"] = 141,
		["123"] = 141,
		["124"] = 141,
		["125"] = 141,
		["126"] = 141,
		["128"] = 149,
		["129"] = 149,
		["130"] = 149,
		["131"] = 149,
		["132"] = 149,
		["133"] = 149,
		["134"] = 149,
		["136"] = 151,
		["137"] = 152,
		["138"] = 153,
		["139"] = 154,
		["140"] = 154,
		["141"] = 154,
		["142"] = 155,
		["143"] = 156,
		["145"] = 154,
		["146"] = 154,
		["150"] = 132,
		["151"] = 132,
		["153"] = 165,
		["154"] = 166,
		["155"] = 166,
		["156"] = 166,
		["157"] = 166,
		["158"] = 166,
		["159"] = 166,
		["160"] = 172,
		["161"] = 173,
		["162"] = 166,
		["163"] = 166,
		["167"] = 123,
		["168"] = 180,
		["169"] = 180,
		["170"] = 180,
		["172"] = 180,
		["173"] = 180,
		["175"] = 181,
		["176"] = 182,
		["177"] = 183,
		["179"] = 185,
		["180"] = 186,
		["181"] = 187,
		["182"] = 188,
		["183"] = 189,
		["184"] = 189,
		["185"] = 189,
		["186"] = 189,
		["187"] = 189,
		["188"] = 189,
		["190"] = 191,
		["193"] = 180,
		["194"] = 27,
		["195"] = 19,
		["196"] = 19,
		["197"] = 19,
		["198"] = 19,
		["199"] = 19,
		["200"] = 19,
		["201"] = 19,
		["202"] = 19,
		["203"] = 27,
		["205"] = 27,
		["206"] = 197,
		["207"] = 205,
		["208"] = 197,
		["209"] = 205,
		["211"] = 205,
		["212"] = 206,
		["213"] = 197,
		["214"] = 225,
		["215"] = 227,
		["216"] = 228,
		["217"] = 230,
		["218"] = 234,
		["219"] = 235,
		["220"] = 225,
		["221"] = 237,
		["222"] = 238,
		["223"] = 239,
		["224"] = 241,
		["225"] = 242,
		["226"] = 243,
		["227"] = 244,
		["229"] = 246,
		["230"] = 247,
		["231"] = 247,
		["232"] = 247,
		["233"] = 247,
		["234"] = 247,
		["235"] = 247,
		["237"] = 249,
		["239"] = 237,
		["240"] = 252,
		["241"] = 253,
		["242"] = 254,
		["243"] = 255,
		["244"] = 255,
		["245"] = 255,
		["246"] = 255,
		["247"] = 255,
		["248"] = 255,
		["250"] = 257,
		["252"] = 252,
		["253"] = 261,
		["254"] = 262,
		["255"] = 261,
		["256"] = 268,
		["257"] = 269,
		["258"] = 268,
		["259"] = 272,
		["260"] = 272,
		["261"] = 272,
		["263"] = 273,
		["264"] = 273,
		["265"] = 273,
		["266"] = 273,
		["269"] = 276,
		["270"] = 277,
		["272"] = 279,
		["275"] = 282,
		["276"] = 283,
		["277"] = 283,
		["278"] = 283,
		["279"] = 283,
		["280"] = 283,
		["281"] = 283,
		["282"] = 283,
		["283"] = 272,
		["284"] = 292,
		["285"] = 293,
		["286"] = 294,
		["287"] = 295,
		["290"] = 298,
		["291"] = 299,
		["292"] = 299,
		["293"] = 299,
		["294"] = 299,
		["295"] = 299,
		["296"] = 299,
		["298"] = 292,
		["299"] = 303,
		["300"] = 304,
		["301"] = 305,
		["302"] = 305,
		["303"] = 305,
		["304"] = 306,
		["305"] = 305,
		["306"] = 305,
		["307"] = 308,
		["308"] = 309,
		["309"] = 310,
		["311"] = 303,
		["312"] = 313,
		["313"] = 314,
		["314"] = 313,
		["315"] = 320,
		["316"] = 321,
		["317"] = 322,
		["319"] = 320,
		["320"] = 330,
		["321"] = 331,
		["322"] = 332,
		["325"] = 337,
		["328"] = 342,
		["329"] = 343,
		["330"] = 344,
		["331"] = 345,
		["332"] = 346,
		["333"] = 349,
		["334"] = 350,
		["336"] = 354,
		["337"] = 369,
		["338"] = 370,
		["340"] = 372,
		["341"] = 373,
		["342"] = 374,
		["345"] = 330,
		["346"] = 378,
		["347"] = 380,
		["350"] = 383,
		["351"] = 378,
		["352"] = 386,
		["353"] = 387,
		["354"] = 388,
		["355"] = 389,
		["357"] = 392,
		["358"] = 386,
		["359"] = 395,
		["360"] = 396,
		["361"] = 396,
		["362"] = 396,
		["363"] = 396,
		["364"] = 396,
		["365"] = 396,
		["366"] = 402,
		["367"] = 403,
		["368"] = 404,
		["369"] = 405,
		["370"] = 405,
		["371"] = 405,
		["372"] = 405,
		["373"] = 405,
		["374"] = 406,
		["375"] = 406,
		["376"] = 406,
		["377"] = 406,
		["378"] = 406,
		["379"] = 406,
		["380"] = 406,
		["381"] = 406,
		["382"] = 406,
		["383"] = 407,
		["384"] = 407,
		["385"] = 407,
		["386"] = 407,
		["387"] = 407,
		["388"] = 408,
		["389"] = 396,
		["390"] = 396,
		["391"] = 396,
		["392"] = 412,
		["393"] = 413,
		["394"] = 414,
		["395"] = 415,
		["396"] = 395,
		["397"] = 205,
		["398"] = 197,
		["399"] = 197,
		["400"] = 197,
		["401"] = 197,
		["402"] = 197,
		["403"] = 197,
		["404"] = 197,
		["405"] = 197,
		["406"] = 205,
		["408"] = 205,
		["409"] = 419,
		["410"] = 427,
		["411"] = 419,
		["412"] = 427,
		["413"] = 429,
		["414"] = 430,
		["415"] = 429,
		["416"] = 433,
		["417"] = 434,
		["418"] = 433,
		["419"] = 437,
		["420"] = 438,
		["421"] = 437,
		["422"] = 427,
		["423"] = 419,
		["424"] = 419,
		["425"] = 419,
		["426"] = 419,
		["427"] = 419,
		["428"] = 419,
		["429"] = 419,
		["430"] = 419,
		["431"] = 427,
		["433"] = 427,
		["434"] = 443,
		["435"] = 444,
		["436"] = 443,
		["437"] = 444,
		["438"] = 445,
		["439"] = 446,
		["440"] = 447,
		["441"] = 448,
		["442"] = 449,
		["443"] = 449,
		["444"] = 449,
		["445"] = 450,
		["448"] = 452,
		["449"] = 453,
		["450"] = 454,
		["451"] = 455,
		["452"] = 456,
		["453"] = 457,
		["454"] = 458,
		["457"] = 461,
		["458"] = 462,
		["459"] = 463,
		["462"] = 466,
		["463"] = 469,
		["464"] = 449,
		["465"] = 449,
		["466"] = 445,
		["467"] = 474,
		["468"] = 475,
		["469"] = 476,
		["470"] = 477,
		["473"] = 478,
		["474"] = 479,
		["475"] = 480,
		["476"] = 480,
		["477"] = 480,
		["478"] = 480,
		["479"] = 480,
		["480"] = 481,
		["481"] = 482,
		["482"] = 482,
		["483"] = 482,
		["484"] = 482,
		["485"] = 483,
		["486"] = 474,
		["487"] = 444,
		["488"] = 443,
		["489"] = 444,
		["491"] = 444,
		["493"] = 488,
		["494"] = 497,
		["495"] = 488,
		["496"] = 497,
		["497"] = 500,
		["498"] = 501,
		["499"] = 502,
		["500"] = 500,
		["501"] = 504,
		["502"] = 505,
		["503"] = 506,
		["504"] = 507,
		["505"] = 508,
		["506"] = 508,
		["507"] = 508,
		["508"] = 508,
		["509"] = 508,
		["510"] = 509,
		["511"] = 509,
		["512"] = 509,
		["513"] = 509,
		["514"] = 509,
		["515"] = 510,
		["516"] = 510,
		["517"] = 510,
		["518"] = 510,
		["519"] = 510,
		["520"] = 511,
		["521"] = 511,
		["522"] = 511,
		["523"] = 511,
		["524"] = 511,
		["525"] = 511,
		["526"] = 511,
		["527"] = 511,
		["529"] = 513,
		["530"] = 514,
		["532"] = 504,
		["533"] = 517,
		["534"] = 518,
		["535"] = 519,
		["536"] = 520,
		["537"] = 520,
		["538"] = 520,
		["539"] = 520,
		["540"] = 520,
		["543"] = 517,
		["544"] = 524,
		["545"] = 525,
		["546"] = 524,
		["547"] = 497,
		["548"] = 488,
		["549"] = 488,
		["550"] = 488,
		["551"] = 488,
		["552"] = 488,
		["553"] = 488,
		["554"] = 488,
		["555"] = 488,
		["556"] = 488,
		["557"] = 497,
		["559"] = 497,
		["561"] = 530,
		["562"] = 541,
		["563"] = 530,
		["564"] = 541,
		["565"] = 541,
		["566"] = 530,
		["567"] = 530,
		["568"] = 530,
		["569"] = 530,
		["570"] = 530,
		["571"] = 530,
		["572"] = 530,
		["573"] = 530,
		["574"] = 530,
		["575"] = 530,
		["576"] = 530,
		["577"] = 541,
		["579"] = 541,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
local q = require("abilities.ability_ai")
local r = q.BaseAbilityAI
local s = q.registerAbilityAI
j.luna_talent = c()
local t = j.luna_talent
t.name = "luna_talent"
d(t, l)
function t.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.sect_attack_lv = 0
end
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_luna_talent"
end
function t.prototype.UpdateSectAttackLv(self)
	self.sect_attack_lv = PlayerData:getHero(self:GetCaster():GetPlayerOwnerID()):getSectLevel("sect_attack")
end
t = e({ m(nil) }, t)
j.luna_talent = t
j.modifier_luna_talent = c()
local u = j.modifier_luna_talent
u.name = "modifier_luna_talent"
d(u, o)
function u.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.collection_cnt = 0
	self.groupMoonDamage = 0
end
function u.prototype.GetAbilitySpecialValue(self)
	self.trigger_cnt = self:GetAbilitySpecialValueFor("trigger_cnt")
		+ self:GetAbilityTalentValue("luna_talent_1", "max_count")
	self.collect_count = self:GetAbilitySpecialValueFor("collect_count")
		+ self:GetAbilityTalentValue("luna_talent_1", "count")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.max_rebound_cnt = self:GetAbilitySpecialValueFor("max_rebound_cnt")
	self.collection_pct = self:GetAbilitySpecialValueFor("collection_pct")
		+ self:GetAbilityTalentValue("luna_talent_9", "add_rebound_collection_pct")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.t2_add_damage = self:GetAbilityTalentValue("luna_talent_2", "add_damage")
	self.t7_attack_speed = self:GetAbilityTalentValue("luna_talent_7", "attack_speed")
	self.base_crit = self:GetAbilityTalentValue("luna_talent_12", "base_crit")
	self.crit = self:GetAbilityTalentValue("luna_talent_12", "crit")
	self.s_incoming_duration = self:GetAbilityTalentValue("luna_shard", "incoming_duration")
	self.ult_Recycle_chance = self:GetAbilityTalentValue("luna_ult", "recycle_chance")
	self.ult_extra_damage = self:GetAbilityTalentValue("luna_ult", "damage")
end
function u.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function u.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE }
end
function u.prototype.EOM_GetModifierAttackSpeedTotalPercentage(self, v)
	return self.t7_attack_speed
end
function u.prototype.OnBattleStart(self, v)
	if self.s_incoming_duration > 0 then
		self.caster:AddNewModifier(
			self.caster,
			self:GetAbility(),
			"modifier_luna_talent_ringmoon",
			{ moon_cnt = self.trigger_cnt }
		)
		self.caster:AddNewModifier(
			self.caster,
			self:GetAbility(),
			"modifier_luna_talent_ringmoon_buf",
			{ duration = self.s_incoming_duration }
		)
	end
end
function u.prototype.OnCustomAttackLanded(self, w)
	local x = self:GetParent()
	local y = x:GetEnemy()
	if bit.band(w.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION then
		local z = self:GetAbilityTalentValue("luna_talent_12", "count")
		self:OnMoonGlaive(self.max_rebound_cnt + z, y, x)
	end
end
function u.prototype.OnMoonGlaive(self, A, B, C)
	if A > 0 and IsValid(self) then
		local x = self:GetParent()
		local y = x:GetEnemy()
		if IsInjurable(x, y) then
			x:EmitSound("Hero_Luna.MoonGlaive.Impact", y:GetAbsOrigin())
			if B == x then
				local D = GetAttackDamage(x) * self.damage_pct * 0.01 * (self.t2_add_damage * 0.01 + 1)
				Projectile:CreateTrackingProjectile({
					hCaster = x,
					hTarget = y,
					sEffectName = x:GetRangedProjectileName(),
					iMoveSpeed = KeyValues:GetUnitData(x, "ProjectileSpeed") + 300,
					OnProjectileHit = function(E, F, G)
						self:OnMoonGlaive(A - 1, y, x)
						if IsValid(self) and IsValid(self.ability) then
							if self.base_crit > 0 then
								x:DealDamage(
									y,
									self.ability,
									D * (self.base_crit + GetPhysicalCriticalChance(self.parent) * self.crit * 0.01),
									EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
									DamageFlags.DAMAGE_FLAG_REFLECTION
										+ DamageFlags.DAMAGE_FLAG_HPLOSS
										+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
								)
							else
								x:DealDamage(
									y,
									self.ability,
									D,
									EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
									DamageFlags.DAMAGE_FLAG_REFLECTION
								)
							end
							if self.parent:HasModifier("modifier_luna_ult_buff") then
								local H = self.parent:FindAbilityByName("luna_ult")
								if IsValid(H) then
									GameTimer(0.03, function()
										if IsValid(H) then
											H:LucentBeam()
										end
									end)
								end
							end
						end
					end,
				})
			else
				self:RecycleBlade()
				Projectile:CreateTrackingProjectile({
					hCaster = x,
					vSpawnOrigin = y:GetAttachmentPosition("attach_hitloc"),
					hTarget = x,
					sEffectName = x:GetRangedProjectileName(),
					iMoveSpeed = KeyValues:GetUnitData(x, "ProjectileSpeed") + 300,
					OnProjectileHit = function(E, F, G)
						self:OnMoonGlaive(A, x, y)
					end,
				})
			end
		end
	end
end
function u.prototype.RecycleBlade(self, A, I)
	if A == nil then
		A = self.collect_count
	end
	if I == nil then
		I = false
	end
	local J = 0
	if self.parent:HasModifier("modifier_luna_ult_buff") then
		J = J + self.ult_Recycle_chance
	end
	if
		not self.caster:HasModifier("modifier_luna_talent_ringmoon")
		and (I or self:PRD(self.collection_pct + J, "luna_talent_coolection"))
	then
		self.collection_cnt = self.collection_cnt + A
		if self.collection_cnt >= self.trigger_cnt then
			self.collection_cnt = 0
			self.caster:AddNewModifier(
				self.caster,
				self:GetAbility(),
				"modifier_luna_talent_ringmoon",
				{ moon_cnt = self.trigger_cnt }
			)
		else
			self:SetStackCount(self.collection_cnt)
		end
	end
end
u = e(
	{
		p(
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
	u
)
j.modifier_luna_talent = u
j.modifier_luna_talent_ringmoon = c()
local K = j.modifier_luna_talent_ringmoon
K.name = "modifier_luna_talent_ringmoon"
d(K, o)
function K.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.moon_cnt = 0
end
function K.prototype.GetAbilitySpecialValue(self)
	self.t3_attack_mul = self:GetAbilityTalentValue("luna_talent_3", "attack_mul")
	self.t3_interval = self:GetAbilityTalentValue("luna_talent_3", "interval")
	self.t3_damage = self:GetAbilityTalentValue("luna_talent_3", "attack")
	self.t9_extra_blade_dmg_pct = self:GetAbilityTalentValue("luna_talent_9", "extra_blade_dmg_pct")
	self.s_incoming_duration = self:GetAbilityTalentValue("luna_shard", "incoming_duration")
end
function K.prototype.OnCreated(self, v)
	if IsServer() then
		self.projList = {}
		self.GroupName = "luna_" .. tostring(self.ability:entindex())
		self.moonAbility = self.parent:FindAbilityByName("luna_ringmoon")
		if self.t3_interval > 0 then
			self:StartIntervalThink(self.t3_interval)
		end
		if self.s_incoming_duration > 0 then
			self.caster:AddNewModifier(
				self.caster,
				self:GetAbility(),
				"modifier_luna_talent_ringmoon_buf",
				{ duration = self.s_incoming_duration }
			)
		end
		self:AddBladeCount(v.moon_cnt)
	end
end
function K.prototype.OnRefresh(self, v)
	if IsServer() then
		if self.s_incoming_duration > 0 then
			self.caster:AddNewModifier(
				self.caster,
				self:GetAbility(),
				"modifier_luna_talent_ringmoon_buf",
				{ duration = self.s_incoming_duration }
			)
		end
		self:AddBladeCount(v.moon_cnt)
	end
end
function K.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent },
	}
end
function K.prototype.OnBattleEnd(self, v)
	self.parent:RemoveModifierByName("modifier_luna_talent_ringmoon")
end
function K.prototype.fireOrb(self, L, y, M)
	if M == nil then
		M = self:GetAbility()
	end
	if not IsInjurable(self:GetParent(), y) then
		return
	end
	if not IsValid(M) then
		M = self:GetAbility()
	end
	if not IsValid(M) then
		return
	end
	local x = self:GetParent()
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_luna/base_attack.vpcf",
		hCaster = x,
		vSpawnOrigin = L,
		hTarget = y,
		iMoveSpeed = 2000,
	})
end
function K.prototype.OnIntervalThink(self)
	if IsServer() then
		local N = self.parent:GetEnemy()
		if not IsInjurable(self.parent, N) then
			return
		end
		local H = self.parent:FindAbilityByName("luna_ringmoon")
		self.parent:DealDamage(
			N,
			H,
			self.t3_attack_mul * GetAttackDamage(self.parent),
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		)
	end
end
function K.prototype.OnDestroy(self)
	if IsServer() then
		f(self.projList, function(O, P)
			Projectile:DestroyProjectile(P)
		end)
		self.projList = {}
		local Q = self.parent:FindModifierByName("modifier_luna_talent")
		Q:SetStackCount(0)
	end
end
function K.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
	}
end
function K.prototype.EOM_GetModifierAttackSourceAbility(self, v)
	if
		v.ability_upgrade == nil
		and self.moon_cnt >= BUFF_VALUE.RingMoonCollectionExpend
		and self.t9_extra_blade_dmg_pct > 0
	then
		return self.moonAbility
	end
end
function K.prototype.OnCustomAttackLanded(self, w)
	if self.moon_cnt < BUFF_VALUE.RingMoonCollectionExpend then
		self:Destroy()
		return
	end
	if
		w.damage_flags
		and bit.band(w.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) == DamageFlags.DAMAGE_FLAG_REFLECTION
	then
		return
	end
	if #self.projList > 0 then
		local R = RandomInt(0, #self.projList - 1)
		local S = self.projList[R + 1]
		local T = Projectile:getProjectileInfo(S)
		self:fireOrb(T._vPosition, w.target)
		g(self.projList, R, 1)
		Projectile:DestroyPartOfSurroundProjectile({ S })
	end
	self.moon_cnt = self.moon_cnt - BUFF_VALUE.RingMoonCollectionExpend
	if self.moon_cnt <= 0 then
		self:Destroy()
	else
		local Q = self.parent:FindModifierByName("modifier_luna_talent")
		if Q then
			Q:SetStackCount(self.moon_cnt)
		end
	end
end
function K.prototype.EOM_GetModifierProcAttackDamagePercentage(self, v)
	if not v.ability or v.ability ~= self.moonAbility then
		return
	end
	return self.t9_extra_blade_dmg_pct
end
function K.prototype.EOM_GetModifierAttackDamageBonus(self, v)
	if IsServer() then
		local U = self.caster:GetPlayerOwnerID()
		self:SetStackCount(PlayerData:getHeroLevel(U))
	end
	return BUFF_VALUE.RingMoonConstantAtk + self:GetStackCount() * (BUFF_VALUE.RingMoonLevelAtkMul + self.t3_damage)
end
function K.prototype.AddBladeCount(self, A)
	local V = Projectile:CreateGroupSurroundProjectile({
		hCaster = self.parent,
		sGroupName = "luna" .. tostring(self:GetAbility():entindex()),
		flCircleRadius = 240,
		flAngularVelocity = 180,
		flOffset = 72,
		OnProjectileCreated = function(W)
			local X = W
			local Y = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_luna/surrounder_blade.vpcf",
				PATTACH_CUSTOMORIGIN,
				X._hThinker
			)
			ParticleManager:SetParticleControl(Y, 0, X._hThinker:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt(
				Y,
				1,
				X._hThinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				X._hThinker:GetAbsOrigin(),
				false
			)
			ParticleManager:SetParticleControl(Y, 2, Vector(0, 0, 1))
			X._iParticleID = Y
		end,
		iCount = A,
	})
	self.projList = h(self.projList, V)
	self.moon_cnt = self.moon_cnt + A
	local Q = self.parent:FindModifierByName("modifier_luna_talent")
	Q:SetStackCount(self.moon_cnt)
end
K = e(
	{
		p(
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
	K
)
j.modifier_luna_talent_ringmoon = K
j.modifier_luna_talent_ringmoon_buf = c()
local Z = j.modifier_luna_talent_ringmoon_buf
Z.name = "modifier_luna_talent_ringmoon_buf"
d(Z, o)
function Z.prototype.GetAbilitySpecialValue(self)
	self.s_incming_pct = self:GetAbilityTalentValue("luna_shard", "incming_pct")
end
function Z.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function Z.prototype.EOM_GetModifierIncomingDamagePercentage(self, v)
	return -self.s_incming_pct
end
Z = e(
	{
		p(
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
	Z
)
j.modifier_luna_talent_ringmoon_buf = Z
j.luna_ult = c()
local _ = j.luna_ult
_.name = "luna_ult"
d(_, r)
function _.prototype.OnSpellStart(self)
	local a0 = self:GetCaster()
	local N = a0:GetEnemy()
	a0:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	self:GameTimer(0.5, function()
		if not IsInjurable(a0, N) then
			return
		end
		local A = 0
		local a1 = self:GetSpecialValueFor("duration")
		a0:EmitSound("Hero_Luna.Eclipse.Cast")
		if a0:HasModifier("modifier_luna_talent_ringmoon") then
			local a2 = a0:FindModifierByName("modifier_luna_talent_ringmoon")
			if a2 then
				a2:AddBladeCount(A)
			end
		else
			local a3 = a0:FindModifierByName("modifier_luna_talent")
			if a3 then
				a3:RecycleBlade(A, true)
			end
		end
		a0:AddNewModifier(a0, self, "modifier_luna_ult_buff", { duration = a1 })
		a0:AddNewModifier(a0, self, "modifier_luna_ult_buff_particle", { duration = a1 })
	end)
end
function _.prototype.LucentBeam(self)
	local a0 = self:GetCaster()
	local N = a0:GetEnemy()
	if not IsInjurable(a0, N) then
		return
	end
	local D = self:GetSpecialValueFor("damage")
	local Y = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_luna/luna_eclipse_impact_notarget.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil,
		a0
	)
	ParticleManager:SetParticleControl(Y, 1, N:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(Y)
	a0:EmitSound("Hero_Luna.LucentBeam.Target", N:GetAbsOrigin())
	a0:DealDamage(N, self, D, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
_ = e({ s(nil) }, _)
j.luna_ult = _
j.modifier_luna_ult_buff = c()
local a4 = j.modifier_luna_ult_buff
a4.name = "modifier_luna_ult_buff"
d(a4, o)
function a4.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilityTalentValue("luna_ult", "interval")
	self.count = self:GetAbilityTalentValue("luna_ult", "count")
end
function a4.prototype.OnCreated(self, v)
	if IsClient() then
		local x = self:GetParent()
		local Y = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_luna/luna_eclipse.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			x
		)
		ParticleManager:SetParticleControl(Y, 0, x:GetAbsOrigin())
		ParticleManager:SetParticleControl(Y, 1, Vector(400, 400, 400))
		ParticleManager:SetParticleControl(Y, 2, x:GetAbsOrigin())
		self:AddParticle(Y, false, false, -1, false, false)
	end
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function a4.prototype.StartIntervalThink(self, a5)
	if IsServer() then
		if self.parent:FindModifierByName("modifier_luna_talent") then
			self.parent
				:FindModifierByName("modifier_luna_talent")
				:OnMoonGlaive(self.count, self.parent, self.parent:GetEnemy())
		end
	end
end
function a4.prototype.OnDestroy(self)
	self:StartIntervalThink(-1)
end
a4 = e(
	{
		p(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	a4
)
j.modifier_luna_ult_buff = a4
j.modifier_luna_ult_buff_particle = c()
local a6 = j.modifier_luna_ult_buff_particle
a6.name = "modifier_luna_ult_buff_particle"
d(a6, o)
a6 = e(
	{
		p(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_luna/luna_shard_marked_moon_overhead.vpcf",
				GetEffectAttachType = PATTACH_OVERHEAD_FOLLOW,
				ShouldUseOverheadOffset = true,
			}
		),
	},
	a6
)
j.modifier_luna_ult_buff_particle = a6
return j