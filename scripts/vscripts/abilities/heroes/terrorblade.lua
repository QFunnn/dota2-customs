--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/terrorblade"
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
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
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
		["27"] = 20,
		["28"] = 12,
		["29"] = 20,
		["31"] = 20,
		["32"] = 36,
		["33"] = 38,
		["34"] = 45,
		["35"] = 46,
		["36"] = 12,
		["37"] = 48,
		["38"] = 49,
		["39"] = 50,
		["40"] = 51,
		["41"] = 52,
		["42"] = 53,
		["43"] = 58,
		["44"] = 59,
		["45"] = 61,
		["46"] = 63,
		["47"] = 65,
		["48"] = 66,
		["49"] = 68,
		["50"] = 69,
		["51"] = 48,
		["52"] = 71,
		["53"] = 72,
		["54"] = 72,
		["55"] = 72,
		["56"] = 72,
		["57"] = 72,
		["58"] = 72,
		["59"] = 72,
		["60"] = 72,
		["61"] = 72,
		["62"] = 72,
		["63"] = 71,
		["64"] = 83,
		["65"] = 84,
		["66"] = 85,
		["67"] = 86,
		["68"] = 87,
		["69"] = 87,
		["70"] = 87,
		["71"] = 87,
		["72"] = 87,
		["73"] = 87,
		["76"] = 83,
		["77"] = 91,
		["78"] = 92,
		["79"] = 93,
		["80"] = 94,
		["82"] = 91,
		["83"] = 97,
		["84"] = 98,
		["85"] = 97,
		["86"] = 100,
		["87"] = 101,
		["88"] = 102,
		["89"] = 103,
		["91"] = 105,
		["92"] = 106,
		["93"] = 106,
		["94"] = 106,
		["95"] = 106,
		["96"] = 106,
		["97"] = 106,
		["98"] = 106,
		["100"] = 108,
		["101"] = 109,
		["102"] = 110,
		["103"] = 111,
		["104"] = 111,
		["105"] = 111,
		["106"] = 111,
		["107"] = 111,
		["108"] = 111,
		["112"] = 100,
		["113"] = 116,
		["114"] = 117,
		["115"] = 118,
		["116"] = 119,
		["117"] = 120,
		["118"] = 121,
		["119"] = 122,
		["120"] = 122,
		["121"] = 122,
		["122"] = 122,
		["123"] = 122,
		["124"] = 122,
		["126"] = 124,
		["127"] = 125,
		["128"] = 125,
		["129"] = 125,
		["130"] = 125,
		["131"] = 125,
		["132"] = 125,
		["136"] = 116,
		["137"] = 130,
		["138"] = 131,
		["139"] = 132,
		["140"] = 133,
		["141"] = 134,
		["142"] = 135,
		["143"] = 136,
		["144"] = 137,
		["145"] = 138,
		["146"] = 139,
		["147"] = 139,
		["148"] = 139,
		["149"] = 139,
		["150"] = 139,
		["151"] = 139,
		["152"] = 139,
		["153"] = 140,
		["154"] = 141,
		["155"] = 142,
		["156"] = 143,
		["157"] = 143,
		["158"] = 143,
		["159"] = 143,
		["160"] = 143,
		["161"] = 143,
		["162"] = 143,
		["163"] = 144,
		["164"] = 145,
		["165"] = 145,
		["166"] = 145,
		["167"] = 145,
		["168"] = 145,
		["169"] = 145,
		["170"] = 145,
		["171"] = 146,
		["174"] = 149,
		["175"] = 150,
		["176"] = 151,
		["177"] = 151,
		["178"] = 151,
		["179"] = 152,
		["180"] = 153,
		["181"] = 154,
		["182"] = 155,
		["183"] = 155,
		["184"] = 155,
		["185"] = 155,
		["186"] = 155,
		["187"] = 155,
		["188"] = 155,
		["189"] = 155,
		["190"] = 155,
		["191"] = 156,
		["192"] = 156,
		["193"] = 156,
		["194"] = 156,
		["195"] = 156,
		["196"] = 156,
		["197"] = 156,
		["198"] = 156,
		["199"] = 156,
		["200"] = 157,
		["201"] = 157,
		["202"] = 157,
		["203"] = 157,
		["204"] = 157,
		["205"] = 151,
		["206"] = 151,
		["210"] = 130,
		["211"] = 163,
		["212"] = 164,
		["213"] = 165,
		["214"] = 166,
		["216"] = 168,
		["217"] = 169,
		["218"] = 170,
		["219"] = 170,
		["220"] = 170,
		["221"] = 170,
		["222"] = 170,
		["223"] = 170,
		["224"] = 170,
		["226"] = 163,
		["227"] = 173,
		["228"] = 174,
		["229"] = 175,
		["230"] = 176,
		["231"] = 177,
		["232"] = 178,
		["233"] = 179,
		["234"] = 179,
		["235"] = 179,
		["236"] = 179,
		["237"] = 179,
		["238"] = 179,
		["239"] = 179,
		["240"] = 180,
		["244"] = 173,
		["245"] = 185,
		["246"] = 186,
		["247"] = 187,
		["248"] = 188,
		["249"] = 189,
		["251"] = 191,
		["252"] = 192,
		["253"] = 193,
		["255"] = 185,
		["256"] = 196,
		["257"] = 197,
		["258"] = 196,
		["259"] = 205,
		["260"] = 206,
		["261"] = 205,
		["262"] = 209,
		["263"] = 210,
		["264"] = 209,
		["265"] = 219,
		["266"] = 220,
		["267"] = 219,
		["268"] = 222,
		["269"] = 223,
		["272"] = 226,
		["273"] = 227,
		["274"] = 222,
		["275"] = 234,
		["276"] = 234,
		["277"] = 234,
		["279"] = 235,
		["280"] = 236,
		["281"] = 237,
		["282"] = 238,
		["283"] = 238,
		["284"] = 238,
		["285"] = 238,
		["286"] = 238,
		["287"] = 240,
		["288"] = 241,
		["291"] = 244,
		["292"] = 245,
		["293"] = 247,
		["294"] = 249,
		["296"] = 251,
		["299"] = 254,
		["300"] = 255,
		["301"] = 257,
		["303"] = 259,
		["304"] = 260,
		["305"] = 261,
		["306"] = 262,
		["307"] = 263,
		["308"] = 265,
		["309"] = 266,
		["311"] = 268,
		["313"] = 270,
		["314"] = 271,
		["315"] = 272,
		["316"] = 273,
		["317"] = 274,
		["318"] = 275,
		["319"] = 275,
		["320"] = 275,
		["321"] = 275,
		["322"] = 275,
		["323"] = 275,
		["324"] = 275,
		["325"] = 275,
		["326"] = 275,
		["327"] = 276,
		["328"] = 276,
		["329"] = 276,
		["330"] = 276,
		["331"] = 276,
		["332"] = 276,
		["333"] = 276,
		["334"] = 276,
		["335"] = 276,
		["336"] = 277,
		["337"] = 277,
		["338"] = 277,
		["339"] = 278,
		["340"] = 277,
		["341"] = 277,
		["343"] = 281,
		["344"] = 282,
		["345"] = 283,
		["347"] = 285,
		["348"] = 234,
		["349"] = 287,
		["350"] = 288,
		["351"] = 289,
		["353"] = 291,
		["354"] = 292,
		["355"] = 293,
		["356"] = 293,
		["357"] = 293,
		["358"] = 293,
		["359"] = 293,
		["360"] = 294,
		["361"] = 295,
		["363"] = 297,
		["364"] = 298,
		["365"] = 299,
		["366"] = 299,
		["367"] = 299,
		["368"] = 299,
		["369"] = 299,
		["370"] = 300,
		["371"] = 301,
		["373"] = 287,
		["374"] = 20,
		["375"] = 12,
		["376"] = 12,
		["377"] = 12,
		["378"] = 12,
		["379"] = 12,
		["380"] = 12,
		["381"] = 12,
		["382"] = 12,
		["383"] = 20,
		["385"] = 20,
		["386"] = 307,
		["387"] = 308,
		["388"] = 307,
		["389"] = 308,
		["390"] = 309,
		["391"] = 310,
		["392"] = 311,
		["393"] = 312,
		["394"] = 314,
		["395"] = 315,
		["396"] = 317,
		["397"] = 318,
		["398"] = 319,
		["402"] = 309,
		["403"] = 308,
		["404"] = 307,
		["405"] = 308,
		["407"] = 308,
		["408"] = 327,
		["409"] = 338,
		["410"] = 327,
		["411"] = 338,
		["412"] = 342,
		["413"] = 343,
		["414"] = 344,
		["415"] = 345,
		["416"] = 342,
		["417"] = 347,
		["418"] = 348,
		["419"] = 349,
		["420"] = 350,
		["421"] = 351,
		["422"] = 352,
		["423"] = 353,
		["425"] = 355,
		["426"] = 356,
		["427"] = 356,
		["428"] = 356,
		["429"] = 356,
		["430"] = 356,
		["431"] = 357,
		["432"] = 358,
		["433"] = 358,
		["434"] = 358,
		["435"] = 358,
		["436"] = 358,
		["438"] = 347,
		["439"] = 361,
		["440"] = 362,
		["441"] = 363,
		["442"] = 364,
		["443"] = 365,
		["444"] = 366,
		["445"] = 367,
		["447"] = 369,
		["448"] = 370,
		["449"] = 370,
		["450"] = 370,
		["451"] = 370,
		["452"] = 370,
		["454"] = 361,
		["455"] = 374,
		["456"] = 375,
		["457"] = 374,
		["458"] = 380,
		["459"] = 381,
		["460"] = 380,
		["461"] = 386,
		["462"] = 387,
		["463"] = 386,
		["464"] = 389,
		["465"] = 390,
		["466"] = 389,
		["467"] = 392,
		["468"] = 393,
		["469"] = 392,
		["470"] = 395,
		["471"] = 396,
		["472"] = 395,
		["473"] = 400,
		["474"] = 401,
		["475"] = 402,
		["477"] = 400,
		["478"] = 405,
		["479"] = 406,
		["480"] = 405,
		["481"] = 408,
		["482"] = 409,
		["483"] = 410,
		["484"] = 411,
		["485"] = 408,
		["486"] = 338,
		["487"] = 327,
		["488"] = 327,
		["489"] = 327,
		["490"] = 327,
		["491"] = 327,
		["492"] = 327,
		["493"] = 327,
		["494"] = 327,
		["495"] = 327,
		["496"] = 327,
		["497"] = 338,
		["499"] = 338,
		["500"] = 416,
		["501"] = 425,
		["502"] = 416,
		["503"] = 425,
		["504"] = 426,
		["505"] = 427,
		["507"] = 426,
		["508"] = 436,
		["509"] = 437,
		["510"] = 438,
		["511"] = 439,
		["512"] = 441,
		["514"] = 443,
		["515"] = 444,
		["517"] = 436,
		["518"] = 451,
		["519"] = 452,
		["520"] = 451,
		["521"] = 456,
		["522"] = 457,
		["523"] = 458,
		["524"] = 458,
		["525"] = 459,
		["528"] = 456,
		["529"] = 425,
		["530"] = 416,
		["531"] = 416,
		["532"] = 416,
		["533"] = 416,
		["534"] = 416,
		["535"] = 416,
		["536"] = 416,
		["537"] = 416,
		["538"] = 416,
		["539"] = 425,
		["541"] = 425,
		["542"] = 465,
		["543"] = 473,
		["544"] = 465,
		["545"] = 473,
		["546"] = 474,
		["547"] = 475,
		["548"] = 474,
		["549"] = 473,
		["550"] = 465,
		["551"] = 465,
		["552"] = 465,
		["553"] = 465,
		["554"] = 465,
		["555"] = 465,
		["556"] = 465,
		["557"] = 465,
		["558"] = 473,
		["560"] = 473,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.terrorblade_talent = c()
