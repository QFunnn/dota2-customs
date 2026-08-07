--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
		["56"] = 83,
		["57"] = 52,
		["58"] = 85,
		["59"] = 86,
		["60"] = 86,
		["61"] = 86,
		["62"] = 89,
		["63"] = 89,
		["64"] = 89,
		["65"] = 86,
		["66"] = 86,
		["67"] = 85,
		["68"] = 92,
		["69"] = 93,
		["70"] = 93,
		["71"] = 93,
		["72"] = 93,
		["73"] = 93,
		["74"] = 93,
		["75"] = 93,
		["76"] = 93,
		["77"] = 92,
		["78"] = 102,
		["79"] = 103,
		["80"] = 104,
		["82"] = 102,
		["83"] = 107,
		["84"] = 108,
		["85"] = 109,
		["87"] = 111,
		["88"] = 107,
		["89"] = 113,
		["90"] = 114,
		["91"] = 115,
		["93"] = 113,
		["94"] = 118,
		["95"] = 119,
		["96"] = 120,
		["98"] = 118,
		["99"] = 123,
		["100"] = 124,
		["101"] = 125,
		["102"] = 126,
		["103"] = 127,
		["104"] = 128,
		["105"] = 129,
		["106"] = 129,
		["107"] = 129,
		["108"] = 129,
		["109"] = 129,
		["110"] = 130,
		["111"] = 130,
		["112"] = 130,
		["113"] = 130,
		["114"] = 130,
		["115"] = 131,
		["116"] = 131,
		["117"] = 131,
		["118"] = 132,
		["119"] = 132,
		["120"] = 132,
		["121"] = 132,
		["122"] = 132,
		["123"] = 133,
		["124"] = 134,
		["125"] = 134,
		["126"] = 134,
		["127"] = 135,
		["128"] = 134,
		["129"] = 134,
		["130"] = 131,
		["131"] = 131,
		["134"] = 123,
		["135"] = 141,
		["136"] = 142,
		["137"] = 143,
		["138"] = 144,
		["139"] = 145,
		["140"] = 145,
		["141"] = 145,
		["142"] = 145,
		["143"] = 145,
		["144"] = 145,
		["146"] = 141,
		["147"] = 148,
		["148"] = 149,
		["149"] = 150,
		["152"] = 151,
		["153"] = 152,
		["154"] = 154,
		["156"] = 154,
		["157"] = 154,
		["159"] = 154,
		["160"] = 155,
		["161"] = 156,
		["162"] = 157,
		["163"] = 157,
		["164"] = 157,
		["165"] = 157,
		["166"] = 157,
		["167"] = 157,
		["168"] = 157,
		["169"] = 157,
		["170"] = 157,
		["171"] = 158,
		["172"] = 158,
		["173"] = 158,
		["174"] = 158,
		["175"] = 158,
		["176"] = 158,
		["177"] = 158,
		["178"] = 158,
		["179"] = 158,
		["180"] = 159,
		["181"] = 159,
		["182"] = 159,
		["183"] = 159,
		["184"] = 165,
		["185"] = 166,
		["186"] = 167,
		["187"] = 167,
		["188"] = 167,
		["189"] = 167,
		["190"] = 167,
		["191"] = 167,
		["192"] = 167,
		["193"] = 167,
		["194"] = 167,
		["195"] = 167,
		["196"] = 177,
		["197"] = 178,
		["199"] = 181,
		["200"] = 182,
		["201"] = 182,
		["202"] = 182,
		["203"] = 182,
		["204"] = 182,
		["205"] = 182,
		["206"] = 182,
		["207"] = 182,
		["208"] = 182,
		["210"] = 193,
		["211"] = 194,
		["212"] = 195,
		["213"] = 199,
		["214"] = 200,
		["215"] = 200,
		["216"] = 200,
		["217"] = 201,
		["218"] = 202,
		["219"] = 203,
		["220"] = 204,
		["221"] = 205,
		["223"] = 205,
		["227"] = 200,
		["228"] = 200,
		["231"] = 211,
		["232"] = 212,
		["234"] = 215,
		["235"] = 216,
		["238"] = 159,
		["239"] = 159,
		["240"] = 238,
		["241"] = 239,
		["242"] = 239,
		["243"] = 239,
		["244"] = 239,
		["247"] = 148,
		["248"] = 20,
		["249"] = 12,
		["250"] = 12,
		["251"] = 12,
		["252"] = 12,
		["253"] = 12,
		["254"] = 12,
		["255"] = 12,
		["256"] = 12,
		["257"] = 20,
		["259"] = 20,
		["260"] = 246,
		["261"] = 254,
		["262"] = 246,
		["263"] = 254,
		["264"] = 255,
		["265"] = 256,
		["266"] = 257,
		["267"] = 258,
		["268"] = 259,
		["271"] = 255,
		["272"] = 263,
		["273"] = 264,
		["274"] = 265,
		["275"] = 266,
		["276"] = 267,
		["279"] = 263,
		["280"] = 271,
		["281"] = 272,
		["282"] = 271,
		["283"] = 276,
		["284"] = 277,
		["285"] = 276,
		["286"] = 254,
		["287"] = 246,
		["288"] = 246,
		["289"] = 246,
		["290"] = 246,
		["291"] = 246,
		["292"] = 246,
		["293"] = 246,
		["294"] = 246,
		["295"] = 254,
		["297"] = 254,
		["298"] = 281,
		["299"] = 289,
		["300"] = 281,
		["301"] = 289,
		["302"] = 290,
		["303"] = 291,
		["304"] = 292,
		["305"] = 293,
		["306"] = 294,
		["309"] = 290,
		["310"] = 298,
		["311"] = 299,
		["312"] = 300,
		["313"] = 301,
		["314"] = 302,
		["317"] = 298,
		["318"] = 306,
		["319"] = 307,
		["320"] = 306,
		["321"] = 311,
		["322"] = 312,
		["323"] = 311,
		["324"] = 289,
		["325"] = 281,
		["326"] = 281,
		["327"] = 281,
		["328"] = 281,
		["329"] = 281,
		["330"] = 281,
		["331"] = 281,
		["332"] = 281,
		["333"] = 289,
		["335"] = 289,
		["336"] = 317,
		["337"] = 325,
		["338"] = 317,
		["339"] = 325,
		["340"] = 328,
		["341"] = 329,
		["342"] = 330,
		["343"] = 328,
		["344"] = 332,
		["345"] = 333,
		["346"] = 334,
		["347"] = 334,
		["348"] = 334,
		["349"] = 334,
		["351"] = 332,
		["352"] = 337,
		["353"] = 338,
		["354"] = 339,
		["355"] = 339,
		["356"] = 339,
		["357"] = 339,
		["359"] = 337,
		["360"] = 342,
		["361"] = 343,
		["362"] = 342,
		["363"] = 347,
		["364"] = 348,
		["365"] = 347,
		["366"] = 325,
		["367"] = 317,
		["368"] = 317,
		["369"] = 317,
		["370"] = 317,
		["371"] = 317,
		["372"] = 317,
		["373"] = 317,
		["374"] = 317,
		["375"] = 325,
		["377"] = 325,
		["378"] = 353,
		["379"] = 354,
		["380"] = 353,
		["381"] = 354,
		["382"] = 355,
		["383"] = 356,
		["384"] = 357,
		["385"] = 358,
		["386"] = 359,
		["387"] = 355,
		["388"] = 354,
		["389"] = 353,
		["390"] = 354,
		["392"] = 354,
		["393"] = 363,
		["394"] = 372,
		["395"] = 363,
		["396"] = 372,
		["397"] = 376,
		["398"] = 377,
		["399"] = 378,
		["400"] = 379,
		["401"] = 376,
		["402"] = 381,
		["403"] = 382,
		["404"] = 383,
		["405"] = 384,
		["406"] = 385,
		["407"] = 386,
		["410"] = 389,
		["411"] = 390,
		["413"] = 392,
		["414"] = 393,
		["415"] = 393,
		["416"] = 393,
		["417"] = 393,
		["418"] = 393,
		["419"] = 393,
		["420"] = 393,
		["421"] = 393,
		["423"] = 381,
		["424"] = 396,
		["425"] = 397,
		["426"] = 398,
		["427"] = 399,
		["429"] = 396,
		["430"] = 402,
		["431"] = 403,
		["432"] = 404,
		["433"] = 405,
		["434"] = 406,
		["435"] = 406,
		["436"] = 406,
		["437"] = 406,
		["438"] = 406,
		["439"] = 406,
		["440"] = 407,
		["441"] = 407,
		["442"] = 407,
		["443"] = 407,
		["444"] = 407,
		["445"] = 407,
		["446"] = 407,
		["447"] = 407,
		["448"] = 407,
		["449"] = 407,
		["450"] = 408,
		["451"] = 409,
		["452"] = 410,
		["453"] = 410,
		["454"] = 410,
		["455"] = 410,
		["456"] = 410,
		["457"] = 411,
		["458"] = 411,
		["459"] = 411,
		["460"] = 411,
		["461"] = 411,
		["462"] = 411,
		["463"] = 411,
		["464"] = 411,
		["465"] = 411,
		["467"] = 402,
		["468"] = 372,
		["469"] = 363,
		["470"] = 363,
		["471"] = 363,
		["472"] = 363,
		["473"] = 363,
		["474"] = 363,
		["475"] = 363,
		["476"] = 363,
		["477"] = 363,
		["478"] = 372,
		["480"] = 372,
		["482"] = 421,
		["483"] = 422,
		["484"] = 421,
		["485"] = 422,
		["486"] = 423,
		["487"] = 424,
		["488"] = 423,
		["489"] = 422,
		["490"] = 421,
		["491"] = 422,
		["493"] = 422,
		["494"] = 427,
		["495"] = 436,
		["496"] = 427,
		["497"] = 436,
		["498"] = 438,
		["499"] = 439,
		["500"] = 438,
		["501"] = 441,
		["502"] = 442,
		["503"] = 441,
		["504"] = 436,
		["505"] = 427,
		["506"] = 427,
		["507"] = 427,
		["508"] = 427,
		["509"] = 427,
		["510"] = 427,
		["511"] = 427,
		["512"] = 427,
		["513"] = 427,
		["514"] = 436,
		["516"] = 436,
		["517"] = 448,
		["518"] = 456,
		["519"] = 448,
		["520"] = 456,
		["521"] = 459,
		["522"] = 460,
		["523"] = 461,
		["524"] = 462,
		["525"] = 463,
		["527"] = 459,
		["528"] = 466,
		["529"] = 467,
		["530"] = 468,
		["532"] = 466,
		["533"] = 471,
		["534"] = 472,
		["535"] = 471,
		["536"] = 477,
		["537"] = 478,
		["538"] = 477,
		["539"] = 480,
		["540"] = 481,
		["541"] = 480,
		["542"] = 456,
		["543"] = 448,
		["544"] = 448,
		["545"] = 448,
		["546"] = 448,
		["547"] = 448,
		["548"] = 448,
		["549"] = 448,
		["550"] = 448,
		["551"] = 456,
		["553"] = 456,
		["554"] = 485,
		["555"] = 493,
		["556"] = 485,
		["557"] = 493,
		["558"] = 494,
		["559"] = 495,
		["560"] = 494,
		["561"] = 493,
		["562"] = 485,
		["563"] = 485,
		["564"] = 485,
		["565"] = 485,
		["566"] = 485,
		["567"] = 485,
		["568"] = 485,
		["569"] = 485,
		["570"] = 493,
		["572"] = 493,
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
	local s = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.g_talent_damage_bonus = (s and s:GetAbilityName()) == "trait_194"
			and s:GetSpecialValueFor("talent_damage_bonus")
		or 0
	self.g_steal_damage = (s and s:GetAbilityName()) == "trait_194" and s:GetSpecialValueFor("steal_damage") or 0
	self.g_steal_attackspeed = (s and s:GetAbilityName()) == "trait_194" and s:GetSpecialValueFor("steal_attackspeed")
		or 0
	self.g_max_stack = (s and s:GetAbilityName()) == "trait_194" and s:GetSpecialValueFor("max_stack") or 0
	self.g_max_duration = (s and s:GetAbilityName()) == "trait_194" and s:GetSpecialValueFor("max_duration") or 0
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
function r.prototype.EOM_GetModifierInjuryAttenuationPercent(self, t)
	if self.tl7_injury_reduce > 0 and t.ability == self:GetAbility() then
		return -self.tl7_injury_reduce
	end
