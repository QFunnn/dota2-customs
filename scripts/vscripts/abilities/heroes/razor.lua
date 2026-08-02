--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/razor"
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
		["33"] = 49,
		["34"] = 50,
		["35"] = 49,
		["36"] = 52,
		["37"] = 54,
		["38"] = 55,
		["39"] = 56,
		["40"] = 57,
		["41"] = 58,
		["42"] = 59,
		["43"] = 60,
		["44"] = 61,
		["45"] = 63,
		["46"] = 65,
		["47"] = 67,
		["48"] = 74,
		["49"] = 75,
		["50"] = 76,
		["51"] = 78,
		["52"] = 79,
		["53"] = 80,
		["54"] = 81,
		["55"] = 82,
		["56"] = 52,
		["57"] = 84,
		["58"] = 85,
		["59"] = 85,
		["60"] = 85,
		["61"] = 88,
		["62"] = 88,
		["63"] = 88,
		["64"] = 85,
		["65"] = 85,
		["66"] = 84,
		["67"] = 91,
		["68"] = 92,
		["69"] = 92,
		["70"] = 92,
		["71"] = 92,
		["72"] = 92,
		["73"] = 92,
		["74"] = 92,
		["75"] = 92,
		["76"] = 91,
		["77"] = 101,
		["78"] = 102,
		["79"] = 103,
		["81"] = 101,
		["82"] = 106,
		["83"] = 107,
		["84"] = 108,
		["86"] = 110,
		["87"] = 106,
		["88"] = 112,
		["89"] = 113,
		["90"] = 114,
		["92"] = 112,
		["93"] = 117,
		["94"] = 118,
		["95"] = 119,
		["97"] = 117,
		["98"] = 122,
		["99"] = 123,
		["100"] = 124,
		["101"] = 125,
		["102"] = 126,
		["103"] = 127,
		["104"] = 128,
		["105"] = 128,
		["106"] = 128,
		["107"] = 128,
		["108"] = 128,
		["109"] = 129,
		["110"] = 129,
		["111"] = 129,
		["112"] = 129,
		["113"] = 129,
		["114"] = 130,
		["115"] = 130,
		["116"] = 130,
		["117"] = 131,
		["118"] = 131,
		["119"] = 131,
		["120"] = 131,
		["121"] = 131,
		["122"] = 132,
		["123"] = 133,
		["124"] = 133,
		["125"] = 133,
		["126"] = 134,
		["127"] = 133,
		["128"] = 133,
		["129"] = 130,
		["130"] = 130,
		["133"] = 122,
		["134"] = 140,
		["135"] = 141,
		["136"] = 142,
		["137"] = 143,
		["138"] = 144,
		["139"] = 144,
		["140"] = 144,
		["141"] = 144,
		["142"] = 144,
		["143"] = 144,
		["145"] = 140,
		["146"] = 147,
		["147"] = 148,
		["148"] = 149,
		["151"] = 150,
		["152"] = 151,
		["153"] = 153,
		["155"] = 153,
		["156"] = 153,
		["158"] = 153,
		["159"] = 154,
		["160"] = 155,
		["161"] = 156,
		["162"] = 156,
		["163"] = 156,
		["164"] = 156,
		["165"] = 156,
		["166"] = 156,
		["167"] = 156,
		["168"] = 156,
		["169"] = 156,
		["170"] = 157,
		["171"] = 157,
		["172"] = 157,
		["173"] = 157,
		["174"] = 157,
		["175"] = 157,
		["176"] = 157,
		["177"] = 157,
		["178"] = 157,
		["179"] = 158,
		["180"] = 158,
		["181"] = 158,
		["182"] = 158,
		["183"] = 164,
		["184"] = 165,
		["185"] = 166,
		["186"] = 166,
		["187"] = 166,
		["188"] = 166,
		["189"] = 166,
		["190"] = 166,
		["191"] = 166,
		["192"] = 166,
		["193"] = 166,
		["194"] = 166,
		["195"] = 176,
		["196"] = 177,
		["198"] = 180,
		["199"] = 181,
		["200"] = 181,
		["201"] = 181,
		["202"] = 181,
		["203"] = 181,
		["204"] = 181,
		["205"] = 181,
		["206"] = 181,
		["207"] = 181,
		["209"] = 192,
		["210"] = 193,
		["211"] = 194,
		["212"] = 195,
		["213"] = 196,
		["214"] = 196,
		["215"] = 196,
		["216"] = 197,
		["217"] = 198,
		["218"] = 199,
		["219"] = 200,
		["220"] = 201,
		["222"] = 201,
		["226"] = 196,
		["227"] = 196,
		["230"] = 207,
		["231"] = 208,
		["233"] = 211,
		["234"] = 212,
		["237"] = 158,
		["238"] = 158,
		["239"] = 234,
		["240"] = 235,
		["241"] = 235,
		["242"] = 235,
		["243"] = 235,
		["246"] = 147,
		["247"] = 20,
		["248"] = 12,
		["249"] = 12,
		["250"] = 12,
		["251"] = 12,
		["252"] = 12,
		["253"] = 12,
		["254"] = 12,
		["255"] = 12,
		["256"] = 20,
		["258"] = 20,
		["259"] = 242,
		["260"] = 250,
		["261"] = 242,
		["262"] = 250,
		["263"] = 251,
		["264"] = 252,
		["265"] = 253,
		["266"] = 254,
		["267"] = 255,
		["270"] = 251,
		["271"] = 259,
		["272"] = 260,
		["273"] = 261,
		["274"] = 262,
		["275"] = 263,
		["278"] = 259,
		["279"] = 267,
		["280"] = 268,
		["281"] = 267,
		["282"] = 272,
		["283"] = 273,
		["284"] = 272,
		["285"] = 250,
		["286"] = 242,
		["287"] = 242,
		["288"] = 242,
		["289"] = 242,
		["290"] = 242,
		["291"] = 242,
		["292"] = 242,
		["293"] = 242,
		["294"] = 250,
		["296"] = 250,
		["297"] = 277,
		["298"] = 285,
		["299"] = 277,
		["300"] = 285,
		["301"] = 286,
		["302"] = 287,
		["303"] = 288,
		["304"] = 289,
		["305"] = 290,
		["308"] = 286,
		["309"] = 294,
		["310"] = 295,
		["311"] = 296,
		["312"] = 297,
		["313"] = 298,
		["316"] = 294,
		["317"] = 302,
		["318"] = 303,
		["319"] = 302,
		["320"] = 307,
		["321"] = 308,
		["322"] = 307,
		["323"] = 285,
		["324"] = 277,
		["325"] = 277,
		["326"] = 277,
		["327"] = 277,
		["328"] = 277,
		["329"] = 277,
		["330"] = 277,
		["331"] = 277,
		["332"] = 285,
		["334"] = 285,
		["335"] = 313,
		["336"] = 321,
		["337"] = 313,
		["338"] = 321,
		["339"] = 324,
		["340"] = 325,
		["341"] = 326,
		["342"] = 324,
		["343"] = 328,
		["344"] = 329,
		["345"] = 330,
		["346"] = 330,
		["347"] = 330,
		["348"] = 330,
		["350"] = 328,
		["351"] = 333,
		["352"] = 334,
		["353"] = 335,
		["354"] = 335,
		["355"] = 335,
		["356"] = 335,
		["358"] = 333,
		["359"] = 338,
		["360"] = 339,
		["361"] = 338,
		["362"] = 343,
		["363"] = 344,
		["364"] = 343,
		["365"] = 321,
		["366"] = 313,
		["367"] = 313,
		["368"] = 313,
		["369"] = 313,
		["370"] = 313,
		["371"] = 313,
		["372"] = 313,
		["373"] = 313,
		["374"] = 321,
		["376"] = 321,
		["377"] = 349,
		["378"] = 350,
		["379"] = 349,
		["380"] = 350,
		["381"] = 351,
		["382"] = 352,
		["383"] = 353,
		["384"] = 354,
		["385"] = 355,
		["386"] = 351,
		["387"] = 350,
		["388"] = 349,
		["389"] = 350,
		["391"] = 350,
		["392"] = 359,
		["393"] = 368,
		["394"] = 359,
		["395"] = 368,
		["396"] = 372,
		["397"] = 373,
		["398"] = 374,
		["399"] = 375,
		["400"] = 372,
		["401"] = 377,
		["402"] = 378,
		["403"] = 379,
		["404"] = 380,
		["405"] = 381,
		["406"] = 382,
		["409"] = 385,
		["410"] = 386,
		["412"] = 388,
		["413"] = 389,
		["414"] = 389,
		["415"] = 389,
		["416"] = 389,
		["417"] = 389,
		["418"] = 389,
		["419"] = 389,
		["420"] = 389,
		["422"] = 377,
		["423"] = 392,
		["424"] = 393,
		["425"] = 394,
		["426"] = 395,
		["428"] = 392,
		["429"] = 398,
		["430"] = 399,
		["431"] = 400,
		["432"] = 401,
		["433"] = 402,
		["434"] = 402,
		["435"] = 402,
		["436"] = 402,
		["437"] = 402,
		["438"] = 402,
		["439"] = 403,
		["440"] = 403,
		["441"] = 403,
		["442"] = 403,
		["443"] = 403,
		["444"] = 403,
		["445"] = 403,
		["446"] = 403,
		["447"] = 403,
		["448"] = 403,
		["449"] = 404,
		["450"] = 405,
		["451"] = 406,
		["452"] = 406,
		["453"] = 406,
		["454"] = 406,
		["455"] = 406,
		["456"] = 407,
		["457"] = 407,
		["458"] = 407,
		["459"] = 407,
		["460"] = 407,
		["461"] = 407,
		["462"] = 407,
		["463"] = 407,
		["464"] = 407,
		["466"] = 398,
		["467"] = 368,
		["468"] = 359,
		["469"] = 359,
		["470"] = 359,
		["471"] = 359,
		["472"] = 359,
		["473"] = 359,
		["474"] = 359,
		["475"] = 359,
		["476"] = 359,
		["477"] = 368,
		["479"] = 368,
		["481"] = 417,
		["482"] = 418,
		["483"] = 417,
		["484"] = 418,
		["485"] = 419,
		["486"] = 420,
		["487"] = 419,
		["488"] = 418,
		["489"] = 417,
		["490"] = 418,
		["492"] = 418,
		["493"] = 423,
		["494"] = 432,
		["495"] = 423,
		["496"] = 432,
		["497"] = 434,
		["498"] = 435,
		["499"] = 434,
		["500"] = 437,
		["501"] = 438,
		["502"] = 437,
		["503"] = 432,
		["504"] = 423,
		["505"] = 423,
		["506"] = 423,
		["507"] = 423,
		["508"] = 423,
		["509"] = 423,
		["510"] = 423,
		["511"] = 423,
		["512"] = 423,
		["513"] = 432,
		["515"] = 432,
		["516"] = 444,
		["517"] = 452,
		["518"] = 444,
		["519"] = 452,
		["520"] = 455,
		["521"] = 456,
		["522"] = 457,
		["523"] = 455,
		["524"] = 459,
		["525"] = 460,
		["526"] = 461,
		["528"] = 459,
		["529"] = 464,
		["530"] = 465,
		["531"] = 466,
		["533"] = 464,
		["534"] = 469,
		["535"] = 470,
		["536"] = 469,
		["537"] = 475,
		["538"] = 476,
		["539"] = 475,
		["540"] = 478,
		["541"] = 479,
		["542"] = 478,
		["543"] = 452,
		["544"] = 444,
		["545"] = 444,
		["546"] = 444,
		["547"] = 444,
		["548"] = 444,
		["549"] = 444,
		["550"] = 444,
		["551"] = 444,
		["552"] = 452,
		["554"] = 452,
		["555"] = 483,
		["556"] = 491,
		["557"] = 483,
		["558"] = 491,
		["559"] = 492,
		["560"] = 493,
		["561"] = 492,
		["562"] = 491,
		["563"] = 483,
		["564"] = 483,
		["565"] = 483,
		["566"] = 483,
		["567"] = 483,
		["568"] = 483,
		["569"] = 483,
		["570"] = 483,
		["571"] = 491,
		["573"] = 491,
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
g.razor_talent = c()
local q = g.razor_talent
q.name = "razor_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_razor_talent"
end
q = e({ j(nil) }, q)
g.razor_talent = q
g.modifier_razor_talent = c()
local r = g.modifier_razor_talent
r.name = "modifier_razor_talent"
d(r, l)
function r.prototype.GetTexture(self)
	return "modifier_razor_talent"
