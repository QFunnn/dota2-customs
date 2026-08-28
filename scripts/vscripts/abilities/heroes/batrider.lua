--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/batrider"
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
		["33"] = 34,
		["34"] = 35,
		["35"] = 36,
		["36"] = 37,
		["37"] = 38,
		["38"] = 39,
		["39"] = 40,
		["40"] = 41,
		["41"] = 42,
		["42"] = 43,
		["43"] = 34,
		["44"] = 45,
		["45"] = 46,
		["46"] = 46,
		["47"] = 48,
		["48"] = 48,
		["49"] = 48,
		["50"] = 46,
		["51"] = 46,
		["52"] = 46,
		["53"] = 45,
		["54"] = 58,
		["55"] = 59,
		["56"] = 60,
		["57"] = 61,
		["59"] = 63,
		["60"] = 64,
		["61"] = 65,
		["62"] = 66,
		["63"] = 67,
		["64"] = 67,
		["65"] = 67,
		["66"] = 67,
		["67"] = 67,
		["68"] = 67,
		["69"] = 67,
		["70"] = 67,
		["71"] = 67,
		["72"] = 68,
		["73"] = 68,
		["74"] = 68,
		["75"] = 68,
		["76"] = 68,
		["77"] = 68,
		["78"] = 68,
		["79"] = 68,
		["80"] = 68,
		["81"] = 71,
		["83"] = 58,
		["84"] = 74,
		["85"] = 75,
		["86"] = 74,
		["87"] = 77,
		["88"] = 78,
		["89"] = 79,
		["91"] = 77,
		["92"] = 83,
		["93"] = 83,
		["94"] = 83,
		["96"] = 84,
		["97"] = 85,
		["98"] = 86,
		["99"] = 87,
		["100"] = 87,
		["101"] = 87,
		["102"] = 88,
		["103"] = 89,
		["104"] = 90,
		["105"] = 90,
		["106"] = 90,
		["107"] = 90,
		["108"] = 90,
		["109"] = 90,
		["110"] = 90,
		["111"] = 90,
		["112"] = 90,
		["113"] = 92,
		["114"] = 92,
		["115"] = 92,
		["116"] = 92,
		["117"] = 92,
		["118"] = 93,
		["119"] = 93,
		["120"] = 93,
		["121"] = 93,
		["122"] = 93,
		["123"] = 93,
		["124"] = 93,
		["125"] = 93,
		["126"] = 93,
		["127"] = 97,
		["128"] = 97,
		["129"] = 97,
		["130"] = 98,
		["131"] = 99,
		["132"] = 100,
		["133"] = 101,
		["134"] = 101,
		["135"] = 101,
		["136"] = 101,
		["137"] = 101,
		["138"] = 101,
		["140"] = 103,
		["141"] = 104,
		["142"] = 105,
		["143"] = 106,
		["144"] = 107,
		["145"] = 107,
		["146"] = 107,
		["147"] = 107,
		["148"] = 107,
		["149"] = 107,
		["150"] = 107,
		["153"] = 110,
		["154"] = 111,
		["155"] = 112,
		["156"] = 113,
		["157"] = 114,
		["158"] = 115,
		["159"] = 115,
		["160"] = 115,
		["161"] = 116,
		["162"] = 117,
		["163"] = 117,
		["164"] = 117,
		["165"] = 117,
		["166"] = 117,
		["167"] = 117,
		["168"] = 117,
		["169"] = 117,
		["170"] = 117,
		["171"] = 119,
		["172"] = 119,
		["173"] = 119,
		["174"] = 119,
		["175"] = 119,
		["176"] = 121,
		["177"] = 121,
		["178"] = 121,
		["179"] = 121,
		["180"] = 121,
		["181"] = 121,
		["182"] = 121,
		["183"] = 121,
		["184"] = 121,
		["185"] = 122,
		["186"] = 123,
		["187"] = 123,
		["188"] = 123,
		["189"] = 124,
		["190"] = 125,
		["191"] = 126,
		["192"] = 126,
		["193"] = 126,
		["194"] = 126,
		["195"] = 126,
		["196"] = 126,
		["197"] = 127,
		["199"] = 129,
		["200"] = 123,
		["201"] = 123,
		["202"] = 115,
		["203"] = 115,
		["206"] = 97,
		["207"] = 97,
		["208"] = 87,
		["209"] = 87,
		["210"] = 83,
		["211"] = 137,
		["212"] = 138,
		["213"] = 139,
		["214"] = 140,
		["215"] = 141,
		["217"] = 143,
		["218"] = 144,
		["219"] = 145,
		["222"] = 148,
		["223"] = 137,
		["224"] = 151,
		["225"] = 152,
		["226"] = 151,
		["227"] = 161,
		["228"] = 162,
		["229"] = 163,
		["230"] = 164,
		["232"] = 166,
		["233"] = 167,
		["235"] = 170,
		["236"] = 171,
		["239"] = 174,
		["240"] = 161,
		["241"] = 176,
		["242"] = 177,
		["243"] = 176,
		["244"] = 181,
		["245"] = 182,
		["246"] = 181,
		["247"] = 21,
		["248"] = 13,
		["249"] = 13,
		["250"] = 13,
		["251"] = 13,
		["252"] = 13,
		["253"] = 13,
		["254"] = 13,
		["255"] = 13,
		["256"] = 21,
		["258"] = 21,
		["259"] = 186,
		["260"] = 193,
		["261"] = 186,
		["262"] = 193,
		["263"] = 199,
		["264"] = 200,
		["265"] = 199,
		["266"] = 202,
		["267"] = 203,
		["268"] = 204,
		["269"] = 206,
		["270"] = 202,
		["271"] = 208,
		["272"] = 209,
		["273"] = 210,
		["274"] = 211,
		["275"] = 212,
		["278"] = 208,
		["279"] = 217,
		["280"] = 218,
		["281"] = 219,
		["283"] = 217,
		["284"] = 222,
		["285"] = 223,
		["286"] = 224,
		["288"] = 222,
		["289"] = 227,
		["290"] = 228,
		["291"] = 227,
		["292"] = 232,
		["293"] = 233,
		["294"] = 232,
		["295"] = 238,
		["296"] = 239,
		["297"] = 241,
		["298"] = 242,
		["300"] = 245,
		["301"] = 246,
		["303"] = 249,
		["304"] = 250,
		["306"] = 253,
		["307"] = 254,
		["309"] = 256,
		["310"] = 238,
		["311"] = 258,
		["312"] = 259,
		["313"] = 260,
		["315"] = 258,
		["316"] = 193,
		["317"] = 186,
		["318"] = 186,
		["319"] = 186,
		["320"] = 186,
		["321"] = 186,
		["322"] = 186,
		["323"] = 186,
		["324"] = 193,
		["326"] = 193,
		["327"] = 266,
		["328"] = 274,
		["329"] = 266,
		["330"] = 274,
		["331"] = 275,
		["332"] = 275,
		["333"] = 278,
		["334"] = 279,
		["335"] = 278,
		["336"] = 283,
		["337"] = 284,
		["338"] = 283,
		["339"] = 286,
		["340"] = 286,
		["341"] = 274,
		["342"] = 266,
		["343"] = 266,
		["344"] = 266,
		["345"] = 266,
		["346"] = 266,
		["347"] = 266,
		["348"] = 266,
		["349"] = 266,
		["350"] = 274,
		["352"] = 274,
		["353"] = 290,
		["354"] = 291,
		["355"] = 290,
		["356"] = 291,
		["357"] = 292,
		["358"] = 293,
		["359"] = 292,
		["360"] = 291,
		["361"] = 290,
		["362"] = 291,
		["364"] = 291,
		["365"] = 297,
		["366"] = 305,
		["367"] = 297,
		["368"] = 305,
		["369"] = 307,
		["370"] = 308,
		["371"] = 307,
		["372"] = 310,
		["373"] = 311,
		["374"] = 310,
		["375"] = 315,
		["376"] = 316,
		["377"] = 317,
		["378"] = 318,
		["379"] = 318,
		["380"] = 318,
		["381"] = 318,
		["382"] = 318,
		["383"] = 318,
		["384"] = 319,
		["387"] = 315,
		["388"] = 305,
		["389"] = 297,
		["390"] = 297,
		["391"] = 297,
		["392"] = 297,
		["393"] = 297,
		["394"] = 297,
		["395"] = 297,
		["396"] = 297,
		["397"] = 305,
		["399"] = 305,
		["400"] = 325,
		["401"] = 332,
		["402"] = 325,
		["403"] = 332,
		["404"] = 336,
		["405"] = 337,
		["406"] = 336,
		["407"] = 339,
		["408"] = 340,
		["409"] = 341,
		["411"] = 339,
		["412"] = 344,
		["413"] = 345,
		["414"] = 344,
		["415"] = 350,
		["416"] = 351,
		["417"] = 352,
		["418"] = 353,
		["420"] = 355,
		["421"] = 356,
		["423"] = 359,
		["424"] = 360,
		["427"] = 363,
		["428"] = 350,
		["429"] = 332,
		["430"] = 325,
		["431"] = 325,
		["432"] = 325,
		["433"] = 325,
		["434"] = 325,
		["435"] = 325,
		["436"] = 325,
		["437"] = 332,
		["439"] = 332,
		["440"] = 400,
		["441"] = 407,
		["442"] = 400,
		["443"] = 407,
		["444"] = 407,
		["445"] = 400,
		["446"] = 400,
		["447"] = 400,
		["448"] = 400,
		["449"] = 400,
		["450"] = 400,
		["451"] = 400,
		["452"] = 407,
		["454"] = 407,
		["455"] = 444,
		["456"] = 445,
		["457"] = 444,
		["458"] = 445,
		["459"] = 446,
		["460"] = 447,
		["461"] = 448,
		["462"] = 450,
		["463"] = 451,
		["464"] = 451,
		["465"] = 451,
		["466"] = 452,
		["467"] = 451,
		["468"] = 451,
		["469"] = 446,
		["470"] = 445,
		["471"] = 444,
		["472"] = 445,
		["474"] = 445,
		["475"] = 457,
		["476"] = 466,
		["477"] = 457,
		["478"] = 466,
		["480"] = 466,
		["481"] = 470,
		["482"] = 471,
		["483"] = 472,
		["484"] = 473,
		["485"] = 475,
		["486"] = 457,
		["487"] = 479,
		["488"] = 480,
		["489"] = 481,
		["490"] = 484,
		["491"] = 485,
		["492"] = 479,
		["493"] = 487,
		["494"] = 488,
		["495"] = 489,
		["496"] = 490,
		["497"] = 491,
		["498"] = 492,
		["500"] = 494,
		["501"] = 495,
		["503"] = 487,
		["504"] = 498,
		["505"] = 499,
		["506"] = 500,
		["507"] = 501,
		["508"] = 502,
		["509"] = 503,
		["510"] = 504,
		["511"] = 505,
		["512"] = 506,
		["513"] = 506,
		["514"] = 506,
		["515"] = 506,
		["516"] = 507,
		["517"] = 508,
		["518"] = 509,
		["519"] = 509,
		["520"] = 509,
		["521"] = 509,
		["522"] = 509,
		["523"] = 510,
		["524"] = 510,
		["525"] = 510,
		["526"] = 510,
		["527"] = 510,
		["528"] = 511,
		["529"] = 511,
		["531"] = 513,
		["532"] = 514,
		["533"] = 515,
		["537"] = 498,
		["538"] = 520,
		["539"] = 521,
		["540"] = 522,
		["541"] = 523,
		["543"] = 525,
		["544"] = 526,
		["545"] = 526,
		["546"] = 526,
		["547"] = 526,
		["548"] = 526,
		["549"] = 526,
		["552"] = 520,
		["553"] = 535,
		["554"] = 536,
		["555"] = 537,
		["556"] = 537,
		["557"] = 536,
		["558"] = 535,
		["559"] = 540,
		["560"] = 541,
		["561"] = 540,
		["562"] = 543,
		["563"] = 544,
		["564"] = 545,
		["565"] = 546,
		["566"] = 547,
		["567"] = 548,
		["568"] = 548,
		["569"] = 548,
		["570"] = 549,
		["571"] = 550,
		["572"] = 548,
		["573"] = 548,
		["576"] = 543,
		["577"] = 466,
		["578"] = 457,
		["579"] = 457,
		["580"] = 457,
		["581"] = 457,
		["582"] = 457,
		["583"] = 457,
		["584"] = 457,
		["585"] = 457,
		["586"] = 457,
		["587"] = 466,
		["589"] = 466,
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
g.batrider_talent = c()
local q = g.batrider_talent
q.name = "batrider_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_batrider_talent"
end
q = e({ j(nil) }, q)
g.batrider_talent = q
g.modifier_batrider_talent = c()
local r = g.modifier_batrider_talent
r.name = "modifier_batrider_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.oil_interval = self:GetAbilitySpecialValueFor("oil_interval")
		- self:GetAbilityTalentValue("batrider_talent_2", "reduce_interval")
	self.magic_damage = self:GetAbilitySpecialValueFor("magic_damage")
	self.fury_damage_pct = self:GetAbilitySpecialValueFor("fury_damage_pct")
	self.tl1_injury_stack = self:GetAbilityTalentValue("batrider_talent_1", "injury_stack")
	self.tl3_oil_chance = self:GetAbilityTalentValue("batrider_talent_3", "oil_chance")
	self.tl5_damage_reduce_pct = self:GetAbilityTalentValue("batrider_talent_5", "reduce_damage_bonus")
	self.tl6_base_chance = self:GetAbilityTalentValue("batrider_talent_6", "chance_base")
	self.tl6_magic_damage = self:GetAbilityTalentValue("batrider_talent_6", "magic_damage")
	self.tl6_fury_stack = self:GetAbilityTalentValue("batrider_talent_6", "fury_stack")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
	}
