--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/pugna"
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
		["35"] = 24,
		["36"] = 28,
		["37"] = 30,
		["38"] = 41,
		["39"] = 42,
		["40"] = 12,
		["41"] = 43,
		["42"] = 44,
		["43"] = 45,
		["44"] = 46,
		["45"] = 47,
		["46"] = 48,
		["47"] = 49,
		["48"] = 50,
		["49"] = 51,
		["50"] = 52,
		["51"] = 53,
		["52"] = 54,
		["53"] = 43,
		["54"] = 57,
		["55"] = 58,
		["56"] = 59,
		["57"] = 60,
		["58"] = 61,
		["59"] = 62,
		["60"] = 63,
		["61"] = 64,
		["62"] = 65,
		["63"] = 66,
		["64"] = 67,
		["65"] = 67,
		["66"] = 67,
		["67"] = 67,
		["68"] = 67,
		["69"] = 67,
		["70"] = 68,
		["71"] = 68,
		["72"] = 68,
		["73"] = 68,
		["74"] = 68,
		["75"] = 69,
		["76"] = 69,
		["77"] = 69,
		["78"] = 69,
		["79"] = 69,
		["80"] = 70,
		["81"] = 70,
		["82"] = 70,
		["83"] = 70,
		["84"] = 70,
		["85"] = 71,
		["86"] = 71,
		["87"] = 71,
		["88"] = 71,
		["89"] = 71,
		["90"] = 72,
		["91"] = 73,
		["92"] = 73,
		["93"] = 73,
		["94"] = 73,
		["95"] = 73,
		["96"] = 73,
		["99"] = 77,
		["100"] = 78,
		["101"] = 79,
		["102"] = 80,
		["103"] = 81,
		["105"] = 83,
		["106"] = 83,
		["107"] = 83,
		["108"] = 83,
		["109"] = 83,
		["110"] = 83,
		["111"] = 83,
		["114"] = 57,
		["115"] = 87,
		["116"] = 88,
		["117"] = 88,
		["118"] = 88,
		["119"] = 91,
		["120"] = 91,
		["121"] = 91,
		["122"] = 88,
		["123"] = 92,
		["124"] = 92,
		["125"] = 92,
		["126"] = 88,
		["127"] = 88,
		["128"] = 88,
		["129"] = 87,
		["130"] = 96,
		["131"] = 97,
		["132"] = 98,
		["133"] = 99,
		["134"] = 100,
		["137"] = 96,
		["138"] = 104,
		["139"] = 105,
		["140"] = 106,
		["141"] = 107,
		["142"] = 108,
		["143"] = 109,
		["144"] = 109,
		["145"] = 109,
		["146"] = 109,
		["147"] = 109,
		["148"] = 109,
		["151"] = 104,
		["152"] = 114,
		["153"] = 115,
		["154"] = 116,
		["155"] = 117,
		["156"] = 118,
		["157"] = 119,
		["158"] = 120,
		["159"] = 121,
		["163"] = 114,
		["164"] = 127,
		["165"] = 128,
		["166"] = 129,
		["167"] = 129,
		["168"] = 129,
		["169"] = 129,
		["170"] = 129,
		["172"] = 127,
		["173"] = 133,
		["174"] = 134,
		["175"] = 135,
		["176"] = 135,
		["177"] = 135,
		["178"] = 136,
		["179"] = 135,
		["180"] = 135,
		["181"] = 138,
		["182"] = 139,
		["183"] = 140,
		["184"] = 141,
		["185"] = 141,
		["186"] = 141,
		["187"] = 141,
		["188"] = 141,
		["189"] = 141,
		["192"] = 133,
		["193"] = 20,
		["194"] = 12,
		["195"] = 12,
		["196"] = 12,
		["197"] = 12,
		["198"] = 12,
		["199"] = 12,
		["200"] = 12,
		["201"] = 12,
		["202"] = 20,
		["204"] = 20,
		["205"] = 147,
		["206"] = 155,
		["207"] = 147,
		["208"] = 155,
		["209"] = 156,
		["210"] = 157,
		["211"] = 157,
		["212"] = 157,
		["213"] = 157,
		["214"] = 157,
		["215"] = 156,
		["216"] = 155,
		["217"] = 147,
		["218"] = 147,
		["219"] = 147,
		["220"] = 147,
		["221"] = 147,
		["222"] = 147,
		["223"] = 147,
		["224"] = 147,
		["225"] = 155,
		["227"] = 155,
		["228"] = 166,
		["229"] = 174,
		["230"] = 166,
		["231"] = 174,
		["232"] = 177,
		["233"] = 178,
		["234"] = 177,
		["235"] = 181,
		["236"] = 182,
		["237"] = 181,
		["238"] = 186,
		["239"] = 187,
		["240"] = 186,
		["241"] = 174,
		["242"] = 166,
		["243"] = 166,
		["244"] = 166,
		["245"] = 166,
		["246"] = 166,
		["247"] = 166,
		["248"] = 166,
		["249"] = 166,
		["250"] = 174,
		["252"] = 174,
		["253"] = 192,
		["254"] = 200,
		["255"] = 192,
		["256"] = 200,
		["257"] = 202,
		["258"] = 203,
		["259"] = 202,
		["260"] = 206,
		["261"] = 207,
		["262"] = 206,
		["263"] = 211,
		["264"] = 212,
		["265"] = 211,
		["266"] = 216,
		["267"] = 217,
		["268"] = 216,
		["269"] = 200,
		["270"] = 192,
		["271"] = 192,
		["272"] = 192,
		["273"] = 192,
		["274"] = 192,
		["275"] = 192,
		["276"] = 192,
		["277"] = 192,
		["278"] = 200,
		["280"] = 200,
		["281"] = 223,
		["282"] = 224,
		["283"] = 223,
		["284"] = 224,
		["285"] = 225,
		["286"] = 226,
		["287"] = 227,
		["288"] = 228,
		["289"] = 229,
		["290"] = 230,
		["291"] = 231,
		["292"] = 233,
		["293"] = 233,
		["294"] = 233,
		["295"] = 233,
		["296"] = 233,
		["297"] = 233,
		["298"] = 233,
		["299"] = 233,
		["300"] = 233,
		["301"] = 234,
		["302"] = 234,
		["303"] = 234,
		["304"] = 234,
		["305"] = 234,
		["306"] = 234,
		["307"] = 234,
		["308"] = 234,
		["309"] = 234,
		["310"] = 235,
		["311"] = 235,
		["312"] = 235,
		["313"] = 235,
		["314"] = 235,
		["315"] = 236,
		["316"] = 236,
		["317"] = 236,
		["318"] = 237,
		["319"] = 238,
		["320"] = 239,
		["322"] = 236,
		["323"] = 236,
		["324"] = 242,
		["325"] = 225,
		["326"] = 224,
		["327"] = 223,
		["328"] = 224,
		["330"] = 224,
		["331"] = 246,
		["332"] = 256,
		["333"] = 246,
		["334"] = 256,
		["335"] = 263,
		["336"] = 264,
		["337"] = 265,
		["338"] = 266,
		["339"] = 263,
		["340"] = 269,
		["341"] = 270,
		["342"] = 271,
		["344"] = 269,
		["345"] = 274,
		["346"] = 275,
		["347"] = 276,
		["349"] = 274,
		["350"] = 279,
		["351"] = 280,
		["352"] = 279,
		["353"] = 256,
		["354"] = 246,
		["355"] = 246,
		["356"] = 246,
		["357"] = 246,
		["358"] = 246,
		["359"] = 246,
		["360"] = 246,
		["361"] = 246,
		["362"] = 246,
		["363"] = 256,
		["365"] = 256,
		["366"] = 284,
		["367"] = 293,
		["368"] = 284,
		["369"] = 293,
		["370"] = 296,
		["371"] = 297,
		["372"] = 296,
		["373"] = 300,
		["374"] = 301,
		["375"] = 302,
		["376"] = 303,
		["377"] = 304,
		["378"] = 305,
		["379"] = 306,
		["380"] = 307,
		["383"] = 300,
		["384"] = 311,
		["385"] = 312,
		["386"] = 313,
		["387"] = 313,
		["388"] = 312,
		["389"] = 311,
		["390"] = 317,
		["391"] = 318,
		["392"] = 317,
		["393"] = 322,
		["394"] = 323,
		["395"] = 322,
		["396"] = 326,
		["397"] = 327,
		["398"] = 328,
		["399"] = 329,
		["400"] = 330,
		["401"] = 331,
		["402"] = 331,
		["403"] = 331,
		["404"] = 331,
		["405"] = 331,
		["407"] = 326,
		["408"] = 293,
		["409"] = 284,
		["410"] = 284,
		["411"] = 284,
		["412"] = 284,
		["413"] = 284,
		["414"] = 284,
		["415"] = 284,
		["416"] = 284,
		["417"] = 293,
		["419"] = 293,
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
g.pugna_talent = c()
local q = g.pugna_talent
q.name = "pugna_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_pugna_talent"
end
q = e({ j(nil) }, q)
g.pugna_talent = q
g.modifier_pugna_talent = c()
local r = g.modifier_pugna_talent
r.name = "modifier_pugna_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.timer = 0
	self.tl1_timer = 0
	self.tl2_wisp_record = 0
	self.tl6_wisp_heal_record = 0
	self.tl6_timer = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.add_hp = self:GetAbilitySpecialValueFor("add_hp")
	self.tl1_interval = self:GetAbilityTalentValue("pugna_talent_1", "interval")
	self.tl1_affect_time = self:GetAbilityTalentValue("pugna_talent_1", "affect_time")
	self.tl4_wisp_add_hp_pct = self:GetAbilityTalentValue("pugna_talent_4", "wisp_add_hp_pct")
	self.tl5_reduce_interval = self:GetAbilityTalentValue("pugna_talent_5", "reduce_interval")
	self.interval = self.interval - self.tl5_reduce_interval
	self.tl6_wisp_trigger = self:GetAbilityTalentValue("pugna_talent_6", "wisp_trigger")
	self.tl6_affect_time = self:GetAbilityTalentValue("pugna_talent_6", "affect_time")
	self.tl6_interval = self:GetAbilityTalentValue("pugna_talent_6", "interval")
