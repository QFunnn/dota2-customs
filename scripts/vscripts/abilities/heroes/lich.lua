--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
		["113"] = 135,
		["114"] = 125,
		["115"] = 135,
		["116"] = 144,
		["117"] = 145,
		["118"] = 146,
		["119"] = 147,
		["120"] = 148,
		["121"] = 149,
		["122"] = 150,
		["123"] = 151,
		["124"] = 152,
		["125"] = 144,
		["126"] = 154,
		["127"] = 155,
		["128"] = 156,
		["129"] = 157,
		["131"] = 154,
		["132"] = 160,
		["133"] = 161,
		["134"] = 162,
		["135"] = 162,
		["136"] = 162,
		["137"] = 162,
		["138"] = 163,
		["140"] = 160,
		["141"] = 166,
		["142"] = 167,
		["143"] = 168,
		["144"] = 168,
		["145"] = 167,
		["146"] = 166,
		["147"] = 171,
		["148"] = 172,
		["149"] = 173,
		["150"] = 174,
		["153"] = 176,
		["154"] = 177,
		["155"] = 177,
		["156"] = 177,
		["157"] = 177,
		["158"] = 177,
		["159"] = 177,
		["160"] = 177,
		["162"] = 179,
		["163"] = 181,
		["164"] = 182,
		["166"] = 185,
		["167"] = 186,
		["168"] = 187,
		["171"] = 191,
		["172"] = 191,
		["173"] = 191,
		["174"] = 191,
		["175"] = 191,
		["176"] = 191,
		["177"] = 193,
		["178"] = 194,
		["179"] = 194,
		["180"] = 194,
		["181"] = 194,
		["182"] = 194,
		["183"] = 195,
		["184"] = 195,
		["185"] = 195,
		["186"] = 195,
		["187"] = 195,
		["188"] = 196,
		["189"] = 198,
		["190"] = 199,
		["191"] = 171,
		["192"] = 201,
		["193"] = 202,
		["194"] = 201,
		["195"] = 206,
		["196"] = 208,
		["197"] = 206,
		["198"] = 135,
		["199"] = 125,
		["200"] = 125,
		["201"] = 125,
		["202"] = 125,
		["203"] = 125,
		["204"] = 125,
		["205"] = 125,
		["206"] = 125,
		["207"] = 135,
		["209"] = 135,
		["211"] = 213,
		["212"] = 214,
		["213"] = 213,
		["214"] = 214,
		["215"] = 215,
		["216"] = 216,
		["217"] = 217,
		["218"] = 219,
		["219"] = 220,
		["220"] = 221,
		["221"] = 222,
		["222"] = 223,
		["223"] = 224,
		["224"] = 225,
		["225"] = 226,
		["226"] = 226,
		["227"] = 226,
		["228"] = 226,
		["229"] = 226,
		["230"] = 226,
		["231"] = 233,
		["232"] = 234,
		["233"] = 235,
		["234"] = 235,
		["235"] = 235,
		["236"] = 235,
		["237"] = 235,
		["238"] = 235,
		["239"] = 236,
		["240"] = 236,
		["241"] = 236,
		["242"] = 236,
		["243"] = 236,
		["244"] = 236,
		["245"] = 236,
		["246"] = 237,
		["249"] = 238,
		["250"] = 240,
		["251"] = 241,
		["253"] = 243,
		["255"] = 226,
		["256"] = 226,
		["258"] = 215,
		["259"] = 214,
		["260"] = 213,
		["261"] = 214,
		["263"] = 214,
		["265"] = 256,
		["266"] = 265,
		["267"] = 256,
		["268"] = 265,
		["269"] = 272,
		["270"] = 273,
		["271"] = 274,
		["272"] = 275,
		["273"] = 276,
		["274"] = 272,
		["275"] = 279,
		["276"] = 280,
		["277"] = 284,
		["278"] = 289,
		["280"] = 292,
		["281"] = 293,
		["282"] = 295,
		["283"] = 295,
		["284"] = 295,
		["285"] = 295,
		["286"] = 295,
		["287"] = 295,
		["288"] = 295,
		["289"] = 295,
		["291"] = 279,
		["292"] = 298,
		["293"] = 299,
		["294"] = 298,
		["295"] = 301,
		["296"] = 302,
		["297"] = 303,
		["298"] = 304,
		["299"] = 305,
		["300"] = 306,
		["301"] = 306,
		["302"] = 306,
		["303"] = 306,
		["304"] = 306,
		["305"] = 306,
		["306"] = 307,
		["307"] = 307,
		["308"] = 307,
		["309"] = 307,
		["310"] = 307,
		["311"] = 307,
		["312"] = 307,
		["313"] = 309,
		["314"] = 310,
		["315"] = 311,
		["317"] = 313,
		["318"] = 314,
		["319"] = 315,
		["321"] = 301,
		["322"] = 318,
		["323"] = 319,
		["324"] = 321,
		["325"] = 323,
		["327"] = 318,
		["328"] = 265,
		["329"] = 256,
		["330"] = 256,
		["331"] = 256,
		["332"] = 256,
		["333"] = 256,
		["334"] = 256,
		["335"] = 256,
		["336"] = 256,
		["337"] = 256,
		["338"] = 265,
		["340"] = 265,
		["342"] = 339,
		["343"] = 340,
		["344"] = 339,
		["345"] = 340,
		["346"] = 341,
		["347"] = 342,
		["348"] = 341,
		["349"] = 340,
		["350"] = 339,
		["351"] = 340,
		["353"] = 340,
		["354"] = 345,
		["355"] = 353,
		["356"] = 345,
		["357"] = 353,
		["358"] = 355,
		["359"] = 356,
		["360"] = 355,
		["361"] = 358,
		["362"] = 360,
		["363"] = 361,
		["364"] = 362,
		["365"] = 363,
		["366"] = 368,
		["368"] = 358,
		["369"] = 371,
		["370"] = 372,
		["371"] = 371,
		["372"] = 376,
		["373"] = 377,
		["374"] = 378,
		["376"] = 376,
		["377"] = 353,
		["378"] = 345,
		["379"] = 345,
		["380"] = 345,
		["381"] = 345,
		["382"] = 345,
		["383"] = 345,
		["384"] = 345,
		["385"] = 345,
		["386"] = 353,
		["388"] = 353,
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
		if self.ice_record >= self.ice then
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
function v.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
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
		self:IncrementStackCount()
	end
