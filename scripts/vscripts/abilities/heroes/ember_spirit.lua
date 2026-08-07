--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/ember_spirit"
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
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 8,
		["25"] = 7,
		["26"] = 6,
		["27"] = 7,
		["29"] = 7,
		["30"] = 13,
		["31"] = 21,
		["32"] = 13,
		["33"] = 21,
		["35"] = 21,
		["36"] = 27,
		["37"] = 40,
		["38"] = 13,
		["39"] = 43,
		["40"] = 44,
		["41"] = 45,
		["42"] = 47,
		["43"] = 50,
		["44"] = 51,
		["45"] = 53,
		["46"] = 54,
		["47"] = 55,
		["48"] = 56,
		["49"] = 57,
		["50"] = 43,
		["51"] = 60,
		["52"] = 61,
		["53"] = 62,
		["54"] = 63,
		["55"] = 64,
		["56"] = 65,
		["58"] = 60,
		["59"] = 68,
		["60"] = 69,
		["62"] = 70,
		["63"] = 70,
		["64"] = 72,
		["65"] = 73,
		["66"] = 70,
		["69"] = 75,
		["70"] = 76,
		["71"] = 77,
		["72"] = 78,
		["75"] = 68,
		["76"] = 82,
		["77"] = 83,
		["78"] = 83,
		["79"] = 85,
		["80"] = 85,
		["81"] = 85,
		["82"] = 83,
		["83"] = 86,
		["84"] = 86,
		["85"] = 86,
		["86"] = 83,
		["87"] = 87,
		["88"] = 87,
		["89"] = 87,
		["90"] = 83,
		["91"] = 83,
		["92"] = 82,
		["93"] = 90,
		["94"] = 91,
		["95"] = 90,
		["96"] = 93,
		["97"] = 94,
		["98"] = 93,
		["99"] = 96,
		["100"] = 97,
		["101"] = 98,
		["102"] = 99,
		["103"] = 100,
		["104"] = 101,
		["106"] = 96,
		["107"] = 104,
		["108"] = 105,
		["111"] = 106,
		["112"] = 107,
		["113"] = 108,
		["114"] = 109,
		["115"] = 110,
		["116"] = 111,
		["117"] = 112,
		["118"] = 112,
		["119"] = 112,
		["120"] = 112,
		["121"] = 112,
		["122"] = 113,
		["123"] = 113,
		["124"] = 113,
		["125"] = 113,
		["126"] = 113,
		["127"] = 113,
		["128"] = 113,
		["129"] = 113,
		["130"] = 113,
		["131"] = 114,
		["132"] = 114,
		["133"] = 114,
		["134"] = 115,
		["135"] = 115,
		["136"] = 115,
		["137"] = 115,
		["138"] = 115,
		["139"] = 115,
		["140"] = 116,
		["141"] = 117,
		["142"] = 118,
		["143"] = 119,
		["144"] = 120,
		["145"] = 120,
		["146"] = 120,
		["147"] = 120,
		["148"] = 120,
		["149"] = 120,
		["150"] = 120,
		["151"] = 120,
		["152"] = 114,
		["153"] = 114,
		["154"] = 122,
		["155"] = 122,
		["156"] = 122,
		["157"] = 123,
		["158"] = 124,
		["159"] = 125,
		["160"] = 122,
		["161"] = 122,
		["164"] = 129,
		["165"] = 130,
		["166"] = 131,
		["167"] = 132,
		["168"] = 133,
		["171"] = 104,
		["172"] = 137,
		["173"] = 138,
		["174"] = 139,
		["175"] = 140,
		["177"] = 142,
		["178"] = 143,
		["180"] = 137,
		["181"] = 151,
		["182"] = 152,
		["183"] = 153,
		["184"] = 154,
		["185"] = 155,
		["186"] = 156,
		["187"] = 161,
		["189"] = 151,
		["190"] = 168,
		["191"] = 169,
		["192"] = 170,
		["193"] = 171,
		["196"] = 172,
		["197"] = 173,
		["198"] = 174,
		["199"] = 174,
		["200"] = 174,
		["201"] = 174,
		["202"] = 174,
		["203"] = 175,
		["204"] = 176,
		["205"] = 177,
		["206"] = 178,
		["207"] = 178,
		["208"] = 178,
		["209"] = 178,
		["210"] = 178,
		["211"] = 178,
		["212"] = 178,
		["213"] = 178,
		["214"] = 186,
		["215"] = 187,
		["218"] = 188,
		["219"] = 188,
		["220"] = 188,
		["221"] = 188,
		["222"] = 188,
		["223"] = 188,
		["224"] = 188,
		["225"] = 188,
		["226"] = 188,
		["227"] = 188,
		["228"] = 195,
		["229"] = 197,
		["230"] = 198,
		["231"] = 199,
		["232"] = 200,
		["234"] = 178,
		["235"] = 178,
		["236"] = 168,
		["237"] = 206,
		["238"] = 212,
		["240"] = 213,
		["241"] = 213,
		["242"] = 214,
		["243"] = 213,
		["246"] = 216,
		["247"] = 216,
		["248"] = 216,
		["249"] = 217,
		["250"] = 219,
		["251"] = 220,
		["253"] = 216,
		["254"] = 216,
		["255"] = 223,
		["256"] = 224,
		["257"] = 225,
		["258"] = 225,
		["259"] = 225,
		["260"] = 225,
		["261"] = 225,
		["262"] = 225,
		["263"] = 206,
		["264"] = 227,
		["265"] = 228,
		["266"] = 229,
		["267"] = 230,
		["268"] = 231,
		["269"] = 232,
		["270"] = 233,
		["271"] = 234,
		["274"] = 227,
		["275"] = 21,
		["276"] = 13,
		["277"] = 13,
		["278"] = 13,
		["279"] = 13,
		["280"] = 13,
		["281"] = 13,
		["282"] = 13,
		["283"] = 13,
		["284"] = 21,
		["286"] = 21,
		["288"] = 241,
		["289"] = 249,
		["290"] = 241,
		["291"] = 249,
		["292"] = 256,
		["293"] = 257,
		["294"] = 258,
		["295"] = 259,
		["296"] = 260,
		["297"] = 261,
		["298"] = 256,
		["299"] = 263,
		["300"] = 264,
		["301"] = 265,
		["302"] = 266,
		["303"] = 268,
		["304"] = 269,
		["305"] = 270,
		["306"] = 270,
		["307"] = 270,
		["308"] = 270,
		["309"] = 270,
		["310"] = 271,
		["311"] = 271,
		["312"] = 271,
		["313"] = 271,
		["314"] = 271,
		["315"] = 272,
		["316"] = 272,
		["317"] = 272,
		["318"] = 272,
		["319"] = 272,
		["320"] = 272,
		["321"] = 272,
		["322"] = 272,
		["323"] = 273,
		["324"] = 274,
		["325"] = 275,
		["326"] = 275,
		["327"] = 275,
		["328"] = 275,
		["329"] = 275,
		["330"] = 276,
		["331"] = 276,
		["332"] = 276,
		["333"] = 276,
		["334"] = 276,
		["335"] = 276,
		["336"] = 276,
		["337"] = 276,
		["338"] = 276,
		["339"] = 277,
		["340"] = 277,
		["341"] = 277,
		["342"] = 277,
		["343"] = 277,
		["344"] = 278,
		["345"] = 278,
		["346"] = 278,
		["347"] = 278,
		["348"] = 278,
		["349"] = 278,
		["350"] = 278,
		["351"] = 278,
		["353"] = 263,
		["354"] = 281,
		["355"] = 282,
		["356"] = 283,
		["358"] = 281,
		["359"] = 286,
		["360"] = 287,
		["361"] = 288,
		["362"] = 289,
		["363"] = 290,
		["364"] = 291,
		["365"] = 292,
		["366"] = 293,
		["367"] = 293,
		["368"] = 293,
		["369"] = 293,
		["370"] = 293,
		["371"] = 294,
		["372"] = 294,
		["373"] = 294,
		["374"] = 294,
		["375"] = 294,
		["376"] = 295,
		["377"] = 296,
		["378"] = 296,
		["379"] = 296,
		["380"] = 296,
		["381"] = 296,
		["382"] = 296,
		["383"] = 296,
		["384"] = 296,
		["385"] = 296,
		["386"] = 297,
		["387"] = 297,
		["388"] = 297,
		["389"] = 297,
		["390"] = 297,
		["391"] = 298,
		["392"] = 299,
		["393"] = 300,
		["394"] = 301,
		["396"] = 306,
		["398"] = 309,
		["399"] = 310,
		["400"] = 311,
		["401"] = 312,
		["402"] = 313,
		["403"] = 313,
		["404"] = 313,
		["405"] = 313,
		["406"] = 313,
		["407"] = 314,
		["408"] = 314,
		["409"] = 314,
		["410"] = 314,
		["411"] = 314,
		["412"] = 314,
		["413"] = 314,
		["414"] = 314,
		["415"] = 314,
		["416"] = 315,
		["420"] = 286,
		["421"] = 320,
		["422"] = 321,
		["423"] = 320,
		["424"] = 326,
		["425"] = 327,
		["426"] = 327,
		["427"] = 327,
		["428"] = 327,
		["429"] = 327,
		["430"] = 327,
		["431"] = 327,
		["432"] = 326,
		["433"] = 249,
		["434"] = 241,
		["435"] = 241,
		["436"] = 241,
		["437"] = 241,
		["438"] = 241,
		["439"] = 241,
		["440"] = 241,
		["441"] = 241,
		["442"] = 249,
		["444"] = 249,
		["446"] = 340,
		["447"] = 341,
		["448"] = 340,
		["449"] = 341,
		["450"] = 342,
		["451"] = 343,
		["452"] = 344,
		["453"] = 345,
		["454"] = 342,
		["455"] = 347,
		["456"] = 347,
		["457"] = 347,
		["459"] = 348,
		["460"] = 349,
		["461"] = 350,
		["462"] = 351,
		["463"] = 347,
		["464"] = 353,
		["465"] = 354,
		["466"] = 353,
		["467"] = 341,
		["468"] = 340,
		["469"] = 341,
		["471"] = 341,
		["472"] = 358,
		["473"] = 366,
		["474"] = 358,
		["475"] = 366,
		["476"] = 369,
		["477"] = 369,
		["478"] = 373,
		["479"] = 374,
		["480"] = 374,
		["481"] = 376,
		["482"] = 376,
		["483"] = 376,
		["484"] = 374,
		["485"] = 374,
		["486"] = 373,
		["487"] = 379,
		["488"] = 379,
		["489"] = 384,
		["490"] = 385,
		["491"] = 384,
		["492"] = 387,
		["493"] = 387,
		["494"] = 366,
		["495"] = 358,
		["496"] = 358,
		["497"] = 358,
		["498"] = 358,
		["499"] = 358,
		["500"] = 358,
		["501"] = 358,
		["502"] = 358,
		["503"] = 366,
		["505"] = 366,
		["507"] = 395,
		["508"] = 404,
		["509"] = 395,
		["510"] = 404,
		["511"] = 412,
		["512"] = 413,
		["513"] = 414,
		["514"] = 415,
		["515"] = 416,
		["516"] = 418,
		["517"] = 419,
		["518"] = 412,
		["519"] = 421,
		["520"] = 422,
		["521"] = 423,
		["522"] = 424,
		["524"] = 426,
		["525"] = 427,
		["526"] = 427,
		["527"] = 427,
		["528"] = 427,
		["529"] = 427,
		["530"] = 427,
		["531"] = 427,
		["532"] = 427,
		["533"] = 427,
		["534"] = 428,
		["535"] = 428,
		["536"] = 428,
		["537"] = 428,
		["538"] = 428,
		["539"] = 429,
		["540"] = 429,
		["541"] = 429,
		["542"] = 429,
		["543"] = 429,
		["544"] = 429,
		["545"] = 429,
		["546"] = 429,
		["547"] = 429,
		["548"] = 430,
		["549"] = 430,
		["550"] = 430,
		["551"] = 430,
		["552"] = 430,
		["553"] = 430,
		["554"] = 430,
		["555"] = 430,
		["557"] = 421,
		["558"] = 433,
		["559"] = 434,
		["560"] = 435,
		["561"] = 436,
		["562"] = 437,
		["563"] = 438,
		["564"] = 439,
		["565"] = 440,
		["566"] = 433,
		["567"] = 442,
		["568"] = 443,
		["569"] = 442,
		["570"] = 453,
		["571"] = 454,
		["572"] = 453,
		["573"] = 404,
		["574"] = 395,
		["575"] = 395,
		["576"] = 395,
		["577"] = 395,
		["578"] = 395,
		["579"] = 395,
		["580"] = 395,
		["581"] = 395,
		["582"] = 395,
		["583"] = 404,
		["585"] = 404,
		["587"] = 465,
		["588"] = 473,
		["589"] = 465,
		["590"] = 473,
		["591"] = 475,
		["592"] = 476,
		["593"] = 475,
		["594"] = 478,
		["595"] = 479,
		["596"] = 480,
		["597"] = 481,
		["599"] = 483,
		["600"] = 484,
		["601"] = 484,
		["602"] = 484,
		["603"] = 484,
		["604"] = 484,
		["605"] = 484,
		["606"] = 484,
		["607"] = 484,
		["609"] = 478,
		["610"] = 487,
		["611"] = 488,
		["612"] = 487,
		["613"] = 473,
		["614"] = 465,
		["615"] = 465,
		["616"] = 465,
		["617"] = 465,
		["618"] = 465,
		["619"] = 465,
		["620"] = 465,
		["621"] = 465,
		["622"] = 473,
		["624"] = 473,
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
g.ember_spirit_talent = c()
local q = g.ember_spirit_talent
q.name = "ember_spirit_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_ember_spirit_talent"
end
q = e({ j(nil) }, q)
g.ember_spirit_talent = q
g.modifier_ember_spirit_talent = c()
local r = g.modifier_ember_spirit_talent
r.name = "modifier_ember_spirit_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.index = 0
	self.shard_enable = true