end
function r.prototype.GetAbilitySpecialValue(self)
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
	self.talent_5_crit_chance = self:GetAbilityTalentValue("razor_talent_5", "crit_chance")
	self.talent_6_mana_regen_pct = self:GetAbilityTalentValue("razor_talent_6", "mana_regen_pct")
	self.talent_1_bonus_chance = self:GetAbilityTalentValue("razor_talent_1", "bonus_chance")
	self.talent_3_damage_pct = self:GetAbilityTalentValue("razor_talent_3", "damage_pct")
	self.tl7_injury_reduce = self:GetAbilityTalentValue("razor_talent_7", "injury_reduce")
	self.tl8_injury_count = self:GetAbilityTalentValue("razor_talent_8", "injury_count")
	self.tl10_mana = self:GetAbilityTalentValue("razor_talent_10", "mana")
	self.s_ability_chance = self:GetAbilityTalentValue("razor_shard", "ability_chance")
	self.s_magic_damage = self:GetAbilityTalentValue("razor_shard", "magic_damage")
	self.s_steal_health_pct = self:GetAbilityTalentValue("razor_shard", "steal_health_pct")
	self.g_talent_damage_bonus = self:GetAbilitySpecialValueFor("g_talent_damage_bonus")
	self.g_steal_damage = self:GetAbilitySpecialValueFor("g_steal_damage")
	self.g_steal_attackspeed = self:GetAbilitySpecialValueFor("g_steal_attackspeed")
	self.g_max_stack = self:GetAbilitySpecialValueFor("g_max_stack")
	self.g_max_duration = self:GetAbilitySpecialValueFor("g_max_duration")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_ATTENUATION_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function r.prototype.EOM_GetModifierInjuryAttenuationPercent(self, s)
	if self.tl7_injury_reduce > 0 and s.ability == self:GetAbility() then
		return -self.tl7_injury_reduce
	end
