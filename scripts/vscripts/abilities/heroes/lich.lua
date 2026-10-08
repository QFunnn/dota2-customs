--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/lich"
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
		["30"] = 12,
		["31"] = 20,
		["32"] = 12,
		["33"] = 20,
		["34"] = 34,
		["35"] = 35,
		["36"] = 36,
		["37"] = 37,
		["38"] = 38,
		["39"] = 38,
		["40"] = 38,
		["41"] = 38,
		["42"] = 38,
		["43"] = 38,
		["44"] = 38,
		["45"] = 38,
		["46"] = 38,
		["47"] = 39,
		["48"] = 39,
		["49"] = 39,
		["50"] = 39,
		["51"] = 39,
		["52"] = 39,
		["53"] = 39,
		["54"] = 39,
		["56"] = 34,
		["57"] = 42,
		["58"] = 43,
		["59"] = 44,
		["60"] = 45,
		["61"] = 46,
		["62"] = 47,
		["63"] = 50,
		["64"] = 51,
		["65"] = 52,
		["66"] = 53,
		["67"] = 54,
		["68"] = 55,
		["69"] = 56,
		["70"] = 42,
		["71"] = 58,
		["72"] = 59,
		["73"] = 59,
		["74"] = 61,
		["75"] = 61,
		["76"] = 61,
		["77"] = 59,
		["78"] = 59,
		["79"] = 58,
		["80"] = 64,
		["81"] = 65,
		["82"] = 66,
		["83"] = 67,
		["84"] = 68,
		["85"] = 69,
		["88"] = 64,
		["89"] = 73,
		["90"] = 74,
		["91"] = 74,
		["92"] = 74,
		["93"] = 74,
		["94"] = 74,
		["95"] = 74,
		["96"] = 73,
		["97"] = 76,
		["98"] = 77,
		["99"] = 76,
		["100"] = 20,
		["101"] = 12,
		["102"] = 12,
		["103"] = 12,
		["104"] = 12,
		["105"] = 12,
		["106"] = 12,
		["107"] = 12,
		["108"] = 12,
		["109"] = 20,
		["111"] = 20,
		["112"] = 125,
		["113"] = 134,
		["114"] = 125,
		["115"] = 134,
		["116"] = 135,
		["117"] = 136,
		["118"] = 135,
		["119"] = 147,
		["120"] = 148,
		["121"] = 149,
		["122"] = 150,
		["123"] = 151,
		["124"] = 152,
		["125"] = 153,
		["126"] = 154,
		["127"] = 155,
		["128"] = 156,
		["129"] = 147,
		["130"] = 158,
		["131"] = 159,
		["132"] = 160,
		["134"] = 158,
		["135"] = 163,
		["136"] = 164,
		["137"] = 165,
		["138"] = 166,
		["139"] = 166,
		["140"] = 166,
		["141"] = 166,
		["142"] = 166,
		["143"] = 166,
		["145"] = 163,
		["146"] = 169,
		["147"] = 170,
		["148"] = 171,
		["150"] = 169,
		["151"] = 174,
		["152"] = 175,
		["153"] = 176,
		["154"] = 176,
		["155"] = 175,
		["156"] = 174,
		["157"] = 179,
		["158"] = 180,
		["159"] = 181,
		["160"] = 182,
		["163"] = 184,
		["164"] = 185,
		["165"] = 185,
		["166"] = 185,
		["167"] = 185,
		["168"] = 185,
		["169"] = 185,
		["170"] = 185,
		["172"] = 188,
		["173"] = 191,
		["174"] = 192,
		["176"] = 195,
		["177"] = 196,
		["178"] = 197,
		["181"] = 201,
		["182"] = 201,
		["183"] = 201,
		["184"] = 201,
		["185"] = 201,
		["186"] = 201,
		["187"] = 203,
		["188"] = 204,
		["189"] = 204,
		["190"] = 204,
		["191"] = 204,
		["192"] = 204,
		["193"] = 205,
		["194"] = 205,
		["195"] = 205,
		["196"] = 205,
		["197"] = 205,
		["198"] = 206,
		["199"] = 208,
		["200"] = 209,
		["201"] = 179,
		["202"] = 211,
		["203"] = 213,
		["204"] = 214,
		["205"] = 211,
		["206"] = 216,
		["207"] = 217,
		["208"] = 216,
		["209"] = 219,
		["210"] = 220,
		["211"] = 219,
		["212"] = 222,
		["213"] = 224,
		["214"] = 222,
		["215"] = 134,
		["216"] = 125,
		["217"] = 125,
		["218"] = 125,
		["219"] = 125,
		["220"] = 125,
		["221"] = 125,
		["222"] = 125,
		["223"] = 134,
		["225"] = 134,
		["227"] = 229,
		["228"] = 236,
		["229"] = 229,
		["230"] = 236,
		["231"] = 238,
		["232"] = 239,
		["233"] = 238,
		["234"] = 241,
		["235"] = 242,
		["236"] = 241,
		["237"] = 244,
		["238"] = 245,
		["239"] = 246,
		["241"] = 244,
		["242"] = 249,
		["243"] = 250,
		["244"] = 251,
		["245"] = 251,
		["246"] = 251,
		["247"] = 251,
		["249"] = 249,
		["250"] = 254,
		["251"] = 255,
		["252"] = 256,
		["253"] = 256,
		["254"] = 255,
		["255"] = 254,
		["256"] = 259,
		["257"] = 260,
		["258"] = 259,
		["259"] = 236,
		["260"] = 229,
		["261"] = 229,
		["262"] = 229,
		["263"] = 229,
		["264"] = 229,
		["265"] = 229,
		["266"] = 229,
		["267"] = 236,
		["269"] = 236,
		["271"] = 265,
		["272"] = 266,
		["273"] = 265,
		["274"] = 266,
		["275"] = 267,
		["276"] = 268,
		["277"] = 269,
		["278"] = 271,
		["279"] = 272,
		["280"] = 273,
		["281"] = 274,
		["282"] = 275,
		["283"] = 276,
		["284"] = 277,
		["285"] = 278,
		["286"] = 278,
		["287"] = 278,
		["288"] = 278,
		["289"] = 278,
		["290"] = 278,
		["291"] = 285,
		["292"] = 286,
		["293"] = 287,
		["294"] = 287,
		["295"] = 287,
		["296"] = 287,
		["297"] = 287,
		["298"] = 287,
		["299"] = 288,
		["300"] = 288,
		["301"] = 288,
		["302"] = 288,
		["303"] = 288,
		["304"] = 288,
		["305"] = 288,
		["306"] = 289,
		["309"] = 290,
		["310"] = 292,
		["311"] = 293,
		["313"] = 295,
		["315"] = 278,
		["316"] = 278,
		["318"] = 267,
		["319"] = 266,
		["320"] = 265,
		["321"] = 266,
		["323"] = 266,
		["325"] = 308,
		["326"] = 317,
		["327"] = 308,
		["328"] = 317,
		["329"] = 324,
		["330"] = 325,
		["331"] = 326,
		["332"] = 327,
		["333"] = 328,
		["334"] = 324,
		["335"] = 331,
		["336"] = 332,
		["337"] = 336,
		["338"] = 341,
		["340"] = 344,
		["341"] = 345,
		["342"] = 347,
		["343"] = 347,
		["344"] = 347,
		["345"] = 347,
		["346"] = 347,
		["347"] = 347,
		["348"] = 347,
		["349"] = 347,
		["351"] = 331,
		["352"] = 350,
		["353"] = 351,
		["354"] = 350,
		["355"] = 353,
		["356"] = 354,
		["357"] = 355,
		["358"] = 356,
		["359"] = 357,
		["360"] = 358,
		["361"] = 358,
		["362"] = 358,
		["363"] = 358,
		["364"] = 358,
		["365"] = 358,
		["366"] = 359,
		["367"] = 359,
		["368"] = 359,
		["369"] = 359,
		["370"] = 359,
		["371"] = 359,
		["372"] = 359,
		["373"] = 361,
		["374"] = 362,
		["375"] = 363,
		["377"] = 365,
		["378"] = 366,
		["379"] = 367,
		["381"] = 353,
		["382"] = 370,
		["383"] = 371,
		["384"] = 373,
		["385"] = 375,
		["387"] = 370,
		["388"] = 317,
		["389"] = 308,
		["390"] = 308,
		["391"] = 308,
		["392"] = 308,
		["393"] = 308,
		["394"] = 308,
		["395"] = 308,
		["396"] = 308,
		["397"] = 308,
		["398"] = 317,
		["400"] = 317,
		["402"] = 391,
		["403"] = 392,
		["404"] = 391,
		["405"] = 392,
		["406"] = 393,
		["407"] = 394,
		["408"] = 393,
		["409"] = 392,
		["410"] = 391,
		["411"] = 392,
		["413"] = 392,
		["414"] = 397,
		["415"] = 405,
		["416"] = 397,
		["417"] = 405,
		["418"] = 407,
		["419"] = 408,
		["420"] = 407,
		["421"] = 410,
		["422"] = 412,
		["423"] = 413,
		["424"] = 414,
		["425"] = 415,
		["426"] = 420,
		["428"] = 410,
		["429"] = 423,
		["430"] = 424,
		["431"] = 423,
		["432"] = 428,
		["433"] = 429,
		["434"] = 430,
		["436"] = 428,
		["437"] = 405,
		["438"] = 397,
		["439"] = 397,
		["440"] = 397,
		["441"] = 397,
		["442"] = 397,
		["443"] = 397,
		["444"] = 397,
		["445"] = 397,
		["446"] = 405,
		["448"] = 405,
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
g.lich_talent = c()
local q = g.lich_talent
q.name = "lich_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_lich_talent"
end
q = e({ j(nil) }, q)
g.lich_talent = q
g.modifier_lich_talent = c()
local r = g.modifier_lich_talent
r.name = "modifier_lich_talent"
d(r, l)
function r.prototype.OnCreated(self, s)
	if not IsServer() then
		local t = self:GetParent()
		local u = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lich/lich_frost_armor.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			t
		)
		ParticleManager:SetParticleControlEnt(u, 2, t, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0, 0, 0), true)
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function r.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
	self.tick = self:GetAbilitySpecialValueFor("tick")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.ice = self:GetAbilitySpecialValueFor("ice")
	self.ice_record = 0
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.ice_count = self:GetAbilitySpecialValueFor("ice_count")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.bonus_ice = self:GetAbilityTalentValue("lich_talent_1", "bonus_ice")
	self.bonus_ice_factor = self:GetAbilityTalentValue("lich_talent_3", "bonus_ice_factor")
	self.mana_chance = self:GetAbilityTalentValue("lich_talent_4", "mana_chance")
	self.mana_restore = self:GetAbilityTalentValue("lich_talent_4", "mana_restore")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnIceGained(self, s)
	if not self:GetParent():PassivesDisabled() then
		self.ice_record = self.ice_record + s.iStackCount
		while self.ice > 0 and self.ice_record >= self.ice do
			self.ice_record = self.ice_record - self.ice
			self:Shield()
		end
	end
