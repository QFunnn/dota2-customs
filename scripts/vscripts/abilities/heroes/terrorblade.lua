--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["16"] = 7,
		["17"] = 8,
		["18"] = 9,
		["19"] = 11,
		["20"] = 12,
		["21"] = 11,
		["22"] = 12,
		["23"] = 13,
		["24"] = 14,
		["25"] = 13,
		["26"] = 12,
		["27"] = 11,
		["28"] = 12,
		["30"] = 12,
		["31"] = 18,
		["32"] = 26,
		["33"] = 18,
		["34"] = 26,
		["36"] = 26,
		["37"] = 42,
		["38"] = 44,
		["39"] = 51,
		["40"] = 52,
		["41"] = 18,
		["42"] = 54,
		["43"] = 55,
		["44"] = 56,
		["45"] = 57,
		["46"] = 58,
		["47"] = 59,
		["48"] = 64,
		["49"] = 65,
		["50"] = 67,
		["51"] = 69,
		["52"] = 71,
		["53"] = 72,
		["54"] = 74,
		["55"] = 75,
		["56"] = 54,
		["57"] = 77,
		["58"] = 78,
		["59"] = 78,
		["60"] = 78,
		["61"] = 78,
		["62"] = 78,
		["63"] = 78,
		["64"] = 78,
		["65"] = 78,
		["66"] = 78,
		["67"] = 78,
		["68"] = 77,
		["69"] = 89,
		["70"] = 90,
		["71"] = 91,
		["72"] = 92,
		["73"] = 93,
		["74"] = 93,
		["75"] = 93,
		["76"] = 93,
		["77"] = 93,
		["78"] = 93,
		["81"] = 89,
		["82"] = 97,
		["83"] = 98,
		["84"] = 99,
		["85"] = 100,
		["87"] = 97,
		["88"] = 103,
		["89"] = 104,
		["90"] = 103,
		["91"] = 106,
		["92"] = 107,
		["93"] = 108,
		["94"] = 109,
		["96"] = 111,
		["97"] = 112,
		["98"] = 112,
		["99"] = 112,
		["100"] = 112,
		["101"] = 112,
		["102"] = 112,
		["103"] = 112,
		["105"] = 114,
		["106"] = 115,
		["107"] = 116,
		["108"] = 117,
		["109"] = 117,
		["110"] = 117,
		["111"] = 117,
		["112"] = 117,
		["113"] = 117,
		["117"] = 106,
		["118"] = 122,
		["119"] = 123,
		["120"] = 124,
		["121"] = 125,
		["122"] = 126,
		["123"] = 127,
		["124"] = 128,
		["125"] = 128,
		["126"] = 128,
		["127"] = 128,
		["128"] = 128,
		["129"] = 128,
		["131"] = 130,
		["132"] = 131,
		["133"] = 131,
		["134"] = 131,
		["135"] = 131,
		["136"] = 131,
		["137"] = 131,
		["141"] = 122,
		["142"] = 136,
		["143"] = 137,
		["144"] = 138,
		["145"] = 139,
		["146"] = 140,
		["147"] = 141,
		["148"] = 142,
		["149"] = 143,
		["150"] = 144,
		["151"] = 145,
		["152"] = 145,
		["153"] = 145,
		["154"] = 145,
		["155"] = 145,
		["156"] = 145,
		["157"] = 145,
		["158"] = 146,
		["159"] = 147,
		["160"] = 148,
		["161"] = 149,
		["162"] = 149,
		["163"] = 149,
		["164"] = 149,
		["165"] = 149,
		["166"] = 149,
		["167"] = 149,
		["168"] = 150,
		["169"] = 151,
		["170"] = 151,
		["171"] = 151,
		["172"] = 151,
		["173"] = 151,
		["174"] = 151,
		["175"] = 151,
		["176"] = 152,
		["179"] = 155,
		["180"] = 156,
		["181"] = 157,
		["182"] = 157,
		["183"] = 157,
		["184"] = 158,
		["185"] = 159,
		["186"] = 160,
		["187"] = 161,
		["188"] = 161,
		["189"] = 161,
		["190"] = 161,
		["191"] = 161,
		["192"] = 161,
		["193"] = 161,
		["194"] = 161,
		["195"] = 161,
		["196"] = 162,
		["197"] = 162,
		["198"] = 162,
		["199"] = 162,
		["200"] = 162,
		["201"] = 162,
		["202"] = 162,
		["203"] = 162,
		["204"] = 162,
		["205"] = 163,
		["206"] = 163,
		["207"] = 163,
		["208"] = 163,
		["209"] = 163,
		["210"] = 157,
		["211"] = 157,
		["215"] = 136,
		["216"] = 169,
		["217"] = 170,
		["220"] = 173,
		["221"] = 174,
		["222"] = 175,
		["224"] = 177,
		["225"] = 178,
		["226"] = 179,
		["227"] = 179,
		["228"] = 179,
		["229"] = 179,
		["230"] = 179,
		["231"] = 179,
		["232"] = 179,
		["234"] = 169,
		["235"] = 182,
		["236"] = 183,
		["237"] = 184,
		["238"] = 185,
		["239"] = 186,
		["240"] = 187,
		["241"] = 188,
		["242"] = 188,
		["243"] = 188,
		["244"] = 188,
		["245"] = 188,
		["246"] = 188,
		["247"] = 188,
		["248"] = 189,
		["252"] = 182,
		["253"] = 194,
		["254"] = 195,
		["255"] = 196,
		["256"] = 197,
		["257"] = 198,
		["259"] = 200,
		["260"] = 201,
		["261"] = 202,
		["263"] = 194,
		["264"] = 205,
		["265"] = 206,
		["266"] = 205,
		["267"] = 214,
		["268"] = 215,
		["269"] = 214,
		["270"] = 218,
		["271"] = 219,
		["272"] = 218,
		["273"] = 228,
		["274"] = 229,
		["275"] = 228,
		["276"] = 231,
		["277"] = 232,
		["280"] = 235,
		["281"] = 236,
		["282"] = 231,
		["283"] = 243,
		["284"] = 243,
		["285"] = 243,
		["287"] = 244,
		["288"] = 245,
		["289"] = 246,
		["290"] = 247,
		["291"] = 247,
		["292"] = 247,
		["293"] = 247,
		["294"] = 247,
		["295"] = 249,
		["296"] = 250,
		["299"] = 253,
		["300"] = 254,
		["301"] = 256,
		["302"] = 257,
		["303"] = 259,
		["305"] = 261,
		["308"] = 264,
		["309"] = 265,
		["310"] = 266,
		["311"] = 268,
		["313"] = 270,
		["314"] = 271,
		["315"] = 272,
		["316"] = 273,
		["317"] = 274,
		["318"] = 276,
		["319"] = 277,
		["321"] = 279,
		["323"] = 281,
		["324"] = 282,
		["325"] = 283,
		["326"] = 284,
		["327"] = 285,
		["328"] = 286,
		["329"] = 286,
		["330"] = 286,
		["331"] = 286,
		["332"] = 286,
		["333"] = 286,
		["334"] = 286,
		["335"] = 286,
		["336"] = 286,
		["337"] = 287,
		["338"] = 287,
		["339"] = 287,
		["340"] = 287,
		["341"] = 287,
		["342"] = 287,
		["343"] = 287,
		["344"] = 287,
		["345"] = 287,
		["346"] = 288,
		["347"] = 288,
		["348"] = 288,
		["349"] = 289,
		["350"] = 288,
		["351"] = 288,
		["353"] = 292,
		["354"] = 293,
		["355"] = 294,
		["357"] = 296,
		["358"] = 243,
		["359"] = 298,
		["360"] = 299,
		["363"] = 302,
		["364"] = 302,
		["365"] = 302,
		["366"] = 302,
		["367"] = 303,
		["368"] = 304,
		["369"] = 305,
		["371"] = 298,
		["372"] = 308,
		["373"] = 309,
		["374"] = 310,
		["376"] = 312,
		["377"] = 313,
		["378"] = 314,
		["379"] = 314,
		["380"] = 314,
		["381"] = 314,
		["382"] = 314,
		["383"] = 315,
		["384"] = 316,
		["386"] = 318,
		["387"] = 319,
		["388"] = 320,
		["389"] = 320,
		["390"] = 320,
		["391"] = 320,
		["392"] = 320,
		["393"] = 321,
		["394"] = 322,
		["396"] = 308,
		["397"] = 26,
		["398"] = 18,
		["399"] = 18,
		["400"] = 18,
		["401"] = 18,
		["402"] = 18,
		["403"] = 18,
		["404"] = 18,
		["405"] = 18,
		["406"] = 26,
		["408"] = 26,
		["409"] = 328,
		["410"] = 329,
		["411"] = 328,
		["412"] = 329,
		["413"] = 330,
		["414"] = 331,
		["415"] = 332,
		["416"] = 333,
		["417"] = 335,
		["418"] = 336,
		["419"] = 338,
		["420"] = 339,
		["421"] = 340,
		["425"] = 330,
		["426"] = 329,
		["427"] = 328,
		["428"] = 329,
		["430"] = 329,
		["431"] = 348,
		["432"] = 359,
		["433"] = 348,
		["434"] = 359,
		["435"] = 363,
		["436"] = 364,
		["437"] = 365,
		["438"] = 366,
		["439"] = 363,
		["440"] = 368,
		["441"] = 369,
		["442"] = 370,
		["443"] = 371,
		["444"] = 372,
		["445"] = 373,
		["446"] = 374,
		["448"] = 376,
		["449"] = 377,
		["450"] = 378,
		["451"] = 378,
		["452"] = 378,
		["453"] = 378,
		["454"] = 378,
		["455"] = 379,
		["456"] = 380,
		["457"] = 380,
		["458"] = 380,
		["459"] = 380,
		["460"] = 380,
		["462"] = 368,
		["463"] = 383,
		["464"] = 384,
		["465"] = 385,
		["466"] = 386,
		["467"] = 387,
		["468"] = 388,
		["469"] = 389,
		["471"] = 391,
		["472"] = 392,
		["473"] = 392,
		["474"] = 392,
		["475"] = 392,
		["476"] = 392,
		["478"] = 383,
		["479"] = 396,
		["480"] = 397,
		["481"] = 396,
		["482"] = 402,
		["483"] = 403,
		["484"] = 402,
		["485"] = 408,
		["486"] = 409,
		["487"] = 408,
		["488"] = 411,
		["489"] = 412,
		["490"] = 411,
		["491"] = 414,
		["492"] = 415,
		["493"] = 414,
		["494"] = 417,
		["495"] = 418,
		["496"] = 417,
		["497"] = 422,
		["498"] = 423,
		["499"] = 424,
		["501"] = 422,
		["502"] = 427,
		["503"] = 428,
		["504"] = 427,
		["505"] = 430,
		["506"] = 431,
		["507"] = 432,
		["508"] = 433,
		["509"] = 430,
		["510"] = 359,
		["511"] = 348,
		["512"] = 348,
		["513"] = 348,
		["514"] = 348,
		["515"] = 348,
		["516"] = 348,
		["517"] = 348,
		["518"] = 348,
		["519"] = 348,
		["520"] = 348,
		["521"] = 359,
		["523"] = 359,
		["524"] = 438,
		["525"] = 447,
		["526"] = 438,
		["527"] = 447,
		["528"] = 448,
		["529"] = 449,
		["531"] = 448,
		["532"] = 458,
		["533"] = 459,
		["534"] = 460,
		["535"] = 461,
		["536"] = 463,
		["538"] = 465,
		["539"] = 466,
		["541"] = 458,
		["542"] = 473,
		["543"] = 474,
		["544"] = 473,
		["545"] = 478,
		["546"] = 479,
		["547"] = 480,
		["548"] = 480,
		["549"] = 481,
		["552"] = 478,
		["553"] = 447,
		["554"] = 438,
		["555"] = 438,
		["556"] = 438,
		["557"] = 438,
		["558"] = 438,
		["559"] = 438,
		["560"] = 438,
		["561"] = 438,
		["562"] = 438,
		["563"] = 447,
		["565"] = 447,
		["566"] = 487,
		["567"] = 495,
		["568"] = 487,
		["569"] = 495,
		["570"] = 496,
		["571"] = 497,
		["572"] = 496,
		["573"] = 495,
		["574"] = 487,
		["575"] = 487,
		["576"] = 487,
		["577"] = 487,
		["578"] = 487,
		["579"] = 487,
		["580"] = 487,
		["581"] = 487,
		["582"] = 495,
		["584"] = 495,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "terrorblade"
