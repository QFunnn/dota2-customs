--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_neutral_cast = class({})


function modifier_neutral_cast:IsHidden() return true end
function modifier_neutral_cast:IsPurgable() return false end
function modifier_neutral_cast:CheckState() 
return 
{
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_ROOTED] = true 
} 
end


function modifier_neutral_cast:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_DISABLE_TURNING
}

end

function modifier_neutral_cast:GetModifierDisableTurning() 
return 1
end 

function modifier_neutral_cast:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()

self.target = nil

if table.target then 
	self.target = EntIndexToHScript(table.target)
end

self.anim = table.anim
self.anim_speed = 1

if table.anim_speed then 
	self.anim_speed = table.anim_speed
end 

self.parent_mod = self:GetParent():FindModifierByName(table.parent_mod)

if table.effect then 
  self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
  self:AddParticle(self.sign, false, false, -1, false, false) 
end 

if self.anim then 
	self:GetParent():StartGestureWithPlaybackRate(self.anim, self.anim_speed)
end

self:OnIntervalThink()
self:StartIntervalThink(FrameTime())
end 

function modifier_neutral_cast:OnIntervalThink()
if not IsServer() then return end 

if self.parent:IsStunned() or self.parent:IsSilenced() or self.parent:IsHexed() then 
	self:Destroy()
end 

end 


function modifier_neutral_cast:OnDestroy()
if not IsServer() then return end 

if self:GetRemainingTime() > 0.01 or not self:GetParent():IsAlive() then

	if self.anim then  
		self:GetParent():FadeGesture(self.anim)
	end
	
	return
end 

if not self.parent_mod or self.parent_mod:IsNull() then return end

self.parent:CheckCastMods(self:GetAbility())
self.parent:SpendMana(self:GetAbility():GetManaCost(1), self:GetAbility())
self.parent:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_neutral_cast_cd", {duration = self:GetAbility():GetSpecialValueFor("AbilityCooldown")})

self.parent_mod:EndCast()


if self.target and not self.target:IsNull() and self.target:IsAlive() then 
  self.parent:SetForceAttackTarget(self.target)

  Timers:CreateTimer(0.7,function()  
    self.parent:SetForceAttackTarget(nil)  
  end)
end 

end 







modifier_neutral_cast_cd = class({})
function modifier_neutral_cast_cd:IsHidden() return false end
function modifier_neutral_cast_cd:IsDebuff() return true end
function modifier_neutral_cast_cd:IsPurgable() return false end