end
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("ember_spirit_talent_2", "chance")
	self.min_interval = self:GetAbilitySpecialValueFor("min_interval")
	self.invincible_duration = self:GetAbilitySpecialValueFor("invincible_duration")
	self.tl12_chance = self:GetAbilityTalentValue("ember_spirit_talent_12", "chance")
	self.remnants = {}
	self.shard_again_chance = self:GetAbilityTalentValue("ember_spirit_shard", "again_chance")
	self.shard_stun_duration = self:GetAbilityTalentValue("ember_spirit_shard", "stun_duration")
	self.shard_shard_duration = self:GetAbilityTalentValue("ember_spirit_shard", "shard_duration")
	self.shard_shard_interval = self:GetAbilityTalentValue("ember_spirit_shard", "shard_interval")
	self.shard_cooldown = self:GetAbilityTalentValue("ember_spirit_shard", "cooldown")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self:GetTl12Ability()
		self.tl12_record = 0
		self.invincible_time = GameRules:GetGameTime()
		self:StartIntervalThink(1)
	end
end
function r.prototype.OnDestroy(self)
	if IsServer() then
		do
			local t = 0
			while t < #self.remnants do
				ParticleManager:DestroyParticle(self.remnants[t + 1]._particleID, false)
				self.remnants[t + 1]:Remove()
				t = t + 1
			end
		end
		self:StartThink(-1, "shard")
		if self.shard_debuff ~= nil then
			ParticleManager:DestroyParticle(self.shard_debuff, false)
			self.shard_debuff = nil
		end
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	self:GetTl12Ability()
end
function r.prototype.GetTl12Ability(self)
	self.tl12Ability = self:GetParent():FindAbilityByName("ember_spirit_talent_12")