local n = g.terrorblade_talent
n.name = "terrorblade_talent"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_terrorblade_talent"
end
n = e({ j(nil) }, n)
g.terrorblade_talent = n
g.modifier_terrorblade_talent = c()
local o = g.modifier_terrorblade_talent
o.name = "modifier_terrorblade_talent"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tl6_enable = true
	self.max_health = 0
	self.tl7_damage_record = 0
	self.onTimer = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.physical_damage_incoming = self:GetAbilitySpecialValueFor("physical_damage_incoming")
	self.magical_damage_incoming = self:GetAbilitySpecialValueFor("magical_damage_incoming")
	self.custom_mana = self:GetAbilitySpecialValueFor("custom_mana")
		+ self:GetAbilityTalentValue("terrorblade_talent_9", "custom_mana")
	self.shadow_duration = self:GetAbilitySpecialValueFor("shadow_duration")
	self.attack_pct = self:GetAbilitySpecialValueFor("attack_pct")
		+ self:GetAbilityTalentValue("terrorblade_talent_5", "shadow_attack_pct")
	self.tl3_health_steal = self:GetAbilityTalentValue("terrorblade_talent_3", "health_steal")
	self.tl3_scar = self:GetAbilityTalentValue("terrorblade_talent_3", "scar")
	self.tl6_countdown = self:GetAbilityTalentValue("terrorblade_shard", "countdown")
	self.shard_min_health = self:GetAbilityTalentValue("terrorblade_shard", "min_health")
	self.tl7_injury_pct = self:GetAbilityTalentValue("terrorblade_talent_7", "injury_pct")
	self.tl7_scar_pct = self:GetAbilityTalentValue("terrorblade_talent_7", "scar_pct")
	self.tl8_scar_damage = self:GetAbilityTalentValue("terrorblade_talent_8", "scar_damage")
	self.tl8_percentage = self:GetAbilityTalentValue("terrorblade_talent_8", "percentage")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ILLUSION_ATTACK] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SCAR_ENOUGH] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKE_SCAR] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self.parent },
	}
