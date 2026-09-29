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
		["203"] = 212,
		["204"] = 212,
		["205"] = 211,
		["206"] = 214,
		["207"] = 215,
		["208"] = 214,
		["209"] = 217,
		["210"] = 218,
		["211"] = 217,
		["212"] = 220,
		["213"] = 222,
		["214"] = 220,
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
		["227"] = 227,
		["228"] = 234,
		["229"] = 227,
		["230"] = 234,
		["231"] = 236,
		["232"] = 237,
		["233"] = 236,
		["234"] = 239,
		["235"] = 240,
		["236"] = 239,
		["237"] = 242,
		["238"] = 243,
		["239"] = 244,
		["241"] = 242,
		["242"] = 247,
		["243"] = 248,
		["244"] = 249,
		["245"] = 249,
		["246"] = 249,
		["247"] = 249,
		["249"] = 247,
		["250"] = 252,
		["251"] = 253,
		["252"] = 254,
		["253"] = 254,
		["254"] = 253,
		["255"] = 252,
		["256"] = 257,
		["257"] = 258,
		["258"] = 257,
		["259"] = 234,
		["260"] = 227,
		["261"] = 227,
		["262"] = 227,
		["263"] = 227,
		["264"] = 227,
		["265"] = 227,
		["266"] = 227,
		["267"] = 234,
		["269"] = 234,
		["271"] = 263,
		["272"] = 264,
		["273"] = 263,
		["274"] = 264,
		["275"] = 265,
		["276"] = 266,
		["277"] = 267,
		["278"] = 269,
		["279"] = 270,
		["280"] = 271,
		["281"] = 272,
		["282"] = 273,
		["283"] = 274,
		["284"] = 275,
		["285"] = 276,
		["286"] = 276,
		["287"] = 276,
		["288"] = 276,
		["289"] = 276,
		["290"] = 276,
		["291"] = 283,
		["292"] = 284,
		["293"] = 285,
		["294"] = 285,
		["295"] = 285,
		["296"] = 285,
		["297"] = 285,
		["298"] = 285,
		["299"] = 286,
		["300"] = 286,
		["301"] = 286,
		["302"] = 286,
		["303"] = 286,
		["304"] = 286,
		["305"] = 286,
		["306"] = 287,
		["309"] = 288,
		["310"] = 290,
		["311"] = 291,
		["313"] = 293,
		["315"] = 276,
		["316"] = 276,
		["318"] = 265,
		["319"] = 264,
		["320"] = 263,
		["321"] = 264,
		["323"] = 264,
		["325"] = 306,
		["326"] = 315,
		["327"] = 306,
		["328"] = 315,
		["329"] = 322,
		["330"] = 323,
		["331"] = 324,
		["332"] = 325,
		["333"] = 326,
		["334"] = 322,
		["335"] = 329,
		["336"] = 330,
		["337"] = 334,
		["338"] = 339,
		["340"] = 342,
		["341"] = 343,
		["342"] = 345,
		["343"] = 345,
		["344"] = 345,
		["345"] = 345,
		["346"] = 345,
		["347"] = 345,
		["348"] = 345,
		["349"] = 345,
		["351"] = 329,
		["352"] = 348,
		["353"] = 349,
		["354"] = 348,
		["355"] = 351,
		["356"] = 352,
		["357"] = 353,
		["358"] = 354,
		["359"] = 355,
		["360"] = 356,
		["361"] = 356,
		["362"] = 356,
		["363"] = 356,
		["364"] = 356,
		["365"] = 356,
		["366"] = 357,
		["367"] = 357,
		["368"] = 357,
		["369"] = 357,
		["370"] = 357,
		["371"] = 357,
		["372"] = 357,
		["373"] = 359,
		["374"] = 360,
		["375"] = 361,
		["377"] = 363,
		["378"] = 364,
		["379"] = 365,
		["381"] = 351,
		["382"] = 368,
		["383"] = 369,
		["384"] = 371,
		["385"] = 373,
		["387"] = 368,
		["388"] = 315,
		["389"] = 306,
		["390"] = 306,
		["391"] = 306,
		["392"] = 306,
		["393"] = 306,
		["394"] = 306,
		["395"] = 306,
		["396"] = 306,
		["397"] = 306,
		["398"] = 315,
		["400"] = 315,
		["402"] = 389,
		["403"] = 390,
		["404"] = 389,
		["405"] = 390,
		["406"] = 391,
		["407"] = 392,
		["408"] = 391,
		["409"] = 390,
		["410"] = 389,
		["411"] = 390,
		["413"] = 390,
		["414"] = 395,
		["415"] = 403,
		["416"] = 395,
		["417"] = 403,
		["418"] = 405,
		["419"] = 406,
		["420"] = 405,
		["421"] = 408,
		["422"] = 410,
		["423"] = 411,
		["424"] = 412,
		["425"] = 413,
		["426"] = 418,
		["428"] = 408,
		["429"] = 421,
		["430"] = 422,
		["431"] = 421,
		["432"] = 426,
		["433"] = 427,
		["434"] = 428,
		["436"] = 426,
		["437"] = 403,
		["438"] = 395,
		["439"] = 395,
		["440"] = 395,
		["441"] = 395,
		["442"] = 395,
		["443"] = 395,
		["444"] = 395,
		["445"] = 395,
		["446"] = 403,
		["448"] = 403,
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
	local y = self:GetParent():FindModifierByName("modifier_lich_frost_resonance")
	return y and y:GetStackCount() or 0
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
local z = g.modifier_lich_frost_resonance
z.name = "modifier_lich_frost_resonance"
d(z, l)
function z.prototype.GetAbilitySpecialValue(self)
	self.limit_stack = self:GetAbilitySpecialValueFor("limit_stack")
