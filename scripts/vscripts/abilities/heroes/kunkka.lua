--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/kunkka"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__ArrayFilter
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["19"] = 5,
		["20"] = 6,
		["21"] = 5,
		["22"] = 6,
		["23"] = 7,
		["24"] = 8,
		["25"] = 7,
		["26"] = 6,
		["27"] = 5,
		["28"] = 6,
		["30"] = 6,
		["31"] = 12,
		["32"] = 20,
		["33"] = 12,
		["34"] = 20,
		["35"] = 33,
		["36"] = 34,
		["37"] = 35,
		["38"] = 37,
		["39"] = 39,
		["40"] = 40,
		["41"] = 41,
		["42"] = 43,
		["43"] = 44,
		["44"] = 45,
		["46"] = 33,
		["47"] = 57,
		["48"] = 58,
		["49"] = 57,
		["50"] = 63,
		["51"] = 64,
		["52"] = 65,
		["53"] = 66,
		["56"] = 63,
		["57"] = 70,
		["58"] = 71,
		["59"] = 71,
		["60"] = 73,
		["61"] = 73,
		["62"] = 73,
		["63"] = 71,
		["64"] = 74,
		["65"] = 74,
		["66"] = 74,
		["67"] = 71,
		["68"] = 71,
		["69"] = 70,
		["70"] = 77,
		["71"] = 78,
		["72"] = 79,
		["73"] = 80,
		["74"] = 77,
		["75"] = 93,
		["76"] = 94,
		["79"] = 95,
		["80"] = 96,
		["81"] = 96,
		["82"] = 96,
		["83"] = 96,
		["85"] = 99,
		["86"] = 100,
		["87"] = 101,
		["90"] = 104,
		["91"] = 105,
		["92"] = 105,
		["93"] = 105,
		["94"] = 105,
		["95"] = 105,
		["96"] = 105,
		["98"] = 93,
		["99"] = 108,
		["100"] = 109,
		["101"] = 111,
		["102"] = 112,
		["103"] = 114,
		["104"] = 115,
		["106"] = 118,
		["107"] = 119,
		["109"] = 121,
		["110"] = 122,
		["111"] = 123,
		["112"] = 123,
		["113"] = 123,
		["114"] = 123,
		["115"] = 123,
		["116"] = 123,
		["121"] = 128,
		["122"] = 129,
		["125"] = 132,
		["126"] = 133,
		["127"] = 134,
		["128"] = 135,
		["129"] = 136,
		["130"] = 136,
		["131"] = 136,
		["132"] = 136,
		["133"] = 136,
		["134"] = 136,
		["136"] = 147,
		["137"] = 148,
		["138"] = 108,
		["139"] = 150,
		["140"] = 165,
		["141"] = 166,
		["142"] = 167,
		["143"] = 169,
		["144"] = 170,
		["145"] = 171,
		["147"] = 173,
		["148"] = 174,
		["151"] = 150,
		["152"] = 179,
		["153"] = 180,
		["154"] = 181,
		["155"] = 182,
		["156"] = 183,
		["158"] = 179,
		["159"] = 20,
		["160"] = 12,
		["161"] = 12,
		["162"] = 12,
		["163"] = 12,
		["164"] = 12,
		["165"] = 12,
		["166"] = 12,
		["167"] = 12,
		["168"] = 20,
		["170"] = 20,
		["171"] = 187,
		["172"] = 195,
		["173"] = 187,
		["174"] = 195,
		["175"] = 198,
		["176"] = 199,
		["177"] = 200,
		["178"] = 198,
		["179"] = 202,
		["180"] = 203,
		["181"] = 204,
		["182"] = 205,
		["183"] = 206,
		["184"] = 206,
		["185"] = 206,
		["186"] = 206,
		["187"] = 206,
		["188"] = 206,
		["189"] = 206,
		["190"] = 206,
		["191"] = 206,
		["192"] = 207,
		["193"] = 207,
		["194"] = 207,
		["195"] = 207,
		["196"] = 207,
		["197"] = 207,
		["198"] = 207,
		["199"] = 207,
		["200"] = 207,
		["201"] = 208,
		["202"] = 208,
		["203"] = 208,
		["204"] = 208,
		["205"] = 208,
		["206"] = 208,
		["207"] = 208,
		["208"] = 208,
		["209"] = 208,
		["210"] = 209,
		["211"] = 209,
		["212"] = 209,
		["213"] = 209,
		["214"] = 209,
		["215"] = 209,
		["216"] = 209,
		["217"] = 209,
		["219"] = 211,
		["221"] = 202,
		["222"] = 214,
		["223"] = 215,
		["224"] = 214,
		["225"] = 220,
		["226"] = 221,
		["227"] = 220,
		["228"] = 223,
		["229"] = 224,
		["230"] = 223,
		["231"] = 195,
		["232"] = 187,
		["233"] = 187,
		["234"] = 187,
		["235"] = 187,
		["236"] = 187,
		["237"] = 187,
		["238"] = 187,
		["239"] = 187,
		["240"] = 195,
		["242"] = 195,
		["243"] = 230,
		["244"] = 231,
		["245"] = 230,
		["246"] = 231,
		["247"] = 232,
		["248"] = 233,
		["249"] = 234,
		["250"] = 235,
		["253"] = 238,
		["254"] = 240,
		["255"] = 241,
		["256"] = 242,
		["257"] = 243,
		["258"] = 244,
		["259"] = 245,
		["260"] = 246,
		["261"] = 246,
		["262"] = 246,
		["263"] = 247,
		["264"] = 248,
		["265"] = 249,
		["266"] = 250,
		["267"] = 251,
		["268"] = 252,
		["269"] = 253,
		["271"] = 256,
		["272"] = 257,
		["274"] = 246,
		["275"] = 246,
		["276"] = 260,
		["277"] = 261,
		["278"] = 262,
		["279"] = 232,
		["280"] = 231,
		["281"] = 230,
		["282"] = 231,
		["284"] = 231,
		["285"] = 268,
		["286"] = 276,
		["287"] = 268,
		["288"] = 276,
		["289"] = 281,
		["290"] = 282,
		["291"] = 281,
		["292"] = 284,
		["293"] = 285,
		["294"] = 286,
		["295"] = 287,
		["296"] = 287,
		["297"] = 287,
		["298"] = 288,
		["299"] = 289,
		["301"] = 287,
		["302"] = 287,
		["304"] = 284,
		["305"] = 294,
		["306"] = 295,
		["309"] = 296,
		["312"] = 297,
		["313"] = 298,
		["314"] = 299,
		["315"] = 300,
		["317"] = 300,
		["319"] = 301,
		["321"] = 303,
		["322"] = 303,
		["323"] = 303,
		["324"] = 303,
		["325"] = 303,
		["326"] = 303,
		["328"] = 294,
		["329"] = 276,
		["330"] = 268,
		["331"] = 268,
		["332"] = 268,
		["333"] = 268,
		["334"] = 268,
		["335"] = 268,
		["336"] = 268,
		["337"] = 268,
		["338"] = 276,
		["340"] = 276,
		["341"] = 311,
		["342"] = 319,
		["343"] = 311,
		["344"] = 319,
		["345"] = 324,
		["346"] = 325,
		["347"] = 324,
		["348"] = 327,
		["349"] = 328,
		["350"] = 329,
		["351"] = 330,
		["352"] = 330,
		["353"] = 330,
		["354"] = 331,
		["355"] = 332,
		["357"] = 330,
		["358"] = 330,
		["360"] = 327,
		["361"] = 337,
		["362"] = 338,
		["365"] = 339,
		["366"] = 340,
		["367"] = 341,
		["368"] = 342,
		["369"] = 343,
		["371"] = 345,
		["372"] = 345,
		["373"] = 345,
		["374"] = 345,
		["375"] = 345,
		["376"] = 345,
		["378"] = 337,
		["379"] = 319,
		["380"] = 311,
		["381"] = 311,
		["382"] = 311,
		["383"] = 311,
		["384"] = 311,
		["385"] = 311,
		["386"] = 311,
		["387"] = 311,
		["388"] = 319,
		["390"] = 319,
		["391"] = 353,
		["392"] = 361,
		["393"] = 353,
		["394"] = 361,
		["395"] = 375,
		["396"] = 376,
		["397"] = 377,
		["398"] = 378,
		["399"] = 375,
		["400"] = 380,
		["401"] = 381,
		["402"] = 382,
		["403"] = 383,
		["404"] = 384,
		["405"] = 385,
		["406"] = 386,
		["407"] = 387,
		["409"] = 389,
		["411"] = 380,
		["412"] = 392,
		["413"] = 393,
		["414"] = 394,
		["415"] = 395,
		["417"] = 392,
		["418"] = 398,
		["419"] = 399,
		["420"] = 400,
		["421"] = 401,
		["422"] = 402,
		["423"] = 403,
		["424"] = 403,
		["425"] = 403,
		["426"] = 403,
		["427"] = 403,
		["428"] = 403,
		["429"] = 404,
		["430"] = 405,
		["431"] = 405,
		["432"] = 405,
		["433"] = 405,
		["434"] = 405,
		["435"] = 406,
		["436"] = 407,
		["437"] = 407,
		["438"] = 407,
		["439"] = 407,
		["440"] = 407,
		["443"] = 398,
		["444"] = 411,
		["445"] = 412,
		["446"] = 413,
		["447"] = 414,
		["450"] = 418,
		["451"] = 419,
		["452"] = 419,
		["454"] = 425,
		["455"] = 426,
		["458"] = 429,
		["461"] = 433,
		["462"] = 434,
		["463"] = 435,
		["464"] = 436,
		["465"] = 436,
		["466"] = 436,
		["467"] = 437,
		["468"] = 438,
		["469"] = 439,
		["470"] = 440,
		["471"] = 441,
		["472"] = 442,
		["474"] = 436,
		["475"] = 436,
		["476"] = 445,
		["477"] = 447,
		["478"] = 447,
		["479"] = 447,
		["480"] = 447,
		["481"] = 448,
		["482"] = 448,
		["483"] = 448,
		["484"] = 448,
		["485"] = 448,
		["486"] = 448,
		["487"] = 448,
		["488"] = 448,
		["489"] = 411,
		["490"] = 450,
		["491"] = 451,
		["492"] = 452,
		["493"] = 450,
		["494"] = 459,
		["495"] = 460,
		["496"] = 459,
		["497"] = 361,
		["498"] = 353,
		["499"] = 353,
		["500"] = 353,
		["501"] = 353,
		["502"] = 353,
		["503"] = 353,
		["504"] = 353,
		["505"] = 353,
		["506"] = 361,
		["508"] = 361,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
