--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/sniper"
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
		["33"] = 35,
		["34"] = 36,
		["35"] = 37,
		["36"] = 38,
		["37"] = 39,
		["38"] = 41,
		["39"] = 43,
		["40"] = 44,
		["41"] = 45,
		["42"] = 46,
		["43"] = 47,
		["44"] = 48,
		["45"] = 51,
		["46"] = 35,
		["47"] = 53,
		["48"] = 54,
		["49"] = 53,
		["50"] = 58,
		["51"] = 59,
		["52"] = 58,
		["53"] = 61,
		["54"] = 62,
		["55"] = 61,
		["56"] = 66,
		["57"] = 67,
		["58"] = 68,
		["59"] = 68,
		["60"] = 67,
		["61"] = 66,
		["62"] = 71,
		["63"] = 72,
		["66"] = 73,
		["67"] = 74,
		["68"] = 75,
		["69"] = 76,
		["70"] = 77,
		["71"] = 78,
		["73"] = 80,
		["74"] = 80,
		["75"] = 80,
		["76"] = 80,
		["77"] = 80,
		["78"] = 80,
		["79"] = 80,
		["80"] = 81,
		["81"] = 81,
		["82"] = 81,
		["83"] = 81,
		["84"] = 81,
		["85"] = 81,
		["86"] = 82,
		["87"] = 82,
		["88"] = 82,
		["89"] = 82,
		["90"] = 82,
		["91"] = 82,
		["92"] = 84,
		["93"] = 85,
		["95"] = 88,
		["96"] = 89,
		["97"] = 89,
		["98"] = 89,
		["99"] = 89,
		["100"] = 89,
		["101"] = 89,
		["103"] = 92,
		["104"] = 93,
		["105"] = 93,
		["106"] = 93,
		["107"] = 93,
		["108"] = 93,
		["109"] = 93,
		["112"] = 71,
		["113"] = 20,
		["114"] = 12,
		["115"] = 12,
		["116"] = 12,
		["117"] = 12,
		["118"] = 12,
		["119"] = 12,
		["120"] = 12,
		["121"] = 12,
		["122"] = 20,
		["124"] = 20,
		["126"] = 104,
		["127"] = 112,
		["128"] = 104,
		["129"] = 112,
		["130"] = 117,
		["131"] = 119,
		["132"] = 120,
		["133"] = 117,
		["134"] = 123,
		["135"] = 124,
		["136"] = 125,
		["137"] = 125,
		["138"] = 125,
		["139"] = 125,
		["140"] = 125,
		["141"] = 125,
		["142"] = 126,
		["143"] = 126,
		["144"] = 126,
		["145"] = 126,
		["146"] = 126,
		["147"] = 126,
		["148"] = 126,
		["149"] = 126,
		["151"] = 123,
		["152"] = 129,
		["153"] = 130,
		["154"] = 129,
		["155"] = 136,
		["156"] = 137,
		["157"] = 136,
		["158"] = 141,
		["159"] = 142,
		["160"] = 141,
		["161"] = 112,
		["162"] = 104,
		["163"] = 104,
		["164"] = 104,
		["165"] = 104,
		["166"] = 104,
		["167"] = 104,
		["168"] = 104,
		["169"] = 104,
		["170"] = 112,
		["172"] = 112,
		["174"] = 146,
		["175"] = 154,
		["176"] = 146,
		["177"] = 154,
		["178"] = 158,
		["179"] = 159,
		["180"] = 158,
		["181"] = 162,
		["182"] = 163,
		["183"] = 162,
		["184"] = 154,
		["185"] = 146,
		["186"] = 146,
		["187"] = 146,
		["188"] = 146,
		["189"] = 146,
		["190"] = 146,
		["191"] = 146,
		["192"] = 146,
		["193"] = 154,
		["195"] = 154,
		["197"] = 170,
		["198"] = 178,
		["199"] = 170,
		["200"] = 178,
		["201"] = 181,
		["202"] = 182,
		["203"] = 183,
		["204"] = 181,
		["205"] = 185,
		["206"] = 186,
		["207"] = 185,
		["208"] = 178,
		["209"] = 170,
		["210"] = 170,
		["211"] = 170,
		["212"] = 170,
		["213"] = 170,
		["214"] = 170,
		["215"] = 170,
		["216"] = 170,
		["217"] = 178,
		["219"] = 178,
		["220"] = 194,
		["221"] = 195,
		["222"] = 194,
		["223"] = 195,
		["224"] = 196,
		["225"] = 197,
		["226"] = 198,
		["227"] = 199,
		["228"] = 201,
		["229"] = 202,
		["230"] = 203,
		["231"] = 204,
		["232"] = 205,
		["233"] = 205,
		["234"] = 205,
		["235"] = 206,
		["236"] = 207,
		["237"] = 207,
		["238"] = 207,
		["239"] = 207,
		["240"] = 207,
		["241"] = 207,
		["242"] = 214,
		["243"] = 215,
		["244"] = 216,
		["245"] = 216,
		["246"] = 216,
		["247"] = 216,
		["248"] = 216,
		["249"] = 216,
		["250"] = 216,
		["252"] = 207,
		["253"] = 207,
		["254"] = 220,
		["256"] = 205,
		["257"] = 205,
		["258"] = 196,
		["259"] = 195,
		["260"] = 194,
		["261"] = 195,
		["263"] = 195,
		["265"] = 228,
		["266"] = 229,
		["267"] = 228,
		["268"] = 229,
		["269"] = 230,
		["270"] = 231,
		["271"] = 230,
		["272"] = 229,
		["273"] = 228,
		["274"] = 229,
		["276"] = 229,
		["277"] = 234,
		["278"] = 242,
		["279"] = 234,
		["280"] = 242,
		["281"] = 244,
		["282"] = 245,
		["283"] = 244,
		["284"] = 247,
		["285"] = 248,
		["286"] = 247,
		["287"] = 253,
		["288"] = 254,
		["289"] = 254,
		["290"] = 255,
		["292"] = 253,
		["293"] = 242,
		["294"] = 234,
		["295"] = 234,
		["296"] = 234,
		["297"] = 234,
		["298"] = 234,
		["299"] = 234,
		["300"] = 234,
		["301"] = 234,
		["302"] = 242,
		["304"] = 242,
		["306"] = 265,
		["307"] = 266,
		["308"] = 265,
		["309"] = 266,
		["310"] = 267,
		["311"] = 268,
		["312"] = 267,
		["313"] = 266,
		["314"] = 265,
		["315"] = 266,
		["317"] = 266,
		["318"] = 271,
		["319"] = 279,
		["320"] = 271,
		["321"] = 279,
		["322"] = 281,
		["323"] = 282,
		["324"] = 281,
		["325"] = 284,
		["326"] = 285,
		["327"] = 284,
		["328"] = 289,
		["329"] = 290,
		["330"] = 290,
		["331"] = 291,
		["333"] = 289,
		["334"] = 279,
		["335"] = 271,
		["336"] = 271,
		["337"] = 271,
		["338"] = 271,
		["339"] = 271,
		["340"] = 271,
		["341"] = 271,
		["342"] = 271,
		["343"] = 279,
		["345"] = 279,
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
g.sniper_talent = c()
local q = g.sniper_talent
q.name = "sniper_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_sniper_talent"
end
q = e({ j(nil) }, q)
g.sniper_talent = q
g.modifier_sniper_talent = c()
local r = g.modifier_sniper_talent
r.name = "modifier_sniper_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.reduce_duration = self:GetAbilitySpecialValueFor("reduce_duration")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
		+ self:GetAbilityTalentValue("sniper_talent_8", "damage_pct")
	self.tl8_crit_damage = self:GetAbilityTalentValue("sniper_talent_8", "cirt_damage")
	self.shard_duration = self:GetAbilityTalentValue("sniper_shard", "duration")
	self.crit_chance = self:GetAbilityTalentValue("sniper_talent_1", "crit_chance")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.mana_regen = self:GetAbilityTalentValue("sniper_talent_3", "mana_regen")
	self.steal_duration = self:GetAbilityTalentValue("sniper_talent_4", "steal_duration")
	self.talent_5_chance = self:GetAbilityTalentValue("sniper_talent_5", "chance")
	self.stun_duration = self:GetAbilityTalentValue("sniper_talent_5", "stun_duration")
	self.bonus_damage = self:GetAbilityTalentValue("sniper_talent_7", "bonus_damage")
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE }
end
function r.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self)
	return self.tl8_crit_damage
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.crit_chance }
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function r.prototype.OnCritical(self, s)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	local t = s.attacker
	local u = s.target
	if
		IsInjurable(u)
		and bit.band(s.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION
		and self:PRD(self.chance, "chance")
	then
		local v = self.damage + s.damage * self.damage_pct * 0.01
		if self.bonus_damage > 0 and s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
			v = v + self.bonus_damage
		end
		t:DealDamage(u, self:GetAbility(), v, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, DamageFlags.DAMAGE_FLAG_HPLOSS)
		u:AddNewModifier(t, self:GetAbility(), "modifier_sniper_talent_debuff", { duration = self.reduce_duration })
		u:AddNewModifier(t, self:GetAbility(), "modifier_sniper_shard_debuff", { duration = self.shard_duration })
		if self.mana_regen > 0 then
			Restore(t, self.mana_regen)
		end
		if self.talent_5_chance > 0 and self:PRD(self.talent_5_chance, "talent_5_chance") then
			AddStun(t, u, self:GetAbility(), self.stun_duration)
		end
		if self.steal_duration > 0 then
			t:AddNewModifier(t, self:GetAbility(), "modifier_sniper_talent_buff", { duration = self.steal_duration })
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
g.modifier_sniper_talent = r
g.modifier_sniper_talent_debuff = c()
local w = g.modifier_sniper_talent_debuff
w.name = "modifier_sniper_talent_debuff"
d(w, l)
function w.prototype.GetAbilitySpecialValue(self)
	self.reduce_attackspeed = self:GetAbilitySpecialValueFor("reduce_attackspeed")
		+ self:GetAbilityTalentValue("sniper_talent_2", "attackspeed_reduce_strength")
	self.mana_regen_reduce = self:GetAbilityTalentValue("sniper_talent_10", "mana_regen_reduce")
end
function w.prototype.OnCreated(self, s)
	if IsClient() then
		local x = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self:GetParent(),
			self:GetCaster()
		)
		self:AddParticle(x, false, false, -1, false, false)
	end
