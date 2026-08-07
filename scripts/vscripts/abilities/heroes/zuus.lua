--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/zuus"
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
		["18"] = 8,
		["19"] = 9,
		["20"] = 8,
		["21"] = 9,
		["22"] = 10,
		["23"] = 11,
		["24"] = 10,
		["25"] = 9,
		["26"] = 8,
		["27"] = 9,
		["29"] = 9,
		["30"] = 15,
		["31"] = 23,
		["32"] = 15,
		["33"] = 23,
		["35"] = 23,
		["36"] = 26,
		["37"] = 27,
		["38"] = 36,
		["39"] = 38,
		["40"] = 15,
		["41"] = 43,
		["42"] = 44,
		["43"] = 45,
		["44"] = 47,
		["45"] = 48,
		["46"] = 50,
		["47"] = 51,
		["48"] = 52,
		["49"] = 54,
		["50"] = 56,
		["51"] = 57,
		["52"] = 43,
		["53"] = 59,
		["54"] = 60,
		["55"] = 61,
		["57"] = 59,
		["58"] = 64,
		["59"] = 65,
		["60"] = 65,
		["61"] = 67,
		["62"] = 67,
		["63"] = 67,
		["64"] = 65,
		["65"] = 68,
		["66"] = 68,
		["67"] = 68,
		["68"] = 65,
		["69"] = 65,
		["70"] = 64,
		["71"] = 71,
		["72"] = 72,
		["73"] = 71,
		["74"] = 76,
		["75"] = 77,
		["76"] = 78,
		["77"] = 79,
		["78"] = 80,
		["79"] = 76,
		["80"] = 82,
		["81"] = 83,
		["84"] = 84,
		["87"] = 85,
		["88"] = 86,
		["89"] = 87,
		["90"] = 88,
		["91"] = 89,
		["92"] = 89,
		["93"] = 89,
		["94"] = 89,
		["95"] = 90,
		["96"] = 89,
		["97"] = 89,
		["99"] = 82,
		["100"] = 94,
		["101"] = 95,
		["102"] = 96,
		["103"] = 96,
		["104"] = 96,
		["105"] = 96,
		["107"] = 94,
		["108"] = 99,
		["109"] = 99,
		["110"] = 99,
		["112"] = 99,
		["113"] = 99,
		["115"] = 100,
		["116"] = 101,
		["117"] = 102,
		["118"] = 103,
		["121"] = 104,
		["122"] = 105,
		["123"] = 106,
		["125"] = 109,
		["126"] = 109,
		["127"] = 109,
		["128"] = 110,
		["131"] = 111,
		["134"] = 113,
		["135"] = 114,
		["136"] = 114,
		["137"] = 114,
		["138"] = 114,
		["139"] = 114,
		["140"] = 114,
		["141"] = 114,
		["142"] = 114,
		["143"] = 114,
		["144"] = 115,
		["145"] = 115,
		["146"] = 115,
		["147"] = 115,
		["148"] = 115,
		["149"] = 115,
		["150"] = 115,
		["151"] = 115,
		["152"] = 115,
		["153"] = 116,
		["154"] = 117,
		["155"] = 118,
		["156"] = 119,
		["157"] = 120,
		["158"] = 122,
		["159"] = 123,
		["160"] = 124,
		["162"] = 126,
		["163"] = 126,
		["164"] = 126,
		["165"] = 126,
		["166"] = 126,
		["167"] = 126,
		["168"] = 126,
		["169"] = 126,
		["170"] = 126,
		["171"] = 136,
		["172"] = 137,
		["173"] = 138,
		["174"] = 139,
		["175"] = 140,
		["176"] = 141,
		["177"] = 142,
		["178"] = 143,
		["179"] = 143,
		["180"] = 143,
		["181"] = 143,
		["182"] = 143,
		["183"] = 144,
		["184"] = 144,
		["185"] = 144,
		["186"] = 144,
		["187"] = 144,
		["188"] = 144,
		["189"] = 144,
		["190"] = 144,
		["191"] = 144,
		["192"] = 145,
		["193"] = 146,
		["194"] = 147,
		["195"] = 147,
		["196"] = 147,
		["197"] = 147,
		["198"] = 147,
		["199"] = 147,
		["200"] = 147,
		["201"] = 147,
		["202"] = 147,
		["203"] = 157,
		["206"] = 160,
		["207"] = 161,
		["208"] = 162,
		["209"] = 163,
		["210"] = 164,
		["211"] = 164,
		["212"] = 164,
		["213"] = 164,
		["214"] = 164,
		["215"] = 164,
		["218"] = 109,
		["219"] = 109,
		["221"] = 99,
		["222"] = 23,
		["223"] = 15,
		["224"] = 15,
		["225"] = 15,
		["226"] = 15,
		["227"] = 15,
		["228"] = 15,
		["229"] = 15,
		["230"] = 15,
		["231"] = 23,
		["233"] = 23,
		["234"] = 172,
		["235"] = 180,
		["236"] = 172,
		["237"] = 180,
		["238"] = 183,
		["239"] = 184,
		["240"] = 183,
		["241"] = 186,
		["242"] = 187,
		["243"] = 188,
		["244"] = 186,
		["245"] = 190,
		["246"] = 191,
		["247"] = 192,
		["248"] = 192,
		["249"] = 192,
		["250"] = 192,
		["252"] = 190,
		["253"] = 195,
		["254"] = 196,
		["255"] = 197,
		["256"] = 197,
		["257"] = 197,
		["258"] = 197,
		["260"] = 195,
		["261"] = 200,
		["262"] = 201,
		["263"] = 200,
		["264"] = 205,
		["265"] = 206,
		["266"] = 205,
		["267"] = 180,
		["268"] = 172,
		["269"] = 172,
		["270"] = 172,
		["271"] = 172,
		["272"] = 172,
		["273"] = 172,
		["274"] = 172,
		["275"] = 172,
		["276"] = 180,
		["278"] = 180,
		["280"] = 213,
		["281"] = 214,
		["282"] = 213,
		["283"] = 214,
		["284"] = 215,
		["285"] = 216,
		["286"] = 217,
		["287"] = 218,
		["288"] = 219,
		["289"] = 221,
		["290"] = 222,
		["291"] = 225,
		["292"] = 225,
		["293"] = 225,
		["294"] = 226,
		["297"] = 228,
		["298"] = 229,
		["299"] = 229,
		["300"] = 229,
		["301"] = 229,
		["302"] = 229,
		["303"] = 229,
		["304"] = 229,
		["305"] = 229,
		["306"] = 229,
		["307"] = 238,
		["308"] = 239,
		["309"] = 239,
		["310"] = 239,
		["311"] = 239,
		["312"] = 239,
		["313"] = 240,
		["314"] = 240,
		["315"] = 240,
		["316"] = 240,
		["317"] = 240,
		["318"] = 240,
		["319"] = 240,
		["320"] = 240,
		["321"] = 240,
		["322"] = 241,
		["323"] = 225,
		["324"] = 225,
		["325"] = 215,
		["326"] = 245,
		["327"] = 246,
		["328"] = 245,
		["329"] = 248,
		["330"] = 249,
		["331"] = 248,
		["332"] = 214,
		["333"] = 213,
		["334"] = 214,
		["336"] = 214,
		["337"] = 253,
		["338"] = 261,
		["339"] = 253,
		["340"] = 261,
		["341"] = 265,
		["342"] = 266,
		["343"] = 267,
		["344"] = 265,
		["345"] = 269,
		["346"] = 270,
		["347"] = 269,
		["348"] = 274,
		["349"] = 276,
		["350"] = 277,
		["351"] = 278,
		["352"] = 279,
		["353"] = 280,
		["354"] = 280,
		["355"] = 280,
		["356"] = 280,
		["357"] = 280,
		["358"] = 280,
		["361"] = 274,
		["362"] = 261,
		["363"] = 253,
		["364"] = 253,
		["365"] = 253,
		["366"] = 253,
		["367"] = 253,
		["368"] = 253,
		["369"] = 253,
		["370"] = 253,
		["371"] = 261,
		["373"] = 261,
		["374"] = 286,
		["375"] = 295,
		["376"] = 286,
		["377"] = 295,
		["378"] = 296,
		["379"] = 297,
		["380"] = 298,
		["381"] = 299,
		["382"] = 300,
		["383"] = 300,
		["384"] = 300,
		["385"] = 300,
		["386"] = 300,
		["387"] = 300,
		["388"] = 300,
		["389"] = 300,
		["390"] = 300,
		["391"] = 301,
		["392"] = 301,
		["393"] = 301,
		["394"] = 301,
		["395"] = 301,
		["396"] = 301,
		["397"] = 301,
		["398"] = 301,
		["399"] = 301,
		["401"] = 303,
		["403"] = 296,
		["404"] = 306,
		["405"] = 307,
		["406"] = 308,
		["407"] = 309,
		["408"] = 310,
		["409"] = 310,
		["410"] = 310,
		["411"] = 310,
		["412"] = 310,
		["413"] = 310,
		["414"] = 310,
		["415"] = 310,
		["416"] = 310,
		["417"] = 311,
		["418"] = 311,
		["419"] = 311,
		["420"] = 311,
		["421"] = 311,
		["422"] = 311,
		["423"] = 311,
		["424"] = 311,
		["425"] = 311,
		["427"] = 313,
		["429"] = 306,
		["430"] = 316,
		["431"] = 317,
		["433"] = 316,
		["434"] = 295,
		["435"] = 286,
		["436"] = 286,
		["437"] = 286,
		["438"] = 286,
		["439"] = 286,
		["440"] = 286,
		["441"] = 286,
		["442"] = 286,
		["443"] = 295,
		["445"] = 295,
		["447"] = 324,
		["448"] = 333,
		["449"] = 324,
		["450"] = 333,
		["451"] = 337,
		["452"] = 338,
		["453"] = 339,
		["454"] = 337,
		["455"] = 341,
		["456"] = 342,
		["457"] = 343,
		["458"] = 344,
		["459"] = 345,
		["460"] = 346,
		["461"] = 347,
		["462"] = 348,
		["463"] = 348,
		["464"] = 348,
		["465"] = 348,
		["466"] = 348,
		["467"] = 349,
		["468"] = 349,
		["469"] = 349,
		["470"] = 349,
		["471"] = 349,
		["472"] = 350,
		["473"] = 351,
		["474"] = 351,
		["475"] = 351,
		["476"] = 351,
		["477"] = 351,
		["478"] = 351,
		["479"] = 351,
		["480"] = 351,
		["482"] = 341,
		["483"] = 354,
		["484"] = 355,
		["485"] = 356,
		["486"] = 357,
		["487"] = 358,
		["490"] = 361,
		["491"] = 362,
		["492"] = 363,
		["493"] = 364,
		["494"] = 365,
		["495"] = 366,
		["496"] = 366,
		["497"] = 366,
		["498"] = 366,
		["499"] = 366,
		["500"] = 366,
		["501"] = 366,
		["502"] = 366,
		["503"] = 366,
		["504"] = 367,
		["505"] = 368,
		["506"] = 371,
		["507"] = 371,
		["508"] = 371,
		["509"] = 371,
		["510"] = 371,
		["511"] = 371,
		["512"] = 371,
		["513"] = 371,
		["514"] = 371,
		["515"] = 380,
		["516"] = 354,
		["517"] = 382,
		["518"] = 383,
		["519"] = 384,
		["520"] = 384,
		["521"] = 383,
		["522"] = 382,
		["523"] = 387,
		["524"] = 388,
		["525"] = 387,
		["526"] = 333,
		["527"] = 324,
		["528"] = 324,
		["529"] = 324,
		["530"] = 324,
		["531"] = 324,
		["532"] = 324,
		["533"] = 324,
		["534"] = 324,
		["535"] = 333,
		["537"] = 333,
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
g.zuus_talent = c()
local q = g.zuus_talent
q.name = "zuus_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_zuus_talent"
end
q = e({ j(nil) }, q)
g.zuus_talent = q
g.modifier_zuus_talent = c()
local r = g.modifier_zuus_talent
r.name = "modifier_zuus_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.mana_regen_record = 0
	self.tick = 0.1
	self.tl4_counter = 0
	self.tl7_record = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage") + self:GetAbilityTalentValue("zuus_talent_2", "arc_damage")
	self.mana_threshold = self:GetAbilitySpecialValueFor("mana_threshold")
		- self:GetAbilityTalentValue("zuus_talent_6", "mana_reduce")
	self.tl3_attackspeed_pct = self:GetAbilityTalentValue("zuus_talent_3", "attackspeed_pct")
	self.tl3_acr_damage_pct = self:GetAbilityTalentValue("zuus_talent_3", "acr_damage_pct")
	self.tl4_count = self:GetAbilityTalentValue("zuus_talent_4", "count")
	self.tl4_stun_duration = self:GetAbilityTalentValue("zuus_talent_4", "stun_duration")
	self.tl4_damage = self:GetAbilityTalentValue("zuus_talent_4", "damage")
	self.tl7_count = self:GetAbilityTalentValue("zuus_talent_7", "count")
	self.s_count = self:GetAbilityTalentValue("zuus_shard", "count")
	self.s_health_pct = self:GetAbilityTalentValue("zuus_shard", "health_pct")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self.s_record = 0
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS_PERCENTAGE] = self.tl3_attackspeed_pct }
end
function r.prototype.OnBattleStartBefore(self, s)
	self.mana_regen_record = 0
	self.tl4_counter = 0
	self.tl7_record = 0
	self.s_record = self.s_count