local p = require("abilities.ability_ai")
local q = p.BaseAbilityAI
local r = p.registerAbilityAI
i.kunkka_talent = c()
local s = i.kunkka_talent
s.name = "kunkka_talent"
d(s, k)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_kunkka_talent"
end
s = e({ l(nil) }, s)
i.kunkka_talent = s
i.modifier_kunkka_talent = c()
local t = i.modifier_kunkka_talent
t.name = "modifier_kunkka_talent"
d(t, n)
function t.prototype.GetAbilitySpecialValue(self)
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
		- self:GetAbilityTalentValue("kunkka_talent_5", "cooldown_reduce")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
		+ self:GetAbilityTalentValue("kunkka_talent_8", "bonus_damage")
	self.bonus_damage_pct = self:GetAbilitySpecialValueFor("bonus_damage_pct")
	self.talent_7_damage_pct = self:GetAbilityTalentValue("kunkka_talent_7", "damage_pct")
	self.talent_3_rum_up = self:GetAbilityTalentValue("kunkka_talent_3", "rum_up")
	self.talent_1_reduce_interval = self:GetAbilityTalentValue("kunkka_talent_1", "reduce_interval")
	self.s_interval = self:GetAbilityTalentValue("kunkka_shard", "interval")
	if IsServer() then
		self.cooldown_remain = 0
	end
