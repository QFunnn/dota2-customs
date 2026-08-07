--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/undying"
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
		["17"] = 7,
		["18"] = 8,
		["19"] = 7,
		["20"] = 8,
		["21"] = 9,
		["22"] = 10,
		["23"] = 9,
		["24"] = 8,
		["25"] = 7,
		["26"] = 8,
		["28"] = 8,
		["29"] = 14,
		["30"] = 22,
		["31"] = 14,
		["32"] = 22,
		["34"] = 22,
		["35"] = 29,
		["36"] = 30,
		["37"] = 14,
		["38"] = 31,
		["39"] = 33,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["43"] = 39,
		["44"] = 31,
		["45"] = 41,
		["46"] = 42,
		["47"] = 43,
		["49"] = 41,
		["50"] = 46,
		["51"] = 47,
		["52"] = 47,
		["53"] = 47,
		["54"] = 50,
		["55"] = 50,
		["56"] = 50,
		["57"] = 47,
		["58"] = 51,
		["59"] = 51,
		["60"] = 51,
		["61"] = 47,
		["62"] = 47,
		["63"] = 46,
		["64"] = 54,
		["65"] = 55,
		["66"] = 56,
		["67"] = 54,
		["68"] = 58,
		["69"] = 59,
		["70"] = 58,
		["71"] = 61,
		["72"] = 62,
		["73"] = 63,
		["74"] = 64,
		["75"] = 65,
		["77"] = 61,
		["78"] = 68,
		["79"] = 69,
		["80"] = 70,
		["81"] = 71,
		["84"] = 74,
		["85"] = 75,
		["88"] = 76,
		["89"] = 77,
		["90"] = 77,
		["91"] = 77,
		["92"] = 78,
		["95"] = 81,
		["96"] = 82,
		["97"] = 83,
		["98"] = 84,
		["99"] = 84,
		["100"] = 84,
		["101"] = 84,
		["102"] = 84,
		["103"] = 84,
		["104"] = 84,
		["105"] = 84,
		["106"] = 85,
		["107"] = 85,
		["108"] = 85,
		["109"] = 85,
		["110"] = 85,
		["111"] = 86,
		["112"] = 87,
		["113"] = 87,
		["114"] = 87,
		["115"] = 87,
		["116"] = 87,
		["117"] = 87,
		["118"] = 90,
		["119"] = 90,
		["120"] = 90,
		["121"] = 90,
		["122"] = 90,
		["123"] = 90,
		["124"] = 94,
		["125"] = 94,
		["126"] = 94,
		["127"] = 94,
		["128"] = 94,
		["129"] = 94,
		["130"] = 98,
		["131"] = 77,
		["132"] = 77,
		["133"] = 68,
		["134"] = 22,
		["135"] = 14,
		["136"] = 14,
		["137"] = 14,
		["138"] = 14,
		["139"] = 14,
		["140"] = 14,
		["141"] = 14,
		["142"] = 14,
		["143"] = 22,
		["145"] = 22,
		["146"] = 103,
		["147"] = 112,
		["148"] = 103,
		["149"] = 112,
		["150"] = 116,
		["151"] = 118,
		["152"] = 120,
		["153"] = 121,
		["154"] = 116,
		["155"] = 123,
		["156"] = 124,
		["157"] = 123,
		["158"] = 126,
		["159"] = 127,
		["160"] = 128,
		["162"] = 126,
		["163"] = 131,
		["164"] = 132,
		["165"] = 133,
		["166"] = 134,
		["169"] = 131,
		["170"] = 138,
		["171"] = 139,
		["172"] = 138,
		["173"] = 144,
		["174"] = 145,
		["175"] = 144,
		["176"] = 147,
		["177"] = 148,
		["178"] = 147,
		["179"] = 112,
		["180"] = 103,
		["181"] = 103,
		["182"] = 103,
		["183"] = 103,
		["184"] = 103,
		["185"] = 103,
		["186"] = 103,
		["187"] = 103,
		["188"] = 103,
		["189"] = 112,
		["191"] = 112,
		["192"] = 152,
		["193"] = 161,
		["194"] = 152,
		["195"] = 161,
		["196"] = 162,
		["197"] = 163,
		["198"] = 162,
		["199"] = 165,
		["200"] = 166,
		["201"] = 167,
		["202"] = 168,
		["203"] = 169,
		["204"] = 169,
		["205"] = 169,
		["206"] = 169,
		["207"] = 169,
		["208"] = 170,
		["209"] = 170,
		["210"] = 170,
		["211"] = 170,
		["212"] = 170,
		["213"] = 170,
		["214"] = 170,
		["215"] = 170,
		["218"] = 165,
		["219"] = 174,
		["220"] = 175,
		["221"] = 174,
		["222"] = 179,
		["223"] = 180,
		["224"] = 181,
		["226"] = 183,
		["228"] = 179,
		["229"] = 161,
		["230"] = 152,
		["231"] = 152,
		["232"] = 152,
		["233"] = 152,
		["234"] = 152,
		["235"] = 152,
		["236"] = 152,
		["237"] = 152,
		["238"] = 161,
		["240"] = 161,
		["241"] = 190,
		["242"] = 191,
		["243"] = 190,
		["244"] = 191,
		["245"] = 192,
		["246"] = 193,
		["247"] = 194,
		["248"] = 195,
		["251"] = 198,
		["252"] = 199,
		["253"] = 200,
		["254"] = 192,
		["255"] = 191,
		["256"] = 190,
		["257"] = 191,
		["259"] = 191,
		["260"] = 206,
		["261"] = 215,
		["262"] = 206,
		["263"] = 215,
		["264"] = 223,
		["265"] = 224,
		["266"] = 225,
		["267"] = 228,
		["268"] = 229,
		["269"] = 223,
		["270"] = 231,
		["271"] = 232,
		["272"] = 233,
		["273"] = 234,
		["274"] = 235,
		["275"] = 236,
		["276"] = 237,
		["277"] = 237,
		["278"] = 237,
		["279"] = 237,
		["280"] = 237,
		["281"] = 237,
		["282"] = 237,
		["283"] = 237,
		["284"] = 237,
		["285"] = 237,
		["286"] = 248,
		["287"] = 249,
		["288"] = 249,
		["289"] = 249,
		["290"] = 249,
		["291"] = 249,
		["293"] = 231,
		["294"] = 252,
		["295"] = 253,
		["296"] = 254,
		["297"] = 255,
		["298"] = 256,
		["299"] = 257,
		["300"] = 257,
		["301"] = 257,
		["302"] = 257,
		["303"] = 257,
		["304"] = 258,
		["305"] = 258,
		["306"] = 258,
		["307"] = 258,
		["308"] = 258,
		["309"] = 259,
		["310"] = 260,
		["311"] = 261,
		["312"] = 262,
		["313"] = 263,
		["316"] = 266,
		["317"] = 267,
		["318"] = 267,
		["319"] = 267,
		["320"] = 267,
		["321"] = 267,
		["322"] = 267,
		["323"] = 268,
		["324"] = 269,
		["325"] = 269,
		["326"] = 269,
		["327"] = 269,
		["328"] = 269,
		["329"] = 269,
		["330"] = 271,
		["331"] = 272,
		["332"] = 272,
		["333"] = 272,
		["334"] = 272,
		["335"] = 272,
		["336"] = 272,
		["337"] = 275,
		["338"] = 275,
		["339"] = 275,
		["340"] = 275,
		["341"] = 275,
		["342"] = 275,
		["345"] = 252,
		["346"] = 281,
		["347"] = 282,
		["348"] = 281,
		["349"] = 215,
		["350"] = 206,
		["351"] = 206,
		["352"] = 206,
		["353"] = 206,
		["354"] = 206,
		["355"] = 206,
		["356"] = 206,
		["357"] = 206,
		["358"] = 215,
		["360"] = 215,
		["361"] = 289,
		["362"] = 297,
		["363"] = 289,
		["364"] = 297,
		["365"] = 298,
		["366"] = 299,
		["367"] = 298,
		["368"] = 303,
		["369"] = 304,
		["372"] = 305,
		["375"] = 306,
		["376"] = 307,
		["377"] = 307,
		["378"] = 307,
		["379"] = 307,
		["380"] = 307,
		["381"] = 307,
		["382"] = 307,
		["383"] = 307,
		["384"] = 308,
		["386"] = 303,
		["387"] = 297,
		["388"] = 289,
		["389"] = 289,
		["390"] = 289,
		["391"] = 289,
		["392"] = 289,
		["393"] = 289,
		["394"] = 289,
		["395"] = 289,
		["396"] = 297,
		["398"] = 297,
		["399"] = 313,
		["400"] = 321,
		["401"] = 313,
		["402"] = 321,
		["403"] = 322,
		["404"] = 323,
		["405"] = 324,
		["407"] = 326,
		["408"] = 326,
		["409"] = 326,
		["410"] = 326,
		["411"] = 326,
		["413"] = 322,
		["414"] = 329,
		["415"] = 330,
		["416"] = 329,
		["417"] = 332,
		["418"] = 333,
		["419"] = 334,
		["421"] = 336,
		["422"] = 336,
		["423"] = 336,
		["424"] = 336,
		["425"] = 336,
		["427"] = 332,
		["428"] = 339,
		["429"] = 340,
		["430"] = 339,
		["431"] = 344,
		["432"] = 345,
		["433"] = 345,
		["434"] = 345,
		["435"] = 345,
		["436"] = 344,
		["437"] = 321,
		["438"] = 313,
		["439"] = 313,
		["440"] = 313,
		["441"] = 313,
		["442"] = 313,
		["443"] = 313,
		["444"] = 313,
		["445"] = 313,
		["446"] = 321,
		["448"] = 321,
		["449"] = 351,
		["450"] = 352,
		["451"] = 351,
		["452"] = 352,
		["453"] = 353,
		["454"] = 354,
		["455"] = 353,
		["456"] = 352,
		["457"] = 351,
		["458"] = 352,
		["460"] = 352,
		["461"] = 358,
		["462"] = 366,
		["463"] = 358,
		["464"] = 366,
		["465"] = 367,
		["466"] = 368,
		["467"] = 367,
		["468"] = 371,
		["469"] = 372,
		["470"] = 371,
		["471"] = 374,
		["472"] = 375,
		["473"] = 374,
		["474"] = 379,
		["475"] = 380,
		["476"] = 381,
		["477"] = 381,
		["478"] = 381,
		["480"] = 381,
		["481"] = 382,
		["482"] = 383,
		["483"] = 379,
		["484"] = 385,
		["485"] = 386,
		["486"] = 385,
		["487"] = 390,
		["488"] = 391,
		["489"] = 390,
		["490"] = 366,
		["491"] = 358,
		["492"] = 358,
		["493"] = 358,
		["494"] = 358,
		["495"] = 358,
		["496"] = 358,
		["497"] = 358,
		["498"] = 358,
		["499"] = 366,
		["501"] = 366,
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
g.undying_talent = c()
local q = g.undying_talent
q.name = "undying_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_undying_talent"
end
q = e({ j(nil) }, q)
g.undying_talent = q
g.modifier_undying_talent = c()
local r = g.modifier_undying_talent
r.name = "modifier_undying_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
	self.calculated_threshold = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
		- self:GetAbilityTalentValue("undying_talent_1", "threshold_reduce")
	self.steal_pct = self:GetAbilitySpecialValueFor("steal_pct")
		+ self:GetAbilityTalentValue("undying_talent_2", "bonus_steal")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.mana = self:GetAbilitySpecialValueFor("mana")
	self.heal = self:GetAbilitySpecialValueFor("heal") + self:GetAbilityTalentValue("undying_talent_7", "bonus_heal")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self.calculated_threshold = self:GetParent():GetMaxHealth() * self.threshold * 0.01
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { nil, self:GetParent() },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	self.record = 0
	self.calculated_threshold = self:GetParent():GetMaxHealth() * self.threshold * 0.01