end
function o.prototype.OnBattleStartBefore(self, p)
	if self:HasTalent("terrorblade_shard") then
		local q = self.parent:GetEnemy()
		if IsInjurable(q) then
			q:AddNewModifier(self.parent, self:GetAbility(), "modifier_terrorblade_shard_debuff", {})
		end
	end
end
function o.prototype.OnBattleStart(self, p)
	self.max_health = self.parent:GetMaxHealth()
	if self:HasTalent("terrorblade_talent_1") and not self.parent:FindModifierByName("modifier_sect_ulti_81_buff") then
		RestoreCustomMana(self.parent, 100)
	end
end
function o.prototype.OnBattleEnd(self, p)
	self:DestroyShadow()
end
function o.prototype.OnCustomAttackLanded(self, r)
	if IsServer() then
		if r.attacker == self.parent and not self.parent:FindModifierByName("modifier_terrorblade_ult") then
			RestoreCustomMana(self.parent, self.custom_mana)
		end
		if self.parent:FindModifierByName("modifier_terrorblade_ult") and self:HasTalent("terrorblade_talent_3") then
			AddScar(self.parent, self.parent, nil, self.max_health * self.tl3_scar * 0.01, "terrorblade_talent_5_left")
		end
		if r.attacker == self.parent and self:HasTalent("terrorblade_talent_8") then
			local q = self.parent:GetEnemy()
			if IsInjurable(self.caster, q) then
				self.caster:DealDamage(
					q,
					self.caster:FindAbilityByName("terrorblade_talent_8"),
					self.tl8_scar_damage * 0.01 * GetScar(q),
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
				)
			end
		end
	end