end
function t.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY,
	}
end
function t.prototype.EOM_GetModifierProcAttackDamageBonus(self, u)
	if IsServer() then
		if self.enable and IsValid(u.ability) and u.ability == self:GetAbility() then
			return self.bonus_damage + self:GetParent():GetHealthDeficit() * self.bonus_damage_pct * 0.01
		end
	end
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function t.prototype.OnBattleStart(self, u)
	self.enable = false
	self:StartIntervalThink(0)
	self.cooldown_remain = self.cooldown
end
function t.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if self.cooldown_remain > 0 then
		self.cooldown_remain = math.max(0, self.cooldown_remain - FrameTime())
	end
	if
		self.cooldown_remain <= 0 and not (self.enable and self:GetParent():HasModifier("modifier_kunkka_talent_buff"))
	then
		if self:GetCaster():PassivesDisabled() then
			self.cooldown_remain = self.cooldown
			return
		end
		local v = self:GetParent()
		v:AddNewModifier(v, self:GetAbility(), "modifier_kunkka_talent_buff", {})
	end
end
function t.prototype.OnCustomAttackLanded(self, w)
	local v = self:GetParent()
	if not (self.enable and v:HasModifier("modifier_kunkka_talent_buff")) then
		if self.cooldown_remain > 0 then
			if self.s_interval > 0 then
				self.cooldown_remain = self.cooldown_remain - self.s_interval
			end
			if self.talent_1_reduce_interval > 0 then
				self.cooldown_remain = self.cooldown_remain - -self.talent_1_reduce_interval
			end
			if self.cooldown_remain <= 0 then
				local v = self:GetParent()
				v:AddNewModifier(v, self:GetAbility(), "modifier_kunkka_talent_buff", {})
			end
		end
		return
	end
	local x = w.target
	if not IsInjurable(v, x) then
		return
	end
	v:RemoveModifierByName("modifier_kunkka_talent_buff")
	self.enable = false
	self.cooldown_remain = self.cooldown
	if self.talent_7_damage_pct > 0 then
		self:GetParent():DealDamage(
			self:GetParent():GetEnemy(),
			self:GetAbility(),
			self:GetParent():GetMaxHealth() * self.talent_7_damage_pct * 0.01,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		)
	end
	x:EmitSound("Hero_Kunkka.TidebringerDamage")
	v:EmitSound("Hero_Kunkka.Tidebringer.Attack")
