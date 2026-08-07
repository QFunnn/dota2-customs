--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/silencer"
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
		["34"] = 20,
		["35"] = 25,
		["36"] = 12,
		["37"] = 37,
		["38"] = 38,
		["39"] = 39,
		["40"] = 40,
		["41"] = 41,
		["42"] = 42,
		["43"] = 43,
		["44"] = 44,
		["45"] = 45,
		["46"] = 46,
		["47"] = 47,
		["48"] = 48,
		["50"] = 37,
		["51"] = 52,
		["52"] = 53,
		["53"] = 54,
		["54"] = 55,
		["55"] = 56,
		["56"] = 57,
		["57"] = 58,
		["58"] = 58,
		["59"] = 58,
		["60"] = 58,
		["61"] = 58,
		["62"] = 58,
		["64"] = 52,
		["65"] = 62,
		["66"] = 63,
		["67"] = 63,
		["68"] = 65,
		["69"] = 65,
		["70"] = 65,
		["71"] = 63,
		["72"] = 63,
		["73"] = 62,
		["74"] = 79,
		["75"] = 82,
		["78"] = 84,
		["79"] = 85,
		["80"] = 86,
		["81"] = 94,
		["82"] = 79,
		["83"] = 113,
		["84"] = 114,
		["85"] = 115,
		["88"] = 117,
		["90"] = 113,
		["91"] = 121,
		["92"] = 122,
		["93"] = 123,
		["94"] = 123,
		["95"] = 123,
		["96"] = 123,
		["97"] = 123,
		["98"] = 123,
		["100"] = 125,
		["101"] = 121,
		["102"] = 128,
		["103"] = 129,
		["104"] = 130,
		["105"] = 131,
		["106"] = 132,
		["107"] = 133,
		["109"] = 137,
		["110"] = 138,
		["111"] = 139,
		["112"] = 140,
		["113"] = 141,
		["114"] = 142,
		["115"] = 142,
		["116"] = 142,
		["117"] = 142,
		["118"] = 142,
		["119"] = 142,
		["122"] = 128,
		["123"] = 147,
		["124"] = 148,
		["125"] = 147,
		["126"] = 154,
		["127"] = 155,
		["128"] = 154,
		["129"] = 158,
		["130"] = 159,
		["131"] = 158,
		["132"] = 161,
		["133"] = 162,
		["134"] = 163,
		["135"] = 164,
		["137"] = 166,
		["139"] = 161,
		["140"] = 170,
		["141"] = 171,
		["142"] = 170,
		["143"] = 175,
		["144"] = 176,
		["145"] = 175,
		["146"] = 20,
		["147"] = 12,
		["148"] = 12,
		["149"] = 12,
		["150"] = 12,
		["151"] = 12,
		["152"] = 12,
		["153"] = 12,
		["154"] = 12,
		["155"] = 20,
		["157"] = 20,
		["158"] = 183,
		["159"] = 192,
		["160"] = 183,
		["161"] = 192,
		["162"] = 198,
		["163"] = 199,
		["164"] = 200,
		["165"] = 198,
		["166"] = 203,
		["167"] = 204,
		["168"] = 205,
		["169"] = 205,
		["170"] = 205,
		["171"] = 204,
		["172"] = 204,
		["173"] = 204,
		["174"] = 203,
		["175"] = 210,
		["176"] = 211,
		["177"] = 210,
		["178"] = 214,
		["179"] = 215,
		["180"] = 216,
		["181"] = 217,
		["182"] = 218,
		["183"] = 220,
		["184"] = 221,
		["185"] = 221,
		["186"] = 221,
		["187"] = 221,
		["188"] = 221,
		["189"] = 221,
		["191"] = 223,
		["192"] = 224,
		["193"] = 224,
		["194"] = 224,
		["195"] = 224,
		["196"] = 224,
		["197"] = 224,
		["199"] = 226,
		["200"] = 227,
		["201"] = 227,
		["202"] = 227,
		["203"] = 227,
		["204"] = 227,
		["205"] = 227,
		["207"] = 230,
		["208"] = 231,
		["209"] = 231,
		["210"] = 231,
		["211"] = 231,
		["212"] = 231,
		["213"] = 231,
		["216"] = 214,
		["217"] = 235,
		["218"] = 236,
		["219"] = 237,
		["220"] = 239,
		["221"] = 240,
		["222"] = 241,
		["223"] = 242,
		["224"] = 243,
		["225"] = 244,
		["226"] = 245,
		["227"] = 246,
		["228"] = 247,
		["229"] = 248,
		["230"] = 249,
		["231"] = 249,
		["232"] = 249,
		["233"] = 249,
		["234"] = 249,
		["235"] = 254,
		["236"] = 255,
		["237"] = 256,
		["239"] = 249,
		["240"] = 249,
		["245"] = 235,
		["246"] = 265,
		["247"] = 266,
		["248"] = 265,
		["249"] = 270,
		["250"] = 273,
		["251"] = 270,
		["252"] = 192,
		["253"] = 183,
		["254"] = 183,
		["255"] = 183,
		["256"] = 183,
		["257"] = 183,
		["258"] = 183,
		["259"] = 183,
		["260"] = 183,
		["261"] = 183,
		["262"] = 192,
		["264"] = 192,
		["265"] = 279,
		["266"] = 289,
		["267"] = 279,
		["268"] = 289,
		["269"] = 291,
		["270"] = 292,
		["271"] = 291,
		["272"] = 295,
		["273"] = 296,
		["274"] = 297,
		["275"] = 298,
		["276"] = 299,
		["277"] = 295,
		["278"] = 302,
		["279"] = 303,
		["280"] = 302,
		["281"] = 307,
		["282"] = 308,
		["283"] = 307,
		["284"] = 289,
		["285"] = 279,
		["286"] = 279,
		["287"] = 279,
		["288"] = 279,
		["289"] = 279,
		["290"] = 279,
		["291"] = 279,
		["292"] = 279,
		["293"] = 289,
		["295"] = 289,
		["296"] = 313,
		["297"] = 323,
		["298"] = 313,
		["299"] = 323,
		["300"] = 339,
		["301"] = 340,
		["302"] = 339,
		["303"] = 343,
		["304"] = 344,
		["305"] = 343,
		["306"] = 350,
		["307"] = 351,
		["308"] = 352,
		["310"] = 350,
		["311"] = 355,
		["312"] = 356,
		["313"] = 357,
		["315"] = 355,
		["316"] = 323,
		["317"] = 313,
		["318"] = 313,
		["319"] = 313,
		["320"] = 313,
		["321"] = 313,
		["322"] = 313,
		["323"] = 313,
		["324"] = 313,
		["325"] = 323,
		["327"] = 323,
		["328"] = 363,
		["329"] = 372,
		["330"] = 363,
		["331"] = 372,
		["332"] = 375,
		["333"] = 376,
		["334"] = 375,
		["335"] = 380,
		["336"] = 381,
		["337"] = 381,
		["338"] = 383,
		["339"] = 383,
		["340"] = 383,
		["341"] = 381,
		["342"] = 381,
		["343"] = 380,
		["344"] = 387,
		["345"] = 389,
		["346"] = 390,
		["348"] = 390,
		["351"] = 387,
		["352"] = 393,
		["353"] = 394,
		["354"] = 395,
		["355"] = 396,
		["356"] = 397,
		["357"] = 393,
		["358"] = 372,
		["359"] = 363,
		["360"] = 363,
		["361"] = 363,
		["362"] = 363,
		["363"] = 363,
		["364"] = 363,
		["365"] = 363,
		["366"] = 363,
		["367"] = 372,
		["369"] = 372,
		["370"] = 401,
		["371"] = 410,
		["372"] = 401,
		["373"] = 410,
		["374"] = 412,
		["375"] = 413,
		["376"] = 412,
		["377"] = 415,
		["378"] = 416,
		["379"] = 415,
		["380"] = 418,
		["381"] = 419,
		["382"] = 420,
		["383"] = 421,
		["385"] = 418,
		["386"] = 425,
		["387"] = 426,
		["388"] = 427,
		["390"] = 425,
		["391"] = 431,
		["392"] = 432,
		["393"] = 433,
		["394"] = 434,
		["395"] = 435,
		["396"] = 435,
		["397"] = 435,
		["398"] = 435,
		["399"] = 435,
		["400"] = 435,
		["402"] = 431,
		["403"] = 410,
		["404"] = 401,
		["405"] = 401,
		["406"] = 401,
		["407"] = 401,
		["408"] = 401,
		["409"] = 401,
		["410"] = 401,
		["411"] = 401,
		["412"] = 401,
		["413"] = 410,
		["415"] = 410,
		["416"] = 440,
		["417"] = 449,
		["418"] = 440,
		["419"] = 449,
		["420"] = 452,
		["421"] = 453,
		["422"] = 452,
		["423"] = 456,
		["424"] = 457,
		["425"] = 456,
		["426"] = 461,
		["427"] = 462,
		["428"] = 463,
		["429"] = 464,
		["430"] = 465,
		["431"] = 466,
		["432"] = 466,
		["433"] = 466,
		["434"] = 466,
		["435"] = 466,
		["436"] = 466,
		["437"] = 466,
		["441"] = 461,
		["442"] = 449,
		["443"] = 440,
		["444"] = 440,
		["445"] = 440,
		["446"] = 440,
		["447"] = 440,
		["448"] = 440,
		["449"] = 440,
		["450"] = 440,
		["451"] = 449,
		["453"] = 449,
		["454"] = 478,
		["455"] = 479,
		["456"] = 478,
		["457"] = 479,
		["458"] = 480,
		["459"] = 482,
		["460"] = 483,
		["461"] = 485,
		["462"] = 486,
		["463"] = 486,
		["464"] = 486,
		["465"] = 487,
		["468"] = 488,
		["469"] = 489,
		["470"] = 490,
		["471"] = 491,
		["472"] = 492,
		["473"] = 492,
		["474"] = 492,
		["475"] = 492,
		["476"] = 492,
		["477"] = 493,
		["478"] = 493,
		["479"] = 493,
		["480"] = 493,
		["481"] = 493,
		["482"] = 494,
		["483"] = 494,
		["484"] = 494,
		["485"] = 494,
		["486"] = 494,
		["487"] = 495,
		["488"] = 496,
		["489"] = 496,
		["490"] = 496,
		["491"] = 496,
		["492"] = 496,
		["493"] = 497,
		["494"] = 497,
		["495"] = 497,
		["496"] = 497,
		["497"] = 497,
		["498"] = 498,
		["499"] = 498,
		["500"] = 498,
		["501"] = 498,
		["502"] = 498,
		["503"] = 486,
		["504"] = 486,
		["505"] = 480,
		["506"] = 479,
		["507"] = 478,
		["508"] = 479,
		["510"] = 479,
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
g.silencer_talent = c()
local q = g.silencer_talent
q.name = "silencer_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_silencer_talent"
end
q = e({ j(nil) }, q)
g.silencer_talent = q
g.modifier_silencer_talent = c()
local r = g.modifier_silencer_talent
r.name = "modifier_silencer_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.attackRecordList = {}
end
function r.prototype.GetAbilitySpecialValue(self)
	self.amp_ulti_need_cnt = self:GetAbilitySpecialValueFor("amp_ulti_need_cnt")
	self.amp_ulti_pct = self:GetAbilitySpecialValueFor("amp_ulti_pct")
	self.amp_ulti_dmg_pct = self:GetAbilitySpecialValueFor("amp_ulti_dmg_pct")
	self.talent3_trigger_cnt = self:GetAbilityTalentValue("silencer_talent_3", "trigger_cnt")
	self.talent3_silencer_time = self:GetAbilityTalentValue("silencer_talent_3", "silencer_time")
	self.silencer_shard_pct = self:GetAbilityTalentValue("silencer_shard", "amp_ulti_pct")
	self.tl7_trigger_pct = self:GetAbilityTalentValue("silencer_talent_7", "trigger_pct")
	if IsServer() then
		self.silencer_shard_kill_cnt = self:GetCount("silencer_shard_kill_cnt")
		self.addUlt = self.silencer_shard_kill_cnt * self.silencer_shard_pct
		self:SetHasCustomTransmitterData(true)
	end
