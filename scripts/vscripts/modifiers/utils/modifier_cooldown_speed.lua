--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_cooldown_speed = class({})
function modifier_cooldown_speed:IsHidden() return true end
function modifier_cooldown_speed:IsPurgable() return false end
function modifier_cooldown_speed:RemoveOnDeath() return false end
function modifier_cooldown_speed:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_cooldown_speed:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()
self.ability = EntIndexToHScript(table.ability)

if not IsValid(self.ability) then 
	self:Destroy()
	return 
end

if self.parent:IsRealHero() then
	self.parent:AddSpellEvent(self)
end

self.interval = 0.05

self.cd_inc = table.cd_inc/100

self.before_cd = 0
self.after_cd = 0

self.start_cd_time = 0
self.IsOnCd = false
self.end_cd_time = 0
self.end_rule = nil
self.proc_rule = nil

self:StartIntervalThink(self.interval)
end 


function modifier_cooldown_speed:SetEndRule( func )
	self.end_rule = func
end


function modifier_cooldown_speed:SetProcRule( func )
	self.proc_rule = func
end


function modifier_cooldown_speed:OnIntervalThink()
if not IsServer() then return end 

if not IsValid(self.ability) then 
	self:Destroy()
	return 
end

if self.end_rule ~= nil then 
	if self.end_rule() == false then 
		self:Destroy()
		return
	end
end 

if self.proc_rule ~= nil then 
	if self.proc_rule() == false then 
		return
	end
end 


self.before_cd = self.ability:GetCooldownTime()

if self.before_cd > 0 and self.IsOnCd == false then
	self:StartCd()
end 

if self.IsOnCd == false then return end

local reduce_cd = self.interval * self.cd_inc

if self.after_cd ~= 0 then 
	local delta = math.max(0, self.after_cd - self.before_cd)

	if delta < self.interval then 
		--reduce_cd = reduce_cd + (self.interval - delta)
	end 
end 

self.parent:CdAbility(self.ability, reduce_cd)

self.after_cd = self.ability:GetCooldownTime()

if self.after_cd == 0 and self.IsOnCd == true then 
	self.IsOnCd = false
	self.end_cd_time = GameRules:GetDOTATime(false, false)

	if test then 
		print('cd time:', self.end_cd_time - self.start_cd_time)
	end
end 

end



function modifier_cooldown_speed:StartCd()

self.start_cd_time = GameRules:GetDOTATime(false, false) 
self.IsOnCd = true
self.after_cd = 0

if test then 
	print('cd start!')
end 

end


function modifier_cooldown_speed:SpellEvent( params )
if not IsServer() then return end
if params.unit~=self:GetParent() then return end
if not params.ability then return end
if not self.ability then return end
if params.ability ~= self.ability then return end
if self.IsOnCd == true then return end

self:StartCd()
self:OnIntervalThink()
end