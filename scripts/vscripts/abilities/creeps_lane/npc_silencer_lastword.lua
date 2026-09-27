--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_silencer_lastword_debuff",
	"abilities/creeps_lane/npc_silencer_lastword",
	LUA_MODIFIER_MOTION_NONE
)

npc_silencer_lastword = class({})

function npc_silencer_lastword:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_silencer/silencer_last_word_status.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_silencer/silencer_last_word_dmg.vpcf", context)
end

function npc_silencer_lastword:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.stun = self:GetLevelSpecialValueFor("stun", 1)
	self.damage = self:GetLevelSpecialValueFor("damage", 1)
end

function npc_silencer_lastword:OnSpellStart()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	target:EmitSound("Hero_Silencer.LastWord.Target")
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_silencer_lastword_debuff",
		{ duration = self.duration * (1 - target:GetStatusResistance()) }
	)
end

modifier_silencer_lastword_debuff = class(mod_visible)
function modifier_silencer_lastword_debuff:GetEffectName()
	return "particles/units/heroes/hero_silencer/silencer_last_word_status.vpcf"
end
function modifier_silencer_lastword_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.parent:AddSpellEvent(self, true)
end

function modifier_silencer_lastword_debuff:SpellEvent(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if params.ability:IsItem() then
		return
	end

	self.cast = true
	self:Destroy()
end

function modifier_silencer_lastword_debuff:OnDestroy()
	if not IsServer() then
		return
	end

	self.parent:StopSound("Hero_Silencer.LastWord.Target")

	if not self.cast then
		return
	end

	self.parent:AddNewModifier(
		self.caster,
		self.ability,
		"modifier_stunned",
		{ duration = self.ability.stun * (1 - self.parent:GetStatusResistance()) }
	)
	self.parent:EmitSound("Hero_Silencer.LastWord.Damage")
	self.parent:GenericParticle("particles/units/heroes/hero_silencer/silencer_last_word_dmg.vpcf")

	DoDamage({
		victim = self.parent,
		attacker = self.caster,
		damage = self.ability.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})
end