local o = "modifier_terrorblade_ult"
local p = "models/eom/hero/terrorblade_1/terrorblade_1.vmdl"
local q = "5100074"
local r = "5100075"
g.terrorblade_talent = c()
local s = g.terrorblade_talent
s.name = "terrorblade_talent"
d(s, i)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_terrorblade_talent"
end
s = e({ j(nil) }, s)
g.terrorblade_talent = s
g.modifier_terrorblade_talent = c()
local t = g.modifier_terrorblade_talent
t.name = "modifier_terrorblade_talent"
d(t, l)
function t.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tl6_enable = true
	self.max_health = 0
	self.tl7_damage_record = 0
	self.onTimer = false
end
function t.prototype.GetAbilitySpecialValue(self)
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
function t.prototype.EDeclareEvents(self)
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
function t.prototype.OnBattleStartBefore(self, u)
	if self:HasTalent("terrorblade_shard") then
		local v = self.parent:GetEnemy()
		if IsInjurable(v) then
			v:AddNewModifier(self.parent, self:GetAbility(), "modifier_terrorblade_shard_debuff", {})
		end
	end
end
function t.prototype.OnBattleStart(self, u)
	self.max_health = self.parent:GetMaxHealth()
	if self:HasTalent("terrorblade_talent_1") and not self.parent:FindModifierByName("modifier_sect_ulti_81_buff") then
		RestoreCustomMana(self.parent, 100)
	end