end
function r.prototype.OnBattleStart(self, s)
	self:StartIntervalThink(self.oil_interval)
	if self:HasTalent("batrider_talent_4") then
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_batrider_talent_4_buff", {})
	end
	if self:HasTalent("batrider_talent_5") then
		local t = self.parent
		local u = t:GetEnemy()
		self.tl5_particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_batrider/batrider_flaming_lasso.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			self.tl5_particle,
			0,
			t,
			PATTACH_POINT_FOLLOW,
			"lasso_attack",
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			self.tl5_particle,
			1,
			u,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.parent:GetAbsOrigin(),
			true
		)
		self.parent:GetEnemy():AddNewModifier(self.parent, self.ability, "modifier_batrider_talent_5_debuff", {})
	end
end
function r.prototype.OnIntervalThink(self)
	self:GiveOil()
end
function r.prototype.OnFuryGained(self, s)
	if self:HasTalent("batrider_talent_3") and self:PRD(self.tl3_oil_chance) then
		self:GiveOil()
	end
end
function r.prototype.GiveOil(self, v)
	if v == nil then
		v = 1
	end
	local w = self.parent
	local u = w:GetEnemy()
	w:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	GameTimer(0.3, function()
		EmitSoundOn("Hero_Batrider.StickyNapalm.Cast", w)
		local x = ParticleManager:CreateParticle(
			"particles/econ/items/batrider/crownfall_immortal/batrider_crownfall_immortal__stickynapalm_impact.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			x,
			0,
			u,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControl(x, 1, Vector(300, 300, 300))
		ParticleManager:SetParticleControlEnt(
			x,
			2,
			w,
			PATTACH_POINT_FOLLOW,
			"lasso_attack",
			self.parent:GetAbsOrigin(),
			true
		)
		GameTimer(0.1, function()
			EmitSoundOn("Hero_Batrider.StickyNapalm.Impact", w)
			if IsInjurable(w, u) then
				local y = GetFury(w) * self.fury_damage_pct * 0.01
				w:DealDamage(u, self:GetAbility(), self.magic_damage + y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			end
			w:AddNewModifier(w, self.ability, "modifier_batrider_talent_buff", { num = v })
			if self:HasTalent("batrider_talent_1") then
				local u = w:GetEnemy()
				if IsValid(u) then
					AddInjury(w, u, self.tl1_injury_stack, self:GetAbility():GetName(), "Ability")
				end
			end
			if self:HasTalent("batrider_talent_6") then
				if self:PRD(self.tl6_base_chance) then
					local w = self.parent
					local u = self.parent:GetEnemy()
					self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_2)
					GameTimer(0.41, function()
						local x = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_batrider/batrider_flamebreak.vpcf",
							PATTACH_ABSORIGIN_FOLLOW,
							self.parent
						)
						ParticleManager:SetParticleControlEnt(
							x,
							0,
							self.parent,
							PATTACH_POINT_FOLLOW,
							"attach_attack1",
							self.parent:GetAbsOrigin(),
							true
						)
						ParticleManager:SetParticleControl(x, 1, Vector(1200, 0, 0))
						ParticleManager:SetParticleControlEnt(
							x,
							5,
							self.parent:GetEnemy(),
							PATTACH_POINT_FOLLOW,
							"attach_attack1",
							self.parent:GetEnemy():GetAbsOrigin(),
							true
						)
						EmitSoundOn("Hero_Batrider.Flamebreak", self.parent)
						GameTimer(0.45, function()
							EmitSoundOn("Hero_Batrider.Flamebreak.Impact", self.parent)
							if IsInjurable(w, u) then
								w:DealDamage(
									u,
									self.parent:FindAbilityByName("batrider_flamebreak"),
									self.tl6_magic_damage,
									EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
								)
								AddFury(w, self.tl6_fury_stack, "batrider_talent_6", "Ability")
							end
							ParticleManager:DestroyParticle(x, false)
						end)
					end)
				end
			end
		end)
	end)
