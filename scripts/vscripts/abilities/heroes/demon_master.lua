--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/demon_master"
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
		["36"] = 27,
		["37"] = 15,
		["38"] = 29,
		["39"] = 30,
		["40"] = 32,
		["41"] = 34,
		["42"] = 35,
		["43"] = 36,
		["45"] = 29,
		["46"] = 40,
		["47"] = 41,
		["48"] = 42,
		["49"] = 40,
		["50"] = 44,
		["51"] = 45,
		["52"] = 45,
		["53"] = 47,
		["54"] = 47,
		["55"] = 47,
		["56"] = 45,
		["57"] = 48,
		["58"] = 48,
		["59"] = 48,
		["60"] = 45,
		["61"] = 45,
		["62"] = 44,
		["63"] = 51,
		["64"] = 52,
		["65"] = 51,
		["66"] = 54,
		["67"] = 55,
		["70"] = 56,
		["71"] = 57,
		["72"] = 58,
		["74"] = 54,
		["75"] = 61,
		["76"] = 62,
		["77"] = 64,
		["78"] = 65,
		["79"] = 66,
		["80"] = 67,
		["81"] = 68,
		["82"] = 69,
		["83"] = 69,
		["84"] = 69,
		["85"] = 69,
		["86"] = 69,
		["87"] = 69,
		["88"] = 70,
		["89"] = 70,
		["90"] = 70,
		["91"] = 70,
		["92"] = 70,
		["93"] = 70,
		["96"] = 73,
		["97"] = 74,
		["98"] = 75,
		["101"] = 61,
		["102"] = 79,
		["103"] = 80,
		["106"] = 81,
		["107"] = 83,
		["108"] = 84,
		["109"] = 85,
		["110"] = 86,
		["111"] = 87,
		["112"] = 88,
		["113"] = 89,
		["114"] = 90,
		["116"] = 92,
		["117"] = 93,
		["118"] = 93,
		["119"] = 93,
		["120"] = 94,
		["121"] = 95,
		["122"] = 96,
		["123"] = 97,
		["124"] = 97,
		["125"] = 97,
		["126"] = 97,
		["127"] = 97,
		["128"] = 98,
		["130"] = 93,
		["131"] = 93,
		["132"] = 79,
		["133"] = 23,
		["134"] = 15,
		["135"] = 15,
		["136"] = 15,
		["137"] = 15,
		["138"] = 15,
		["139"] = 15,
		["140"] = 15,
		["141"] = 15,
		["142"] = 23,
		["144"] = 23,
		["145"] = 103,
		["146"] = 113,
		["147"] = 103,
		["148"] = 113,
		["150"] = 113,
		["151"] = 114,
		["152"] = 103,
		["153"] = 117,
		["154"] = 118,
		["155"] = 117,
		["156"] = 120,
		["157"] = 121,
		["158"] = 122,
		["159"] = 123,
		["161"] = 120,
		["162"] = 126,
		["163"] = 127,
		["164"] = 128,
		["166"] = 126,
		["167"] = 131,
		["168"] = 132,
		["169"] = 131,
		["170"] = 137,
		["171"] = 138,
		["172"] = 138,
		["173"] = 138,
		["174"] = 138,
		["175"] = 139,
		["176"] = 140,
		["177"] = 137,
		["178"] = 143,
		["179"] = 144,
		["182"] = 145,
		["185"] = 146,
		["186"] = 147,
		["187"] = 143,
		["188"] = 149,
		["189"] = 150,
		["190"] = 151,
		["191"] = 152,
		["192"] = 153,
		["193"] = 154,
		["195"] = 149,
		["196"] = 113,
		["197"] = 103,
		["198"] = 103,
		["199"] = 103,
		["200"] = 103,
		["201"] = 103,
		["202"] = 103,
		["203"] = 103,
		["204"] = 103,
		["205"] = 103,
		["206"] = 103,
		["207"] = 113,
		["209"] = 113,
		["210"] = 158,
		["211"] = 166,
		["212"] = 158,
		["213"] = 166,
		["214"] = 167,
		["215"] = 168,
		["216"] = 167,
		["217"] = 174,
		["218"] = 175,
		["219"] = 177,
		["220"] = 179,
		["221"] = 174,
		["222"] = 182,
		["223"] = 183,
		["224"] = 184,
		["225"] = 185,
		["226"] = 186,
		["227"] = 187,
		["228"] = 188,
		["229"] = 189,
		["232"] = 182,
		["233"] = 193,
		["234"] = 194,
		["235"] = 195,
		["236"] = 196,
		["237"] = 197,
		["238"] = 198,
		["239"] = 199,
		["242"] = 193,
		["243"] = 203,
		["244"] = 204,
		["245"] = 205,
		["246"] = 206,
		["247"] = 207,
		["248"] = 208,
		["249"] = 209,
		["250"] = 210,
		["251"] = 211,
		["256"] = 203,
		["257"] = 166,
		["258"] = 158,
		["259"] = 158,
		["260"] = 158,
		["261"] = 158,
		["262"] = 158,
		["263"] = 158,
		["264"] = 158,
		["265"] = 158,
		["266"] = 166,
		["268"] = 166,
		["270"] = 219,
		["271"] = 227,
		["272"] = 219,
		["273"] = 227,
		["274"] = 231,
		["275"] = 232,
		["276"] = 233,
		["277"] = 234,
		["278"] = 235,
		["279"] = 235,
		["280"] = 235,
		["281"] = 235,
		["282"] = 236,
		["283"] = 237,
		["284"] = 239,
		["285"] = 240,
		["287"] = 242,
		["288"] = 242,
		["289"] = 242,
		["290"] = 242,
		["291"] = 242,
		["292"] = 242,
		["293"] = 242,
		["294"] = 242,
		["295"] = 243,
		["296"] = 244,
		["299"] = 231,
		["300"] = 248,
		["301"] = 249,
		["302"] = 250,
		["303"] = 251,
		["305"] = 253,
		["306"] = 254,
		["307"] = 255,
		["311"] = 248,
		["312"] = 260,
		["313"] = 261,
		["314"] = 262,
		["315"] = 263,
		["316"] = 263,
		["317"] = 262,
		["319"] = 266,
		["320"] = 260,
		["321"] = 268,
		["322"] = 269,
		["323"] = 270,
		["324"] = 271,
		["326"] = 268,
		["327"] = 274,
		["328"] = 275,
		["329"] = 276,
		["331"] = 280,
		["332"] = 274,
		["333"] = 282,
		["334"] = 283,
		["335"] = 282,
		["336"] = 227,
		["337"] = 219,
		["338"] = 219,
		["339"] = 219,
		["340"] = 219,
		["341"] = 219,
		["342"] = 219,
		["343"] = 219,
		["344"] = 219,
		["345"] = 227,
		["347"] = 227,
		["349"] = 289,
		["350"] = 297,
		["351"] = 289,
		["352"] = 297,
		["353"] = 299,
		["354"] = 301,
		["355"] = 299,
		["356"] = 303,
		["357"] = 304,
		["358"] = 305,
		["360"] = 303,
		["361"] = 308,
		["362"] = 309,
		["363"] = 310,
		["364"] = 310,
		["365"] = 310,
		["366"] = 310,
		["367"] = 311,
		["369"] = 308,
		["370"] = 314,
		["371"] = 315,
		["372"] = 314,
		["373"] = 320,
		["374"] = 321,
		["375"] = 320,
		["376"] = 297,
		["377"] = 289,
		["378"] = 289,
		["379"] = 289,
		["380"] = 289,
		["381"] = 289,
		["382"] = 289,
		["383"] = 289,
		["384"] = 289,
		["385"] = 297,
		["387"] = 297,
		["389"] = 325,
		["390"] = 335,
		["391"] = 325,
		["392"] = 335,
		["393"] = 340,
		["394"] = 342,
		["395"] = 344,
		["396"] = 346,
		["397"] = 348,
		["398"] = 340,
		["399"] = 350,
		["400"] = 351,
		["402"] = 350,
		["403"] = 376,
		["404"] = 377,
		["405"] = 376,
		["406"] = 381,
		["407"] = 382,
		["408"] = 381,
		["409"] = 384,
		["410"] = 385,
		["411"] = 384,
		["412"] = 389,
		["413"] = 390,
		["414"] = 389,
		["415"] = 396,
		["416"] = 397,
		["417"] = 396,
		["418"] = 335,
		["419"] = 325,
		["420"] = 325,
		["421"] = 325,
		["422"] = 325,
		["423"] = 325,
		["424"] = 325,
		["425"] = 325,
		["426"] = 325,
		["427"] = 325,
		["428"] = 325,
		["429"] = 335,
		["431"] = 335,
		["433"] = 403,
		["434"] = 404,
		["435"] = 403,
		["436"] = 404,
		["437"] = 405,
		["438"] = 406,
		["439"] = 407,
		["440"] = 408,
		["443"] = 409,
		["444"] = 410,
		["445"] = 410,
		["446"] = 410,
		["447"] = 410,
		["448"] = 411,
		["449"] = 412,
		["451"] = 410,
		["452"] = 410,
		["453"] = 415,
		["454"] = 405,
		["455"] = 417,
		["456"] = 418,
		["457"] = 419,
		["458"] = 420,
		["461"] = 423,
		["462"] = 424,
		["463"] = 425,
		["464"] = 426,
		["465"] = 427,
		["468"] = 431,
		["469"] = 432,
		["470"] = 433,
		["471"] = 433,
		["472"] = 433,
		["473"] = 433,
		["474"] = 433,
		["475"] = 433,
		["476"] = 440,
		["477"] = 441,
		["478"] = 442,
		["479"] = 443,
		["480"] = 444,
		["481"] = 445,
		["483"] = 447,
		["484"] = 448,
		["485"] = 448,
		["486"] = 448,
		["487"] = 448,
		["488"] = 448,
		["489"] = 448,
		["490"] = 448,
		["491"] = 448,
		["492"] = 448,
		["493"] = 448,
		["495"] = 459,
		["496"] = 459,
		["497"] = 459,
		["498"] = 459,
		["499"] = 459,
		["500"] = 459,
		["501"] = 459,
		["502"] = 459,
		["503"] = 459,
		["504"] = 459,
		["507"] = 433,
		["508"] = 433,
		["510"] = 474,
		["511"] = 417,
		["512"] = 404,
		["513"] = 403,
		["514"] = 404,
		["516"] = 404,
		["518"] = 481,
		["519"] = 482,
		["520"] = 481,
		["521"] = 482,
		["522"] = 483,
		["523"] = 484,
		["524"] = 485,
		["525"] = 486,
		["528"] = 487,
		["529"] = 488,
		["530"] = 489,
		["531"] = 489,
		["532"] = 489,
		["533"] = 490,
		["536"] = 491,
		["537"] = 492,
		["538"] = 493,
		["539"] = 493,
		["540"] = 493,
		["541"] = 493,
		["542"] = 494,
		["543"] = 495,
		["545"] = 493,
		["546"] = 493,
		["547"] = 498,
		["548"] = 499,
		["549"] = 500,
		["550"] = 501,
		["552"] = 503,
		["553"] = 489,
		["554"] = 489,
		["555"] = 483,
		["556"] = 482,
		["557"] = 481,
		["558"] = 482,
		["560"] = 482,
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
g.demon_master_talent = c()
local q = g.demon_master_talent
q.name = "demon_master_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_demon_master_talent"
end
q = e({ j(nil) }, q)
g.demon_master_talent = q
g.modifier_demon_master_talent = c()
local r = g.modifier_demon_master_talent
r.name = "modifier_demon_master_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.unblockDemon = false
end
function r.prototype.GetAbilitySpecialValue(self)
	self.physical_pct = self:GetAbilitySpecialValueFor("physical_pct")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.tl2_threshold = self:GetAbilityTalentValue("demon_master_talent_2", "threshold")
	if IsServer() then
		self.counter = 0
	end