end
function t.prototype.OnBattleEnd(self, u)
	self:DestroyShadow()
end
function t.prototype.OnCustomAttackLanded(self, w)
	if IsServer() then
		if w.attacker == self.parent and not self.parent:FindModifierByName("modifier_terrorblade_ult") then
			RestoreCustomMana(self.parent, self.custom_mana)
		end
		if self.parent:FindModifierByName("modifier_terrorblade_ult") and self:HasTalent("terrorblade_talent_3") then
			AddScar(self.parent, self.parent, nil, self.max_health * self.tl3_scar * 0.01, "terrorblade_talent_5_left")
		end
		if w.attacker == self.parent and self:HasTalent("terrorblade_talent_8") then
			local v = self.parent:GetEnemy()
			if IsInjurable(self.caster, v) then
				self.caster:DealDamage(
					v,
					self.caster:FindAbilityByName("terrorblade_talent_8"),
					self.tl8_scar_damage * 0.01 * GetScar(v),
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
				)
			end
		end
	end
end
function t.prototype.OnIllusionAttack(self, w)
	if IsServer() then
		local v = self.parent:GetEnemy()
		if IsInjurable(v, self.parent) then
			if w.attacker == self.enemyShadow then
				local x = self:GetAbility()
				self.parent:DealDamage(
					v,
					x,
					GetAttackDamage(v) * self.attack_pct * 0.01,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
				)
			else
				local x = self.parent:FindAbilityByName("terrorblade_conjure_image")
				self.parent:DealDamage(
					v,
					x,
					GetAttackDamage(self.parent) * self.attack_pct * 0.01,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
				)
			end
		end
	end