end
function r.prototype.OnCreated(self, s)
	local t = self:GetParent()
	self.record = 0
	self.talent3_record = 0
	self.trigger_wisdom = false
	if IsServer() then
		t:AddNewModifier(t, self:GetAbility(), "modifier_silencer_talent_buff", {})
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_KILLED] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnCustomAttackStart(self, u)
	if self:GetParent():PassivesDisabled() then
		return
	end
	local v = GetUltiPower(u.attacker) * self.amp_ulti_dmg_pct * 0.01
	local t = self:GetParent()
	t:EmitSound("Hero_Silencer.GlaivesOfWisdom")
	self:TakePureDamage(t, u.target, v)
end
function r.prototype.OnKilled(self, s)
	if IsServer() then
		if self:GetParent():GetEnemy() ~= s.target then
			return
		end
		self:AddCount(1, "silencer_shard_kill_cnt")
	end
end
function r.prototype.TakePureDamage(self, t, w, x)
	if IsInjurable(w, t) and x > 0 then
		t:DealDamage(w, self:GetAbility(), x, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
	end
	self:AddRecord()
end
function r.prototype.AddRecord(self)
	self.record = self.record + 1
	self.talent3_record = self.talent3_record + 1
	if self.amp_ulti_need_cnt <= self.record then
		self.record = 0
		self:AddModifierStackCount(self.amp_ulti_pct)
	end
	if self.talent3_trigger_cnt > 0 and self.talent3_trigger_cnt <= self.talent3_record then
		self.talent3_record = 0
		local y = self:GetParent()
		local w = y:GetEnemy()
		if IsInjurable(w) then
			AddSilence(y, w, self:GetAbility(), self.talent3_silencer_time)
		end
	end
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_NAME,
	}