end
function o.prototype.OnIllusionAttack(self, r)
	if IsServer() then
		local q = self.parent:GetEnemy()
		if IsInjurable(q, self.parent) then
			if r.attacker == self.enemyShadow then
				local s = self:GetAbility()
				self.parent:DealDamage(
					q,
					s,
					GetAttackDamage(q) * self.attack_pct * 0.01,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
				)
			else
				local s = self.parent:FindAbilityByName("terrorblade_conjure_image")
				self.parent:DealDamage(
					q,
					s,
					GetAttackDamage(self.parent) * self.attack_pct * 0.01,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
				)
			end
		end
	end
end
function o.prototype.OnScarEnough(self, p)
	if p.target == self.parent then
		if IsServer() then
			if self.tl6_countdown > 0 and self.tl6_enable then
				self.tl6_enable = false
				self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4)
				EmitSoundOn("Hero_Terrorblade.Sunder.Target", self.parent)
				local q = self.parent:GetEnemy()
				local t = self.parent:FindModifierByName("modifier_scar_custom")
				AddScar(self.parent, q, nil, GetScar(self.parent), "terrorblade_talent_15")
				t:Reset()
				local u = self.parent:GetHealth()
				local v = q:GetHealth()
				self.parent:SetHealth(
					math.max(
						self.shard_min_health * 0.01 * self.parent:GetMaxHealth(),
						math.min(self.parent:GetMaxHealth(), v)
					)
				)
				local w = GetScar(q) + q:GetMaxHealth()
				q:SetHealth(math.max(w * 0.01 * self.shard_min_health, math.min(q:GetMaxHealth(), u)))
				self:StartThink(self.tl6_countdown, "tl6")
			end
		end
		if IsClient() then
			if self.tl6_countdown > 0 and self.tl6_enable then
				GameTimer(0.4, function()
					local x = self.parent
					local q = x:GetEnemy()
					local y = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf",
						PATTACH_ABSORIGIN,
						x
					)
					ParticleManager:SetParticleControlEnt(
						y,
						0,
						self.parent,
						PATTACH_POINT_FOLLOW,
						"attach_attack2",
						vec3_zero,
						true
					)
					ParticleManager:SetParticleControlEnt(
						y,
						1,
						q,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						vec3_zero,
						true
					)
					ParticleManager:SetParticleControl(y, 60, Vector(0, 255, 255))
				end)
			end
		end
	end