end
function t.prototype.OnScarEnough(self, u)
	if u.target == self.parent then
		if IsServer() then
			if self.tl6_countdown > 0 and self.tl6_enable then
				self.tl6_enable = false
				self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4)
				EmitSoundOn("Hero_Terrorblade.Sunder.Target", self.parent)
				local v = self.parent:GetEnemy()
				local y = self.parent:FindModifierByName("modifier_scar_custom")
				AddScar(self.parent, v, nil, GetScar(self.parent), "terrorblade_talent_15")
				y:Reset()
				local z = self.parent:GetHealth()
				local A = v:GetHealth()
				self.parent:SetHealth(
					math.max(
						self.shard_min_health * 0.01 * self.parent:GetMaxHealth(),
						math.min(self.parent:GetMaxHealth(), A)
					)
				)
				local B = GetScar(v) + v:GetMaxHealth()
				v:SetHealth(math.max(B * 0.01 * self.shard_min_health, math.min(v:GetMaxHealth(), z)))
				self:StartThink(self.tl6_countdown, "tl6")
			end
		end
		if IsClient() then
			if self.tl6_countdown > 0 and self.tl6_enable then
				GameTimer(0.4, function()
					local C = self.parent
					local v = C:GetEnemy()
					local D = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf",
						PATTACH_ABSORIGIN,
						C
					)
					ParticleManager:SetParticleControlEnt(
						D,
						0,
						self.parent,
						PATTACH_POINT_FOLLOW,
						"attach_attack2",
						vec3_zero,
						true
					)
					ParticleManager:SetParticleControlEnt(
						D,
						1,
						v,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						vec3_zero,
						true
					)
					ParticleManager:SetParticleControl(D, 60, Vector(0, 255, 255))
				end)
			end
		end
	end