end
function r.prototype.OnBattleStart(self, s)
	self.calculated_threshold = self:GetParent():GetMaxHealth() * self.threshold * 0.01
end
function r.prototype.OnCustomTakeDamage(self, t)
	self.record = self.record + t.damage
	if self.record >= self.calculated_threshold then
		self.record = self.record - self.calculated_threshold
		self:Decay()
	end
end
function r.prototype.Decay(self)
	local u = self:GetParent()
	local v = u:GetEnemy()
	if not IsInjurable(u, v) then
		return
	end
	RestoreCustomMana(u, self.mana)
	if self.parent:PassivesDisabled() then
		return
	end
	u:StartGesture(ACT_DOTA_UNDYING_DECAY)
	GameTimer(0.3, function()
		if not (IsValid(self) and IsInjurable(u, v)) then
			return
		end
		u:EmitSound("Hero_Undying.Decay.Cast")
		v:EmitSound("Hero_Undying.Decay.Target")
		local w = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_undying/undying_decay.vpcf",
			PATTACH_CUSTOMORIGIN,
			u
		)
		ParticleManager:SetParticleControl(w, 0, GetGroundPosition(v:GetAbsOrigin(), nil))
		ParticleManager:SetParticleControl(w, 1, Vector(0, 0, 0))
		local x = v:GetMaxHealth() * self.steal_pct * 0.01
		u:AddNewModifier(u, self:GetAbility(), "modifier_undying_talent_steal_count", { duration = self.duration })
		u:AddNewModifier(
			u,
			self:GetAbility(),
			"modifier_undying_talent_steal",
			{ duration = self.duration, stealValue = x }
		)
		v:AddNewModifier(
			u,
			self:GetAbility(),
			"modifier_undying_talent_steal",
			{ duration = self.duration, stealValue = x }
		)
		Heal(u, self.heal, "undying_talent", "Ability")
	end)
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
g.modifier_undying_talent = r
g.modifier_undying_talent_steal_count = c()
local y = g.modifier_undying_talent_steal_count
y.name = "modifier_undying_talent_steal_count"
d(y, l)
function y.prototype.GetAbilitySpecialValue(self)
	self.tl3_heal_pct = self:GetAbilityTalentValue("undying_talent_3", "heal_pct")
	self.s_bonus_heal = self:GetAbilityTalentValue("undying_shard", "bonus_heal")
	self.s_max_stack = self:GetAbilityTalentValue("undying_shard", "max_stack")