end
function r.prototype.AddModifierStackCount(self, z)
	self:SetStackCount(self:GetStackCount() + z)
end
function r.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount() + self.addUlt
end
function r.prototype.EOM_GetModifierProjectileName(self)
	if IsServer() then
		if self.parent:FindModifierByName("modifier_5100065") then
			return "models/eom/hero/silencer_1/particles/sileccer_1_glaive_fx.vpcf"
		end
		return "particles/units/heroes/hero_silencer/silencer_glaives_of_wisdom.vpcf"
	end
end
function r.prototype.AddCustomTransmitterData(self)
	return { addUlt = self.addUlt }
end
function r.prototype.HandleCustomTransmitterData(self, A)
	self.addUlt = A.addUlt
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
g.modifier_silencer_talent = r
g.modifier_silencer_talent_buff = c()
local B = g.modifier_silencer_talent_buff
B.name = "modifier_silencer_talent_buff"
d(B, l)
function B.prototype.GetAbilitySpecialValue(self)
	self.talent1_rate = self:GetAbilityTalentValue("silencer_talent_1", "add_atk_rate_pct")
	self.talent4_trigger_cnt = self:GetAbilityTalentValue("silencer_talent_4", "trigger_magical_cnt")
end
function B.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
	}
end
function B.prototype.OnCreated(self, s)
	self.talent4_damage_record = 0