end
function r.prototype.EOM_GetModifierAbilityLifesteal(self, t)
	if self.s_steal_health_pct > 0 and t.ability == self.s_ability then
		return self.s_steal_health_pct
	end
	return 0
end
function r.prototype.EOM_GetModifierAttackDamageBonus(self, u)
	if self.g_steal_damage > 0 then
		return self:GetStackCount() * self.g_steal_damage
	end
end
function r.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	if self.g_steal_attackspeed > 0 then
		return self:GetStackCount() * self.g_steal_attackspeed
	end
end
function r.prototype.OnCustomTakeDamage(self, v)
	if self:HasTalent("razor_shard") and v.target == self:GetParent() then
		if self:PRD(self.s_ability_chance, "razor_shard") then
			local w = self:GetParent()
			local x = v.attacker
			local y = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_razor/razor_plasmafield.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				w
			)
			ParticleManager:SetParticleControl(y, 0, w:GetAbsOrigin())
			ParticleManager:SetParticleControl(y, 1, Vector(550, 550, 550))
			GameTimer(1.1, function()
				ParticleManager:SetParticleControl(y, 1, Vector(550, 0, 550))
				w:DealDamage(x, self.s_ability, self.s_magic_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				GameTimer(1.1, function()
					ParticleManager:DestroyParticle(y, true)
				end)
			end)
		end
	end
end
function r.prototype.OnBattleStartBefore(self, t)
	self.s_ability = self.parent:FindAbilityByName("razor_plasma_field")
	self:SetStackCount(0)
	if self.g_max_duration > 0 then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_razor_greevil_mana_loss", {})
	end
end
function r.prototype.OnInjuryGained(self)
	local w = self:GetParent()
	if w:PassivesDisabled() then
		return
	end
	local z = w:GetEnemy()
	local A = self:GetAbility()
	local B = IsInjurable(z)
	if B then
		local C = self:GetAbility()
		B = C and C:IsCooldownReady()
	end
	if B and self:PRD(self.chance + self.talent_1_bonus_chance, "razor_talent_1") then
		self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 200)
		local D = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_razor/razor_injury_effect.vpcf",
			PATTACH_CUSTOMORIGIN,
			w
		)
		ParticleManager:SetParticleControlEnt(D, 0, w, PATTACH_POINT_FOLLOW, "attach_static", w:GetAbsOrigin(), false)
		ParticleManager:SetParticleControlEnt(D, 1, z, PATTACH_POINT_FOLLOW, "attach_hitloc", z:GetAbsOrigin(), false)
		Projectile:CreateTrackingProjectile({
			hCaster = w,
			hTarget = z,
			iMoveSpeed = w:GetProjectileSpeed(),
			OnProjectileHit = function(E, F, G)
				if IsInjurable(w, z) then
					DamageSystem:dealDamage({
						attacker = w,
						target = z,
						ability = A,
						damage = self.base_damage + GetInjury(z) * (self.damage_pct + self.talent_3_damage_pct) * 0.01,
						damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
						damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
						damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
						is_crit = self:PRD(self.talent_5_crit_chance),
					})
					if self.tl8_injury_count > 0 then
						z:AddNewModifier(w, A, "modifier_razor_talent_8_buff", nil)
					end
					if self.g_talent_damage_bonus > 0 then
						DamageSystem:dealDamage({
							attacker = w,
							target = z,
							ability = A,
							damage = GetAttackDamage(w) * self.g_talent_damage_bonus * 0.01,
							damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
							damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
							damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
						})
					end
					if self.g_steal_damage > 0 and self:GetStackCount() < self.g_max_stack then
						self:SetStackCount(self:GetStackCount() + 1)
						z:AddNewModifier(
							w,
							A,
							"modifier_razor_greevil_debuff",
							{ steal_damage = self.g_steal_damage, steal_attackspeed = self.g_steal_attackspeed }
						)
						if self:GetStackCount() >= self.g_max_stack then
							GameTimer(self.g_max_duration, function()
								if IsValid(self) then
									self:SetStackCount(0)
									local H = w:GetEnemy()
									if IsValid(H) then
										local I = H:FindModifierByName("modifier_razor_greevil_debuff")
										if I ~= nil then
											I:Destroy()
										end
									end
								end
							end)
						end
					end
					if self.tl10_mana > 0 then
						Restore(w, self.tl10_mana)
					end
					if self:HasTalent("razor_talent_9") then
						DamageSystem:performAttack(w, z)
					end
				end
			end,
		})
		if self.talent_6_mana_regen_pct > 0 then
			Restore(w, w:GetMaxMana() * self.talent_6_mana_regen_pct * 0.01)
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
local J = g.modifier_razor_shard_as
J.name = "modifier_razor_shard_as"
d(J, l)
function J.prototype.OnCreated(self, t)
	if IsServer() then
		local K = t and t.iAttackSpeed or 0
		if K > 0 then
			self:IncrementStackCount(K)
		end
	end