end
function t.prototype.OnTakeScar(self, u)
	if u.target ~= self.parent then
		return
	end
	self:CreateShadow()
	if self:HasTalent("terrorblade_talent_5") then
		self:CreateShadow(false)
	end
	if self.tl8_percentage > 0 then
		local v = self.parent:GetEnemy()
		AddScar(self.parent, v, self.ability, u.stack * self.tl8_percentage * 0.01, "terrorblade_talent_8")
	end
end
function t.prototype.OnCustomTakeDamage(self, w)
	if w.attacker == self.parent:GetEnemy() then
		if self.tl7_injury_pct > 0 then
			self.tl7_damage_record = self.tl7_damage_record + w.damage
			local E = self.max_health * self.tl7_injury_pct * 0.01
			if self.tl7_damage_record >= E then
				AddScar(self.parent, self.parent, nil, E * self.tl7_scar_pct * 0.01, "terrorblade_talent_5")
				self.tl7_damage_record = self.tl7_damage_record - E
			end
		end
	end
end
function t.prototype.OnThink(self, F)
	if F == "DestroyShadow" then
		self:DestroyShadow()
		self.onTimer = false
		self:StartThink(-1, F)
	end
	if F == "tl6" then
		self.tl6_enable = true
		self:StartThink(-1, F)
	end
end
function t.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_LIFESTEAL,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE,
	}
end
function t.prototype.EOM_GetModifierIncomingPhysicalDamagePercentage(self, u)
	return -self.physical_damage_incoming
end
function t.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self, u)
	return self.magical_damage_incoming
end
function t.prototype.EOM_GetModifierLifesteal(self, u)
	return self.tl3_health_steal
end
function t.prototype.EOM_GetModifierOutgoingPhysicalDamagePercentage(self, u)
	if not self:HasTalent("terrorblade_talent_4") then
		return
	end
	local G = math.floor(
		GetScar(self.parent) / (self.parent:GetMaxHealth() * GetScarMaxHealthPercentage(self.parent) * 0.01) * 100
	)
	return G