end
function r.prototype.OnRestore(self, s)
	if s.count <= 0 then
		return
	end
	if self:GetCaster():PassivesDisabled() then
		return
	end
	self.mana_regen_record = self.mana_regen_record + s.count
	if self.mana_regen_record >= self.mana_threshold then
		local t = math.floor(self.mana_regen_record / self.mana_threshold)
		self.mana_regen_record = self.mana_regen_record - t * self.mana_threshold
		ForWithInterval(self.tick, t, function()
			self:ArcLighting()
		end)
	end
end
function r.prototype.OnCustomAttackLanded(self, u)
	if self.tl3_acr_damage_pct > 0 then
		self:ArcLighting(self.tl3_acr_damage_pct, self:GetParent():FindAbilityByName("zuus_talent_3"))
	end
end
function r.prototype.ArcLighting(self, v, w)
	if v == nil then
		v = 100
	end
	if w == nil then
		w = self:GetAbility()
	end
	if IsServer() then
		local x = self:GetParent()
		local y = x:GetEnemy()
		if not IsInjurable(x, y) then
			return
		end
		local z = self:GetAbility()
		if w == z and not x:HasModifier("modifier_zuus_ult_cast") then
			x:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 3)
		end
		GameTimer(0.06, function()
			if not (IsValid(self) and IsValid(w)) then
				return
			end
			if not IsInjurable(x, y) then
				return
			end
			local A = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf",
				PATTACH_CUSTOMORIGIN,
				x
			)
			ParticleManager:SetParticleControlEnt(A, 0, x, PATTACH_POINT_FOLLOW, "attach_attack1", vec3_zero, true)
			ParticleManager:SetParticleControlEnt(A, 1, y, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
			ParticleManager:ReleaseParticleIndex(A)
			local B = self.damage
			local C = B * v * 0.01
			x:EmitSound("Hero_Zuus.ArcLightning.Cast")
			y:EmitSound("Hero_Zuus.ArcLightning.Target")
			if self.s_record > 0 then
				C = C + y:GetHealth() * self.s_health_pct * 0.01
				self.s_record = self.s_record - 1
			end
			DamageSystem:dealDamage({
				attacker = x,
				target = y,
				ability = w,
				damage = C,
				damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
				damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
				damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
			})
			if self.tl4_count > 0 then
				self.tl4_counter = self.tl4_counter + 1
				if self.tl4_counter >= self.tl4_count then
					self.tl4_counter = 0
					local D = x:FindAbilityByName("zuus_talent_4")
					local E = y:GetAbsOrigin()
					local A = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf",
						PATTACH_CUSTOMORIGIN,
						x
					)
					ParticleManager:SetParticleControl(A, 0, E + Vector(0, 0, 2000))
					ParticleManager:SetParticleControlEnt(A, 1, y, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
					ParticleManager:ReleaseParticleIndex(A)
					EmitSoundOnLocationWithCaster(E, "Hero_Zuus.LightningBolt", x)
					DamageSystem:dealDamage({
						attacker = x,
						target = y,
						ability = D,
						damage = self.tl4_damage,
						damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
						damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
						damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
					})
					AddStun(x, y, z, self.tl4_stun_duration)
				end
			end
			if self.tl7_count > 0 then
				self.tl7_record = self.tl7_record + 1
				if self.tl7_record >= self.tl7_count then
					self.tl7_record = 0
					x:AddNewModifier(x, self:GetAbility(), "modifier_zuus_talent_7", nil)
				end
			end
		end)
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
g.modifier_zuus_talent = r
g.modifier_zuus_talent_7 = c()
local F = g.modifier_zuus_talent_7
F.name = "modifier_zuus_talent_7"
d(F, l)
function F.prototype.GetTexture(self)
	return "zuus_arc_lightning"