end
function r.prototype.OnIntervalThink(self)
	self.timer = self.timer + self.interval
	self.tl1_timer = self.tl1_timer + self.interval
	self.tl6_timer = self.tl6_timer + self.interval
	if self.timer >= self.interval then
		self.timer = 0
		local s = self.caster:GetEnemy()
		if IsInjurable(s, self.caster) and not self:GetParent():PassivesDisabled() then
			local t = self.caster:FindModifierByName("modifier_pugna_ult")
			local u = t and t:GetAddHpMul() or 1
			self.caster:DealDamage(s, self:GetAbility(), self.damage * u, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			local v = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_pugna/pugna_ward_attack.vpcf",
				PATTACH_ABSORIGIN,
				self:GetParent()
			)
			ParticleManager:SetParticleControl(
				v,
				0,
				self.parent:GetAbsOrigin() + Vector(0, 0, 120) - self.parent:GetForwardVector():Normalized() * 20
			)
			ParticleManager:SetParticleControl(
				v,
				1,
				self.parent:GetAbsOrigin() + Vector(0, 0, 120) - self.parent:GetForwardVector():Normalized() * 20
			)
			ParticleManager:SetParticleControl(
				v,
				4,
				self.parent:GetAbsOrigin() + Vector(0, 0, 120) - self.parent:GetForwardVector():Normalized() * 20
			)
			ParticleManager:ReleaseParticleIndex(v)
			Heal(self.caster, self.add_hp * u, self:GetAbility():GetAbilityName(), "Ability")
		end
	end
	if self:HasTalent("pugna_talent_1") and self.tl1_timer > self.tl1_interval then
		self.tl1_timer = 0
		local w = self.caster
		if RandomInt(1, 100) > 50 then
			w = self.caster:GetEnemy()
		end
		if w ~= nil then
			w:AddNewModifier(
				self.caster,
				self:GetAbility(),
				"modifier_pugna_talent1",
				{ duration = self.tl1_affect_time }
			)
		end
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SPAWN] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { nil, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_HEAL] = { self:GetParent() },
	}