end
function o.prototype.OnTakeScar(self, p)
	self:CreateShadow()
	if self:HasTalent("terrorblade_talent_5") then
		self:CreateShadow(false)
	end
	if self.tl8_percentage > 0 then
		local q = self.parent:GetEnemy()
		AddScar(self.parent, q, self.ability, p.stack * self.tl8_percentage * 0.01, "terrorblade_talent_8")
	end
end
function o.prototype.OnCustomTakeDamage(self, r)
	if r.attacker == self.parent:GetEnemy() then
		if self.tl7_injury_pct > 0 then
			self.tl7_damage_record = self.tl7_damage_record + r.damage
			local z = self.max_health * self.tl7_injury_pct * 0.01
			if self.tl7_damage_record >= z then
				AddScar(self.parent, self.parent, nil, z * self.tl7_scar_pct * 0.01, "terrorblade_talent_5")
				self.tl7_damage_record = self.tl7_damage_record - z
			end
		end
	end
end
function o.prototype.OnThink(self, A)
	if A == "DestroyShadow" then
		self:DestroyShadow()
		self.onTimer = false
		self:StartThink(-1, A)
	end
	if A == "tl6" then
		self.tl6_enable = true
		self:StartThink(-1, A)
	end
end
function o.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_LIFESTEAL,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE,
	}
end
function o.prototype.EOM_GetModifierIncomingPhysicalDamagePercentage(self, p)
	return -self.physical_damage_incoming
end
function o.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self, p)
	return self.magical_damage_incoming
end
function o.prototype.EOM_GetModifierLifesteal(self, p)
	return self.tl3_health_steal