end
function F.prototype.GetAbilitySpecialValue(self)
	self.ult_bonus = self:GetAbilityTalentValue("zuus_talent_7", "ult_bonus")
	self.max_count = self:GetAbilityTalentValue("zuus_talent_7", "max_count")
end
function F.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(math.min(self.max_count, self:GetStackCount() + 1))
	end
end
function F.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetStackCount(math.min(self.max_count, self:GetStackCount() + 1))
	end
end
function F.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function F.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount() * self.ult_bonus
end
F = e(
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
	F
)
g.modifier_zuus_talent_7 = F
g.zuus_ult = c()
local G = g.zuus_ult
G.name = "zuus_ult"
d(G, o)
function G.prototype.OnSpellStart(self)
	local H = self:GetCaster()
	local y = H:GetEnemy()
	local I = 0.5
	local C = self:getThundergodsWrathDamage()
	H:EmitSound("Hero_Zuus.GodsWrath.PreCast")
	H:AddNewModifier(H, self, "modifier_zuus_ult_cast", { duration = I })
	self:GameTimer(I, function()
		if not IsInjurable(H, y) then
			return
		end
		y:EmitSound("Hero_Zuus.LightningBolt")
		DamageSystem:dealDamage({
			attacker = H,
			target = y,
			ability = self,
			damage = C,
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		})
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf",
			PATTACH_CUSTOMORIGIN,
			H
		)
		ParticleManager:SetParticleControl(A, 0, y:GetAbsOrigin() + Vector(0, 0, 2000))
		ParticleManager:SetParticleControlEnt(A, 1, y, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
		ParticleManager:ReleaseParticleIndex(A)
	end)
