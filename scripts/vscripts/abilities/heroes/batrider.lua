--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["159"] = 116,
		["160"] = 117,
		["161"] = 117,
		["162"] = 117,
		["163"] = 118,
		["164"] = 119,
		["165"] = 119,
		["166"] = 119,
		["167"] = 119,
		["168"] = 119,
		["169"] = 119,
		["170"] = 119,
		["171"] = 119,
		["172"] = 119,
		["173"] = 121,
		["174"] = 121,
		["175"] = 121,
		["176"] = 121,
		["177"] = 121,
		["178"] = 123,
		["179"] = 123,
		["180"] = 123,
		["181"] = 123,
		["182"] = 123,
		["183"] = 123,
		["184"] = 123,
		["185"] = 123,
		["186"] = 123,
		["187"] = 124,
		["188"] = 125,
		["189"] = 125,
		["190"] = 125,
		["191"] = 126,
		["192"] = 127,
		["193"] = 128,
		["194"] = 128,
		["195"] = 128,
		["196"] = 128,
		["197"] = 128,
		["198"] = 128,
		["199"] = 129,
		["201"] = 131,
		["202"] = 125,
		["203"] = 125,
		["204"] = 117,
		["205"] = 117,
		["208"] = 97,
		["209"] = 97,
		["210"] = 87,
		["211"] = 87,
		["212"] = 83,
		["213"] = 139,
		["214"] = 140,
		["215"] = 141,
		["216"] = 142,
		["217"] = 143,
		["219"] = 145,
		["220"] = 146,
		["221"] = 147,
		["224"] = 150,
		["225"] = 139,
		["226"] = 153,
		["227"] = 154,
		["228"] = 153,
		["229"] = 163,
		["230"] = 164,
		["231"] = 165,
		["232"] = 166,
		["234"] = 168,
		["235"] = 169,
		["237"] = 172,
		["238"] = 173,
		["241"] = 176,
		["242"] = 163,
		["243"] = 178,
		["244"] = 179,
		["245"] = 178,
		["246"] = 183,
		["247"] = 184,
		["248"] = 183,
		["249"] = 21,
		["250"] = 13,
		["251"] = 13,
		["252"] = 13,
		["253"] = 13,
		["254"] = 13,
		["255"] = 13,
		["256"] = 13,
		["257"] = 13,
		["258"] = 21,
		["260"] = 21,
		["261"] = 188,
		["262"] = 195,
		["263"] = 188,
		["264"] = 195,
		["265"] = 201,
		["266"] = 202,
		["267"] = 201,
		["268"] = 204,
		["269"] = 205,
		["270"] = 206,
		["271"] = 208,
		["272"] = 204,
		["273"] = 210,
		["274"] = 211,
		["275"] = 212,
		["276"] = 213,
		["277"] = 214,
		["280"] = 210,
		["281"] = 219,
		["282"] = 220,
		["283"] = 221,
		["285"] = 219,
		["286"] = 224,
		["287"] = 225,
		["288"] = 226,
		["290"] = 224,
		["291"] = 229,
		["292"] = 230,
		["293"] = 229,
		["294"] = 234,
		["295"] = 235,
		["296"] = 234,
		["297"] = 240,
		["298"] = 241,
		["299"] = 243,
		["300"] = 244,
		["302"] = 247,
		["303"] = 248,
		["305"] = 251,
		["306"] = 252,
		["308"] = 255,
		["309"] = 256,
		["311"] = 258,
		["312"] = 240,
		["313"] = 260,
		["314"] = 261,
		["315"] = 262,
		["317"] = 260,
		["318"] = 195,
		["319"] = 188,
		["320"] = 188,
		["321"] = 188,
		["322"] = 188,
		["323"] = 188,
		["324"] = 188,
		["325"] = 188,
		["326"] = 195,
		["328"] = 195,
		["329"] = 268,
		["330"] = 276,
		["331"] = 268,
		["332"] = 276,
		["333"] = 277,
		["334"] = 277,
		["335"] = 280,
		["336"] = 281,
		["337"] = 280,
		["338"] = 285,
		["339"] = 286,
		["340"] = 285,
		["341"] = 288,
		["342"] = 288,
		["343"] = 276,
		["344"] = 268,
		["345"] = 268,
		["346"] = 268,
		["347"] = 268,
		["348"] = 268,
		["349"] = 268,
		["350"] = 268,
		["351"] = 268,
		["352"] = 276,
		["354"] = 276,
		["355"] = 292,
		["356"] = 293,
		["357"] = 292,
		["358"] = 293,
		["359"] = 294,
		["360"] = 295,
		["361"] = 294,
		["362"] = 293,
		["363"] = 292,
		["364"] = 293,
		["366"] = 293,
		["367"] = 299,
		["368"] = 307,
		["369"] = 299,
		["370"] = 307,
		["371"] = 309,
		["372"] = 310,
		["373"] = 309,
		["374"] = 312,
		["375"] = 313,
		["376"] = 312,
		["377"] = 317,
		["378"] = 318,
		["379"] = 319,
		["380"] = 320,
		["381"] = 320,
		["382"] = 320,
		["383"] = 320,
		["384"] = 320,
		["385"] = 320,
		["386"] = 321,
		["389"] = 317,
		["390"] = 307,
		["391"] = 299,
		["392"] = 299,
		["393"] = 299,
		["394"] = 299,
		["395"] = 299,
		["396"] = 299,
		["397"] = 299,
		["398"] = 299,
		["399"] = 307,
		["401"] = 307,
		["402"] = 327,
		["403"] = 334,
		["404"] = 327,
		["405"] = 334,
		["406"] = 338,
		["407"] = 339,
		["408"] = 338,
		["409"] = 341,
		["410"] = 342,
		["411"] = 343,
		["413"] = 341,
		["414"] = 346,
		["415"] = 347,
		["416"] = 346,
		["417"] = 352,
		["418"] = 353,
		["419"] = 354,
		["420"] = 355,
		["422"] = 357,
		["423"] = 358,
		["425"] = 361,
		["426"] = 362,
		["429"] = 365,
		["430"] = 352,
		["431"] = 334,
		["432"] = 327,
		["433"] = 327,
		["434"] = 327,
		["435"] = 327,
		["436"] = 327,
		["437"] = 327,
		["438"] = 327,
		["439"] = 334,
		["441"] = 334,
		["442"] = 402,
		["443"] = 409,
		["444"] = 402,
		["445"] = 409,
		["446"] = 409,
		["447"] = 402,
		["448"] = 402,
		["449"] = 402,
		["450"] = 402,
		["451"] = 402,
		["452"] = 402,
		["453"] = 402,
		["454"] = 409,
		["456"] = 409,
		["457"] = 446,
		["458"] = 447,
		["459"] = 446,
		["460"] = 447,
		["461"] = 448,
		["462"] = 449,
		["463"] = 450,
		["464"] = 452,
		["465"] = 453,
		["466"] = 453,
		["467"] = 453,
		["468"] = 454,
		["469"] = 453,
		["470"] = 453,
		["471"] = 448,
		["472"] = 447,
		["473"] = 446,
		["474"] = 447,
		["476"] = 447,
		["477"] = 459,
		["478"] = 468,
		["479"] = 459,
		["480"] = 468,
		["482"] = 468,
		["483"] = 472,
		["484"] = 473,
		["485"] = 474,
		["486"] = 475,
		["487"] = 477,
		["488"] = 459,
		["489"] = 481,
		["490"] = 482,
		["491"] = 483,
		["492"] = 486,
		["493"] = 487,
		["494"] = 481,
		["495"] = 489,
		["496"] = 490,
		["497"] = 491,
		["498"] = 492,
		["499"] = 493,
		["500"] = 494,
		["502"] = 496,
		["503"] = 497,
		["505"] = 489,
		["506"] = 500,
		["507"] = 501,
		["508"] = 502,
		["509"] = 503,
		["510"] = 504,
		["511"] = 505,
		["512"] = 506,
		["513"] = 507,
		["514"] = 508,
		["515"] = 508,
		["516"] = 508,
		["517"] = 508,
		["518"] = 509,
		["519"] = 510,
		["520"] = 511,
		["521"] = 511,
		["522"] = 511,
		["523"] = 511,
		["524"] = 511,
		["525"] = 512,
		["526"] = 512,
		["527"] = 512,
		["528"] = 512,
		["529"] = 512,
		["530"] = 513,
		["531"] = 513,
		["533"] = 515,
		["534"] = 516,
		["535"] = 517,
		["539"] = 500,
		["540"] = 522,
		["541"] = 523,
		["542"] = 524,
		["543"] = 525,
		["545"] = 527,
		["546"] = 528,
		["547"] = 528,
		["548"] = 528,
		["549"] = 528,
		["550"] = 528,
		["551"] = 528,
		["554"] = 522,
		["555"] = 537,
		["556"] = 538,
		["557"] = 539,
		["558"] = 539,
		["559"] = 538,
		["560"] = 537,
		["561"] = 542,
		["562"] = 543,
		["563"] = 542,
		["564"] = 545,
		["565"] = 546,
		["566"] = 547,
		["567"] = 548,
		["568"] = 549,
		["569"] = 550,
		["570"] = 550,
		["571"] = 550,
		["572"] = 551,
		["573"] = 552,
		["574"] = 550,
		["575"] = 550,
		["578"] = 545,
		["579"] = 468,
		["580"] = 459,
		["581"] = 459,
		["582"] = 459,
		["583"] = 459,
		["584"] = 459,
		["585"] = 459,
		["586"] = 459,
		["587"] = 459,
		["588"] = 459,
		["589"] = 468,
		["591"] = 468,
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
				print("概率", self.tl6_base_chance)
				if self:PRD(self.tl6_base_chance) then
					print("释放")
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