end
function r.prototype.OnBattleEnd(self, s)
	self:StartThink(-1, "shard")
	self:StartThink(-1, "shard_cooldown")
	if self.shard_debuff ~= nil then
		ParticleManager:DestroyParticle(self.shard_debuff, false)
		self.shard_debuff = nil
	end
end
function r.prototype.OnFuryGained(self, s)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if self:PRD(self.chance, "fury_gain") then
		self:SleightOfFist()
		if self.shard_enable and self:PRD(self.shard_again_chance, "shard_again") then
			local u = self:GetParent()
			local v = u:GetEnemy()
			local w = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ember_spirit/ember_spirit_searing_chains_start.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				u
			)
			ParticleManager:SetParticleControl(w, 0, u:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt(
				w,
				1,
				v,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				v:GetAbsOrigin(),
				false
			)
			GameTimer(0.35, function()
				AddStun(self:GetParent(), self:GetParent():GetEnemy(), self:GetAbility(), self.shard_stun_duration)
				self.shard_enable = false
				self:StartThink(self.shard_shard_interval, "shard")
				self:StartThink(self.shard_cooldown, "shard_cooldown")
				self.shard_debuff = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_ember_spirit/ember_spirit_searing_chains_debuff.vpcf",
					PATTACH_ABSORIGIN,
					v
				)
				self:AddParticle(w, false, false, -1, false, false)
			end)
			GameTimer(self.shard_shard_duration, function()
				self:StartThink(-1, "shard")
				ParticleManager:DestroyParticle(self.shard_debuff, false)
				self.shard_debuff = nil
			end)
		end
	end
	if self.tl12_chance > 0 then
		self.tl12_record = self.tl12_record + 1
		if self.tl12_record >= self.tl12_chance then
			self.tl12_record = 0
			self:CreateRemnant()
		end
	end
