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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
local modifier_spirit_astral_step_debuff = __TS__Class()
modifier_spirit_astral_step_debuff.name = "modifier_spirit_astral_step_debuff"
__TS__ClassExtends(modifier_spirit_astral_step_debuff, BaseModifier)
function modifier_spirit_astral_step_debuff.prototype.IsHidden(self)
	return false
end
function modifier_spirit_astral_step_debuff.prototype.IsDebuff(self)
	return true
end
function modifier_spirit_astral_step_debuff.prototype.IsPurgable(self)
	return true
end
function modifier_spirit_astral_step_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_spirit_astral_step_debuff.prototype.OnCreated(self, _kv)
	self.damage = 20
	self.slow = -40
end
function modifier_spirit_astral_step_debuff.prototype.OnRemoved(self)
	if not IsServer() then
		return
	end
	self:GetCaster():MonsterDamage({
		victim = self:GetParent(),
		damage_rate = 30,
		ability = self:GetAbility(),
	})
	self:PlayEffects()
end
function modifier_spirit_astral_step_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function modifier_spirit_astral_step_debuff.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	return self.slow
end
function modifier_spirit_astral_step_debuff.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf"
end
function modifier_spirit_astral_step_debuff.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_spirit_astral_step_debuff.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_void_spirit_astral_step_debuff.vpcf"
end
function modifier_spirit_astral_step_debuff.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_spirit_astral_step_debuff.prototype.PlayEffects(self)
	local particle_cast = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_dmg.vpcf"
	local sound_target = "Hero_VoidSpirit.AstralStep.MarkExplosion"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_target, self:GetParent())
end
modifier_spirit_astral_step_debuff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_spirit_astral_step_debuff)
return ____exports