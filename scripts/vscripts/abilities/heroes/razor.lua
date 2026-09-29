--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/razor"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__Number
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 3,
		["16"] = 3,
		["17"] = 3,
		["18"] = 5,
		["19"] = 6,
		["20"] = 5,
		["21"] = 6,
		["22"] = 7,
		["23"] = 8,
		["24"] = 7,
		["25"] = 6,
		["26"] = 5,
		["27"] = 6,
		["29"] = 6,
		["30"] = 12,
		["31"] = 20,
		["32"] = 12,
		["33"] = 20,
		["34"] = 49,
		["35"] = 50,
		["36"] = 49,
		["37"] = 52,
		["38"] = 54,
		["39"] = 55,
		["40"] = 56,
		["41"] = 57,
		["42"] = 58,
		["43"] = 59,
		["44"] = 60,
		["45"] = 61,
		["46"] = 63,
		["47"] = 65,
		["48"] = 67,
		["49"] = 74,
		["50"] = 75,
		["51"] = 76,
		["52"] = 78,
		["53"] = 79,
		["54"] = 80,
		["55"] = 81,
		["56"] = 82,
		["57"] = 83,
		["58"] = 52,
		["59"] = 85,
		["60"] = 86,
		["61"] = 86,
		["62"] = 86,
		["63"] = 89,
		["64"] = 89,
		["65"] = 89,
		["66"] = 86,
		["67"] = 86,
		["68"] = 85,
		["69"] = 92,
		["70"] = 93,
		["71"] = 93,
		["72"] = 93,
		["73"] = 93,
		["74"] = 93,
		["75"] = 93,
		["76"] = 93,
		["77"] = 93,
		["78"] = 92,
		["79"] = 102,
		["80"] = 103,
		["81"] = 104,
		["83"] = 102,
		["84"] = 107,
		["85"] = 108,
		["86"] = 109,
		["88"] = 111,
		["89"] = 107,
		["90"] = 113,
		["91"] = 114,
		["92"] = 115,
		["94"] = 113,
		["95"] = 118,
		["96"] = 119,
		["97"] = 120,
		["99"] = 118,
		["100"] = 123,
		["101"] = 124,
		["102"] = 125,
		["103"] = 126,
		["104"] = 127,
		["105"] = 128,
		["106"] = 129,
		["107"] = 129,
		["108"] = 129,
		["109"] = 129,
		["110"] = 129,
		["111"] = 130,
		["112"] = 130,
		["113"] = 130,
		["114"] = 130,
		["115"] = 130,
		["116"] = 131,
		["117"] = 131,
		["118"] = 131,
		["119"] = 132,
		["120"] = 132,
		["121"] = 132,
		["122"] = 132,
		["123"] = 132,
		["124"] = 133,
		["125"] = 134,
		["126"] = 134,
		["127"] = 134,
		["128"] = 135,
		["129"] = 134,
		["130"] = 134,
		["131"] = 131,
		["132"] = 131,
		["135"] = 123,
		["136"] = 141,
		["137"] = 142,
		["138"] = 143,
		["139"] = 144,
		["140"] = 145,
		["141"] = 145,
		["142"] = 145,
		["143"] = 145,
		["144"] = 145,
		["145"] = 145,
		["147"] = 141,
		["148"] = 148,
		["149"] = 149,
		["150"] = 150,
		["153"] = 151,
		["154"] = 152,
		["155"] = 154,
		["157"] = 154,
		["158"] = 154,
		["160"] = 154,
		["161"] = 155,
		["162"] = 156,
		["163"] = 157,
		["164"] = 157,
		["165"] = 157,
		["166"] = 157,
		["167"] = 157,
		["168"] = 157,
		["169"] = 157,
		["170"] = 157,
		["171"] = 157,
		["172"] = 158,
		["173"] = 158,
		["174"] = 158,
		["175"] = 158,
		["176"] = 158,
		["177"] = 158,
		["178"] = 158,
		["179"] = 158,
		["180"] = 158,
		["181"] = 159,
		["182"] = 159,
		["183"] = 159,
		["184"] = 159,
		["185"] = 165,
		["186"] = 166,
		["187"] = 167,
		["188"] = 167,
		["189"] = 167,
		["190"] = 167,
		["191"] = 167,
		["192"] = 167,
		["193"] = 167,
		["194"] = 167,
		["195"] = 167,
		["196"] = 167,
		["197"] = 177,
		["198"] = 178,
		["200"] = 181,
		["201"] = 182,
		["202"] = 182,
		["203"] = 182,
		["204"] = 182,
		["205"] = 182,
		["206"] = 182,
		["207"] = 182,
		["208"] = 182,
		["209"] = 182,
		["211"] = 193,
		["212"] = 194,
		["213"] = 195,
		["214"] = 199,
		["215"] = 200,
		["216"] = 200,
		["217"] = 200,
		["218"] = 201,
		["219"] = 202,
		["220"] = 203,
		["221"] = 204,
		["222"] = 205,
		["224"] = 205,
		["228"] = 200,
		["229"] = 200,
		["232"] = 211,
		["233"] = 212,
		["235"] = 215,
		["236"] = 216,
		["239"] = 159,
		["240"] = 159,
		["241"] = 238,
		["242"] = 239,
		["243"] = 239,
		["244"] = 239,
		["245"] = 239,
		["248"] = 148,
		["249"] = 20,
		["250"] = 12,
		["251"] = 12,
		["252"] = 12,
		["253"] = 12,
		["254"] = 12,
		["255"] = 12,
		["256"] = 12,
		["257"] = 12,
		["258"] = 20,
		["260"] = 20,
		["261"] = 246,
		["262"] = 254,
		["263"] = 246,
		["264"] = 254,
		["265"] = 255,
		["266"] = 256,
		["267"] = 257,
		["268"] = 258,
		["269"] = 259,
		["272"] = 255,
		["273"] = 263,
		["274"] = 264,
		["275"] = 265,
		["276"] = 266,
		["277"] = 267,
		["280"] = 263,
		["281"] = 271,
		["282"] = 272,
		["283"] = 271,
		["284"] = 276,
		["285"] = 277,
		["286"] = 276,
		["287"] = 254,
		["288"] = 246,
		["289"] = 246,
		["290"] = 246,
		["291"] = 246,
		["292"] = 246,
		["293"] = 246,
		["294"] = 246,
		["295"] = 246,
		["296"] = 254,
		["298"] = 254,
		["299"] = 281,
		["300"] = 289,
		["301"] = 281,
		["302"] = 289,
		["303"] = 290,
		["304"] = 291,
		["305"] = 292,
		["306"] = 293,
		["307"] = 294,
		["310"] = 290,
		["311"] = 298,
		["312"] = 299,
		["313"] = 300,
		["314"] = 301,
		["315"] = 302,
		["318"] = 298,
		["319"] = 306,
		["320"] = 307,
		["321"] = 306,
		["322"] = 311,
		["323"] = 312,
		["324"] = 311,
		["325"] = 289,
		["326"] = 281,
		["327"] = 281,
		["328"] = 281,
		["329"] = 281,
		["330"] = 281,
		["331"] = 281,
		["332"] = 281,
		["333"] = 281,
		["334"] = 289,
		["336"] = 289,
		["337"] = 317,
		["338"] = 325,
		["339"] = 317,
		["340"] = 325,
		["341"] = 328,
		["342"] = 329,
		["343"] = 330,
		["344"] = 328,
		["345"] = 332,
		["346"] = 333,
		["347"] = 334,
		["348"] = 334,
		["349"] = 334,
		["350"] = 334,
		["352"] = 332,
		["353"] = 337,
		["354"] = 338,
		["355"] = 339,
		["356"] = 339,
		["357"] = 339,
		["358"] = 339,
		["360"] = 337,
		["361"] = 342,
		["362"] = 343,
		["363"] = 342,
		["364"] = 347,
		["365"] = 348,
		["366"] = 347,
		["367"] = 325,
		["368"] = 317,
		["369"] = 317,
		["370"] = 317,
		["371"] = 317,
		["372"] = 317,
		["373"] = 317,
		["374"] = 317,
		["375"] = 317,
		["376"] = 325,
		["378"] = 325,
		["379"] = 353,
		["380"] = 354,
		["381"] = 353,
		["382"] = 354,
		["383"] = 355,
		["384"] = 356,
		["385"] = 357,
		["386"] = 358,
		["387"] = 359,
		["388"] = 355,
		["389"] = 354,
		["390"] = 353,
		["391"] = 354,
		["393"] = 354,
		["394"] = 363,
		["395"] = 372,
		["396"] = 363,
		["397"] = 372,
		["398"] = 376,
		["399"] = 377,
		["400"] = 378,
		["401"] = 379,
		["402"] = 376,
		["403"] = 381,
		["404"] = 382,
		["405"] = 383,
		["406"] = 384,
		["407"] = 385,
		["408"] = 386,
		["411"] = 389,
		["412"] = 390,
		["414"] = 392,
		["415"] = 393,
		["416"] = 393,
		["417"] = 393,
		["418"] = 393,
		["419"] = 393,
		["420"] = 393,
		["421"] = 393,
		["422"] = 393,
		["424"] = 381,
		["425"] = 396,
		["426"] = 397,
		["427"] = 398,
		["428"] = 399,
		["430"] = 396,
		["431"] = 402,
		["432"] = 403,
		["433"] = 404,
		["434"] = 405,
		["435"] = 406,
		["436"] = 406,
		["437"] = 406,
		["438"] = 406,
		["439"] = 406,
		["440"] = 406,
		["441"] = 407,
		["442"] = 407,
		["443"] = 407,
		["444"] = 407,
		["445"] = 407,
		["446"] = 407,
		["447"] = 407,
		["448"] = 407,
		["449"] = 407,
		["450"] = 407,
		["451"] = 408,
		["452"] = 409,
		["453"] = 410,
		["454"] = 410,
		["455"] = 410,
		["456"] = 410,
		["457"] = 410,
		["458"] = 411,
		["459"] = 411,
		["460"] = 411,
		["461"] = 411,
		["462"] = 411,
		["463"] = 411,
		["464"] = 411,
		["465"] = 411,
		["466"] = 411,
		["468"] = 402,
		["469"] = 372,
		["470"] = 363,
		["471"] = 363,
		["472"] = 363,
		["473"] = 363,
		["474"] = 363,
		["475"] = 363,
		["476"] = 363,
		["477"] = 363,
		["478"] = 363,
		["479"] = 372,
		["481"] = 372,
		["483"] = 421,
		["484"] = 422,
		["485"] = 421,
		["486"] = 422,
		["487"] = 423,
		["488"] = 424,
		["489"] = 423,
		["490"] = 422,
		["491"] = 421,
		["492"] = 422,
		["494"] = 422,
		["495"] = 427,
		["496"] = 436,
		["497"] = 427,
		["498"] = 436,
		["499"] = 438,
		["500"] = 439,
		["501"] = 438,
		["502"] = 441,
		["503"] = 442,
		["504"] = 441,
		["505"] = 436,
		["506"] = 427,
		["507"] = 427,
		["508"] = 427,
		["509"] = 427,
		["510"] = 427,
		["511"] = 427,
		["512"] = 427,
		["513"] = 427,
		["514"] = 427,
		["515"] = 436,
		["517"] = 436,
		["518"] = 448,
		["519"] = 456,
		["520"] = 448,
		["521"] = 456,
		["523"] = 456,
		["524"] = 457,
		["525"] = 458,
		["526"] = 448,
		["527"] = 459,
		["528"] = 460,
		["529"] = 461,
		["530"] = 459,
		["531"] = 463,
		["532"] = 464,
		["533"] = 463,
		["534"] = 466,
		["535"] = 467,
		["536"] = 466,
		["537"] = 469,
		["538"] = 470,
		["539"] = 469,
		["540"] = 475,
		["541"] = 476,
		["542"] = 475,
		["543"] = 478,
		["544"] = 479,
		["545"] = 478,
		["546"] = 456,
		["547"] = 448,
		["548"] = 448,
		["549"] = 448,
		["550"] = 448,
		["551"] = 448,
		["552"] = 448,
		["553"] = 448,
		["554"] = 448,
		["555"] = 456,
		["557"] = 456,
		["558"] = 483,
		["559"] = 491,
		["560"] = 483,
		["561"] = 491,
		["562"] = 492,
		["563"] = 493,
		["565"] = 493,
		["567"] = 493,
		["568"] = 493,
		["569"] = 493,
		["571"] = 493,
		["572"] = 494,
		["573"] = 492,
		["574"] = 491,
		["575"] = 483,
		["576"] = 483,
		["577"] = 483,
		["578"] = 483,
		["579"] = 483,
		["580"] = 483,
		["581"] = 483,
		["582"] = 483,
		["583"] = 491,
		["585"] = 491,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