end
function r.prototype.OnBattleEnd(self, s)
	self.parent:RemoveModifierByName("modifier_batrider_talent_buff")
	if self:HasTalent("batrider_talent_5") then
		if self.tl5_particle ~= nil then
			ParticleManager:DestroyParticle(self.tl5_particle, true)
		end
		local u = self.parent:GetEnemy()
		if IsValid(u) then
			u:RemoveModifierByName("modifier_batrider_talent_5_debuff")
		end
	end
	self:StartIntervalThink(-1)
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE,
	}
end
function r.prototype.EOM_GetModifierOutgoingDamagePercentage(self, s)
	if self:HasTalent("batrider_talent_5") and s then
		if s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
			return -self.tl5_damage_reduce_pct
		end
		if
			IsValid(s.ability)
			and (
				s.ability:GetAbilityName() == "batrider_talent"
				or s.ability:GetAbilityName() == "batrider_ult"
				or s.ability:GetAbilityName() == "batrider_flamebreak"
			)
		then
			return -self.tl5_damage_reduce_pct
		end
		if s.ability_upgrade == "138" or s.ability_upgrade == "150" then
			return -self.tl5_damage_reduce_pct
		end
	end
	return 0
end
function r.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function r.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_IDLE
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
g.modifier_batrider_talent = r
g.modifier_batrider_talent_buff = c()
local z = g.modifier_batrider_talent_buff
z.name = "modifier_batrider_talent_buff"
d(z, l)
function z.prototype.GetTexture(self)
	return "batrider_sticky_napalm"