end
function B.prototype.OnBattleStartBefore(self, s)
	local y = self:GetParent()
	local w = y:GetEnemy()
	self.talent4_trigger_cnt = self:GetAbilityTalentValue("silencer_talent_4", "trigger_magical_cnt")
	if IsValid(w) then
		if self:HasTalent("silencer_talent_2") then
			w:AddNewModifier(y, self:GetAbility(), "modifier_silencer_talent_2_debuff", {})
		end
		if self:HasTalent("silencer_talent_5") then
			w:AddNewModifier(y, self:GetAbility(), "modifier_silencer_talent_5_debuff", {})
		end
		if self:HasTalent("silencer_talent_6") then
			y:AddNewModifier(y, self:GetAbility(), "modifier_silencer_talent_6", {})
		end
		if self:HasTalent("silencer_talent_7") then
			w:AddNewModifier(y, self:GetAbility(), "modifier_silencer_talent7_debuff", {})
		end
	end
end
function B.prototype.OnCustomTakeDamage(self, u)
	local t = u.attacker
	local w = u.target
	if self.talent4_trigger_cnt > 0 and IsInjurable(t, w) then
		if w:IsSilenced() and u.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
			self.talent4_damage_record = self.talent4_damage_record + 1
			if self.talent4_trigger_cnt <= self.talent4_damage_record then
				self.talent4_damage_record = 0
				local C = t:FindModifierByName("modifier_silencer_talent")
				local v = t:GetUltiPower() - w:GetUltiPower()
				DamageSystem:performAttack(t, w, {})
				if C ~= nil then
					t:EmitSound("Hero_Silencer.GlaivesOfWisdom")
					Projectile:CreateTrackingProjectile({
						EffectName = "particles/units/heroes/hero_silencer/silencer_glaives_of_wisdom.vpcf",
						hCaster = t,
						hTarget = w,
						iMoveSpeed = t:GetProjectileSpeed(),
						OnProjectileHit = function(D, E, F)
							if IsValid(self) and IsInjurable(D) then
								C:TakePureDamage(t, w, v)
							end
						end,
					})
				end
			end
		end
	end