end
function r.prototype.EOM_GetModifierAbilityLifesteal(self, s)
	if self.s_steal_health_pct > 0 and s.ability == self.s_ability then
		return self.s_steal_health_pct
	end
	return 0
end
function r.prototype.EOM_GetModifierAttackDamageBonus(self, t)
	if self.g_steal_damage > 0 then
		return self:GetStackCount() * self.g_steal_damage
	end
end
function r.prototype.EOM_GetModifierAttackSpeedBonus(self, t)
	if self.g_steal_attackspeed > 0 then
		return self:GetStackCount() * self.g_steal_attackspeed
	end
end
function r.prototype.OnCustomTakeDamage(self, u)
	if self:HasTalent("razor_shard") and u.target == self:GetParent() then
		if self:PRD(self.s_ability_chance, "razor_shard") then
			local v = self:GetParent()
			local w = u.attacker
			local x = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_razor/razor_plasmafield.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				v
			)
			ParticleManager:SetParticleControl(x, 0, v:GetAbsOrigin())
			ParticleManager:SetParticleControl(x, 1, Vector(550, 550, 550))
			GameTimer(1.1, function()
				ParticleManager:SetParticleControl(x, 1, Vector(550, 0, 550))
				v:DealDamage(w, self.s_ability, self.s_magic_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				GameTimer(1.1, function()
					ParticleManager:DestroyParticle(x, true)
				end)
			end)
		end
	end
end
function r.prototype.OnBattleStartBefore(self, s)
	self.s_ability = self.parent:FindAbilityByName("razor_plasma_field")
	self:SetStackCount(0)
	if self.g_max_duration > 0 then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_razor_greevil_mana_loss", {})
	end
end
function r.prototype.OnInjuryGained(self)
	local v = self:GetParent()
	if v:PassivesDisabled() then
		return
	end
	local y = v:GetEnemy()
	local z = self:GetAbility()
	local A = IsInjurable(y)
	if A then
		local B = self:GetAbility()
		A = B and B:IsCooldownReady()
	end
	if A and self:PRD(self.chance + self.talent_1_bonus_chance, "razor_talent_1") then
		self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 200)
		local C = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_razor/razor_injury_effect.vpcf",
			PATTACH_CUSTOMORIGIN,
			v
		)
		ParticleManager:SetParticleControlEnt(C, 0, v, PATTACH_POINT_FOLLOW, "attach_static", v:GetAbsOrigin(), false)
		ParticleManager:SetParticleControlEnt(C, 1, y, PATTACH_POINT_FOLLOW, "attach_hitloc", y:GetAbsOrigin(), false)
		Projectile:CreateTrackingProjectile({
			hCaster = v,
			hTarget = y,
			iMoveSpeed = v:GetProjectileSpeed(),
			OnProjectileHit = function(D, E, F)
				if IsInjurable(v, y) then
					DamageSystem:dealDamage({
						attacker = v,
						target = y,
						ability = z,
						damage = self.base_damage + GetInjury(y) * (self.damage_pct + self.talent_3_damage_pct) * 0.01,
						damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
						damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
						damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
						is_crit = self:PRD(self.talent_5_crit_chance),
					})
					if self.tl8_injury_count > 0 then
						y:AddNewModifier(v, z, "modifier_razor_talent_8_buff", nil)
					end
					if self.g_talent_damage_bonus > 0 then
						DamageSystem:dealDamage({
							attacker = v,
							target = y,
							ability = z,
							damage = GetAttackDamage(v) * self.g_talent_damage_bonus * 0.01,
							damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
							damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
							damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
						})
					end
					if self.g_steal_damage > 0 and self:GetStackCount() < self.g_max_stack then
						self:SetStackCount(self:GetStackCount() + 1)
						y:AddNewModifier(v, z, "modifier_razor_greevil_debuff", {})
						if self:GetStackCount() >= self.g_max_stack then
							GameTimer(self.g_max_duration, function()
								if IsValid(self) then
									self:SetStackCount(0)
									local G = v:GetEnemy()
									if IsValid(G) then
										local H = G:FindModifierByName("modifier_razor_greevil_debuff")
										if H ~= nil then
											H:Destroy()
										end
									end
								end
							end)
						end
					end
					if self.tl10_mana > 0 then
						Restore(v, self.tl10_mana)
					end
					if self:HasTalent("razor_talent_9") then
						DamageSystem:performAttack(v, y)
					end
				end
			end,
		})
		if self.talent_6_mana_regen_pct > 0 then
			Restore(v, v:GetMaxMana() * self.talent_6_mana_regen_pct * 0.01)
		end
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
g.modifier_razor_talent = r
g.modifier_razor_shard_as = c()
local I = g.modifier_razor_shard_as
I.name = "modifier_razor_shard_as"
d(I, l)
function I.prototype.OnCreated(self, s)
	if IsServer() then
		local J = s and s.iAttackSpeed or 0
		if J > 0 then
			self:IncrementStackCount(J)
		end
	end