end
function z.prototype.GetAbilitySpecialValue(self)
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
		+ self:GetAbilityTalentValue("batrider_talent_4", "outgoing_damage_bonus")
	self.tl5_steal_attckspeed = self:GetAbilityTalentValue("batrider_talent_5", "steal_attckspeed")
	self.flamebreak_duration = self:GetAbilityTalentValue("batrider_talent_6", "flamebreak_duration")
end
function z.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(s.num)
		self.parent:GetEnemy():AddNewModifier(self.parent, self.ability, "modifier_batrider_talent_debuff", {})
		if self:HasTalent("batrider_shard") and IsValid(self.parent:GetEnemy()) then
		end
	end
end
function z.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + s.num)
	end
end
function z.prototype.OnBattleEnd(self, s)
	if IsServer() then
		self:Destroy()
	end
end
function z.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent } }
end
function z.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_CONSTANT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function z.prototype.EOM_GetModifierOutgoingDamageConstant(self, s)
	local A = self:GetStackCount() * self.damage_bonus
	if s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return A
	end
	if
		IsValid(s.ability)
		and (
			s.ability:GetAbilityName() == "batrider_talent"
			or s.ability:GetAbilityName() == "batrider_ult"
			or s.ability:GetAbilityName() == "batrider_flamebreak"
		)
	then
		return A
	end
	if s.ability_upgrade == "138" or s.ability_upgrade == "150" then
		return A
	end
	if
		self:HasTalent("batrider_talent_4")
		and (
			s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			or s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		)
	then
		return A
	end
	return 0
