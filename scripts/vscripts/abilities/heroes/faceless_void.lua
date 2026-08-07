--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/faceless_void"
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
		["34"] = 33,
		["35"] = 34,
		["36"] = 35,
		["37"] = 36,
		["38"] = 37,
		["39"] = 38,
		["40"] = 39,
		["41"] = 40,
		["42"] = 41,
		["43"] = 42,
		["44"] = 43,
		["45"] = 44,
		["46"] = 33,
		["47"] = 46,
		["48"] = 47,
		["49"] = 48,
		["50"] = 48,
		["51"] = 48,
		["52"] = 49,
		["53"] = 50,
		["56"] = 51,
		["57"] = 52,
		["60"] = 48,
		["61"] = 48,
		["63"] = 46,
		["64"] = 58,
		["65"] = 59,
		["66"] = 60,
		["67"] = 60,
		["68"] = 60,
		["69"] = 59,
		["70"] = 61,
		["71"] = 61,
		["72"] = 61,
		["73"] = 59,
		["74"] = 62,
		["75"] = 62,
		["76"] = 62,
		["77"] = 59,
		["78"] = 59,
		["79"] = 58,
		["80"] = 65,
		["81"] = 66,
		["82"] = 65,
		["83"] = 71,
		["84"] = 72,
		["85"] = 73,
		["86"] = 74,
		["87"] = 75,
		["88"] = 76,
		["89"] = 76,
		["90"] = 76,
		["91"] = 76,
		["92"] = 76,
		["93"] = 76,
		["94"] = 76,
		["95"] = 76,
		["96"] = 77,
		["99"] = 80,
		["100"] = 71,
		["101"] = 91,
		["102"] = 92,
		["103"] = 93,
		["104"] = 94,
		["105"] = 95,
		["108"] = 98,
		["109"] = 99,
		["110"] = 91,
		["111"] = 101,
		["112"] = 103,
		["113"] = 104,
		["114"] = 105,
		["115"] = 106,
		["116"] = 107,
		["117"] = 108,
		["120"] = 111,
		["121"] = 112,
		["122"] = 113,
		["125"] = 101,
		["126"] = 118,
		["127"] = 119,
		["128"] = 120,
		["129"] = 121,
		["130"] = 122,
		["131"] = 123,
		["132"] = 124,
		["133"] = 125,
		["134"] = 126,
		["136"] = 128,
		["137"] = 129,
		["138"] = 129,
		["139"] = 129,
		["140"] = 129,
		["141"] = 129,
		["142"] = 129,
		["143"] = 129,
		["144"] = 129,
		["145"] = 129,
		["146"] = 130,
		["147"] = 130,
		["148"] = 130,
		["149"] = 130,
		["150"] = 130,
		["151"] = 130,
		["152"] = 130,
		["153"] = 130,
		["154"] = 130,
		["155"] = 131,
		["156"] = 131,
		["157"] = 131,
		["158"] = 132,
		["159"] = 133,
		["160"] = 134,
		["161"] = 135,
		["162"] = 136,
		["163"] = 137,
		["165"] = 139,
		["166"] = 139,
		["167"] = 139,
		["168"] = 139,
		["169"] = 139,
		["170"] = 139,
		["171"] = 139,
		["172"] = 140,
		["173"] = 141,
		["175"] = 143,
		["176"] = 143,
		["177"] = 143,
		["178"] = 143,
		["179"] = 143,
		["180"] = 143,
		["181"] = 143,
		["182"] = 143,
		["184"] = 131,
		["185"] = 131,
		["188"] = 118,
		["189"] = 21,
		["190"] = 13,
		["191"] = 13,
		["192"] = 13,
		["193"] = 13,
		["194"] = 13,
		["195"] = 13,
		["196"] = 13,
		["197"] = 13,
		["198"] = 21,
		["200"] = 21,
		["202"] = 155,
		["203"] = 163,
		["204"] = 155,
		["205"] = 163,
		["206"] = 165,
		["207"] = 166,
		["208"] = 165,
		["209"] = 168,
		["210"] = 169,
		["211"] = 168,
		["212"] = 163,
		["213"] = 155,
		["214"] = 155,
		["215"] = 155,
		["216"] = 155,
		["217"] = 155,
		["218"] = 155,
		["219"] = 155,
		["220"] = 155,
		["221"] = 163,
		["223"] = 163,
		["224"] = 176,
		["225"] = 177,
		["226"] = 176,
		["227"] = 177,
		["228"] = 178,
		["229"] = 179,
		["230"] = 180,
		["231"] = 181,
		["234"] = 184,
		["235"] = 185,
		["236"] = 186,
		["237"] = 187,
		["238"] = 188,
		["239"] = 188,
		["240"] = 188,
		["241"] = 188,
		["243"] = 190,
		["245"] = 192,
		["246"] = 193,
		["247"] = 194,
		["248"] = 195,
		["249"] = 196,
		["251"] = 198,
		["252"] = 199,
		["254"] = 201,
		["255"] = 178,
		["256"] = 177,
		["257"] = 176,
		["258"] = 177,
		["260"] = 177,
		["262"] = 206,
		["263"] = 215,
		["264"] = 206,
		["265"] = 215,
		["266"] = 220,
		["267"] = 221,
		["268"] = 223,
		["269"] = 224,
		["270"] = 220,
		["271"] = 226,
		["272"] = 227,
		["273"] = 228,
		["274"] = 229,
		["275"] = 230,
		["276"] = 231,
		["277"] = 231,
		["278"] = 231,
		["279"] = 231,
		["280"] = 231,
		["281"] = 232,
		["282"] = 232,
		["283"] = 232,
		["284"] = 232,
		["285"] = 232,
		["286"] = 233,
		["287"] = 233,
		["288"] = 233,
		["289"] = 233,
		["290"] = 233,
		["291"] = 233,
		["292"] = 233,
		["293"] = 233,
		["294"] = 234,
		["296"] = 236,
		["297"] = 237,
		["298"] = 237,
		["299"] = 237,
		["300"] = 237,
		["301"] = 237,
		["302"] = 237,
		["303"] = 237,
		["304"] = 237,
		["306"] = 226,
		["307"] = 240,
		["308"] = 241,
		["309"] = 242,
		["311"] = 240,
		["312"] = 245,
		["313"] = 246,
		["314"] = 247,
		["315"] = 248,
		["316"] = 249,
		["317"] = 250,
		["318"] = 250,
		["319"] = 250,
		["320"] = 250,
		["321"] = 250,
		["322"] = 250,
		["323"] = 251,
		["326"] = 245,
		["327"] = 255,
		["328"] = 256,
		["329"] = 257,
		["331"] = 255,
		["332"] = 260,
		["333"] = 261,
		["334"] = 260,
		["335"] = 265,
		["336"] = 266,
		["337"] = 267,
		["338"] = 267,
		["339"] = 266,
		["340"] = 265,
		["341"] = 270,
		["342"] = 271,
		["343"] = 272,
		["345"] = 270,
		["346"] = 215,
		["347"] = 206,
		["348"] = 206,
		["349"] = 206,
		["350"] = 206,
		["351"] = 206,
		["352"] = 206,
		["353"] = 206,
		["354"] = 206,
		["355"] = 206,
		["356"] = 215,
		["358"] = 215,
		["360"] = 278,
		["361"] = 287,
		["362"] = 278,
		["363"] = 287,
		["364"] = 290,
		["365"] = 291,
		["366"] = 292,
		["367"] = 290,
		["368"] = 294,
		["369"] = 295,
		["371"] = 297,
		["372"] = 298,
		["373"] = 299,
		["374"] = 299,
		["375"] = 299,
		["376"] = 299,
		["377"] = 299,
		["378"] = 299,
		["379"] = 299,
		["380"] = 299,
		["382"] = 294,
		["383"] = 302,
		["384"] = 303,
		["385"] = 302,
		["386"] = 308,
		["387"] = 309,
		["388"] = 308,
		["389"] = 287,
		["390"] = 278,
		["391"] = 278,
		["392"] = 278,
		["393"] = 278,
		["394"] = 278,
		["395"] = 278,
		["396"] = 278,
		["397"] = 278,
		["398"] = 278,
		["399"] = 287,
		["401"] = 287,
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
g.faceless_void_talent = c()
local q = g.faceless_void_talent
q.name = "faceless_void_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_faceless_void_talent"
end
q = e({ j(nil) }, q)
g.faceless_void_talent = q
g.modifier_faceless_void_talent = c()
local r = g.modifier_faceless_void_talent
r.name = "modifier_faceless_void_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("faceless_void_talent_1", "bonus_chance")
	self.damage = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilityTalentValue("faceless_void_talent_2", "bonus_damage")
		+ self:GetAbilityTalentValue("faceless_void_talent_8", "bonus_damage")
	self.tl3_lock_duration = self:GetAbilityTalentValue("faceless_void_talent_9", "lock_duration")
	self.tl3_steal_pct = self:GetAbilityTalentValue("faceless_void_talent_9", "steal_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration") + self.tl3_lock_duration
	self.immune_chance = self:GetAbilityTalentValue("faceless_void_talent_4", "immune_chance")
	self.recall_duration = self:GetAbilityTalentValue("faceless_void_talent_5", "recall_duration")
	self.tl7_bonus_pct = self:GetAbilityTalentValue("faceless_void_talent_7", "bonus_pct")
	self.tl8_stun_duration = self:GetAbilityTalentValue("faceless_void_talent_8", "stun_duration")
	self.tl8_chance = self:GetAbilityTalentValue("faceless_void_talent_8", "chance")
	self.health_record = {}
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(t, s, u, v)
			if u == self:GetParent() then
				if u:PassivesDisabled() then
					return
				end
				if s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and self:PRD(self.chance, "chance") then
					s.time_lock = true
				end
			end
		end)
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
	}
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE }
end
function r.prototype.EOM_GetModifierAllBlockChance(self, s)
	if s then
		if self.immune_chance > 0 and self:PRD(self.immune_chance, "immune_chance") then
			local w = self:GetParent()
			local x = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf",
				PATTACH_ABSORIGIN,
				w
			)
			self:AddParticle(x, false, false, -1, false, false)
			return 100
		end
	end
	return 0