end
function G.prototype.getThundergodsWrathDamage(self)
	return self:GetSpecialValueFor("damage") + self:GetTalentValue("zuus_talent_1", "ult_damage")
end
function G.prototype.GetIntrinsicModifierName(self)
	return "modifier_zuus_ult"
end
G = e({ p(nil) }, G)
g.zuus_ult = G
g.modifier_zuus_ult = c()
local J = g.modifier_zuus_ult
J.name = "modifier_zuus_ult"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.tl5_interval = self:GetAbilityTalentValue("zuus_talent_5", "interval")
	self.tl5_stun_duration = self:GetAbilityTalentValue("zuus_talent_5", "stun_duration")
end
function J.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function J.prototype.OnBattleStart(self, s)
	if self.tl5_interval > 0 then
		local H = self:GetCaster()
		local y = H:GetEnemy()
		if IsInjurable(y, H) then
			y:AddNewModifier(H, self:GetAbility(), "modifier_zuus_talent_5_debuff", nil)
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
			}
		),
	},
	J
)
g.modifier_zuus_ult = J
g.modifier_zuus_ult_cast = c()
local K = g.modifier_zuus_ult_cast
K.name = "modifier_zuus_ult_cast"
d(K, l)
function K.prototype.OnCreated(self, s)
	local x = self:GetParent()
	if IsClient() then
		local L = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf",
			PATTACH_ABSORIGIN,
			x
		)
		ParticleManager:SetParticleControlEnt(L, 1, x, PATTACH_POINT_FOLLOW, "attach_attack1", vec3_zero, true)
		ParticleManager:SetParticleControlEnt(L, 2, x, PATTACH_POINT_FOLLOW, "attach_attack2", vec3_zero, true)
	else
		x:StartGesture(ACT_DOTA_CAST_ABILITY_5)
	end