end
function z.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	if self:HasTalent("batrider_talent_5") then
		return self.tl5_steal_attckspeed * self:GetStackCount()
	end
end
z = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	z
)
g.modifier_batrider_talent_buff = z
g.modifier_batrider_talent_debuff = c()
local B = g.modifier_batrider_talent_debuff
B.name = "modifier_batrider_talent_debuff"
d(B, l)
function B.prototype.OnCreated(self, s) end
function B.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent } }
end
function B.prototype.OnBattleEnd(self, s)
	self:Destroy()
end
function B.prototype.OnDestroy(self) end
B = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetStatusEffectName = "particles/units/heroes/hero_batrider/batrider_stickynapalm_debuff.vpcf",
			}
		),
	},
	B
)
g.modifier_batrider_talent_debuff = B
g.batrider_talent_5 = c()
local C = g.batrider_talent_5
C.name = "batrider_talent_5"
d(C, i)
function C.prototype.GetIntrinsicModifierName(self)
	return "modifier_batrider_talent_5"
end
C = e({ j(nil) }, C)
g.batrider_talent_5 = C
g.modifier_batrider_talent_5 = c()
local D = g.modifier_batrider_talent_5
D.name = "modifier_batrider_talent_5"
d(D, l)
function D.prototype.GetAbilitySpecialValue(self)
	self.steal_chance = self:GetAbilitySpecialValueFor("steal_chance")