end
function I.prototype.OnRefresh(self, s)
	if IsServer() then
		local J = s and s.iAttackSpeed or 0
		if J > 0 then
			self:IncrementStackCount(J)
		end
	end
end
function I.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function I.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	return self:GetStackCount()
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
			}
		),
	},
	I
)
g.modifier_razor_shard_as = I
g.modifier_razor_shard_ad = c()
local K = g.modifier_razor_shard_ad
K.name = "modifier_razor_shard_ad"
d(K, l)
function K.prototype.OnCreated(self, s)
	if IsServer() then
		local J = s and s.iAttackDamage or 0
		if J > 0 then
			self:IncrementStackCount(J)
		end
	end
end
function K.prototype.OnRefresh(self, s)
	if IsServer() then
		local J = s and s.iAttackDamage or 0
		if J > 0 then
			self:IncrementStackCount(J)
		end
	end
end
function K.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function K.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	return self:GetStackCount()
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
			}
		),
	},
	K
)
g.modifier_razor_shard_ad = K
g.modifier_razor_talent_8_buff = c()
local L = g.modifier_razor_talent_8_buff
L.name = "modifier_razor_talent_8_buff"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.injury_count = self:GetAbilityTalentValue("razor_talent_8", "injury_count")
	self.max_count = self:GetAbilityTalentValue("razor_talent_8", "max_count")
