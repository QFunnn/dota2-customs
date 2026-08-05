--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


--[[
    Боевой stat-модификатор помощника.

    Базовые статы (max health, attack damage, armor, health regen) живут на полях
    _levelup_custom_* юнита и сворачиваются с summon aura через
    modifier_levelup_summon_aura_receiver. Атака и скорость передвижения не
    проходят через receiver как "база", поэтому их 25%-копию от героя помощник
    получает здесь, читая поля, которые раз в секунду обновляет AssistantManager.
]]
modifier_levelup_assistant_stats = class({})

function modifier_levelup_assistant_stats:IsHidden()
	return true
end
function modifier_levelup_assistant_stats:IsPurgable()
	return false
end
function modifier_levelup_assistant_stats:IsPurgeException()
	return false
end
function modifier_levelup_assistant_stats:RemoveOnDeath()
	return false
end

function modifier_levelup_assistant_stats:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_levelup_assistant_stats:OnCreated()
	self.parent = self:GetParent()
end

function modifier_levelup_assistant_stats:GetAttackSound()
	local parent = self.parent or self:GetParent()
	if not IsValid(parent) then
		return nil
	end

	return parent._levelup_attack_sound
end

function modifier_levelup_assistant_stats:OnAttackStart(params)
	if not IsServer() then
		return
	end

	local parent = self.parent or self:GetParent()
	if params.attacker ~= parent then
		return
	end
	if params.no_attack_cooldown then
		return
	end
	if not IsValid(params.target) then
		return
	end
	if not parent._levelup_pre_attack_sound then
		return
	end

	EmitSoundOn(parent._levelup_pre_attack_sound, parent)
end

function modifier_levelup_assistant_stats:OnAttackLanded(params)
	if not IsServer() then
		return
	end

	local parent = self.parent or self:GetParent()
	if params.attacker ~= parent then
		return
	end

	local target = params.target
	if not IsValid(parent, target) then
		return
	end
	if not parent._levelup_attack_impact_sound then
		return
	end

	StopSoundOn("Hero_Sniper.ProjectileImpact", target)
	EmitSoundOn(parent._levelup_attack_impact_sound, target)
end

function modifier_levelup_assistant_stats:GetModifierAttackSpeedBonus_Constant()
	local parent = self.parent or self:GetParent()
	return tonumber(parent.levelup_assistant_attack_speed_bonus) or 0
end

function modifier_levelup_assistant_stats:GetModifierMoveSpeedBonus_Constant()
	local parent = self.parent or self:GetParent()
	return tonumber(parent.levelup_assistant_move_speed_bonus) or 0
end