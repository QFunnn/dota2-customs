--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/windrunner"
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
		["34"] = 28,
		["35"] = 29,
		["36"] = 30,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["40"] = 28,
		["41"] = 36,
		["42"] = 37,
		["43"] = 36,
		["44"] = 41,
		["45"] = 42,
		["46"] = 41,
		["47"] = 45,
		["48"] = 46,
		["49"] = 46,
		["50"] = 48,
		["51"] = 48,
		["52"] = 48,
		["53"] = 46,
		["54"] = 46,
		["55"] = 45,
		["56"] = 52,
		["57"] = 53,
		["58"] = 54,
		["59"] = 55,
		["61"] = 58,
		["62"] = 59,
		["63"] = 60,
		["65"] = 61,
		["66"] = 61,
		["67"] = 62,
		["68"] = 61,
		["74"] = 52,
		["75"] = 68,
		["76"] = 69,
		["77"] = 70,
		["78"] = 71,
		["81"] = 68,
		["82"] = 76,
		["83"] = 78,
		["84"] = 80,
		["85"] = 80,
		["86"] = 80,
		["87"] = 80,
		["88"] = 80,
		["89"] = 80,
		["91"] = 76,
		["92"] = 21,
		["93"] = 13,
		["94"] = 13,
		["95"] = 13,
		["96"] = 13,
		["97"] = 13,
		["98"] = 13,
		["99"] = 13,
		["100"] = 13,
		["101"] = 21,
		["103"] = 21,
		["104"] = 88,
		["105"] = 97,
		["106"] = 88,
		["107"] = 97,
		["108"] = 103,
		["109"] = 104,
		["110"] = 103,
		["111"] = 107,
		["112"] = 108,
		["113"] = 107,
		["114"] = 110,
		["115"] = 111,
		["116"] = 112,
		["117"] = 112,
		["118"] = 112,
		["119"] = 112,
		["120"] = 113,
		["121"] = 114,
		["122"] = 114,
		["123"] = 114,
		["124"] = 114,
		["125"] = 114,
		["126"] = 115,
		["127"] = 116,
		["128"] = 117,
		["129"] = 118,
		["130"] = 119,
		["131"] = 120,
		["133"] = 123,
		["134"] = 124,
		["136"] = 126,
		["137"] = 126,
		["138"] = 126,
		["139"] = 126,
		["140"] = 126,
		["142"] = 128,
		["143"] = 128,
		["144"] = 128,
		["145"] = 128,
		["146"] = 128,
		["147"] = 129,
		["148"] = 129,
		["149"] = 129,
		["150"] = 129,
		["151"] = 129,
		["152"] = 129,
		["153"] = 129,
		["154"] = 129,
		["156"] = 110,
		["157"] = 132,
		["158"] = 133,
		["159"] = 134,
		["160"] = 134,
		["161"] = 134,
		["162"] = 134,
		["163"] = 135,
		["165"] = 132,
		["166"] = 138,
		["167"] = 139,
		["168"] = 140,
		["170"] = 138,
		["171"] = 143,
		["172"] = 144,
		["173"] = 145,
		["174"] = 146,
		["175"] = 147,
		["176"] = 148,
		["177"] = 149,
		["178"] = 150,
		["179"] = 151,
		["181"] = 154,
		["182"] = 155,
		["184"] = 157,
		["185"] = 157,
		["186"] = 157,
		["187"] = 157,
		["188"] = 157,
		["191"] = 143,
		["192"] = 161,
		["193"] = 162,
		["194"] = 161,
		["195"] = 166,
		["196"] = 167,
		["197"] = 166,
		["198"] = 97,
		["199"] = 88,
		["200"] = 88,
		["201"] = 88,
		["202"] = 88,
		["203"] = 88,
		["204"] = 88,
		["205"] = 88,
		["206"] = 88,
		["207"] = 88,
		["208"] = 97,
		["210"] = 97,
		["212"] = 173,
		["213"] = 174,
		["214"] = 173,
		["215"] = 174,
		["216"] = 175,
		["217"] = 176,
		["218"] = 177,
		["219"] = 178,
		["220"] = 179,
		["221"] = 180,
		["222"] = 181,
		["223"] = 182,
		["224"] = 183,
		["225"] = 184,
		["226"] = 185,
		["227"] = 186,
		["228"] = 187,
		["231"] = 191,
		["232"] = 192,
		["233"] = 193,
		["234"] = 193,
		["235"] = 193,
		["236"] = 194,
		["237"] = 195,
		["238"] = 196,
		["239"] = 197,
		["241"] = 193,
		["242"] = 193,
		["245"] = 175,
		["246"] = 204,
		["247"] = 204,
		["248"] = 204,
		["250"] = 205,
		["251"] = 206,
		["252"] = 207,
		["253"] = 208,
		["254"] = 209,
		["255"] = 210,
		["256"] = 213,
		["257"] = 214,
		["258"] = 214,
		["259"] = 214,
		["260"] = 214,
		["261"] = 214,
		["262"] = 214,
		["263"] = 214,
		["264"] = 223,
		["265"] = 224,
		["266"] = 225,
		["267"] = 226,
		["268"] = 227,
		["269"] = 228,
		["270"] = 229,
		["271"] = 230,
		["272"] = 231,
		["274"] = 233,
		["275"] = 233,
		["276"] = 233,
		["277"] = 233,
		["278"] = 233,
		["279"] = 233,
		["280"] = 233,
		["281"] = 233,
		["282"] = 233,
		["283"] = 233,
		["285"] = 244,
		["287"] = 246,
		["289"] = 214,
		["290"] = 213,
		["291"] = 251,
		["292"] = 251,
		["293"] = 251,
		["294"] = 251,
		["295"] = 251,
		["297"] = 204,
		["298"] = 255,
		["299"] = 256,
		["300"] = 255,
		["301"] = 174,
		["302"] = 173,
		["303"] = 174,
		["305"] = 174,
		["306"] = 260,
		["307"] = 268,
		["308"] = 260,
		["309"] = 268,
		["310"] = 269,
		["311"] = 270,
		["312"] = 269,
		["313"] = 274,
		["314"] = 275,
		["315"] = 276,
		["316"] = 276,
		["317"] = 276,
		["318"] = 276,
		["319"] = 276,
		["320"] = 276,
		["322"] = 274,
		["323"] = 268,
		["324"] = 260,
		["325"] = 260,
		["326"] = 260,
		["327"] = 260,
		["328"] = 260,
		["329"] = 260,
		["330"] = 260,
		["331"] = 260,
		["332"] = 268,
		["334"] = 268,
		["335"] = 281,
		["336"] = 289,
		["337"] = 281,
		["338"] = 289,
		["339"] = 291,
		["340"] = 292,
		["341"] = 293,
		["342"] = 294,
		["343"] = 295,
		["344"] = 296,
		["345"] = 297,
		["346"] = 298,
		["347"] = 299,
		["348"] = 300,
		["352"] = 291,
		["353"] = 305,
		["354"] = 306,
		["355"] = 307,
		["357"] = 305,
		["358"] = 310,
		["359"] = 311,
		["360"] = 310,
		["361"] = 315,
		["362"] = 316,
		["363"] = 315,
		["364"] = 320,
		["365"] = 321,
		["366"] = 322,
		["367"] = 322,
		["368"] = 321,
		["369"] = 320,
		["370"] = 325,
		["371"] = 326,
		["372"] = 325,
		["373"] = 289,
		["374"] = 281,
		["375"] = 281,
		["376"] = 281,
		["377"] = 281,
		["378"] = 281,
		["379"] = 281,
		["380"] = 281,
		["381"] = 281,
		["382"] = 289,
		["384"] = 289,
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
g.windrunner_talent = c()
local q = g.windrunner_talent
q.name = "windrunner_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_windrunner_talent"
end
q = e({ j(nil) }, q)
g.windrunner_talent = q
g.modifier_windrunner_talent = c()
local r = g.modifier_windrunner_talent
r.name = "modifier_windrunner_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.bonus_evasion = self:GetAbilityTalentValue("windrunner_talent_1", "bonus_evasion")
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("windrunner_talent_3", "bonus_chance")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.talent_shot_chance = self:GetAbilityTalentValue("windrunner_talent_5", "talent_shot_chance")
	self.talent_shot_count = self:GetAbilityTalentValue("windrunner_talent_5", "talent_shot_count")
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS }
end
function r.prototype.EOM_GetModifierEvasion_Bonus(self, s)
	return self.bonus_evasion
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnEvasion(self, t)
	if IsServer() then
		if not self:GetCaster():PassivesDisabled() and self:PRD(self.chance, "chance") then
			self:AddStacks(1)
		end
		if self.talent_shot_chance > 0 then
			if self:PRD(self.talent_shot_chance, "talent_shot_chance") then
				local u = self:GetParent():FindAbilityByName("windrunner_ult")
				do
					local v = 0
					while v < self.talent_shot_count do
						u:Shot()
						v = v + 1
					end
				end
			end
		end
	end