end
function L.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(math.min(self:GetStackCount() + self.injury_count, self.max_count))
	end
end
function L.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetStackCount(math.min(self:GetStackCount() + self.injury_count, self.max_count))
	end
end
function L.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function L.prototype.EOM_GetModifierInjuryPermanent(self, s)
	return self:GetStackCount()
end
L = e(
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
			}
		),
	},
	L
)
g.modifier_razor_talent_8_buff = L
g.razor_ult = c()
local M = g.razor_ult
M.name = "razor_ult"
d(M, o)
function M.prototype.OnSpellStart(self)
	local N = self:GetCaster()
	local O = self:GetSpecialValueFor("duration") + self:GetTalentValue("razor_talent_2", "duration")
	N:AddNewModifier(N, self, "modifier_razor_ult", { duration = O })
	N:EmitSound("Hero_Razor.Storm.Cast")
end
M = e({ p(nil) }, M)
g.razor_ult = M
g.modifier_razor_ult = c()
local P = g.modifier_razor_ult
P.name = "modifier_razor_ult"
d(P, l)
function P.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("razor_talent_4", "interval_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.injury = self:GetAbilitySpecialValueFor("injury")
end
function P.prototype.OnCreated(self, s)
	local Q = self:GetParent()
	if IsServer() then
		if s.is_single then
			self:OnIntervalThink()
			self:Destroy()
			return
		end
		self:StartIntervalThink(self.interval)
		Q:EmitSound("Hero_Razor.Storm.Loop")
	else
		local R = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_razor/razor_rain_storm.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			Q
		)
		self:AddParticle(R, false, false, -1, false, false)
	end