end
function r.prototype.OnThink(self, x)
	if x == "shard" then
		self:StartThink(self.shard_shard_interval, "shard")
		self:SleightOfFist()
	end
	if x == "shard_cooldown" then
		self.shard_enable = true
	end
end
function r.prototype.SleightOfFist(self)
	local y = self:GetAbility()
	local u = self:GetParent()
	local z = u:GetEnemy()
	if IsInjurable(z) then
		local A = 0
		u:AddNewModifier(
			u,
			y,
			"modifier_ember_spirit_talent_buff",
			{ duration = self.invincible_duration, invincible = A }
		)
	end
end
function r.prototype.CreateRemnant(self)
	local u = self:GetParent()
	local z = u:GetEnemy()
	if not IsInjurable(u, z) then
		return
	end
	local B = self.remnants
	local C = z:GetAbsOrigin()
	local D = RotatePosition(vec3_zero, QAngle(0, self.index * 120, 0), vec3_top)
	local E = C + D * 250
	local F = (E - u:GetAbsOrigin()):Length2D()
	self.index = self.index + 1
	Projectile:CreateLinearProjectile({
		EffectName = "particles/units/heroes/hero_ember_spirit/ember_spirit_fire_remnant_trail.vpcf",
		hCaster = u,
		vSpawnOrigin = u:GetAbsOrigin(),
		vDirection = (E - u:GetAbsOrigin()):Normalized(),
		flDistance = F,
		flRadius = 0,
		iMoveSpeed = F,
		OnProjectileDestroy = function(G, H)
			if not IsInjurable(u, z) then
				return
			end
			local I = SpawnEntityFromTableSynchronous(
				"prop_dynamic",
				{
					origin = G,
					model = Wearable:getReplaceUnitModel(u, "models/heroes/ember_spirit/ember_spirit_sfm.vmdl"),
					DefaultAnim = "ACT_DOTA_OVERRIDE_ABILITY_4",
					use_animgraph = "1",
					AnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				}
			)
			local w = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ember_spirit/ember_spirit__2fire_remnant.vpcf",
				PATTACH_ABSORIGIN,
				I,
				u
			)
			I._particleID = w
			B[#B + 1] = I
			if #B == BUFF_VALUE.RemnantCount then
				self:Detonate()
			end
		end,
	})