end
function D.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS_PERCENTAGE_BEFORE_EVENT }
end
function D.prototype.EOM_GetModifierFuryStackBonusPercentBeforeEvent(self, s)
	if s.count > 0 then
		if self:PRD(self.steal_chance, "tl5_chance") then
			AddFury(self:GetCaster(), s.count, "batrider_talent_5", "Ability")
			return -1000
		end
	end
end
D = e(
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
	D
)
g.modifier_batrider_talent_5 = D
g.modifier_batrider_talent_5_debuff = c()
local E = g.modifier_batrider_talent_5_debuff
E.name = "modifier_batrider_talent_5_debuff"
d(E, l)
function E.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce_pct = self:GetAbilityTalentValue("batrider_talent_5", "reduce_damage_bonus")
end
function E.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(1)
	end
end
function E.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function E.prototype.EOM_GetModifierOutgoingDamagePercentage(self, s)
	if self:HasTalent("batrider_talent_5") and s then
		if s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
			return -self.damage_reduce_pct
		end
		if IsValid(s.ability) then
			return -self.damage_reduce_pct
		end
		if s.ability_upgrade == "138" or s.ability_upgrade == "150" then
			return -self.damage_reduce_pct
		end
	end
	return 0
end
E = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	E
)
g.modifier_batrider_talent_5_debuff = E
g.modifier_batrider_flamebreak = c()
local F = g.modifier_batrider_flamebreak
F.name = "modifier_batrider_flamebreak"
d(F, l)
F = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	F
)
g.modifier_batrider_flamebreak = F
g.batrider_ult = c()
local G = g.batrider_ult
G.name = "batrider_ult"
d(G, o)
function G.prototype.OnSpellStart(self)
	local H = self:GetCaster()
	local I = self:GetSpecialValueFor("duration")
	H:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	GameTimer(0.35, function()
		H:AddNewModifier(H, self, "modifier_batrider_ult", { duration = I })
	end)