end
function P.prototype.OnDestroy(self)
	if IsServer() and IsInjurable(self:GetParent()) then
		self:GetParent():StopSound("Hero_Razor.Storm.Loop")
		self:GetParent():EmitSound("Hero_Razor.StormEnd")
	end
end
function P.prototype.OnIntervalThink(self)
	local Q = self:GetParent()
	local S = Q:GetEnemy()
	if IsValid(S) then
		Q:DealDamage(S, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
		local T = AddInjury
		local U = self.injury
		local V = self:GetAbility()
		T(Q, S, U, V and V:GetAbilityName(), "Ability")
		Q:EmitSound("Hero_razor.lightning")
		local R = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf",
			PATTACH_CUSTOMORIGIN,
			Q
		)
		ParticleManager:SetParticleControl(R, 0, Q:GetAbsOrigin() + Vector(0, 0, 500))
		ParticleManager:SetParticleControlEnt(R, 1, S, PATTACH_POINT_FOLLOW, "attach_hitloc", S:GetAbsOrigin(), true)
	end
end
P = e(
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
	P
)
g.modifier_razor_ult = P
g.razor_talent_1 = c()
local W = g.razor_talent_1
W.name = "razor_talent_1"
d(W, i)
function W.prototype.GetIntrinsicModifierName(self)
	return "modifier_razor_talent_1"
end
W = e({ j(nil) }, W)
g.razor_talent_1 = W
g.modifier_razor_talent_1 = c()
local X = g.modifier_razor_talent_1
X.name = "modifier_razor_talent_1"
d(X, l)
function X.prototype.GetAbilitySpecialValue(self)
	self.attack_damage_bonus = self:GetAbilitySpecialValueFor("attack_damage_bonus")
end
function X.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.attack_damage_bonus }
end
X = e(
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
	X
)
g.modifier_razor_talent_1 = X
g.modifier_razor_greevil_debuff = c()
local Y = g.modifier_razor_greevil_debuff
Y.name = "modifier_razor_greevil_debuff"
d(Y, l)
function Y.prototype.GetAbilitySpecialValue(self)
	self.steal_damage = self:GetAbilitySpecialValueFor("g_steal_damage")
	self.steal_attackspeed = self:GetAbilitySpecialValueFor("g_steal_attackspeed")
end
function Y.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + 1)
	end
end
function Y.prototype.OnRefresh(self, s)
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + 1)
	end
end
function Y.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function Y.prototype.EOM_GetModifierAttackDamageBonus(self, t)
	return -self:GetStackCount() * self.steal_damage
end
function Y.prototype.EOM_GetModifierAttackSpeedBonus(self, t)
	return -self:GetStackCount() * self.steal_attackspeed
end
Y = e(
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
	Y
)
g.modifier_razor_greevil_debuff = Y
g.modifier_razor_greevil_mana_loss = c()
local Z = g.modifier_razor_greevil_mana_loss
Z.name = "modifier_razor_greevil_mana_loss"
d(Z, l)
function Z.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_LOSS_PERCENTAGE] = 999 }
end
Z = e(
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
	Z
)
g.modifier_razor_greevil_mana_loss = Z
return g