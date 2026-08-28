--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_kunkka_xmark_custom_tracker",
	"abilities/kunkka/kunkka_x_marks_the_spot_custom",
	LUA_MODIFIER_MOTION_NONE
)

kunkka_x_marks_the_spot_custom = class({})
kunkka_x_marks_the_spot_custom.talents = {}

function kunkka_x_marks_the_spot_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource("particle", "", context)
end

function kunkka_x_marks_the_spot_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {}
	end
end

function kunkka_x_marks_the_spot_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_kunkka_xmark_custom_tracker"
end

modifier_kunkka_xmark_custom_tracker = class(mod_hidden)
function modifier_kunkka_xmark_custom_tracker:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.parent.xmark_ability = self.ability
end