end
function r.prototype.OnCustomTakeDamage(self, y)
	local z = {}
	for A, B in pairs(self.health_record) do
		if GameRules:GetGameTime() - A <= self.recall_duration then
			z[A] = B
		end
	end
	self.health_record = z
	self.health_record[GameRules:GetGameTime()] = y.damage
end
function r.prototype.OnCustomAbilityFullyCast(self, y)
	if y.ability:GetAbilityName() == "faceless_void_ult" then
		local w = self:GetParent()
		local C = 0
		for A, B in pairs(self.health_record) do
			if GameRules:GetGameTime() - A <= self.recall_duration then
				C = C + B
			end
		end
		self.health_record = {}
		if C > 0 then
			Heal(w, C, "faceless_void_talent_5", "Ability")
		end
	end
end
function r.prototype.OnCustomAttackLanded(self, y)
	if y.time_lock then
		local w = self:GetParent()
		local D = self:GetAbility()
		local E = w:GetEnemy()
		if IsInjurable(E) then
			E:AddNewModifier(w, D, "modifier_lock_custom", { duration = self.duration })
			if self.tl3_steal_pct > 0 then
				w:AddNewModifier(w, D, "modifier_faceless_void_talent_lock_steal", { duration = self.duration })
			end
			local x = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				E,
				w
			)
			ParticleManager:SetParticleControlEnt(
				x,
				1,
				E,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				E:GetAbsOrigin(),
				false
			)
			ParticleManager:SetParticleControlEnt(x, 2, w, PATTACH_ABSORIGIN_FOLLOW, nil, E:GetAbsOrigin(), false)
			GameTimer(0.4, function()
				local E = w:GetEnemy()
				if
					IsInjurable(E)
					and bit.band(y.damage_flags, DamageFlags.DAMAGE_FLAG_NO_EXTRA)
						~= DamageFlags.DAMAGE_FLAG_NO_EXTRA
				then
					w:EmitSound("Hero_FacelessVoid.TimeLockImpact")
					local B = self.damage
					if self.tl7_bonus_pct > 0 then
						B = B * (1 + self.tl7_bonus_pct * 0.01)
					end
					w:DealDamage(E, D, B, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, DamageFlags.DAMAGE_FLAG_NO_EXTRA)
					if self.tl8_stun_duration > 0 and self:PRD(self.tl8_chance) then
						AddStun(w, E, D, self.tl8_stun_duration)
					end
					DamageSystem:performAttack(
						w,
						E,
						{ ability = self:GetAbility(), damage = GetAttackDamage(w) * (1 + self.tl7_bonus_pct * 0.01) }
					)
				end
			end)
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
g.modifier_faceless_void_talent = r
g.modifier_faceless_void_talent_lock_steal = c()
local F = g.modifier_faceless_void_talent_lock_steal
F.name = "modifier_faceless_void_talent_lock_steal"
d(F, l)
function F.prototype.GetAbilitySpecialValue(self)
	self.steal_pct = self:GetAbilityTalentValue("faceless_void_talent_9", "steal_pct")