end
function J.prototype.OnRefresh(self, t)
	if IsServer() then
		local K = t and t.iAttackSpeed or 0
		if K > 0 then
			self:IncrementStackCount(K)
		end
	end
end
function J.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function J.prototype.EOM_GetModifierAttackSpeedBonus(self, t)
	return self:GetStackCount()
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
			}
		),
	},
	J
)
g.modifier_razor_shard_as = J
g.modifier_razor_shard_ad = c()
local L = g.modifier_razor_shard_ad
L.name = "modifier_razor_shard_ad"
d(L, l)
function L.prototype.OnCreated(self, t)
	if IsServer() then
		local K = t and t.iAttackDamage or 0
		if K > 0 then
			self:IncrementStackCount(K)
		end
	end
end
function L.prototype.OnRefresh(self, t)
	if IsServer() then
		local K = t and t.iAttackDamage or 0
		if K > 0 then
			self:IncrementStackCount(K)
		end
	end
end
function L.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function L.prototype.EOM_GetModifierAttackSpeedBonus(self, t)
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
g.modifier_razor_shard_ad = L
g.modifier_razor_talent_8_buff = c()
local M = g.modifier_razor_talent_8_buff
M.name = "modifier_razor_talent_8_buff"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.injury_count = self:GetAbilityTalentValue("razor_talent_8", "injury_count")
	self.max_count = self:GetAbilityTalentValue("razor_talent_8", "max_count")