end
function y.prototype.GetTexture(self)
	return "modifier_undying_talent_steal_count"
end
function y.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function y.prototype.OnRefresh(self, s)
	if IsServer() then
		if self.s_max_stack <= 0 or self:GetStackCount() < self.s_max_stack then
			self:IncrementStackCount()
		end
	end
end
function y.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY,
	}
end
function y.prototype.EOM_GetModifierHeal_Bonus(self, s)
	return self.s_bonus_heal * self:GetStackCount()
end
function y.prototype.EOM_GetModifierHealAmplity(self, s)
	return self.tl3_heal_pct
end
y = e(
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
				IsIndependent = true,
			}
		),
	},
	y
)
g.modifier_undying_talent_steal_count = y
g.modifier_undying_talent_steal = c()
local z = g.modifier_undying_talent_steal
z.name = "modifier_undying_talent_steal"
d(z, l)
function z.prototype.IsDebuff(self)
	return self:GetParent() ~= self:GetCaster()
end
function z.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(Round(s.stealValue))
		if not self:IsDebuff() then
			local w = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_undying/undying_decay_strength_buff.vpcf",
				PATTACH_CUSTOMORIGIN,
				self:GetParent()
			)
			self:AddParticle(w, false, false, -1, false, false)
		end
	end
end
function z.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function z.prototype.EOM_GetModifierHealthBonus(self, s)
	if self:IsDebuff() then
		return -self:GetStackCount()
	else
		return self:GetStackCount()
	end