end
function r.prototype.Shield(self)
	self:GetParent()
		:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_lich_talent_buff", { duration = self.duration })
end
function r.prototype.OnBattleStart(self, s)
	self:Shield()
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
g.modifier_lich_talent = r
g.modifier_lich_talent_buff = c()
local v = g.modifier_lich_talent_buff
v.name = "modifier_lich_talent_buff"
d(v, l)
function v.prototype.GetTexture(self)
	return "lich_frost_shield"
end
function v.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
	self.reduce_damage = self:GetAbilitySpecialValueFor("reduce_damage")
	self.tick = self:GetAbilitySpecialValueFor("tick") - self:GetAbilityTalentValue("lich_talent_5", "tick_reduce")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.bonus_ice = self:GetAbilityTalentValue("lich_talent_1", "bonus_ice")
	self.bonus_ice_factor = self:GetAbilityTalentValue("lich_talent_3", "bonus_ice_factor")
	self.mana_chance = self:GetAbilityTalentValue("lich_talent_4", "mana_chance")
	self.mana_restore = self:GetAbilityTalentValue("lich_talent_4", "mana_restore")
end
function v.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(self.tick)
	end
end
function v.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetDuration(s.duration, true)
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_lich_frost_resonance", {})
	end
end
function v.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveModifierByName("modifier_lich_frost_resonance")
	end