local o = require("abilities.ability_ai")
local p = o.BaseAbilityAI
local q = o.registerAbilityAI
h.razor_talent = c()
local r = h.razor_talent
r.name = "razor_talent"
d(r, j)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_razor_talent"
end
r = e({ k(nil) }, r)
h.razor_talent = r
h.modifier_razor_talent = c()
local s = h.modifier_razor_talent
s.name = "modifier_razor_talent"
d(s, m)
function s.prototype.GetTexture(self)
	return "modifier_razor_talent"
end
function s.prototype.GetAbilitySpecialValue(self)
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
	local t = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.g_talent_damage_bonus = (t and t:GetAbilityName()) == "trait_194"
			and t:GetSpecialValueFor("talent_damage_bonus")
		or 0
	self.g_steal_damage = (t and t:GetAbilityName()) == "trait_194" and t:GetSpecialValueFor("steal_damage") or 0
	self.g_steal_attackspeed = (t and t:GetAbilityName()) == "trait_194" and t:GetSpecialValueFor("steal_attackspeed")
		or 0
	self.g_max_stack = (t and t:GetAbilityName()) == "trait_194" and t:GetSpecialValueFor("max_stack") or 0
	self.g_max_duration = (t and t:GetAbilityName()) == "trait_194" and t:GetSpecialValueFor("max_duration") or 0
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function s.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_PHYSICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_ATTENUATION_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS_STEAL,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function s.prototype.EOM_GetModifierInjuryAttenuationPercent(self, u)
	if self.tl7_injury_reduce > 0 and u.ability == self:GetAbility() then
		return -self.tl7_injury_reduce
	end