end
function v.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetDuration(self:GetRemainingTime() + s.duration, true)
		self:IncrementStackCount()
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
	local x = self.damage * self:GetStackCount()
	if self.bonus_ice_factor > 0 then
		x = x + GetIce(w) * self.bonus_ice_factor * 0.01
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
function v.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = -self.damage_reduce }
end
function v.prototype.OnBattleEnd(self, s)
	self:Destroy()
end
v = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
			}
		),
	},
	v
)
g.modifier_lich_talent_buff = v
g.lich_ult = c()
local y = g.lich_ult
y.name = "lich_ult"
d(y, o)
function y.prototype.OnSpellStart(self)
	local z = self:GetCaster()
	local w = z:GetEnemy()
	local A = self:GetSpecialValueFor("base_damage")
	local B = self:GetSpecialValueFor("ice")
	local C = self:GetTalentValue("lich_talent_2", "ice_factor")
	local D = self:GetTalentValue("lich_talent_6", "per_ice")
	z:StartGesture(ACT_DOTA_CAST_ABILITY_6)
	if IsInjurable(w) then
		z:EmitSound("Hero_Lich.ChainFrost")
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf",
			hCaster = z,
			vSpawnOrigin = z:GetAttachmentPosition("attach_attack1"),
			hTarget = w,
			iMoveSpeed = 850,
			OnProjectileHit = function(E, F, G)
				if IsInjurable(w) then
					z:DealDamage(E, self, A + C * GetIce(E) * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
					AddIce(z, E, B, "lich_ult", "Ability")
					if D <= 0 then
						return
					end
					local H = math.floor(GetIce(w) / D)
					if H > 0 then
						w:AddNewModifier(z, self, "modifier_lich_ult_buff", { count = H })
					end
					z:EmitSound("Hero_Lich.ChainFrostImpact.Creep")
				end
			end,
		})
	end
end
y = e({ p(nil) }, y)
g.lich_ult = y
g.modifier_lich_ult_buff = c()
local I = g.modifier_lich_ult_buff
I.name = "modifier_lich_ult_buff"
d(I, l)
function I.prototype.GetAbilitySpecialValue(self)
	self.ice_factor = self:GetAbilityTalentValue("lich_talent_2", "bonus_ice_factor")
	self.per_ice = self:GetAbilityTalentValue("lich_talent_6", "per_ice")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.ice = self:GetAbilitySpecialValueFor("ice")
end
function I.prototype.OnCreated(self, s)
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
function I.prototype.OnIntervalThink(self)
	self:Burst()
end
function I.prototype.Burst(self)
	local z = self:GetCaster()
	local w = self:GetParent()
	local J = self:GetAbility()
	if IsInjurable(z) and IsInjurable(w) then
		z:DealDamage(w, J, self.base_damage + self.ice_factor * GetIce(w) * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		AddIce(z, w, self.ice, "lich_ult", "Ability")
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
function I.prototype.OnDestroy(self)
	if IsServer() then
		local t = self:GetParent()
		t:StopSound("Hero_Lich.SinisterGaze.Cast")
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
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	I
)
g.modifier_lich_ult_buff = I
g.lich_shard = c()
local K = g.lich_shard
K.name = "lich_shard"
d(K, i)
function K.prototype.GetIntrinsicModifierName(self)
	return "modifier_lich_shard"
end
K = e({ j(nil) }, K)
g.lich_shard = K
g.modifier_lich_shard = c()
local L = g.modifier_lich_shard
L.name = "modifier_lich_shard"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function L.prototype.OnCreated(self, s)
	local M = self.parent:GetPlayerOwnerID()
	if not PlayerData:loadData(M, "lich_shard") then
		PlayerData:getHero(M):learnAbility("98", true)
		Notification:combatToPlayer(
			M,
			{
				message = "notify_artifact_ability_" .. "r",
				string_itemname_artifact = "DOTA_Tooltip_ability_lich_shard",
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. "98",
			}
		)
		PlayerData:saveData(M, "lich_shard", 1)
	end
end
function L.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROC_DAMAGE_BONUS }
end
function L.prototype.EOM_GetModifierProcDamageBonus(self, s)
	if s.ability_upgrade == "98" then
		return self.damage
	end
end
L = e(
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
	L
)
g.modifier_lich_shard = L
return g