end
function r.prototype.SaveStack(self, s)
	local t = PlayerData:getplayerData(s)
	t:modifyPermanentBuffStackCount("modifier_demon_master_permanent", self.physical_pct)
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), self:GetParent() },
	}
end
function r.prototype.OnBattleStartBefore(self, u)
	self.counter = 0
end
function r.prototype.OnBattleEnd(self, u)
	if u.isNeutral then
		return
	end
	local v = u.winPlayerID
	if v ~= u.illusionPlayerID then
		self:SaveStack(v)
	end
end
function r.prototype.OnCustomTakeDamage(self, w)
	if w.attacker == self:GetParent() then
		if w.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS then
			self.counter = self.counter + 1
			if self.counter >= self.count then
				self.counter = 0
				local x = self:GetParent()
				x:AddNewModifier(x, self:GetAbility(), "modifier_demon_master_talent_mark", nil)
				x:AddNewModifier(x, self:GetAbility(), "modifier_demon_master_talent_buff", nil)
			end
		end
	elseif self.tl2_threshold > 0 then
		if self:GetParent():GetHealthPercent() <= self.tl2_threshold then
			self:OnUnblockDemon()
		end
	end
end
function r.prototype.OnUnblockDemon(self)
	if self.unblockDemon then
		return
	end
	self.unblockDemon = true
	local x = self:GetParent()
	local y = self:GetAbility()
	x:SwapAbilities("demon_master_ult", "demon_master_extra", false, true)
	x:AddNewModifier(x, y, "modifier_demon_master_unblock_demon", nil)
	local z = x:AddNewModifier(x, y, "modifier_demon_master_unblock_demon_buff", nil)
	x:AddNewModifier(x, y, "modifier_demon_master_unblock_demon_buff2", nil)
	if IsValid(z) then
		z:SetStackCount(
			PlayerData:getplayerData(x:GetPlayerOwnerID()):GetPermanentBuffStackCount("modifier_demon_master_permanent")
		)
	end
	x:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	GameTimer(0.27, function()
		if IsInjurable(x) then
			x:EmitSound("Hero_Sven.WarCry.Signet")
			local A = ParticleManager:CreateParticle(
				"models/eom/hero/chonglou_1/particles/chonglou_1_bianshen.vpcf",
				PATTACH_ABSORIGIN,
				x
			)
			ParticleManager:SetParticleControl(A, 3, x:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(A)
		end
	end)
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
g.modifier_demon_master_talent = r
g.modifier_demon_master_talent_buff = c()
local B = g.modifier_demon_master_talent_buff
B.name = "modifier_demon_master_talent_buff"
d(B, l)
function B.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.enable = false
end
function B.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function B.prototype.OnCreated(self, u)
	if IsServer() then
		self:IncrementStackCount()
		self.attackHeartWave = false
	end
end
function B.prototype.OnRespawn(self, u)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function B.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_BONUS,
	}