end
function r.prototype.Detonate(self)
	local J = {}
	do
		local t = 0
		while t < BUFF_VALUE.RemnantCount do
			J[#J + 1] = table.remove(self.remnants, 1)
			t = t + 1
		end
	end
	GameTimer(0.2, function()
		for K, L in ipairs(J) do
			ParticleManager:DestroyParticle(L._particleID, false)
			L:Remove()
		end
	end)
	local u = self:GetParent()
	local z = u:GetEnemy()
	u:DealDamage(
		z,
		self.tl12Ability,
		GetFury(u) * BUFF_VALUE.RemnantFuryDamage * 0.01,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
	)
end
function r.prototype.OnIntervalThink(self)
	if self.tl12_chance > 0 and #self.remnants > 0 then
		local u = self:GetParent()
		local z = u:GetEnemy()
		if IsInjurable(u, z) then
			local M = #self.remnants
			AddFury(u, BUFF_VALUE.RemnantFury * M, "ember_spirit_talent_12", "Ability")
			u:DealDamage(z, self.tl12Ability, BUFF_VALUE.RemnantDmg * M, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		end
	end
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
g.modifier_ember_spirit_talent = r
g.modifier_ember_spirit_talent_buff = c()
local N = g.modifier_ember_spirit_talent_buff
N.name = "modifier_ember_spirit_talent_buff"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.fury_pct = self:GetAbilitySpecialValueFor("fury_pct")
		+ self:GetAbilityTalentValue("ember_spirit_talent_3", "fury_pct")
	self.crit_damage_bonus = self:GetAbilityTalentValue("ember_spirit_talent_10", "crit_damage_bonus")
	self.chance = self:GetAbilityTalentValue("ember_spirit_talent_11", "chance")
	self.duration = self:GetAbilityTalentValue("ember_spirit_talent_11", "duration")
end
function N.prototype.OnCreated(self, s)
	local u = self:GetParent()
	if IsServer() then
		self.invincible = s.invincible
		local v = u:GetEnemy()
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ember_spirit/ember_spirit_sleight_of_fist_cast.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			u
		)
		ParticleManager:SetParticleControl(O, 0, v:GetAbsOrigin())
		ParticleManager:SetParticleControl(O, 1, Vector(350, 350, 350))
		self:AddParticle(O, false, false, -1, false, false)
		u:EmitSound("Hero_EmberSpirit.SleightOfFist.Cast")
		local w = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ember_spirit/ember_spirit_sleight_of_fist_caster.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			u
		)
		ParticleManager:SetParticleControl(w, 0, u:GetAbsOrigin())
		ParticleManager:SetParticleControlEnt(w, 1, u, PATTACH_CUSTOMORIGIN_FOLLOW, nil, u:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlForward(w, 1, u:GetForwardVector())
		self:AddParticle(w, false, false, -1, false, false)
	end
end
function N.prototype.OnRefresh(self, s)
	if IsServer() then
		self.invincible = s.invincible
	end
end
function N.prototype.OnDestroy(self)
	if IsServer() then
		local u = self:GetParent()
		local v = u:GetEnemy()
		local y = self:GetAbility()
		if IsInjurable(v) and IsInjurable(u) then
			local w = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ember_spirit/ember_spirit_sleightoffist_trail.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil,
				u
			)
			ParticleManager:SetParticleControl(w, 0, u:GetAbsOrigin())
			ParticleManager:SetParticleControl(w, 1, v:GetAbsOrigin())
			local P = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ember_spirit/ember_spirit_sleightoffist_tgt.vpcf",
				PATTACH_CUSTOMORIGIN,
				v,
				u
			)
			ParticleManager:SetParticleControlEnt(
				P,
				0,
				v,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				v:GetAbsOrigin(),
				true
			)
			EmitSoundOnLocationWithCaster(v:GetAbsOrigin(), "Hero_EmberSpirit.SleightOfFist.Damage", u)
			local Q = self.base_damage + GetFury(u) * self.fury_pct * 0.01
			if self:HasTalent("ember_spirit_talent_4") then
				Q = Q + GetAttackDamage(u)
				DamageSystem:performAttack(u, v, { ability = y, damage = Q })
			else
				u:DealDamage(v, y, Q, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
			end
			if self:PRD(self.chance, "talent_11") then
				v:AddNewModifier(u, y, "modifier_ember_spirit_talent_11", { duration = self.duration })
				ParticleManager:CreateParticle(
					"particles/units/heroes/hero_ember_spirit/ember_spirit_searing_chains_cast.vpcf",
					PATTACH_ABSORIGIN,
					u
				)
				local w = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_ember_spirit/ember_spirit_searing_chains_start.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil,
					u
				)
				ParticleManager:SetParticleControl(w, 0, u:GetAbsOrigin())
				ParticleManager:SetParticleControlEnt(
					w,
					1,
					v,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					v:GetAbsOrigin(),
					false
				)
				u:EmitSound("Hero_EmberSpirit.SearingChains.Cast")
			end
		end
	end