end
function v.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function v.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	local w = t:GetEnemy()
	if not IsInjurable(w) then
		return
	end
	if self.bonus_ice > 0 then
		AddIce(t, w, self.bonus_ice, "lich_talent", "Ability")
	end
	local x = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilitySpecialValueFor("damage_add") * self:GetResonanceStackCount()
	if self.bonus_ice_factor > 0 then
		x = x + GetIce(w) * self.bonus_ice_factor * 0.01 * (1 + GetUltiPower(t) * 0.01)
	end
	if self.mana_chance > 0 and self.mana_restore > 0 then
		if self:PRD(self.mana_chance) then
			Restore(t, self.mana_restore, true)
		end
	end
	t:DealDamage(w, self:GetAbility(), x, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	local u =
		ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_ice_age_dmg.vpcf", PATTACH_ABSORIGIN, t)
	ParticleManager:SetParticleControl(u, 1, t:GetAbsOrigin())
	ParticleManager:SetParticleControl(u, 2, Vector(500, 500, 500))
	ParticleManager:ReleaseParticleIndex(u)
	u = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_lich/lich_ice_age_debuff.vpcf",
		PATTACH_ABSORIGIN,
		w
	)
	ParticleManager:ReleaseParticleIndex(u)
end
function v.prototype.GetResonanceStackCount(self)
	local t = self:GetParent()
	return t:GetModifierStackCount("modifier_lich_frost_resonance", t)
end
function v.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function v.prototype.EOM_GetModifierIncomingDamagePercentage(self)
	return -(self.damage_reduce + self.reduce_damage * self:GetResonanceStackCount())
end
function v.prototype.OnBattleEnd(self, s)
	self:Destroy()