end
function r.prototype.OnBattleStartBefore(self, x)
	if IsServer() then
		self:StartIntervalThink(self.interval)
		if self:HasTalent("pugna_shard") then
			self.caster:AddNewModifier(self.caster, self.ability, "modifier_pugna_shard", {})
		end
	end
end
function r.prototype.OnWispSpawn(self, x)
	if self:HasTalent("pugna_talent_2") then
		self.tl2_wisp_record = self.tl2_wisp_record + 1
		local s = self.caster:GetEnemy()
		if IsInjurable(s, self.caster) then
			s:AddNewModifier(self.caster, self:GetAbility(), "modifier_pugna_talent2", {})
		end
	end
end
function r.prototype.OnWispDie(self, x)
	if self:HasTalent("pugna_talent_2") then
		self.tl2_wisp_record = self.tl2_wisp_record - 1
		if self.tl2_wisp_record <= 0 then
			self.tl2_wisp_record = 0
			local s = self.caster:GetEnemy()
			if IsInjurable(s, self.caster) then
				s:RemoveModifierByName("modifier_pugna_talent2")
			end
		end
	end
end
function r.prototype.OnHeal(self, x)
	if self:HasTalent("pugna_talent_4") then
		HealWisp(self.caster, self:GetAbility(), x.flHealAmount * self.tl4_wisp_add_hp_pct * 0.01)
	end