end
function M.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(math.min(self:GetStackCount() + self.injury_count, self.max_count))
	end
end
function M.prototype.OnRefresh(self, t)
	if IsServer() then
		self:SetStackCount(math.min(self:GetStackCount() + self.injury_count, self.max_count))
	end
end
function M.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function M.prototype.EOM_GetModifierInjuryPermanent(self, t)
	return self:GetStackCount()
end
M = e(
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
	M
)
g.modifier_razor_talent_8_buff = M
g.razor_ult = c()
local N = g.razor_ult
N.name = "razor_ult"
d(N, o)
function N.prototype.OnSpellStart(self)
	local O = self:GetCaster()
	local P = self:GetSpecialValueFor("duration") + self:GetTalentValue("razor_talent_2", "duration")
	O:AddNewModifier(O, self, "modifier_razor_ult", { duration = P })
	O:EmitSound("Hero_Razor.Storm.Cast")
end
N = e({ p(nil) }, N)
g.razor_ult = N
g.modifier_razor_ult = c()
local Q = g.modifier_razor_ult
Q.name = "modifier_razor_ult"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("razor_talent_4", "interval_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.injury = self:GetAbilitySpecialValueFor("injury")
end
function Q.prototype.OnCreated(self, t)
	local R = self:GetParent()
	if IsServer() then
		if t.is_single then
			self:OnIntervalThink()
			self:Destroy()
			return
		end
		self:StartIntervalThink(self.interval)
		R:EmitSound("Hero_Razor.Storm.Loop")
	else
		local S = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_razor/razor_rain_storm.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			R
		)
		self:AddParticle(S, false, false, -1, false, false)
	end