end
function B.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function B.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	return self.talent1_rate * self:GetParent():GetUltiPower() * 0.01
end
B = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	B
)
g.modifier_silencer_talent_buff = B
g.modifier_silencer_talent_2_debuff = c()
local G = g.modifier_silencer_talent_2_debuff
G.name = "modifier_silencer_talent_2_debuff"
d(G, l)
function G.prototype.GetAbilitySpecialValue(self)
	self.talent2_damage = self:GetAbilityTalentValue("silencer_talent_2", "damage")
end
function G.prototype.TakeMagicalDamage(self)
	local t = self:GetCaster()
	local y = self:GetParent()
	local H = t:FindAbilityByName("silencer_show")
	t:DealDamage(y, H, self.talent2_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
function G.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_END] = { self:GetCaster() } }
end
function G.prototype.OnSilenceEnd(self)
	self:TakeMagicalDamage()
end
G = e(
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
	G
)
g.modifier_silencer_talent_2_debuff = G
g.modifier_silencer_talent_5_debuff = c()
local I = g.modifier_silencer_talent_5_debuff
I.name = "modifier_silencer_talent_5_debuff"
d(I, l)
function I.prototype.GetAbilitySpecialValue(self)
	self.talent5_damage_add_pct = self:GetAbilityTalentValue("silencer_talent_5", "damage_add_pct")
end
function I.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE,
	}
end
function I.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	if self:GetParent():IsSilenced() then
		return -self.talent5_damage_add_pct
	end
end
function I.prototype.EOM_GetModifierIncomingDamagePercentage(self, s)
	if self:GetParent():IsSilenced() then
		return self.talent5_damage_add_pct
	end
end
I = e(
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
	I
)
g.modifier_silencer_talent_5_debuff = I
g.modifier_silencer_talent_6 = c()
local J = g.modifier_silencer_talent_6
J.name = "modifier_silencer_talent_6"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.talent6_damage = self:GetAbilityTalentValue("silencer_talent_6", "damage")
end
function J.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SILENCE_ADD] = { self:GetParent(), -1 },
	}
end
function J.prototype.OnCustomAbilityFullyCast(self, u)
	if u and u.unit == self:GetParent():GetEnemy() then
		local K = u.unit
		if K ~= nil then
			K:RemoveModifierByName("modifier_silencer_talent_6_Atk")
		end
	end