end
function t.prototype.CreateShadow(self, H)
	if H == nil then
		H = true
	end
	local I = nil
	local J = math.rad(225)
	local K = 150
	local L = Vector(K * math.cos(J), K * math.sin(J), 0)
	if H then
		if self.enemyShadow ~= nil then
			return
		end
		local v = self.parent:GetEnemy()
		local M = v:GetAbsOrigin():__add(L)
		I = v:CreatePhantom(M, self.parent)
		self:FixTerrorbladeShadowModel(v, I)
		I:AddNewModifier(v, nil, "modifier_terrorblade_illu", {})
	else
		if self.mineShadow ~= nil then
			return
		end
		local M = self.parent:GetAbsOrigin():__add(L)
		I = self.parent:CreatePhantom(M, self.parent)
		self:FixTerrorbladeShadowModel(self.parent, I)
		I:AddNewModifier(self.parent, nil, "modifier_terrorblade_illu", {})
	end
	local N = self.parent:GetEnemy():GetAbsOrigin() - self.parent:GetAbsOrigin()
	N.z = 0
	N = N:Normalized()
	I:SetForwardVector(N)
	I:SetTeam(self.parent:GetTeamNumber())
	if H then
		self.enemyShadow = I
	else
		self.mineShadow = I
	end
	self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 4)
	EmitSoundOn("Hero_Terrorblade.Reflection", self.parent)
	if IsClient() then
		local O = self:GetParent()
		local P = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_reflection_cast.vpcf",
			PATTACH_CUSTOMORIGIN,
			O
		)
		ParticleManager:SetParticleControlEnt(P, 0, O, PATTACH_POINT_FOLLOW, "attach_hitloc", O:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(P, 1, O, PATTACH_ABSORIGIN_FOLLOW, nil, I:GetAbsOrigin(), true)
		Timer(0.3, function()
			ParticleManager:ReleaseParticleIndex(P)
		end)
	end
	if not self.onTimer then
		self:StartThink(self.shadow_duration, "DestroyShadow")
		self.onTimer = true
	end
	return I
end
function t.prototype.FixTerrorbladeShadowModel(self, Q, I)
	if Q:GetUnitName() ~= n or Q:HasModifier(o) then
		return
	end
	local R = Wearable:serviceGetEquipWearable(Q:GetPlayerOwnerID(), Q:GetUnitName())
	if R == q or R == r then
		I:SetOriginalModel(p)
		I:ManageModelChanges()
	end
end
function t.prototype.DestroyShadow(self)
	if self.enemyShadow ~= nil or self.mineShadow ~= nil then
		EmitSoundOn("Hero_Terrorblade.Reflection", self.parent)
	end
	if self.enemyShadow ~= nil then
		local P = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_mirror_image.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.enemyShadow
		)
		ParticleManager:SetParticleControl(P, 0, self.enemyShadow:GetAbsOrigin())
		self.enemyShadow:SafeRemoveUnit()
		self.enemyShadow = nil
	end
	if self.mineShadow ~= nil then
		local P = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_mirror_image.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.mineShadow
		)
		ParticleManager:SetParticleControl(P, 0, self.mineShadow:GetAbsOrigin())
		self.mineShadow:SafeRemoveUnit()
		self.mineShadow = nil
	end
end
t = e(
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
	t
)
g.modifier_terrorblade_talent = t
g.terrorblade_ult = c()
local S = g.terrorblade_ult
S.name = "terrorblade_ult"
d(S, i)
function S.prototype.OnSpellStart(self)
	if IsServer() then
		local T = self:GetCaster()
		local U = self:GetSpecialValueFor("ult_duration")
		local V = T:FindModifierByName("modifier_terrorblade_talent").max_health
			* self:GetSpecialValueFor("health_reduce_pct")
			* 0.01
		if T:IsAlive() then
			AddScar(T, T, self, V)
			if not T:FindModifierByName("modifier_terrorblade_ult") then
				T:AddNewModifier(T, self, "modifier_terrorblade_ult", { duration = U })
			end
		end
	end
end
S = e({ j(nil) }, S)
g.terrorblade_ult = S
g.modifier_terrorblade_ult = c()
local W = g.modifier_terrorblade_ult
W.name = "modifier_terrorblade_ult"
d(W, l)
function W.prototype.GetAbilitySpecialValue(self)
	self.attack_interval = self:GetAbilitySpecialValueFor("attack_interval")
		+ self:GetAbilityTalentValue("terrorblade_talent_9", "attack_interval")
	self.max_health_pct = self:GetAbilitySpecialValueFor("max_health_pct")
	self.attack = self:GetAbilitySpecialValueFor("attack")