end
function z.prototype.GetTexture(self)
	return "lich_frost_shield"
end
function z.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(1)
	end
end
function z.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetStackCount(math.min(self:GetStackCount() + 1, self.limit_stack))
	end
end
function z.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function z.prototype.OnBattleEnd(self, s)
	self:Destroy()
end
z = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	z
)
g.modifier_lich_frost_resonance = z
g.lich_ult = c()
local A = g.lich_ult
A.name = "lich_ult"
d(A, o)
function A.prototype.OnSpellStart(self)
	local B = self:GetCaster()
	local w = B:GetEnemy()
	local C = self:GetSpecialValueFor("base_damage")
	local D = self:GetSpecialValueFor("ice")
	local E = self:GetTalentValue("lich_talent_2", "ice_factor")
	local F = self:GetTalentValue("lich_talent_6", "per_ice")
	B:StartGesture(ACT_DOTA_CAST_ABILITY_6)
	if IsInjurable(w) then
		B:EmitSound("Hero_Lich.ChainFrost")
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf",
			hCaster = B,
			vSpawnOrigin = B:GetAttachmentPosition("attach_attack1"),
			hTarget = w,
			iMoveSpeed = 850,
			OnProjectileHit = function(G, H, I)
				if IsInjurable(w) then
					B:DealDamage(G, self, C + E * GetIce(G) * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
					AddIce(B, G, D, "lich_ult", "Ability")
					if F <= 0 then
						return
					end
					local J = math.floor(GetIce(w) / F)
					if J > 0 then
						w:AddNewModifier(B, self, "modifier_lich_ult_buff", { count = J })
					end
					B:EmitSound("Hero_Lich.ChainFrostImpact.Creep")
				end
			end,
		})
	end
end
A = e({ p(nil) }, A)
g.lich_ult = A
g.modifier_lich_ult_buff = c()
local K = g.modifier_lich_ult_buff
K.name = "modifier_lich_ult_buff"
d(K, l)
function K.prototype.GetAbilitySpecialValue(self)
	self.ice_factor = self:GetAbilityTalentValue("lich_talent_2", "bonus_ice_factor")
	self.per_ice = self:GetAbilityTalentValue("lich_talent_6", "per_ice")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.ice = self:GetAbilitySpecialValueFor("ice")
end
function K.prototype.OnCreated(self, s)
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
function K.prototype.OnIntervalThink(self)
	self:Burst()
end
function K.prototype.Burst(self)
	local B = self:GetCaster()
	local w = self:GetParent()
	local L = self:GetAbility()
	if IsInjurable(B) and IsInjurable(w) then
		B:DealDamage(w, L, self.base_damage + self.ice_factor * GetIce(w) * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		AddIce(B, w, self.ice, "lich_ult", "Ability")
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
function K.prototype.OnDestroy(self)
	if IsServer() then
		local t = self:GetParent()
		t:StopSound("Hero_Lich.SinisterGaze.Cast")
	end
end
K = e(
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
	K
)
g.modifier_lich_ult_buff = K
g.lich_shard = c()
local M = g.lich_shard
M.name = "lich_shard"
d(M, i)
function M.prototype.GetIntrinsicModifierName(self)
	return "modifier_lich_shard"
end
M = e({ j(nil) }, M)
g.lich_shard = M
g.modifier_lich_shard = c()
local N = g.modifier_lich_shard
N.name = "modifier_lich_shard"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function N.prototype.OnCreated(self, s)
	local O = self.parent:GetPlayerOwnerID()
	if not PlayerData:loadData(O, "lich_shard") then
		PlayerData:getHero(O):learnAbility("98", true)
		Notification:combatToPlayer(
			O,
			{
				message = "notify_artifact_ability_" .. "r",
				string_itemname_artifact = "DOTA_Tooltip_ability_lich_shard",
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. "98",
			}
		)
		PlayerData:saveData(O, "lich_shard", 1)
	end
end
function N.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROC_DAMAGE_BONUS }
end
function N.prototype.EOM_GetModifierProcDamageBonus(self, s)
	if s.ability_upgrade == "98" then
		return self.damage
	end
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
			}
		),
	},
	N
)
g.modifier_lich_shard = N
return g