end
function r.prototype.OnWispHeal(self, x)
	if self:HasTalent("pugna_talent_6") then
		EachWisp(self.caster, function(y)
			self.tl6_wisp_heal_record = self.tl6_wisp_heal_record + x.healAmount
		end)
		if self.tl6_wisp_heal_record > self.tl6_wisp_trigger and self.tl6_timer >= self.tl6_interval then
			self.tl6_wisp_heal_record = 0
			self.tl6_timer = 0
			self.caster:AddNewModifier(
				self.caster,
				self:GetAbility(),
				"modifier_pugna_talent6",
				{ duration = self.tl6_affect_time }
			)
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
g.modifier_pugna_talent = r
g.modifier_pugna_talent1 = c()
local z = g.modifier_pugna_talent1
z.name = "modifier_pugna_talent1"
d(z, l)
function z.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE] = -BUFF_VALUE.AnilePhysicalDmgReducePct,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = BUFF_VALUE.AnileMagicalDmgAddPct,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY] = self.caster == self:GetParent()
				and BUFF_VALUE.AnileSelfAddHealPct
			or 0,
	}
end
z = e(
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
	z
)
g.modifier_pugna_talent1 = z
g.modifier_pugna_talent2 = c()
local A = g.modifier_pugna_talent2
A.name = "modifier_pugna_talent2"
d(A, l)
function A.prototype.GetAbilitySpecialValue(self)
	self.reduce_regen_pct = self:GetAbilityTalentValue("pugna_talent_2", "reduce_regen_pct")
end
function A.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE_PERCENTAGEMUL }
end
function A.prototype.EOM_GetModifierManaRegenBasePercentageMul(self, x)
	return -self.reduce_regen_pct
end
A = e(
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
	A
)
g.modifier_pugna_talent2 = A
g.modifier_pugna_talent6 = c()
local B = g.modifier_pugna_talent6
B.name = "modifier_pugna_talent6"
d(B, l)
function B.prototype.GetAbilitySpecialValue(self)
	self.tl6_enable = self:HasTalent("pugna_talent_6")