end
function r.prototype.OnCustomTakeDamage(self, t)
	if IsServer() then
		if not self:GetCaster():PassivesDisabled() and self:PRD(self.chance, "PassivesDisabled") then
			self:AddStacks(1)
		end
	end
end
function r.prototype.AddStacks(self, w)
	if IsServer() then
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_windrunner_talent_buff",
			{ duration = self.duration, count = w }
		)
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
g.modifier_windrunner_talent = r
g.modifier_windrunner_talent_buff = c()
local x = g.modifier_windrunner_talent_buff
x.name = "modifier_windrunner_talent_buff"
d(x, l)
function x.prototype.IndependentMaxCount(self)
	return self:GetAbilitySpecialValueFor("max_stacks")
end
function x.prototype.GetAbilitySpecialValue(self)
	self.evasion = self:GetAbilitySpecialValueFor("evasion")
end
function x.prototype.OnCreated(self, t)
	if IsServer() then
		local y = defaultValue(tonumber(t.count), 1)
		self:IncrementStackCount(y)
		self.stack_particle = ParticleManager:CreateParticle(
			"particles/windrunner/windrunner_talent.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self:GetParent()
		)
		local z = self:GetStackCount()
		local A = math.floor(z / 10)
		local B = z % 10
		local C = z % 10
		if A >= 1 then
			C = 0
		else
			A = 0
			B = 0
		end
		ParticleManager:SetParticleControl(self.stack_particle, 1, Vector(A, B, C))
	else
		self.windrun_particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_windrunner/windrunner_windrun.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(self.windrun_particle, false, false, -1, false, false)
	end