end
function w.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = -self.reduce_attackspeed }
end
function w.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_LOSS_PERCENTAGE }
end
function w.prototype.EOM_GetModifierManaLossPercentage(self, s)
	return self.mana_regen_reduce or 0
end
w = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	w
)
g.modifier_sniper_talent_debuff = w
g.modifier_sniper_shard_debuff = c()
local y = g.modifier_sniper_shard_debuff
y.name = "modifier_sniper_shard_debuff"
d(y, l)
function y.prototype.GetAbilitySpecialValue(self)
	self.s_evade_reduce = self:GetAbilityTalentValue("sniper_shard", "evade_reduce")
end
function y.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVADE_DAMAGE_REDUCE_BONUS_PERCENT] = -self.s_evade_reduce }
end
y = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	y
)
g.modifier_sniper_shard_debuff = y
g.modifier_sniper_talent_buff = c()
local z = g.modifier_sniper_talent_buff
z.name = "modifier_sniper_talent_buff"
d(z, l)
function z.prototype.GetAbilitySpecialValue(self)
	self.reduce_attackspeed = self:GetAbilitySpecialValueFor("reduce_attackspeed")
		+ self:GetAbilityTalentValue("sniper_talent_2", "attackspeed_reduce_strength")
	self.attackspeed_steal = self:GetAbilityTalentValue("sniper_talent_4", "attackspeed_steal")