end
function o.prototype.EOM_GetModifierOutgoingPhysicalDamagePercentage(self, p)
	if not self:HasTalent("terrorblade_talent_4") then
		return
	end
	local B = math.floor(
		GetScar(self.parent) / (self.parent:GetMaxHealth() * GetScarMaxHealthPercentage(self.parent) * 0.01) * 100
	)
	return B
end
function o.prototype.CreateShadow(self, C)
	if C == nil then
		C = true
	end
	local D = nil
	local E = math.rad(225)
	local F = 150
	local G = Vector(F * math.cos(E), F * math.sin(E), 0)
	if C then
		if self.enemyShadow ~= nil then
			return
		end
		local q = self.parent:GetEnemy()
		local H = q:GetAbsOrigin():__add(G)
		D = q:CreatePhantom(H, self.parent)
		D:AddNewModifier(q, nil, "modifier_terrorblade_illu", {})
	else
		if self.mineShadow ~= nil then
			return
		end
		local H = self.parent:GetAbsOrigin():__add(G)
		D = self.parent:CreatePhantom(H, self.parent)
		D:AddNewModifier(self.parent, nil, "modifier_terrorblade_illu", {})
	end
	local I = self.parent:GetEnemy():GetAbsOrigin() - self.parent:GetAbsOrigin()
	I.z = 0
	I = I:Normalized()
	D:SetForwardVector(I)
	D:SetTeam(self.parent:GetTeamNumber())
	if C then
		self.enemyShadow = D
	else
		self.mineShadow = D
	end
	self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 4)
	EmitSoundOn("Hero_Terrorblade.Reflection", self.parent)
	if IsClient() then
		local J = self:GetParent()
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_reflection_cast.vpcf",
			PATTACH_CUSTOMORIGIN,
			J
		)
		ParticleManager:SetParticleControlEnt(K, 0, J, PATTACH_POINT_FOLLOW, "attach_hitloc", J:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(K, 1, J, PATTACH_ABSORIGIN_FOLLOW, nil, D:GetAbsOrigin(), true)
		Timer(0.3, function()
			ParticleManager:ReleaseParticleIndex(K)
		end)
	end
	if not self.onTimer then
		self:StartThink(self.shadow_duration, "DestroyShadow")
		self.onTimer = true
	end
	return D
end
function o.prototype.DestroyShadow(self)
	if self.enemyShadow ~= nil or self.mineShadow ~= nil then
		EmitSoundOn("Hero_Terrorblade.Reflection", self.parent)
	end
	if self.enemyShadow ~= nil then
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_mirror_image.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.enemyShadow
		)
		ParticleManager:SetParticleControl(K, 0, self.enemyShadow:GetAbsOrigin())
		self.enemyShadow:SafeRemoveUnit()
		self.enemyShadow = nil
	end
	if self.mineShadow ~= nil then
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_mirror_image.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.mineShadow
		)
		ParticleManager:SetParticleControl(K, 0, self.mineShadow:GetAbsOrigin())
		self.mineShadow:SafeRemoveUnit()
		self.mineShadow = nil
	end
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
				RemoveOnDeath = true,
			}
		),
	},
	o
)
g.modifier_terrorblade_talent = o
g.terrorblade_ult = c()
local L = g.terrorblade_ult
L.name = "terrorblade_ult"
d(L, i)
function L.prototype.OnSpellStart(self)
	if IsServer() then
		local M = self:GetCaster()
		local N = self:GetSpecialValueFor("ult_duration")
		local O = M:FindModifierByName("modifier_terrorblade_talent").max_health
			* self:GetSpecialValueFor("health_reduce_pct")
			* 0.01
		if M:IsAlive() then
			AddScar(M, M, self, O)
			if not M:FindModifierByName("modifier_terrorblade_ult") then
				M:AddNewModifier(M, self, "modifier_terrorblade_ult", { duration = N })
			end
		end
	end