end
function J.prototype.OnSilenceAdd(self)
	local t = self:GetCaster()
	local L = t:GetEnemy()
	local H = t:FindAbilityByName("silencer_show15")
	L:AddNewModifier(t, H, "modifier_silencer_talent_6_Atk", { duration = 999 })
end
J = e(
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
	J
)
g.modifier_silencer_talent_6 = J
g.modifier_silencer_talent_6_Atk = c()
local M = g.modifier_silencer_talent_6_Atk
M.name = "modifier_silencer_talent_6_Atk"
d(M, l)
function M.prototype.GetTexture(self)
	return "silencer_glaives_of_wisdom"
end
function M.prototype.GetAbilitySpecialValue(self)
	self.talent6_damage = self:GetAbilityTalentValue("silencer_talent_6", "damage")
end
function M.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(1)
	end
end
function M.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function M.prototype.OnIntervalThink(self)
	if IsServer() then
		local t = self:GetCaster()
		local w = self:GetParent()
		t:DealDamage(
			w,
			self:GetAbility(),
			self.talent6_damage * self:GetStackCount(),
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		)
	end
end
M = e(
	{
		m(
			a,
			{
				IsHidden = false,
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
g.modifier_silencer_talent_6_Atk = M
g.modifier_silencer_talent7_debuff = c()
local N = g.modifier_silencer_talent7_debuff
N.name = "modifier_silencer_talent7_debuff"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.tl7_trigger_pct = self:GetAbilityTalentValue("silencer_talent_7", "trigger_pct")
end
function N.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self.parent } }
end
function N.prototype.OnCustomTakeDamage(self, u)
	if
		(u.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK or u.damage_type == DAMAGE_TYPE_MAGICAL)
		and self.parent:IsSilenced()
	then
		if bit.band(u.damage_flags, DamageFlags.DAMAGE_FLAG_NO_EXTRA) ~= DamageFlags.DAMAGE_FLAG_NO_EXTRA then
			if self:PRD(self.tl7_trigger_pct, "tl7_trigger_pct") then
				local O = math.abs(GetUltiPower(u.attacker) - GetUltiPower(self.parent))
				u.attacker:DealDamage(
					self.parent,
					self:GetAbility(),
					O,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
					DamageFlags.DAMAGE_FLAG_NO_EXTRA
				)
			end
		end
	end
end
N = e(
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
	N
)
g.modifier_silencer_talent7_debuff = N
g.silencer_ult = c()
local P = g.silencer_ult
P.name = "silencer_ult"
d(P, o)
function P.prototype.OnSpellStart(self)
	local t = self:GetCaster()
	local L = t:GetEnemy()
	t:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	self:GameTimer(0.4, function()
		if not IsInjurable(t, L) then
			return
		end
		t:EmitSound("CustomHero_Silencer.GlobalSlience")
		local Q = self:GetSpecialValueFor("silence_time")
		AddSilence(t, L, self, Q)
		local R = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_silencer/silencer_global_silence.vpcf",
			PATTACH_CUSTOMORIGIN,
			t
		)
		ParticleManager:SetParticleControl(R, 0, t:GetAbsOrigin() + Vector(0, 0, 64))
		ParticleManager:SetParticleControl(R, 1, t:GetAbsOrigin() + Vector(0, 0, 64))
		ParticleManager:SetParticleControl(R, 11, Vector(255, 0, 0))
		local S = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_silencer/silencer_global_silence_hero.vpcf",
			PATTACH_CUSTOMORIGIN,
			L
		)
		ParticleManager:SetParticleControl(S, 0, L:GetAbsOrigin() + Vector(0, 0, 64))
		ParticleManager:SetParticleControl(S, 1, L:GetAbsOrigin() + Vector(0, 0, 64))
		ParticleManager:SetParticleControl(R, 11, Vector(255, 0, 0))
	end)
end
P = e({ p(nil) }, P)
g.silencer_ult = P
return g