end
function N.prototype.CheckState(self)
	return {}
end
function N.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_INJURY_PERCENTAGE] = 100 * (self.invincible or 0),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_POISON_PERCENTAGE] = 100 * (self.invincible or 0),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_ICE_PERCENTAGE] = 100 * (self.invincible or 0),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE] = 100 * (self.invincible or 0),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE] = self.crit_damage_bonus,
	}
end
N = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	N
)
g.modifier_ember_spirit_talent_buff = N
g.ember_spirit_ult = c()
local R = g.ember_spirit_ult
R.name = "ember_spirit_ult"
d(R, o)
function R.prototype.OnSpellStart(self)
	local S = self:GetCaster()
	S:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	self:AddEmberShield()
end
function R.prototype.AddEmberShield(self, T)
	if T == nil then
		T = self:GetSpecialValueFor("duration")
	end
	local S = self:GetCaster()
	S:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	S:AddNewModifier(S, self, "modifier_ember_spirit_ult_buff", { duration = T })
	S:EmitSound("Hero_EmberSpirit.FlameGuard.Cast")
end
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_ember_spirit_ult"
end
R = e({ p(nil) }, R)
g.ember_spirit_ult = R
g.modifier_ember_spirit_ult = c()
local U = g.modifier_ember_spirit_ult
U.name = "modifier_ember_spirit_ult"
d(U, l)
function U.prototype.GetAbilitySpecialValue(self) end
function U.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function U.prototype.OnBattleStartBefore(self, s) end
function U.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
end
function U.prototype.OnIntervalThink(self) end
U = e(
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
	U
)
g.modifier_ember_spirit_ult = U
g.modifier_ember_spirit_ult_buff = c()
local V = g.modifier_ember_spirit_ult_buff
V.name = "modifier_ember_spirit_ult_buff"
d(V, l)
function V.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("ember_spirit_talent_5", "damage_interval_reduce")
	self.fury_gain = self:GetAbilitySpecialValueFor("fury_gain")
	self.shield_gain = self:GetAbilitySpecialValueFor("shield_gain")
		+ self:GetAbilityTalentValue("ember_spirit_talent_1", "shield")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
		+ self:GetAbilityTalentValue("ember_spirit_talent_1", "damage_bonus")
	self.magical_damage_reduce = self:GetAbilityTalentValue("ember_spirit_talent_8", "magical_damage_reduce")
	self.fury_damage_pct = self:GetAbilityTalentValue("ember_spirit_talent_9", "fury_damage_pct")