end
G = e({ p(nil) }, G)
g.batrider_ult = G
g.modifier_batrider_ult = c()
local J = g.modifier_batrider_ult
J.name = "modifier_batrider_ult"
d(J, l)
function J.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.distance = 175
	self.show_count = 5
	self.line_counter = 0
	self.particle_list = {}
	self.destroy_delay = 1.5
end
function J.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.magic_damage = self:GetAbilitySpecialValueFor("magic_damage")
	self.shard_oil_stack = self:GetAbilityTalentValue("batrider_shard", "oil_stack")
	self.shard_fury_stack = self:GetAbilityTalentValue("batrider_shard", "shard_fury_stack")
end
function J.prototype.OnCreated(self, s)
	if IsServer() then
		self.particle_list = {}
		self.line_counter = 0
		if self:HasTalent("batrider_shard") then
			self.parent:FindModifierByName("modifier_batrider_talent"):GiveOil(self.shard_oil_stack)
		end
		self:StartThink(0.1, "particle")
		self:StartIntervalThink(self.interval)
	end
end
function J.prototype.OnThink(self, K)
	if K == "particle" then
		local t = self:GetParent()
		local u = t:GetEnemy()
		if IsInjurable(t, u) then
			local L = u:GetAbsOrigin() - t:GetAbsOrigin()
			L.z = 0
			L = L:Normalized()
			local M = GetGroundPosition(t:GetAbsOrigin() + L * self.distance * self.line_counter, nil)
			local x = ParticleManager:CreateParticle(
				"particles/econ/items/batrider/batrider_ti8_immortal_mount/batrider_ti8_immortal_firefly.vpcf",
				PATTACH_CUSTOMORIGIN,
				t
			)
			ParticleManager:SetParticleControl(x, 0, M)
			ParticleManager:SetParticleControl(x, 1, Vector(300, 0, 0))
			ParticleManager:SetParticleControl(x, 11, Vector(100, 0, 0))
			local N = self.particle_list
			N[#N + 1] = x
		end
		self.line_counter = self.line_counter + 1
		if self.line_counter >= self.show_count then
			self:StartThink(-1, K)
		end
		return
	end
end
function J.prototype.OnIntervalThink(self)
	if IsServer() then
		if self:HasTalent("batrider_shard") then
			AddFury(self.parent, self.shard_fury_stack, "batrider_shard", "Ability")
		end
		if IsValid(self.parent:GetEnemy()) then
			self.parent:DealDamage(
				self.parent:GetEnemy(),
				self:GetAbility(),
				self.magic_damage,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
		end
	end
end
function J.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function J.prototype.OnBattleEnd(self, s)
	self:Destroy()
end
function J.prototype.OnDestroy(self)
	self:StartIntervalThink(-1)
	if IsServer() then
		local O = self.particle_list
		for P, x in ipairs(O) do
			GameTimer(self.destroy_delay + (P - 1) * 0.1, function()
				ParticleManager:DestroyParticle(x, false)
				ParticleManager:ReleaseParticleIndex(x)
			end)
		end
	end
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
				IsIndependent = true,
			}
		),
	},
	J
)
g.modifier_batrider_ult = J
return g