end
function x.prototype.OnRefresh(self, t)
	if IsServer() then
		local y = defaultValue(tonumber(t.count), 1)
		self:IncrementStackCount(y)
	end
end
function x.prototype.OnDestroy(self)
	if IsServer() then
		ParticleManager:DestroyParticle(self.stack_particle, false)
	end
end
function x.prototype.OnStackCountChanged(self, D)
	if IsServer() then
		if self.stack_particle then
			local z = self:GetStackCount()
			local A = math.floor(z / 10)
			local B = z % 10
			local C = z % 10
			if A >= 1 then
				C = 0
			else
				A = 0
				B = 0
			end
			ParticleManager:SetParticleControl(self.stack_particle, 1, Vector(A, B, C))
		end
	end
end
function x.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS }
end
function x.prototype.EOM_GetModifierEvasion_Bonus(self, s)
	return self:GetStackCount() * self.evasion
end
x = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsIndependent = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	x
)
g.modifier_windrunner_talent_buff = x
g.windrunner_ult = c()
local E = g.windrunner_ult
E.name = "windrunner_ult"
d(E, o)
function E.prototype.OnSpellStart(self)
	local F = self:GetCaster()
	if IsValid(F) then
		local G = F:GetEnemy()
		if IsInjurable(F, G) then
			local H = self:GetSpecialValueFor("base_shot") + self:GetTalentValue("windrunner_talent_2", "bonus_shot")
			local I = self:GetSpecialValueFor("bonus_threshold")
			local J = self:GetTalentValue("windrunner_talent_4", "bonus_windrunner_stacks")
			local K = F:GetModifierStackCount("modifier_windrunner_talent_buff", F)
			if J > 0 then
				local L = F:FindModifierByNameAndCaster("modifier_windrunner_talent", F)
				if IsValid(L) then
					L:AddStacks(J)
				end
			end
			local M = H + math.floor(K / I)
			local v = 0
			self:GameTimer(0, function()
				self:Shot()
				v = v + 1
				if v < M then
					return 0.1
				end
			end)
		end
	end