end
function s.prototype.EOM_GetModifierAbilityLifesteal(self, u)
	if self.s_steal_health_pct > 0 and u.ability == self.s_ability then
		return self.s_steal_health_pct
	end
	return 0
end
function s.prototype.EOM_GetModifierAttackDamageBonusSteal(self, v)
	if self.g_steal_damage > 0 then
		return self:GetStackCount() * self.g_steal_damage
	end
end
function s.prototype.EOM_GetModifierAttackSpeedBonus(self, v)
	if self.g_steal_attackspeed > 0 then
		return self:GetStackCount() * self.g_steal_attackspeed
	end
end
function s.prototype.OnCustomTakeDamage(self, w)
	if self:HasTalent("razor_shard") and w.target == self:GetParent() then
		if self:PRD(self.s_ability_chance, "razor_shard") then
			local x = self:GetParent()
			local y = w.attacker
			local z = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_razor/razor_plasmafield.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				x
			)
			ParticleManager:SetParticleControl(z, 0, x:GetAbsOrigin())
			ParticleManager:SetParticleControl(z, 1, Vector(550, 550, 550))
			GameTimer(1.1, function()
				ParticleManager:SetParticleControl(z, 1, Vector(550, 0, 550))
				x:DealDamage(y, self.s_ability, self.s_magic_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				GameTimer(1.1, function()
					ParticleManager:DestroyParticle(z, true)
				end)
			end)
		end
	end
end
function s.prototype.OnBattleStartBefore(self, u)
	self.s_ability = self.parent:FindAbilityByName("razor_plasma_field")
	self:SetStackCount(0)
	if self.g_max_duration > 0 then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_razor_greevil_mana_loss", {})
	end
end
function s.prototype.OnInjuryGained(self)
	local x = self:GetParent()
	if x:PassivesDisabled() then
		return
	end
	local A = x:GetEnemy()
	local B = self:GetAbility()
	local C = IsInjurable(A)
	if C then
		local D = self:GetAbility()
		C = D and D:IsCooldownReady()
	end
	if C and self:PRD(self.chance + self.talent_1_bonus_chance, "razor_talent_1") then
		self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 200)
		local E = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_razor/razor_injury_effect.vpcf",
			PATTACH_CUSTOMORIGIN,
			x
		)
		ParticleManager:SetParticleControlEnt(E, 0, x, PATTACH_POINT_FOLLOW, "attach_static", x:GetAbsOrigin(), false)
		ParticleManager:SetParticleControlEnt(E, 1, A, PATTACH_POINT_FOLLOW, "attach_hitloc", A:GetAbsOrigin(), false)
		Projectile:CreateTrackingProjectile({
			hCaster = x,
			hTarget = A,
			iMoveSpeed = x:GetProjectileSpeed(),
			OnProjectileHit = function(F, G, H)
				if IsInjurable(x, A) then
					DamageSystem:dealDamage({
						attacker = x,
						target = A,
						ability = B,
						damage = self.base_damage + GetInjury(A) * (self.damage_pct + self.talent_3_damage_pct) * 0.01,
						damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
						damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
						damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
						is_crit = self:PRD(self.talent_5_crit_chance),
					})
					if self.tl8_injury_count > 0 then
						A:AddNewModifier(x, B, "modifier_razor_talent_8_buff", nil)
					end
					if self.g_talent_damage_bonus > 0 then
						DamageSystem:dealDamage({
							attacker = x,
							target = A,
							ability = B,
							damage = GetAttackDamage(x) * self.g_talent_damage_bonus * 0.01,
							damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
							damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
							damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
						})
					end
					if self.g_steal_damage > 0 and self:GetStackCount() < self.g_max_stack then
						self:SetStackCount(self:GetStackCount() + 1)
						A:AddNewModifier(
							x,
							B,
							"modifier_razor_greevil_debuff",
							{ steal_damage = self.g_steal_damage, steal_attackspeed = self.g_steal_attackspeed }
						)
						if self:GetStackCount() >= self.g_max_stack then
							GameTimer(self.g_max_duration, function()
								if IsValid(self) then
									self:SetStackCount(0)
									local I = x:GetEnemy()
									if IsValid(I) then
										local J = I:FindModifierByName("modifier_razor_greevil_debuff")
										if J ~= nil then
											J:Destroy()
										end
									end
								end
							end)
						end
					end
					if self.tl10_mana > 0 then
						Restore(x, self.tl10_mana)
					end
					if self:HasTalent("razor_talent_9") then
						DamageSystem:performAttack(x, A)
					end
				end
			end,
		})
		if self.talent_6_mana_regen_pct > 0 then
			Restore(x, x:GetMaxMana() * self.talent_6_mana_regen_pct * 0.01)
		end
	end