end
v = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	v
)
g.modifier_lich_talent_buff = v
g.modifier_lich_frost_resonance = c()
local y = g.modifier_lich_frost_resonance
y.name = "modifier_lich_frost_resonance"
d(y, l)
function y.prototype.GetAbilitySpecialValue(self)
	self.limit_stack = self:GetAbilitySpecialValueFor("limit_stack")
end
function y.prototype.GetTexture(self)
	return "lich_frost_shield"
end
function y.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(1)
	end
end
function y.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetStackCount(math.min(self:GetStackCount() + 1, self.limit_stack))
	end
end
function y.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function y.prototype.OnBattleEnd(self, s)
	self:Destroy()
end
y = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	y
)
g.modifier_lich_frost_resonance = y
g.lich_ult = c()
local z = g.lich_ult
z.name = "lich_ult"
d(z, o)
function z.prototype.OnSpellStart(self)
	local A = self:GetCaster()
	local w = A:GetEnemy()
	local B = self:GetSpecialValueFor("base_damage")
	local C = self:GetSpecialValueFor("ice")
	local D = self:GetTalentValue("lich_talent_2", "ice_factor")
	local E = self:GetTalentValue("lich_talent_6", "per_ice")
	A:StartGesture(ACT_DOTA_CAST_ABILITY_6)
	if IsInjurable(w) then
		A:EmitSound("Hero_Lich.ChainFrost")
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf",
			hCaster = A,
			vSpawnOrigin = A:GetAttachmentPosition("attach_attack1"),
			hTarget = w,
			iMoveSpeed = 850,
			OnProjectileHit = function(F, G, H)
				if IsInjurable(w) then
					A:DealDamage(F, self, B + D * GetIce(F) * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
					AddIce(A, F, C, "lich_ult", "Ability")
					if E <= 0 then
						return
					end
					local I = math.floor(GetIce(w) / E)
					if I > 0 then
						w:AddNewModifier(A, self, "modifier_lich_ult_buff", { count = I })
					end
					A:EmitSound("Hero_Lich.ChainFrostImpact.Creep")
				end
			end,
		})
	end
end
z = e({ p(nil) }, z)
g.lich_ult = z
g.modifier_lich_ult_buff = c()
local J = g.modifier_lich_ult_buff
J.name = "modifier_lich_ult_buff"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.ice_factor = self:GetAbilityTalentValue("lich_talent_2", "bonus_ice_factor")
	self.per_ice = self:GetAbilityTalentValue("lich_talent_6", "per_ice")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.ice = self:GetAbilitySpecialValueFor("ice")
end
function J.prototype.OnCreated(self, s)
	if IsServer() then
		self.count = s.count
		self:StartIntervalThink(0.5)
	else
		local t = self:GetParent()
		local u = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lich/lich_chain_frost_frostbound.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			t
		)
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function J.prototype.OnIntervalThink(self)
	self:Burst()
end
function J.prototype.Burst(self)
	local A = self:GetCaster()
	local w = self:GetParent()
	local K = self:GetAbility()
	if IsInjurable(A) and IsInjurable(w) then
		A:DealDamage(w, K, self.base_damage + self.ice_factor * GetIce(w) * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		AddIce(A, w, self.ice, "lich_ult", "Ability")
		local u = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lich/lich_frost_nova.vpcf",
			PATTACH_ABSORIGIN,
			w
		)
		ParticleManager:ReleaseParticleIndex(u)
		w:EmitSound("Ability.FrostNova")
	end
	self.count = self.count - 1
	if self.count <= 0 then
		self:Destroy()
	end
end
function J.prototype.OnDestroy(self)
	if IsServer() then
		local t = self:GetParent()
		t:StopSound("Hero_Lich.SinisterGaze.Cast")
	end
end
J = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	J
)
g.modifier_lich_ult_buff = J
g.lich_shard = c()
local L = g.lich_shard
L.name = "lich_shard"
d(L, i)
function L.prototype.GetIntrinsicModifierName(self)
	return "modifier_lich_shard"
end
L = e({ j(nil) }, L)
g.lich_shard = L
g.modifier_lich_shard = c()
local M = g.modifier_lich_shard
M.name = "modifier_lich_shard"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function M.prototype.OnCreated(self, s)
	local N = self.parent:GetPlayerOwnerID()
	if not PlayerData:loadData(N, "lich_shard") then
		PlayerData:getHero(N):learnAbility("98", true)
		Notification:combatToPlayer(
			N,
			{
				message = "notify_artifact_ability_" .. "r",
				string_itemname_artifact = "DOTA_Tooltip_ability_lich_shard",
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. "98",
			}
		)
		PlayerData:saveData(N, "lich_shard", 1)
	end
end
function M.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROC_DAMAGE_BONUS }
end
function M.prototype.EOM_GetModifierProcDamageBonus(self, s)
	if s.ability_upgrade == "98" then
		return self.damage
	end
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
g.modifier_lich_shard = M
return g