end
function t.prototype.OnCustomTakeDamage(self, w)
	if self.talent_3_rum_up > 0 then
		local v = self:GetParent()
		if v:GetHealthPercent() <= self.talent_3_rum_up then
			local y = v:FindAbilityByName("kunkka_ult")
			if IsValid(y) then
				v:AddNewModifier(v, y, "modifier_kunkka_ult_damage_record", {})
			end
		elseif v:HasModifier("modifier_kunkka_ult_damage_record") then
			v:RemoveModifierByName("modifier_kunkka_ult_damage_record")
		end
	end
end
function t.prototype.EOM_GetModifierAttackSourceAbility(self, u)
	local v = self:GetParent()
	if not self.enable and v:HasModifier("modifier_kunkka_talent_buff") then
		self.enable = true
		return self:GetAbility()
	end
end
t = e(
	{
		o(
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
	t
)
i.modifier_kunkka_talent = t
i.modifier_kunkka_talent_buff = c()
local z = i.modifier_kunkka_talent_buff
z.name = "modifier_kunkka_talent_buff"
d(z, n)
function z.prototype.GetAbilitySpecialValue(self)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_damage_pct = self:GetAbilitySpecialValueFor("bonus_damage_pct")
end
function z.prototype.OnCreated(self, u)
	local v = self:GetParent()
	if IsClient() then
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kunkka/kunkka_weapon_tidebringer.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			v
		)
		ParticleManager:SetParticleControlEnt(
			A,
			0,
			v,
			PATTACH_POINT_FOLLOW,
			"attach_tidebringer",
			v:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			A,
			1,
			v,
			PATTACH_POINT_FOLLOW,
			"attach_tidebringer_2",
			v:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(A, 2, v, PATTACH_POINT_FOLLOW, "attach_sword", v:GetAbsOrigin(), true)
		self:AddParticle(A, false, false, -1, false, false)
	else
		v:EmitSound("Hero_Kunkaa.Tidebringer")
	end
end
function z.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function z.prototype.GetActivityTranslationModifiers(self)
	return "tidebringer"
end
function z.prototype.GetAttackSound(self)
	return "Hero_Kunkka.Tidebringer.Attack"
end
z = e(
	{
		o(
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
	z
)
i.modifier_kunkka_talent_buff = z
i.kunkka_ult = c()
local B = i.kunkka_ult
B.name = "kunkka_ult"
d(B, q)
function B.prototype.OnSpellStart(self)
	local C = self:GetCaster()
	local x = C:GetEnemy()
	if not IsInjurable(x, C) then
		return
	end
	local D = self:GetSpecialValueFor("duration")
	local E = self:GetSpecialValueFor("damage_pct") + self:GetTalentValue("kunkka_talent_2", "rum_damage_pct")
	local F = (x:GetAbsOrigin() - C:GetAbsOrigin()):Normalized()
	local G = x:GetAbsOrigin() + F * -400 * D
	local A = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_kunkka/kunkka_ghost_ship.vpcf",
		PATTACH_CUSTOMORIGIN,
		C
	)
	ParticleManager:SetParticleControl(A, 0, G)
	ParticleManager:SetParticleControl(A, 1, F * 400)
	GameTimer(D, function()
		ParticleManager:DestroyParticle(A, false)
		if IsInjurable(C, x) then
			local H = self:GetSpecialValueFor("damage")
			local I = C:FindModifierByName("modifier_kunkka_ult")
			if IsValid(I) then
				local J = I:getTotalRecord()
				H = H + J * E * 0.01
			end
			C:DealDamage(x, self, H, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			C:EmitSound("Ability.Ghostship.crash")
		end
	end)
	C:EmitSound("Ability.Ghostship.bell")
	C:EmitSound("Ability.Ghostship")
	C:AddNewModifier(C, self, "modifier_kunkka_ult_damage_record_ult", { duration = D })
end
B = e({ r(nil) }, B)
i.kunkka_ult = B
i.modifier_kunkka_ult_damage_record_ult = c()
local K = i.modifier_kunkka_ult_damage_record_ult
K.name = "modifier_kunkka_ult_damage_record_ult"
d(K, n)
function K.prototype.GetAbilitySpecialValue(self)
	self.reduce_pct = BUFF_VALUE.DrunkReduce + self:GetAbilityTalentValue("kunkka_talent_6", "rum_reduce_pct")
end
function K.prototype.OnCreated(self, u)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_PREDAMAGE, function(L, u, M, x)
			if x == self:GetParent() then
				self:OnPreDamage(u)
			end
		end)
	end
end
function K.prototype.OnPreDamage(self, w)
	if w.ability == self.rum_ability then
		return
	end
	if self:GetParent():HasModifier("modifier_kunkka_ult_damage_record") then
		return
	end
	local N = math.floor(w.damage * self.reduce_pct * 0.01)
	w.damage = w.damage - N
	if IsValid(self.rum_modifier) and self.rum_modifier.RecordDamage ~= nil then
		local O = self.rum_modifier
		if O ~= nil then
			O:RecordDamage(N)
		end
		self.rum_modifier:SetDuration(BUFF_VALUE.DrunkDuration, true)
	else
		self.rum_modifier = self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_kunkka_ult",
			{ duration = BUFF_VALUE.DrunkDuration, record_damage = N }
		)
	end
end
K = e(
	{
		o(
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
i.modifier_kunkka_ult_damage_record_ult = K
i.modifier_kunkka_ult_damage_record = c()
local P = i.modifier_kunkka_ult_damage_record
P.name = "modifier_kunkka_ult_damage_record"
d(P, n)
function P.prototype.GetAbilitySpecialValue(self)
	self.reduce_pct = BUFF_VALUE.DrunkReduce + self:GetAbilityTalentValue("kunkka_talent_6", "rum_reduce_pct")
end
function P.prototype.OnCreated(self, u)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_PREDAMAGE, function(L, u, M, x)
			if x == self:GetParent() then
				self:OnPreDamage(u)
			end
		end)
	end
end
function P.prototype.OnPreDamage(self, w)
	if w.ability == self.rum_ability then
		return
	end
	local N = math.floor(w.damage * self.reduce_pct * 0.01)
	w.damage = w.damage - N
	if IsValid(self.rum_modifier) then
		self.rum_modifier:RecordDamage(N)
		self.rum_modifier:SetDuration(BUFF_VALUE.DrunkDuration, true)
	else
		self.rum_modifier = self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_kunkka_ult",
			{ duration = BUFF_VALUE.DrunkDuration, record_damage = N }
		)
	end
end
P = e(
	{
		o(
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
	P
)
i.modifier_kunkka_ult_damage_record = P
i.modifier_kunkka_ult = c()
local Q = i.modifier_kunkka_ult
Q.name = "modifier_kunkka_ult"
d(Q, n)
function Q.prototype.GetAbilitySpecialValue(self)
	self.rum_duration = BUFF_VALUE.DrunkDuration
	self.talent_2_interval = self:GetAbilityTalentValue("kunkka_talent_2", "interval")
	self.talent_2_damage_pct = self:GetAbilityTalentValue("kunkka_talent_2", "damage_pct")
end
function Q.prototype.OnCreated(self, u)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self.record = 0
		self.recordList = {}
		self:RecordDamage(u and u.record_damage or 0)
		if self.talent_2_interval > 0 then
			self:StartThink(self.talent_2_interval, "kunkka_talent_2")
		end
		self:StartIntervalThink(1)
	end
end
function Q.prototype.OnRefresh(self, u)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self:RecordDamage(u and u.record_damage or 0)
	end
end
function Q.prototype.OnThink(self, R)
	if R == "kunkka_talent_2" then
		local v = self:GetParent()
		local x = self:GetParent():GetEnemy()
		if IsInjurable(v, x) and self:getTotalRecord() > 0 then
			v:DealDamage(
				x,
				self:GetParent():FindAbilityByName("kunkka_talent_2"),
				self:getTotalRecord() * self.talent_2_damage_pct * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
			local A = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				x,
				v
			)
			ParticleManager:SetParticleControl(A, 0, x:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(A)
			EmitSoundOnLocationWithCaster(x:GetAbsOrigin(), "Ability.Torrent", v)
		end
	end
end
function Q.prototype.OnIntervalThink(self)
	local v = self:GetParent()
	local x = v:GetEnemy()
	if not IsInjurable(v, x) then
		return
	end
	if self.record > 0 then
		local S = self.recordList
		S[#S + 1] = { damage = self.record, remainDamage = self.record, time = 0 }
	else
		if self:GetStackCount() <= 0 then
			self:Destroy()
			return
		else
			self:SetDuration(BUFF_VALUE.DrunkDuration, true)
		end
	end
	self.record = 0
	local H = 0
	local T = 0
	f(self.recordList, function(U, V, W)
		if V.remainDamage > 0 then
			V.time = V.time + 1
			local X = V.time == self.rum_duration and V.remainDamage or V.damage * 1 / self.rum_duration
			V.remainDamage = V.remainDamage - X
			T = T + V.remainDamage
			H = H + X
		end
	end)
	self:SetStackCount(T)
	self.recordList = g(self.recordList, function(U, V)
		return V.remainDamage > 0
	end)
	x:DealDamage(
		v,
		self.rum_ability,
		H,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
		DamageFlags.DAMAGE_FLAG_NO_LETHAL
			+ DamageFlags.DAMAGE_FLAG_REFLECTION
			+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
			+ DamageFlags.DAMAGE_FLAG_PURE_INCOMING,
		"Rum"
	)
end
function Q.prototype.RecordDamage(self, H)
	self.record = self.record + H
	self:SetStackCount(self:GetStackCount() + H)
end
function Q.prototype.getTotalRecord(self)
	return self:GetStackCount()
end
Q = e(
	{
		o(
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
	Q
)
i.modifier_kunkka_ult = Q
return i