end
z = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	z
)
g.modifier_undying_talent_steal = z
g.undying_ult = c()
local A = g.undying_ult
A.name = "undying_ult"
d(A, o)
function A.prototype.OnSpellStart(self)
	local B = self:GetCaster()
	local v = B:GetEnemy()
	if not IsInjurable(B, v) then
		return
	end
	local C = self:GetTalentValue("undying_talent_5", "add_ult_duration")
	local D = self:GetSpecialValueFor("duration") + C
	B:AddNewModifier(B, self, "modifier_undying_ult", { duration = D })
end
A = e({ p(nil) }, A)
g.undying_ult = A
g.modifier_undying_ult = c()
local E = g.modifier_undying_ult
E.name = "modifier_undying_ult"
d(E, l)
function E.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.bonus_pct = self:GetAbilitySpecialValueFor("bonus_pct")
		+ self:GetAbilityTalentValue("undying_talent_5", "ult_dmg_pct")
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
end
function E.prototype.OnCreated(self, s)
	if IsServer() then
		self.health_record = self:GetParent():GetHealthDeficit()
		local u = self:GetParent()
		u:SetModelScale(0.01)
		u:EmitSound("Hero_Undying.Tombstone")
		self.dummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = u:GetAbsOrigin(),
				model = Wearable:getReplaceUnitModel(u, "models/heroes/undying/undying_tower.vmdl"),
				angles = u:GetForwardVector(),
				use_animgraph = "1",
				ModelScale = 0.7,
			}
		)
		local w = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_undying/undying_tombstone.vpcf",
			PATTACH_CUSTOMORIGIN,
			u
		)
		ParticleManager:SetParticleControl(w, 0, self.dummy:GetAbsOrigin())
	end
