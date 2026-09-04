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
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_normal_018_cultist_buff
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 3
local SKULL_PFX = "particles/units/heroes/hero_witchdoctor/witchdoctor_ward_skull.vpcf"
--- 参见 soundevents.json：deathward_build.vsnd
local BUILD_SOUND = "Hero_WitchDoctor.Death_WardBuild"
local STAT_PCT = 50
local MODEL_SCALE_PCT = 20
local MODEL_SCALE_MAX_PCT = 60
local MODEL_SCALE_ANIM_TIME = 0.75
--- 普通技能18 - 邪教徒仪祭：引导后永久强化并变大，可多次引导叠加
____exports.normal_018 = __TS__Class()
local normal_018 = ____exports.normal_018
normal_018.name = "normal_018"
__TS__ClassExtends(normal_018, MonsterAbility_CS)
function normal_018.prototype.Precache(self, context)
	PrecacheResource("particle", SKULL_PFX, context)
end
function normal_018.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = 0,
		castPoint = CAST_POINT,
		castDuration = 0.1,
		castAnimation = ACT_DOTA_VICTORY,
		animationPlaybackRate = 1.25,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(BUILD_SOUND, caster)
			local pfx = ParticleManager:CreateParticle(SKULL_PFX, PATTACH_ABSORIGIN_FOLLOW, caster)
			for ____, cp in ipairs({ 0, 1, 2 }) do
				ParticleManager:SetParticleControlEnt(
					pfx,
					cp,
					caster,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					caster:GetAbsOrigin(),
					true
				)
			end
			self._skullPfx = pfx
		end,
		OnStart = function()
			self:EndPrecastPresentation()
			local caster = self:GetCaster()
			EmitSoundOn("Greevil.Bloodlust.Target", caster)
			caster:CustomHeal(caster:GetMaxHealth() * 0.35, { ability = self, source = "spell" })
			local effect = ParticleManager:CreateParticle(
				"particles/items3_fx/fish_bones_active.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				caster
			)
			ParticleManager:ReleaseParticleIndex(effect)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			if not IsValidAlive(nil, caster) then
				return
			end
			self:AddCultistBuff(caster)
			Timers:CreateTimer(0.2, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:FadeGesture(ACT_DOTA_VICTORY)
				local order = {
					UnitIndex = caster:entindex(),
					OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
					Position = caster:GetAbsOrigin(),
					Queue = false,
				}
				ExecuteOrderFromTable(order)
			end)
		end,
		OnInterrupt = function()
			self:EndPrecastPresentation()
			local caster = self:GetCaster()
			caster:FadeGesture(ACT_DOTA_VICTORY)
		end,
	}
end
function normal_018.prototype.AddCultistBuff(self, caster)
	local existing = modifier_normal_018_cultist_buff:find_on(caster)
	if existing then
		existing:AddStack()
		return
	end
	modifier_normal_018_cultist_buff:applys(caster, caster, self, { stacks = 1 })
end
function normal_018.prototype.EndPrecastPresentation(self)
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		StopSoundOn(BUILD_SOUND, caster)
	end
	if self._skullPfx ~= nil then
		ParticleManager:DestroyParticle(self._skullPfx, false)
		ParticleManager:ReleaseParticleIndex(self._skullPfx)
		self._skullPfx = nil
	end
end
normal_018 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_018)
____exports.normal_018 = normal_018
modifier_normal_018_cultist_buff = __TS__Class()
modifier_normal_018_cultist_buff.name = "modifier_normal_018_cultist_buff"
__TS__ClassExtends(modifier_normal_018_cultist_buff, MonsterModifier_CS)
function modifier_normal_018_cultist_buff.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self:SetStackCount(math.max(1, kv and kv.stacks or 1))
	self:RefreshAttributes()
end
function modifier_normal_018_cultist_buff.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:AddStack()
end
function modifier_normal_018_cultist_buff.prototype.AddStack(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
	self:RefreshAttributes()
end
function modifier_normal_018_cultist_buff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME }
end
function modifier_normal_018_cultist_buff.prototype.GetModifierModelScaleAnimateTime(self)
	return MODEL_SCALE_ANIM_TIME
end
function modifier_normal_018_cultist_buff.prototype.GetModifierModelScale(self)
	return math.min(self:GetStackCount() * MODEL_SCALE_PCT, MODEL_SCALE_MAX_PCT)
end
function modifier_normal_018_cultist_buff.prototype.GetAttributeBonus(self)
	local stacks = self:GetStackCount()
	return {
		base_health_pct = STAT_PCT * stacks,
		all_attack_damage_percent = STAT_PCT * stacks,
		bonus_movespeed_pct = STAT_PCT * stacks,
	}
end
function modifier_normal_018_cultist_buff.GetLocalizationCN(self)
	return { name = "邪祭之躯", description = "永久提升生命、攻击力与移速；体型最多提升60%。" }
end
function modifier_normal_018_cultist_buff.prototype.IsHidden(self)
	return false
end
function modifier_normal_018_cultist_buff.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf"
end
function modifier_normal_018_cultist_buff.prototype.IsDebuff(self)
	return false
end
function modifier_normal_018_cultist_buff.prototype.IsPurgable(self)
	return false
end
function modifier_normal_018_cultist_buff.prototype.IsPermanent(self)
	return true
end
modifier_normal_018_cultist_buff = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_normal_018_cultist_buff") },
	modifier_normal_018_cultist_buff
)
return ____exports