end
function B.prototype.GetMarkBonusDamage(self)
	local C = self:GetParent():GetModifierStackCount("modifier_demon_master_talent_mark", self:GetParent()) or 0
	self:Destroy()
	return self:GetStackCount() * self.damage * C
end
function B.prototype.EOM_GetModifierAttackSourceAbility(self, u)
	if self.attackHeartWave and self:GetParent():HasModifier("modifier_demon_master_unblock_demon") then
		return
	end
	if self.enable then
		return
	end
	self.enable = true
	return self:GetAbility()
end
function B.prototype.EOM_GetModifierProcAttackDamageBonus(self, u)
	if self.enable and u.ability and IsValid(u.ability) then
		u.target:EmitSound("Item_Desolator.Target")
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_chonglou/hero_chonglou_talent.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			u.target
		)
		ParticleManager:ReleaseParticleIndex(A)
		return self:GetMarkBonusDamage()
	end
end
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
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	B
)
g.modifier_demon_master_talent_buff = B
g.modifier_demon_master_talent_mark = c()
local D = g.modifier_demon_master_talent_mark
D.name = "modifier_demon_master_talent_mark"
d(D, l)
function D.prototype.GetTexture(self)
	return "demon_master_talent_mark"
end
function D.prototype.GetAbilitySpecialValue(self)
	self.physical_pct = self:GetAbilitySpecialValueFor("physical_pct")
	self.buff = self:GetAbilitySpecialValueFor("buff")
		+ self:GetAbilityTalentValue("demon_master_talent_3", "bonus_count")
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
end
function D.prototype.OnCreated(self, u)
	if IsServer() then
		self.unblocked = false
		local E = self:GetStackCount()
		if not self:GetParent():HasModifier("modifier_demon_master_unblock_demon_buff") and E <= self.threshold then
			self:SetStackCount(math.min(E + self.buff, self.threshold))
		elseif self:HasTalent("demon_master_talent_6") then
			self:SetStackCount(E + self.buff)
		end
	end