end
function V.prototype.OnCreated(self, s)
	local u = self:GetParent()
	if IsServer() then
		self:StartIntervalThink(self.interval)
	else
		local w = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ember_spirit/ember_spirit_flameguard.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			u
		)
		ParticleManager:SetParticleControlEnt(w, 1, u, PATTACH_ABSORIGIN_FOLLOW, nil, u:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(w, 2, Vector(350, 350, 350))
		ParticleManager:SetParticleControl(w, 3, Vector(u:GetModelRadius(), 0, 0))
		self:AddParticle(w, false, false, -1, false, false)
	end
end
function V.prototype.OnIntervalThink(self)
	local u = self:GetParent()
	local v = u:GetEnemy()
	local y = self:GetAbility()
	AddFury(u, self.fury_gain, "ember_spirit_ult", "Ability")
	AddShield(u, self.shield_gain, "ember_spirit_ult", "Ability")
	local Q = self.base_damage + GetFury(u) * self.fury_damage_pct * 0.01
	u:DealDamage(v, y, Q, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
function V.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function V.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self, s)
	return -self.magical_damage_reduce
end
V = e(
	{
		m(
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
	V
)
g.modifier_ember_spirit_ult_buff = V
g.modifier_ember_spirit_talent_11 = c()
local W = g.modifier_ember_spirit_talent_11
W.name = "modifier_ember_spirit_talent_11"
d(W, l)
function W.prototype.GetAbilitySpecialValue(self)
	self.mana_reduce = self:GetAbilityTalentValue("ember_spirit_talent_11", "mana_reduce")
end
function W.prototype.OnCreated(self, s)
	local u = self:GetParent()
	if IsServer() then
		u:EmitSound("Hero_EmberSpirit.SearingChains.Target")
	else
		local w = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ember_spirit/ember_spirit_searing_chains_debuff.vpcf",
			PATTACH_ABSORIGIN,
			u
		)
		self:AddParticle(w, false, false, -1, false, false)
	end
end
function W.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_LOSS_PERCENTAGE] = self.mana_reduce }
end
W = e(
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
	W
)
g.modifier_ember_spirit_talent_11 = W
return g