end
L = e({ j(nil) }, L)
g.terrorblade_ult = L
g.modifier_terrorblade_ult = c()
local P = g.modifier_terrorblade_ult
P.name = "modifier_terrorblade_ult"
d(P, l)
function P.prototype.GetAbilitySpecialValue(self)
	self.attack_interval = self:GetAbilitySpecialValueFor("attack_interval")
		+ self:GetAbilityTalentValue("terrorblade_talent_9", "attack_interval")
	self.max_health_pct = self:GetAbilitySpecialValueFor("max_health_pct")
	self.attack = self:GetAbilitySpecialValueFor("attack")
end
function P.prototype.OnCreated(self, p)
	if IsServer() then
		EmitSoundOn("Hero_Terrorblade.Metamorphosis", self.parent)
		self.parent:SetOriginalModel(Wearable:getReplaceParticle(self.parent, "models/heroes/terrorblade/demon.vmdl"))
		self.parent:ManageModelChanges()
		self.parent:SetWearablesVisible(false)
		self.parent:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
	else
		local y = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform_b.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(y, 0, self.parent:GetAbsOrigin())
		local Q = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(Q, 0, self.parent:GetAbsOrigin())
	end
end
function P.prototype.OnDestroy(self)
	if IsServer() then
		EmitSoundOn("Hero_Terrorblade.morph_Death", self.parent)
		self.parent:SetOriginalModel(
			Wearable:getReplaceParticle(self.parent, "models/heroes/terrorblade/terrorblade.vmdl")
		)
		self.parent:ManageModelChanges()
		self.parent:SetWearablesVisible(true)
		self.parent:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
	else
		local y = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform_end.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(y, 0, self.parent:GetAbsOrigin())
	end
end
function P.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_RATE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
	}
end
function P.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME,
	}
end
function P.prototype.GetAttackSound(self)
	return "Hero_Terrorblade_Morphed.preAttack"
end
function P.prototype.GetModifierModelScale(self)
	return 30
end
function P.prototype.GetModifierModelScaleAnimateTime(self)
	return 0.1
end
function P.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent, -1 } }
end
function P.prototype.OnCustomAttackLanded(self, r)
	if IsValid(r.target) then
		r.target:EmitSound("Hero_Terrorblade_Morphed.projectileImpact")
	end
end
function P.prototype.EOM_GetModifierAttackRateBonus(self, p)
	return -self.attack_interval
end
function P.prototype.EOM_GetModifierAttackDamageBonus(self, p)
	local R = GetScar(self.parent)
	local S = self.max_health_pct * (self.parent:GetMaxHealth() + R) * 0.01
	return math.floor(R / S) * self.attack
end
P = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
				StatusEffectPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
				GetStatusEffectName = "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_ambient_beams_f.vpcf",
			}
		),
	},
	P
)
g.modifier_terrorblade_ult = P
g.modifier_terrorblade_illu = c()
local T = g.modifier_terrorblade_illu
T.name = "modifier_terrorblade_illu"
d(T, l)
function T.prototype.OnCreated(self, p)
	if IsClient() then
	end
end
function T.prototype.OnRemoved(self, U)
	if IsServer() then
		local V = self:GetCaster()
		local J = self:GetParent()
		J:AddNoDraw()
	else
		local V = self:GetCaster()
		local J = self:GetParent()
	end
end
function T.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_OVERRIDE }
end
function T.prototype.EOM_GetModifierAttackSpeedBonusOverride(self, p)
	if IsServer() then
		local W = self:GetCaster()
		if W and W:IsAlive() then
			return GetAttackspeed(self:GetCaster())
		end
	end
end
T = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				StatusEffectPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
				GetStatusEffectName = "particles/status_fx/status_effect_terrorblade_reflection.vpcf",
			}
		),
	},
	T
)
g.modifier_terrorblade_illu = T
g.modifier_terrorblade_shard_debuff = c()
local X = g.modifier_terrorblade_shard_debuff
X.name = "modifier_terrorblade_shard_debuff"
d(X, l)
function X.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_SCAR_STACK_PERCENTAGE] = self:GetAbilityTalentValue(
			"terrorblade_shard",
			"scar_limit"
		),
	}
end
X = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				StatusEffectPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	X
)
g.modifier_terrorblade_shard_debuff = X
return g