end
function K.prototype.OnRefresh(self, s)
	local x = self:GetParent()
	if IsClient() then
		local L = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf",
			PATTACH_ABSORIGIN,
			x
		)
		ParticleManager:SetParticleControlEnt(L, 1, x, PATTACH_POINT_FOLLOW, "attach_attack1", vec3_zero, true)
		ParticleManager:SetParticleControlEnt(L, 2, x, PATTACH_POINT_FOLLOW, "attach_attack2", vec3_zero, true)
	else
		x:StartGesture(ACT_DOTA_CAST_ABILITY_5)
	end
end
function K.prototype.OnDestroy(self)
	if IsServer() then
	end
end
K = e(
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
	K
)
g.modifier_zuus_ult_cast = K
g.modifier_zuus_talent_5_debuff = c()
local M = g.modifier_zuus_talent_5_debuff
M.name = "modifier_zuus_talent_5_debuff"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.tl5_interval = self:GetAbilityTalentValue("zuus_talent_5", "interval")
	self.tl5_stun_duration = self:GetAbilityTalentValue("zuus_talent_5", "stun_duration")
end
function M.prototype.OnCreated(self, s)
	if IsServer() then
		local H = self:GetCaster()
		self:StartIntervalThink(self.tl5_interval)
		self.damage_position = H:GetAbsOrigin() + Vector(0, 0, 500)
		EmitSoundOnLocationWithCaster(self.damage_position, "Hero_Zuus.Cloud.Cast", H)
		local A =
			ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud.vpcf", PATTACH_CUSTOMORIGIN, H)
		ParticleManager:SetParticleControl(A, 0, H:GetAbsOrigin())
		ParticleManager:SetParticleControl(A, 1, Vector(300, 0, 0))
		ParticleManager:SetParticleControl(A, 2, self.damage_position)
		self:AddParticle(A, false, false, -1, false, false)
	end
end
function M.prototype.OnIntervalThink(self)
	local H = self:GetCaster()
	local x = self:GetParent()
	if not IsInjurable(H, x) then
		self:Destroy()
		return
	end
	local z = self:GetAbility()
	local C = z:getThundergodsWrathDamage()
	local N = H:FindAbilityByName("zuus_talent_5")
	local A = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf",
		PATTACH_CUSTOMORIGIN,
		H
	)
	ParticleManager:SetParticleControl(A, 0, self.damage_position)
	ParticleManager:SetParticleControlEnt(A, 1, x, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
	ParticleManager:ReleaseParticleIndex(A)
	EmitSoundOnLocationWithCaster(self.damage_position, "Hero_Zuus.LightningBolt.Cloud", H)
	DamageSystem:dealDamage({
		attacker = H,
		target = x,
		ability = N,
		damage = C,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
	})
	AddStun(H, x, N, self.tl5_stun_duration)
end
function M.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function M.prototype.OnBattleEnd(self, s)
	self:Destroy()
end
M = e(
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
	M
)
g.modifier_zuus_talent_5_debuff = M
return g