end
s = e(
	{
		n(
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
	s
)
h.modifier_razor_talent = s
h.modifier_razor_shard_as = c()
local K = h.modifier_razor_shard_as
K.name = "modifier_razor_shard_as"
d(K, m)
function K.prototype.OnCreated(self, u)
	if IsServer() then
		local L = u and u.iAttackSpeed or 0
		if L > 0 then
			self:IncrementStackCount(L)
		end
	end
end
function K.prototype.OnRefresh(self, u)
	if IsServer() then
		local L = u and u.iAttackSpeed or 0
		if L > 0 then
			self:IncrementStackCount(L)
		end
	end
end
function K.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function K.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	return self:GetStackCount()
end
K = e(
	{
		n(
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
h.modifier_razor_shard_as = K
h.modifier_razor_shard_ad = c()
local M = h.modifier_razor_shard_ad
M.name = "modifier_razor_shard_ad"
d(M, m)
function M.prototype.OnCreated(self, u)
	if IsServer() then
		local L = u and u.iAttackDamage or 0
		if L > 0 then
			self:IncrementStackCount(L)
		end
	end
end
function M.prototype.OnRefresh(self, u)
	if IsServer() then
		local L = u and u.iAttackDamage or 0
		if L > 0 then
			self:IncrementStackCount(L)
		end
	end
end
function M.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function M.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	return self:GetStackCount()
end
M = e(
	{
		n(
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
h.modifier_razor_shard_ad = M
h.modifier_razor_talent_8_buff = c()
local N = h.modifier_razor_talent_8_buff
N.name = "modifier_razor_talent_8_buff"
d(N, m)
function N.prototype.GetAbilitySpecialValue(self)
	self.injury_count = self:GetAbilityTalentValue("razor_talent_8", "injury_count")
	self.max_count = self:GetAbilityTalentValue("razor_talent_8", "max_count")
end
function N.prototype.OnCreated(self, u)
	if IsServer() then
		self:SetStackCount(math.min(self:GetStackCount() + self.injury_count, self.max_count))
	end
end
function N.prototype.OnRefresh(self, u)
	if IsServer() then
		self:SetStackCount(math.min(self:GetStackCount() + self.injury_count, self.max_count))
	end
end
function N.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function N.prototype.EOM_GetModifierInjuryPermanent(self, u)
	return self:GetStackCount()
end
N = e(
	{
		n(
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
	N
)
h.modifier_razor_talent_8_buff = N
h.razor_ult = c()
local O = h.razor_ult
O.name = "razor_ult"
d(O, p)
function O.prototype.OnSpellStart(self)
	local P = self:GetCaster()
	local Q = self:GetSpecialValueFor("duration") + self:GetTalentValue("razor_talent_2", "duration")
	P:AddNewModifier(P, self, "modifier_razor_ult", { duration = Q })
	P:EmitSound("Hero_Razor.Storm.Cast")
end
O = e({ q(nil) }, O)
h.razor_ult = O
h.modifier_razor_ult = c()
local R = h.modifier_razor_ult
R.name = "modifier_razor_ult"
d(R, m)
function R.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("razor_talent_4", "interval_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.injury = self:GetAbilitySpecialValueFor("injury")
end
function R.prototype.OnCreated(self, u)
	local S = self:GetParent()
	if IsServer() then
		if u.is_single then
			self:OnIntervalThink()
			self:Destroy()
			return
		end
		self:StartIntervalThink(self.interval)
		S:EmitSound("Hero_Razor.Storm.Loop")
	else
		local T = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_razor/razor_rain_storm.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			S
		)
		self:AddParticle(T, false, false, -1, false, false)
	end
end
function R.prototype.OnDestroy(self)
	if IsServer() and IsInjurable(self:GetParent()) then
		self:GetParent():StopSound("Hero_Razor.Storm.Loop")
		self:GetParent():EmitSound("Hero_Razor.StormEnd")
	end
end
function R.prototype.OnIntervalThink(self)
	local S = self:GetParent()
	local U = S:GetEnemy()
	if IsValid(U) then
		S:DealDamage(U, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
		local V = AddInjury
		local W = self.injury
		local X = self:GetAbility()
		V(S, U, W, X and X:GetAbilityName(), "Ability")
		S:EmitSound("Hero_razor.lightning")
		local T = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf",
			PATTACH_CUSTOMORIGIN,
			S
		)
		ParticleManager:SetParticleControl(T, 0, S:GetAbsOrigin() + Vector(0, 0, 500))
		ParticleManager:SetParticleControlEnt(T, 1, U, PATTACH_POINT_FOLLOW, "attach_hitloc", U:GetAbsOrigin(), true)
	end
end
R = e(
	{
		n(
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
	R
)
h.modifier_razor_ult = R
h.razor_talent_1 = c()
local Y = h.razor_talent_1
Y.name = "razor_talent_1"
d(Y, j)
function Y.prototype.GetIntrinsicModifierName(self)
	return "modifier_razor_talent_1"
end
Y = e({ k(nil) }, Y)
h.razor_talent_1 = Y
h.modifier_razor_talent_1 = c()
local Z = h.modifier_razor_talent_1
Z.name = "modifier_razor_talent_1"
d(Z, m)
function Z.prototype.GetAbilitySpecialValue(self)
	self.attack_damage_bonus = self:GetAbilitySpecialValueFor("attack_damage_bonus")
end
function Z.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.attack_damage_bonus }
end
Z = e(
	{
		n(
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
	Z
)
h.modifier_razor_talent_1 = Z
h.modifier_razor_greevil_debuff = c()
local _ = h.modifier_razor_greevil_debuff
_.name = "modifier_razor_greevil_debuff"
d(_, m)
function _.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.steal_damage = 0
	self.steal_attackspeed = 0
end
function _.prototype.GetAbilitySpecialValue(self)
	self.steal_damage = self:GetAbilityTalentValue("trait_194", "steal_damage") or 0
	self.steal_attackspeed = self:GetAbilityTalentValue("trait_194", "steal_attackspeed") or 0
end
function _.prototype.OnCreated(self, u)
	self:SetStackCount(self:GetStackCount() + 1)
end
function _.prototype.OnRefresh(self, u)
	self:SetStackCount(self:GetStackCount() + 1)
end
function _.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function _.prototype.EOM_GetModifierAttackDamageBonus(self, v)
	return -self:GetStackCount() * self.steal_damage
end
function _.prototype.EOM_GetModifierAttackSpeedBonus(self, v)
	return -self:GetStackCount() * self.steal_attackspeed
end
_ = e(
	{
		n(
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
h.modifier_razor_greevil_debuff = _
h.modifier_razor_greevil_mana_loss = c()
local a0 = h.modifier_razor_greevil_mana_loss
a0.name = "modifier_razor_greevil_mana_loss"
d(a0, m)
function a0.prototype.EFunctionValues(self)
	local a1 = KeyValues.UnitsKv[self:GetParent():GetUnitName()]
	if a1 ~= nil then
		a1 = a1.ManaRegen
	end
	local a2 = a1
	if a2 == nil then
		a2 = 0
	end
	local a3 = a2
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE] = f(-a3) }
end
a0 = e(
	{
		n(
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
	a0
)
h.modifier_razor_greevil_mana_loss = a0
return h