end
function D.prototype.OnRefresh(self, u)
	if IsServer() then
		local E = self:GetStackCount()
		if not self:GetParent():HasModifier("modifier_demon_master_unblock_demon_buff") and E <= self.threshold then
			self:SetStackCount(math.min(E + self.buff, self.threshold))
		elseif self:HasTalent("demon_master_talent_6") then
			self:SetStackCount(E + self.buff)
		end
	end
end
function D.prototype.OnStackCountChanged(self, F)
	if IsServer() then
		if not self.unblocked then
			local E = self:GetStackCount()
			if E >= self.threshold then
				local G = self:GetParent():FindModifierByName("modifier_demon_master_talent")
				if IsValid(G) then
					self.unblocked = true
					G:OnUnblockDemon()
				end
			end
		end
	end
end
D = e(
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
	D
)
g.modifier_demon_master_talent_mark = D
g.modifier_demon_master_unblock_demon = c()
local H = g.modifier_demon_master_unblock_demon
H.name = "modifier_demon_master_unblock_demon"
d(H, l)
function H.prototype.OnCreated(self, u)
	if IsServer() then
		local x = self:GetParent()
		self.buffExtraDamage = {}
		local I = self:GetParent():GetModifierStackCount("modifier_demon_master_talent_mark", self:GetParent()) or 0
		local J = BUFF_VALUE.UnblockDemonRegenBase
		if I > 0 then
			local K = self:GetAbilityTalentValue("demon_master_shard", "heal_pct")
			J = J + x:GetMaxHealth() * I * (BUFF_VALUE.UnblockDemonRegen + K) * 0.01
		end
		Heal(
			x,
			J,
			"demon_master_talent",
			"Ability",
			true,
			HealFlags.HEAL_FLAG_IGNORE_ADJUST + HealFlags.HEAL_FLAG_IGNORE_DISTURB
		)
		if self:HasTalent("demon_master_talent_5") then
			x:AddActivityModifier("unblock_demon")
		end
	end
