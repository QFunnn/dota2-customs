--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
____exports.axe_006 = __TS__Class()
local axe_006 = ____exports.axe_006
axe_006.name = "axe_006"
__TS__ClassExtends(axe_006, BaseHeroAbility)
function axe_006.prototype.GetAbilityConfig(self)
	return {
		castPoint = 0.2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		animationPlaybackRate = 1,
	}
end
function axe_006.prototype.OnAbilityPhaseStart(self)
	if not IsServer() then
		return true
	end
	self._caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_2, 1)
	return true
end
function axe_006.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local buffDuration = self:GetSpecialValue("axe_006", "buff_duration")
	____exports.modifier_axe_006_berserk:applys(caster, caster, self, { duration = buffDuration })
	caster:EmitSound("Hero_Axe.Battle_Hunger")
	caster:EmitSound("Hero_LegionCommander.PressTheAttack")
	ScreenShake(caster:GetAbsOrigin(), 100, 100, 0.3, 1000, 0, true)
	local shockRadius = self:GetSpecialValue("axe_006", "shock_radius")
	local vulnerableDuration = self:GetSpecialValue("axe_006", "vulnerable_duration")
	local enemies = self:FindMonsterEnemies(caster:GetAbsOrigin(), shockRadius)
	__TS__ArrayForEach(enemies, function(____, enemy)
		if not IsValidAlive(nil, enemy) then
			return
		end
		AddDeBuffStatus(
			nil,
			enemy,
			caster,
			self,
			DebuffStatusType.VULNERABLE,
			{ stack = 5, duration = vulnerableDuration }
		)
	end)
	self:PlayEffect()
end
function axe_006.prototype.PlayEffect(self)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/axe/ability/life_stealer_infest_emerge_bloody.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self._caster,
		self._caster
	)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, self._caster:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 1, Vector(400, 400, 400))
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
end
axe_006 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_006)
____exports.axe_006 = axe_006
____exports.modifier_axe_006_berserk = __TS__Class()
local modifier_axe_006_berserk = ____exports.modifier_axe_006_berserk
modifier_axe_006_berserk.name = "modifier_axe_006_berserk"
__TS__ClassExtends(modifier_axe_006_berserk, BaseHeroModifier)
function modifier_axe_006_berserk.GetLocalizationCN(self)
	return {
		name = "狂暴之怒",
		description = "免疫大多数负面效果并大幅提高负面抗性；提升最大生命值与基础护甲，并减少承受伤害。",
	}
end
function modifier_axe_006_berserk.prototype.PlayEffect1(self)
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_legion_commander/legion_commander_press_owner.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 1, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		pfx,
		2,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(pfx, 3, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 4, self:GetParent():GetAbsOrigin())
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_axe_006_berserk.prototype.PlayEffect2(self)
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_centaur/centaur_return_buff.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 1, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 2, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 3, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 4, self:GetParent():GetAbsOrigin())
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_axe_006_berserk.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:PlayBurstImmuneFx()
	self:PlayEffect1()
	self:PlayEffect2()
end
function modifier_axe_006_berserk.prototype.PlayBurstImmuneFx(self)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_legion_commander/legion_commander_odds_dmgb.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent(),
		self:GetCaster()
	)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 1, self:GetParent():GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 2, self:GetParent():GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 3, self:GetParent():GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(pfx, 4, self:GetParent():GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_axe_006_berserk.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_axe_006_berserk.prototype.GetAttributeBonus(self)
	local bonusPct = self:GetSpecialValue("axe_006", "buff_bonus_max_health_pct")
	return {
		debuff_resistance = 100,
		base_health_pct = bonusPct,
		base_armor_pct = bonusPct,
		incoming_damage_decrease_pct = self:GetSpecialValue("axe_006", "buff_incoming_damage_increase_pct"),
	}
end
function modifier_axe_006_berserk.prototype.CheckState(self)
	return { [MODIFIER_STATE_DEBUFF_IMMUNE] = true }
end
modifier_axe_006_berserk = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_006_berserk)
____exports.modifier_axe_006_berserk = modifier_axe_006_berserk
return ____exports