end
function E.prototype.Shot(self, N, O, P, Q)
	if Q == nil then
		Q = 0
	end
	local F = self:GetCaster()
	local G = F:GetEnemy()
	if IsInjurable(F, G) then
		local R = F:GetAbsOrigin() + RandomVector(RandomFloat(0, 160))
		local S = (G:GetAbsOrigin() - R):Normalized()
		local T = (G:GetAbsOrigin() - R):Length2D() + 120
		Projectile:CreateLinearProjectile({
			hCaster = F,
			flDistance = T,
			vDirection = S,
			EffectName = "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf",
			vSpawnOrigin = R,
			flRadius = 125,
			iMoveSpeed = 3000,
			OnProjectileHit = function(U, V, W)
				if IsInjurable(U) then
					local X = self:GetSpecialValueFor("base_damage")
					local Y = self:GetSpecialValueFor("evade_factor")
						+ self:GetTalentValue("windrunner_talent_6", "bonus_evade_factor")
					local Z = X + GetEvasion(F) * Y + Q
					if N then
						local _ = O
						if not IsValid(O) then
							_ = self
						end
						DamageSystem:dealDamage({
							attacker = F,
							target = U,
							ability = _,
							ability_upgrade = P,
							damage = Z,
							damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
							damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
							damage_category = DOTA_DAMAGE_CATEGORY_ATTACK,
						})
					else
						F:DealDamage(U, self, Z, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
					end
					EmitSoundOnLocationWithCaster(V, "Hero_Windrunner.PowershotDamage", U)
				end
			end,
		})
		EmitSoundOnLocationWithCaster(F:GetAbsOrigin(), "Ability.Powershot", F)
	end
end
function E.prototype.GetIntrinsicModifierName(self)
	return "modifier_windrunner_ult"
end
E = e({ p(nil) }, E)
g.windrunner_ult = E
g.modifier_windrunner_ult = c()
local a0 = g.modifier_windrunner_ult
a0.name = "modifier_windrunner_ult"
d(a0, l)
function a0.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function a0.prototype.OnBattleStartBefore(self, t)
	if self:HasTalent("windrunner_shard") then
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_windrunner_shard", nil)
	end
end
a0 = e(
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
	a0
)
g.modifier_windrunner_ult = a0
g.modifier_windrunner_shard = c()
local a1 = g.modifier_windrunner_shard
a1.name = "modifier_windrunner_shard"
d(a1, l)
function a1.prototype.OnCreated(self, t)
	if IsServer() then
		self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
		self.exp_damage = 0
		local a2 = self:GetAbilityTalentValue("windrunner_shard", "exp_factor")
		local a3 = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if a3 then
			local a4 = a3:getAbilityData(false, true)
			if a4.sect_attack then
				self.exp_damage = a4.sect_attack.exp * a2
			end
		end
	end
end
function a1.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
	end
end
function a1.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY }
end
function a1.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_FAKE_ATTACK] = true }
end
function a1.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_FAKE_ATTACK] = { self:GetParent(), -1 } }
end
function a1.prototype.OnFakeAttack(self, s)
	self:GetAbility():Shot(true, s.ability, s.ability_upgrade, self.exp_damage)
end
a1 = e(
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
	a1
)
g.modifier_windrunner_shard = a1
return g