end
function W.prototype.OnCreated(self, u)
	if IsServer() then
		EmitSoundOn("Hero_Terrorblade.Metamorphosis", self.parent)
		self.parent:SetOriginalModel(Wearable:getReplaceUnitModel(self.parent, "models/heroes/terrorblade/demon.vmdl"))
		self.parent:ManageModelChanges()
		self.parent:SetWearablesVisible(false)
		self.parent:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
	else
		local X = Wearable:getReplaceParticle(
			self.parent,
			"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform_b.vpcf"
		)
		local D = ParticleManager:CreateParticle(X, PATTACH_CUSTOMORIGIN, self.parent)
		ParticleManager:SetParticleControl(D, 0, self.parent:GetAbsOrigin())
		local Y = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(Y, 0, self.parent:GetAbsOrigin())
	end
end
function W.prototype.OnDestroy(self)
	if IsServer() then
		EmitSoundOn("Hero_Terrorblade.morph_Death", self.parent)
		self.parent:SetOriginalModel(
			Wearable:getReplaceUnitModel(self.parent, "models/heroes/terrorblade/terrorblade.vmdl")
		)
		self.parent:ManageModelChanges()
		self.parent:SetWearablesVisible(true)
		self.parent:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
	else
		local D = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform_end.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(D, 0, self.parent:GetAbsOrigin())
	end
end
function W.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_RATE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
	}
end
function W.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME,
	}
end
function W.prototype.GetAttackSound(self)
	return "Hero_Terrorblade_Morphed.preAttack"
end
function W.prototype.GetModifierModelScale(self)
	return 30
end
function W.prototype.GetModifierModelScaleAnimateTime(self)
	return 0.1
end
function W.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent, -1 } }
end
function W.prototype.OnCustomAttackLanded(self, w)
	if IsValid(w.target) then
		w.target:EmitSound("Hero_Terrorblade_Morphed.projectileImpact")
	end
end
function W.prototype.EOM_GetModifierAttackRateBonus(self, u)
	return -self.attack_interval
end
function W.prototype.EOM_GetModifierAttackDamageBonus(self, u)
	local Z = GetScar(self.parent)
	local _ = self.max_health_pct * (self.parent:GetMaxHealth() + Z) * 0.01
	return math.floor(Z / _) * self.attack
end
W = e(
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
	W
)
g.modifier_terrorblade_ult = W
g.modifier_terrorblade_illu = c()
local a0 = g.modifier_terrorblade_illu
a0.name = "modifier_terrorblade_illu"
d(a0, l)
function a0.prototype.OnCreated(self, u)
	if IsClient() then
	end
end
function a0.prototype.OnRemoved(self, a1)
	if IsServer() then
		local a2 = self:GetCaster()
		local O = self:GetParent()
		O:AddNoDraw()
	else
		local a2 = self:GetCaster()
		local O = self:GetParent()
	end
end
function a0.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_OVERRIDE }
end
function a0.prototype.EOM_GetModifierAttackSpeedBonusOverride(self, u)
	if IsServer() then
		local a3 = self:GetCaster()
		if a3 and a3:IsAlive() then
			return GetAttackspeed(self:GetCaster())
		end
	end
end
a0 = e(
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
	a0
)
g.modifier_terrorblade_illu = a0
g.modifier_terrorblade_shard_debuff = c()
local a4 = g.modifier_terrorblade_shard_debuff
a4.name = "modifier_terrorblade_shard_debuff"
d(a4, l)
function a4.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_SCAR_STACK_PERCENTAGE] = self:GetAbilityTalentValue(
			"terrorblade_shard",
			"scar_limit"
		),
	}
end
a4 = e(
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
	a4
)
g.modifier_terrorblade_shard_debuff = a4
return g