end
function B.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = self.tl6_enable
				and -BUFF_VALUE.SiphoningReduceIncomingDamagePct
			or 0,
	}
end
function B.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_INTERVAL }
end
function B.prototype.EOM_GetModifierWispInterval(self)
	return self.tl6_enable and BUFF_VALUE.SiphoningReduceWispInterval or 0
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
			}
		),
	},
	B
)
g.modifier_pugna_talent6 = B
g.pugna_ult = c()
local C = g.pugna_ult
C.name = "pugna_ult"
d(C, o)
function C.prototype.OnSpellStart(self)
	local D = self:GetCaster()
	local s = D:GetEnemy()
	local u = self:GetSpecialValueFor("add_hp_mul")
	local E = self:GetSpecialValueFor("affect_time")
	D:StartGestureWithFade(ACT_DOTA_CAST_ABILITY_4, 0.03, 0.09)
	local v =
		ParticleManager:CreateParticle("particles/units/heroes/hero_pugna/pugna_life_drain.vpcf", PATTACH_ABSORIGIN, D)
	ParticleManager:SetParticleControlEnt(v, 0, D, PATTACH_POINT_FOLLOW, "attach_head", vec3_zero, true)
	ParticleManager:SetParticleControlEnt(v, 1, s, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_zero, true)
	ParticleManager:SetParticleControl(v, 61, Vector(1, 0, 0))
	GameTimer(E, function()
		ParticleManager:DestroyParticle(v, true)
		if IsInjurable(D) then
			D:RemoveGesture(ACT_DOTA_CAST_ABILITY_4)
		end
	end)
	D:AddNewModifier(D, self, "modifier_pugna_ult", { duration = E })
end
C = e({ p(nil) }, C)
g.pugna_ult = C
g.modifier_pugna_ult = c()
local F = g.modifier_pugna_ult
F.name = "modifier_pugna_ult"
d(F, l)
function F.prototype.GetAbilitySpecialValue(self)
	self.add_hp_mul = self:GetAbilitySpecialValueFor("add_hp_mul")
	self.tl3_add_hp_mul = self:GetAbilityTalentValue("pugna_talent_3", "add_hp_mul")
	self.steal_enemy_heal_pct = self:GetAbilityTalentValue("pugna_shard", "steal_enemy_heal_pct")
end
function F.prototype.OnCreated(self, x)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function F.prototype.OnRefresh(self, x)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function F.prototype.GetAddHpMul(self)
	return (self.add_hp_mul + self.tl3_add_hp_mul) * self:GetStackCount()
end
F = e(
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
	F
)
g.modifier_pugna_ult = F
g.modifier_pugna_shard = c()
local G = g.modifier_pugna_shard
G.name = "modifier_pugna_shard"
d(G, l)
function G.prototype.GetAbilitySpecialValue(self)
	self.first_wisp_hp_add_pct = self:GetAbilityTalentValue("pugna_shard", "first_wisp_hp_add_pct")
end
function G.prototype.OnCreated(self, x)
	if IsServer() then
		local H = self:GetParent()
		local I = self.caster:GetPlayerOwnerID()
		local J = PlayerData:loadData(I, "pugna_shard")
		local K = self:GetAbility()
		if J then
			self:SetStackCount(J)
		end
	end
end
function G.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { nil, self.parent:GetEnemy() } }
end
function G.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_PERCENTAGE }
end
function G.prototype.EOM_GetModifierWispHealthPercentage(self, x)
	return self:GetStackCount() * self.first_wisp_hp_add_pct
end
function G.prototype.OnWispDie(self, x)
	local H = self:GetParent()
	local I = self.caster:GetPlayerOwnerID()
	if not H:GetHeroBase():isIllusion(H) and IsInjurable(self.caster, self.parent) then
		self:SetStackCount(self:GetStackCount() + 1)
		PlayerData:saveData(I, "pugna_shard", self:GetStackCount())
	end
end
G = e(
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
	G
)
g.modifier_pugna_shard = G
return g