end
function Q.prototype.OnDestroy(self)
	if IsServer() and IsInjurable(self:GetParent()) then
		self:GetParent():StopSound("Hero_Razor.Storm.Loop")
		self:GetParent():EmitSound("Hero_Razor.StormEnd")
	end
end
function Q.prototype.OnIntervalThink(self)
	local R = self:GetParent()
	local T = R:GetEnemy()
	if IsValid(T) then
		R:DealDamage(T, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
		local U = AddInjury
		local V = self.injury
		local W = self:GetAbility()
		U(R, T, V, W and W:GetAbilityName(), "Ability")
		R:EmitSound("Hero_razor.lightning")
		local S = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf",
			PATTACH_CUSTOMORIGIN,
			R
		)
		ParticleManager:SetParticleControl(S, 0, R:GetAbsOrigin() + Vector(0, 0, 500))
		ParticleManager:SetParticleControlEnt(S, 1, T, PATTACH_POINT_FOLLOW, "attach_hitloc", T:GetAbsOrigin(), true)
	end
end
Q = e(
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
	Q
)
g.modifier_razor_ult = Q
g.razor_talent_1 = c()
local X = g.razor_talent_1
X.name = "razor_talent_1"
d(X, i)
function X.prototype.GetIntrinsicModifierName(self)
	return "modifier_razor_talent_1"