end
function F.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = BUFF_VALUE.LockReduce * self.steal_pct * 0.01,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE] = BUFF_VALUE.LockManaRegenBaseReduce
			* self.steal_pct
			* 0.01,
	}
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
			}
		),
	},
	F
)
g.modifier_faceless_void_talent_lock_steal = F
g.faceless_void_ult = c()
local G = g.faceless_void_ult
G.name = "faceless_void_ult"
d(G, o)
function G.prototype.OnSpellStart(self)
	local H = self:GetCaster()
	local E = H:GetEnemy()
	if not IsInjurable(E, H) then
		return
	end
	H:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	local I = self:GetSpecialValueFor("duration") + self:GetTalentValue("faceless_void_talent_6", "bonus_duration")
	local J = H:FindModifierByName("modifier_faceless_void_ult_buff")
	if J then
		J:SetDuration(J:GetRemainingTime() + I, true)
	else
		H:AddNewModifier(H, self, "modifier_faceless_void_ult_buff", { duration = I })
	end
	E:AddNewModifier(H, self, "modifier_lock_custom", { duration = I })
	local K = self:GetTalentValue("faceless_void_talent_8", "stun_duration")
	local L = self:GetTalentValue("faceless_void_talent_8", "chance")
	if K > 0 and self:PRD(L, "faceless_void_talent_8_stun") then
		AddStun(H, E, self, K)
	end
	if self:GetTalentValue("faceless_void_talent_9", "steal_pct") > 0 then
		H:AddNewModifier(H, self, "modifier_faceless_void_talent_lock_steal", { duration = I })
	end
	H:EmitSound("CNY_Beast.Chronosphere")