end
function H.prototype.GetUltiAbility(self)
	if IsServer() then
		if IsValid(self.ultiAbility) then
			return self.ultiAbility
		end
		self.ultiAbility = self:GetParent():FindAbilityByName("demon_master_ult")
		if IsValid(self.ultiAbility) then
			return self.ultiAbility
		end
		return
	end
end
function H.prototype.EDeclareEvents(self)
	if IsServer() and self:HasTalent("demon_master_talent_5") then
		return { [EOMModifierEvents.MODIFIER_EVENT_ON_FAKE_ATTACK] = { self:GetParent(), -1 } }
	end
	return {}
end
function H.prototype.OnFakeAttack(self, w)
	local L = self:GetUltiAbility()
	if IsValid(L) then
		L:HeartWave(true, w.ability, w.ability_upgrade)
	end
end
function H.prototype.ECheckState(self)
	if IsServer() and self:HasTalent("demon_master_talent_5") then
		return { [EOMModifierStates.MODIFIER_STATE_FAKE_ATTACK] = true }
	end
	return {}
end
function H.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY }
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
g.modifier_demon_master_unblock_demon = H
g.modifier_demon_master_unblock_demon_buff2 = c()
local M = g.modifier_demon_master_unblock_demon_buff2
M.name = "modifier_demon_master_unblock_demon_buff2"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.tl4_convert_pct = self:GetAbilityTalentValue("demon_master_talent_4", "convert_pct")
end
function M.prototype.OnCreated(self, u)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function M.prototype.OnIntervalThink(self)
	if IsServer() then
		local C = self:GetParent():GetModifierStackCount("modifier_demon_master_talent_mark", self:GetParent()) or 0
		self:SetStackCount(C)
	end
end
function M.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS,
	}
end
function M.prototype.EOM_GetModifierManaRegenBonus(self, u)
	return self:GetStackCount() * BUFF_VALUE.UnblockDemonConvertManaRegen * (1 + self.tl4_convert_pct * 0.01)
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
g.modifier_demon_master_unblock_demon_buff2 = M
g.modifier_demon_master_unblock_demon_buff = c()
local N = g.modifier_demon_master_unblock_demon_buff
N.name = "modifier_demon_master_unblock_demon_buff"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.tl4_convert_pct = self:GetAbilityTalentValue("demon_master_talent_4", "convert_pct")
	self.tl5_attackspeed = self:GetAbilityTalentValue("demon_master_talent_5", "attackspeed")
	self.tl6_chaos = self:GetAbilityTalentValue("demon_master_talent_6", "chaos")
	self.tl7_bonus_value = self:GetAbilityTalentValue("demon_master_talent_7", "bonus_value")
end
function N.prototype.OnCreated(self, u)
	if IsServer() then
	end
end
function N.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_EXTRA_MANA_BONUS }
end
function N.prototype.GetModifierExtraManaBonus(self)
	return BUFF_VALUE.UnblockDemonManaLimit - 100