end
function E.prototype.OnDestroy(self)
	if IsServer() then
		local u = self:GetParent()
		local v = u:GetEnemy()
		local w = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_undying/undying_tower_destruction.vpcf",
			PATTACH_CUSTOMORIGIN,
			u
		)
		ParticleManager:SetParticleControl(w, 0, self.dummy:GetAbsOrigin())
		ParticleManager:SetParticleControl(w, 1, self.dummy:GetAbsOrigin())
		self.dummy:Remove()
		u:SetModelScale(u:GetDefaultModelScale())
		u:StopSound("Hero_Undying.Tombstone")
		u:EmitSound("Hero_Undying.Tombstone.Destruction")
		if not IsInjurable(u, v) then
			return
		end
		local F = self.damage + self.health_record * self.bonus_pct * 0.01
		u:DealDamage(v, self:GetAbility(), F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
		local G = F * self.heal_pct * 0.01
		Heal(u, G, self:GetAbility():GetAbilityName(), "Ability")
		if self:HasTalent("undying_talent_6") then
			v:AddNewModifier(
				u,
				self:GetAbility(),
				"modifier_undying_talent_6_debuff",
				{ duration = BUFF_VALUE.FleshGolemDuration }
			)
			u:AddNewModifier(
				u,
				self:GetAbility(),
				"modifier_undying_talent_6",
				{ duration = BUFF_VALUE.FleshGolemDuration }
			)
		end
	end
end
function E.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE] = 100 }
end
E = e(
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
	E
)
g.modifier_undying_ult = E
g.modifier_undying_talent_6_debuff = c()
local H = g.modifier_undying_talent_6_debuff
H.name = "modifier_undying_talent_6_debuff"
d(H, l)
function H.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE }
end
function H.prototype.EOM_GetModifierGainReductionPercentage(self, s)
	if s.type ~= "heal" then
		return
	end
	if s.flag ~= nil and bit.band(s.flag, HealFlags.HEAL_FLAG_RAIN) == HealFlags.HEAL_FLAG_RAIN then
		return
	end
	if self:PRD(BUFF_VALUE.FleshGolemChance) then
		Heal(
			self:GetCaster(),
			s.count,
			"undying_talent_6",
			"Ability",
			true,
			HealFlags.HEAL_FLAG_RAIN + HealFlags.HEAL_FLAG_IGNORE_ADJUST
		)
		return 1000
	end
end
H = e(
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
	H
)
g.modifier_undying_talent_6_debuff = H
g.modifier_undying_talent_6 = c()
local I = g.modifier_undying_talent_6
I.name = "modifier_undying_talent_6"
d(I, l)
function I.prototype.OnCreated(self, s)
	if IsServer() then
		self:GetParent():EmitSound("Hero_Undying.FleshGolem.Cast")
	else
		ParticleManager:CreateParticle(
			"particles/units/heroes/hero_undying/undying_fg_transform.vpcf",
			PATTACH_ABSORIGIN,
			self:GetParent()
		)
	end
end
function I.prototype.OnRefresh(self, s)
	self:OnCreated(s)
end
function I.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():EmitSound("Hero_Undying.FleshGolem.End")
	else
		ParticleManager:CreateParticle(
			"particles/units/heroes/hero_undying/undying_fg_transform_reverse.vpcf",
			PATTACH_ABSORIGIN,
			self:GetParent()
		)
	end
end
function I.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function I.prototype.GetModifierModelChange(self)
	return Wearable:getReplaceUnitModel(self:GetParent(), "models/heroes/undying/undying_flesh_golem.vmdl")
end
I = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	I
)
g.modifier_undying_talent_6 = I
g.undying_talent_4 = c()
local J = g.undying_talent_4
J.name = "undying_talent_4"
d(J, o)
function J.prototype.GetIntrinsicModifierName(self)
	return "modifier_undying_talent_4"
end
J = e({ p(nil) }, J)
g.undying_talent_4 = J
g.modifier_undying_talent_4 = c()
local K = g.modifier_undying_talent_4
K.name = "modifier_undying_talent_4"
d(K, l)
function K.prototype.GetTexture(self)
	return "modifier_undying_talent_5"
end
function K.prototype.GetAbilitySpecialValue(self)
	self.bonus_hp = self:GetAbilitySpecialValueFor("bonus_hp")
end
function K.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function K.prototype.OnBattleStartBefore(self, s)
	local L = self:GetParent():GetPlayerOwnerID()
	local M = PlayerData:loadData(L, "undying_talent_4")
	if M == nil then
		M = 0
	end
	local N = M
	self:SetStackCount(N)
	PlayerData:saveData(L, "undying_talent_4", N + 1)
end
function K.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function K.prototype.EOM_GetModifierHealthBonus(self, s)
	return self.bonus_hp * self:GetStackCount()
end
K = e(
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
	K
)
g.modifier_undying_talent_4 = K
return g