end
G = e({ p(nil) }, G)
g.faceless_void_ult = G
g.modifier_faceless_void_ult_buff = c()
local M = g.modifier_faceless_void_ult_buff
M.name = "modifier_faceless_void_ult_buff"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
		+ self:GetAbilityTalentValue("faceless_void_talent_3", "bonus_attackspeed")
	self.s_damage_per = self:GetAbilityTalentValue("faceless_void_shard", "damage_per")
	self.shard_interval = self:GetAbilityTalentValue("faceless_void_shard", "interval")
end
function M.prototype.OnCreated(self, s)
	local w = self:GetParent()
	if IsServer() then
		self.s_record = 0
		local x = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_faceless_void/faceless_void_chronosphere.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			w
		)
		ParticleManager:SetParticleControl(x, 0, w:GetAbsOrigin() + w:GetForwardVector() * 300)
		ParticleManager:SetParticleControl(x, 1, Vector(500, 500, 500))
		self:AddParticle(x, false, false, -1, false, false)
		self:StartIntervalThink(self.shard_interval)
	else
		local x = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_faceless_void/faceless_void_chrono_speed.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			w
		)
		self:AddParticle(x, false, false, -1, false, false)
	end
end
function M.prototype.OnIntervalThink(self)
	if IsServer() then
		self:ShardDamage()
	end
end
function M.prototype.ShardDamage(self)
	if self.s_record > 0 then
		local w = self:GetParent()
		local E = w:GetEnemy()
		if IsInjurable(w, E) then
			w:DealDamage(
				E,
				self:GetAbility(),
				self.s_record * self.s_damage_per * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
			self.s_record = 0
		end
	end
end
function M.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function M.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed }
end
function M.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function M.prototype.OnCustomTakeDamage(self, y)
	if self.s_damage_per > 0 and IsValid(y.ability) and y.ability:GetAbilityName() == "faceless_void_talent" then
		self.s_record = self.s_record + y.damage
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
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	M
)
g.modifier_faceless_void_ult_buff = M
g.modifier_faceless_void_debuff = c()
local N = g.modifier_faceless_void_debuff
N.name = "modifier_faceless_void_debuff"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_reduce = self:GetAbilitySpecialValueFor("attackspeed_reduce")
	self.mana_regen_reduce_pct = self:GetAbilitySpecialValueFor("mana_regen_reduce_pct")
end
function N.prototype.OnCreated(self, s)
	if IsServer() then
	else
		local w = self:GetParent()
		local x = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_faceless_chronosphere.vpcf",
			PATTACH_INVALID,
			w
		)
		self:AddParticle(x, false, true, 10, false, false)
	end
end
function N.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_LOSS_PERCENTAGE] = self.mana_regen_reduce_pct,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = -self.attackspeed_reduce,
	}
end
function N.prototype.CheckState(self)
	return { [MODIFIER_STATE_FROZEN] = true }
end
N = e(
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
	N
)
g.modifier_faceless_void_debuff = N
return g