end
function z.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed_steal }
end
z = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	z
)
g.modifier_sniper_talent_buff = z
g.sniper_ult = c()
local A = g.sniper_ult
A.name = "sniper_ult"
d(A, o)
function A.prototype.OnSpellStart(self)
	local B = self:GetCaster()
	local u = B:GetEnemy()
	local v = self:GetSpecialValueFor("damage") + self:GetTalentValue("sniper_talent_11", "extra_damage")
	B:AddActivityModifier("ultimate_scepter")
	B:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 200)
	B:RemoveActivityModifier("ultimate_scepter")
	B:EmitSound("Ability.AssassinateLoad")
	self:GameTimer(0.25, function()
		if IsInjurable(u) then
			Projectile:CreateTrackingProjectile({
				EffectName = "particles/units/heroes/hero_sniper/sniper_assassinate.vpcf",
				hCaster = B,
				vSpawnOrigin = B:GetAttachmentPosition("attach_attack1"),
				hTarget = u,
				iMoveSpeed = 2500,
				OnProjectileHit = function(C, D, E)
					if IsInjurable(C) then
						B:DealDamage(
							C,
							self,
							v,
							EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
							self:HasTalent("sniper_talent_9") and DamageFlags.DAMAGE_FLAG_NO_EVASION
								or DamageFlags.DAMAGE_FLAG_NONE
						)
					end
				end,
			})
			B:EmitSound("Ability.Assassinate")
		end
	end)
end
A = e({ p(nil) }, A)
g.sniper_ult = A
g.sniper_talent_6 = c()
local F = g.sniper_talent_6
F.name = "sniper_talent_6"
d(F, i)
function F.prototype.GetIntrinsicModifierName(self)
	return "modifier_sniper_talent_6"
end
F = e({ j(nil) }, F)
g.sniper_talent_6 = F
g.modifier_sniper_talent_6 = c()
local G = g.modifier_sniper_talent_6
G.name = "modifier_sniper_talent_6"
d(G, l)
function G.prototype.GetAbilitySpecialValue(self)
	self.crit_chance_bonus = self:GetAbilityTalentValue("sniper_talent_6", "crit_chance_bonus")
end
function G.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function G.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, s)
	local H = s and s.ability
	if (H and H:GetAbilityName()) == "sniper_ult" then
		return self.crit_chance_bonus
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
g.modifier_sniper_talent_6 = G
g.sniper_talent_7 = c()
local I = g.sniper_talent_7
I.name = "sniper_talent_7"
d(I, i)
function I.prototype.GetIntrinsicModifierName(self)
	return "modifier_sniper_talent_7"
end
I = e({ j(nil) }, I)
g.sniper_talent_7 = I
g.modifier_sniper_talent_7 = c()
local J = g.modifier_sniper_talent_7
J.name = "modifier_sniper_talent_7"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.crit_damage_bonus = self:GetAbilityTalentValue("sniper_talent_7", "crit_damage_bonus")
end
function J.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE }
end
function J.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self, s)
	local K = s and s.ability
	if (K and K:GetAbilityName()) == "sniper_ult" then
		return self.crit_damage_bonus
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
g.modifier_sniper_talent_7 = J
return g