end
function N.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS }
end
function N.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_PERMANENT] = self.tl6_chaos,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.tl5_attackspeed,
	}
end
function N.prototype.EOM_GetModifierChaosDamageBonus(self, u)
	return math.floor(self:GetStackCount() / BUFF_VALUE.UnblockDemonConvertPhy)
		* (BUFF_VALUE.UnblockDemonConvertChaos + self.tl7_bonus_value)
		* (1 + self.tl4_convert_pct * 0.01)
end
N = e(
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
				GetEffectName = "models/eom/hero/chonglou_1/particles/chonglou_1_bianshen_body.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	N
)
g.modifier_demon_master_unblock_demon_buff = N
g.demon_master_ult = c()
local O = g.demon_master_ult
O.name = "demon_master_ult"
d(O, o)
function O.prototype.OnSpellStart(self)
	local P = self:GetCaster()
	local Q = P:GetEnemy()
	if not IsInjurable(P, Q) then
		return
	end
	local E = self:GetSpecialValueFor("count")
	ForWithInterval(0.1, E, function()
		if IsValid(self) then
			self:HeartWave()
		end
	end)
	P:StartGesture(ACT_DOTA_CAST_ABILITY_2)
end
function O.prototype.HeartWave(self, R, S, T)
	local P = self:GetCaster()
	local Q = P:GetEnemy()
	if not IsInjurable(P, Q) then
		return
	end
	local U = self:GetSpecialValueFor("damage") + self:GetTalentValue("demon_master_talent_1", "bonus_damage")
	if R and P:HasModifier("modifier_demon_master_talent_buff") then
		local z = P:FindModifierByName("modifier_demon_master_talent_buff")
		if IsValid(z) then
			U = U + z:GetMarkBonusDamage()
		end
	end
	if IsValid(self) and IsInjurable(P, Q) then
		P:EmitSound("Hero_AbyssalUnderlord.Firestorm")
		Projectile:CreateTrackingProjectile({
			EffectName = "models/eom/hero/chonglou_1/particles/chonglou_1_skill_02.vpcf",
			hCaster = P,
			vSpawnOrigin = P:GetAttachmentPosition("attach_heartwave"),
			hTarget = Q,
			iMoveSpeed = PROJECTILE_SPEED_FAST,
			OnProjectileHit = function(V, W, X)
				if IsValid(self) and IsInjurable(P, Q) then
					Q:EmitSound("Hero_AbyssalUnderlord.Firestorm.Target")
					local y = S
					if not IsValid(S) then
						y = self
					end
					if R then
						DamageSystem:dealDamage({
							attacker = P,
							target = Q,
							ability = y,
							ability_upgrade = T,
							damage = U,
							damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS,
							damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
							damage_category = DOTA_DAMAGE_CATEGORY_ATTACK,
						})
					else
						DamageSystem:dealDamage({
							attacker = P,
							target = Q,
							ability = y,
							ability_upgrade = T,
							damage = U,
							damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS,
							damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
							damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
						})
					end
				end
			end,
		})
	end
	return true
end
O = e({ p(nil) }, O)
g.demon_master_ult = O
g.demon_master_extra = c()
local Y = g.demon_master_extra
Y.name = "demon_master_extra"
d(Y, o)
function Y.prototype.OnSpellStart(self)
	local P = self:GetCaster()
	local Q = P:GetEnemy()
	if not IsInjurable(P, Q) then
		return
	end
	P:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	local U = self:GetSpecialValueFor("damage")
	self:GameTimer(0.37, function()
		if not (IsValid(self) and IsInjurable(P, Q)) then
			return
		end
		local A = ParticleManager:CreateParticle(
			"models/eom/hero/chonglou_1/particles/chonglou_1_skill_01.vpcf",
			PATTACH_ABSORIGIN,
			Q
		)
		ParticleManager:ReleaseParticleIndex(A)
		ForWithInterval(0.1, 3, function()
			if IsValid(Q) then
				Q:EmitSound("Hero_Zuus.LightningHands.Target")
			end
		end)
		local I = 1
		local Z = P:GetModifierStackCount("modifier_demon_master_talent_mark", P)
		if Z > 0 then
			I = Z
		end
		P:DealDamage(Q, self, U * I, EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS)
	end)
end
Y = e({ p(nil) }, Y)
g.demon_master_extra = Y
return g