end
X = e({ j(nil) }, X)
g.razor_talent_1 = X
g.modifier_razor_talent_1 = c()
local Y = g.modifier_razor_talent_1
Y.name = "modifier_razor_talent_1"
d(Y, l)
function Y.prototype.GetAbilitySpecialValue(self)
	self.attack_damage_bonus = self:GetAbilitySpecialValueFor("attack_damage_bonus")
end
function Y.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.attack_damage_bonus }
end
Y = e(
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
	Y
)
g.modifier_razor_talent_1 = Y
g.modifier_razor_greevil_debuff = c()
local Z = g.modifier_razor_greevil_debuff
Z.name = "modifier_razor_greevil_debuff"
d(Z, l)
function Z.prototype.OnCreated(self, t)
	self.steal_damage = t.steal_damage
	self.steal_attackspeed = t.steal_attackspeed
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + 1)
	end
end
function Z.prototype.OnRefresh(self, t)
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + 1)
	end
end
function Z.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function Z.prototype.EOM_GetModifierAttackDamageBonus(self, u)
	return -self:GetStackCount() * self.steal_damage
end
function Z.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	return -self:GetStackCount() * self.steal_attackspeed
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
g.modifier_razor_greevil_debuff = Z
g.modifier_razor_greevil_mana_loss = c()
local _ = g.modifier_razor_greevil_mana_loss
_.name = "modifier_razor_greevil_mana_loss"
d(_, l)
function _.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_LOSS_PERCENTAGE] = 999 }
end
_ = e(
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
	_
)
g.modifier_razor_greevil_mana_loss = _
return g