--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_generic_arc = class(mod_hidden)
function modifier_generic_arc:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_generic_arc:OnCreated( kv )
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.interrupted = false
self:SetJumpParameters( kv )
self:Jump()
end

function modifier_generic_arc:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_generic_arc:OnDestroy()
if not IsServer() then return end
local pos = self.parent:GetOrigin()

self.parent:RemoveHorizontalMotionController( self )
self.parent:RemoveVerticalMotionController( self )

if self.end_offset~=0 then
	self.parent:SetOrigin( pos )
end

local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)

if self.endCallback then
	self.endCallback( self.interrupted )
end

if IsValid(self.bkb_mod) then
	self.bkb_mod:Destroy()
end

end

function modifier_generic_arc:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DISABLE_TURNING,
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_generic_arc:GetModifierDisableTurning()
if not self.isForward then return end
return 1
end

function modifier_generic_arc:GetOverrideAnimation()
if self:GetStackCount() == 0 then return end
return self:GetStackCount()
end

function modifier_generic_arc:CheckState()
local state = 
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
}
if self.isStun then
	state[MODIFIER_STATE_STUNNED] = true
end
if self.isRestricted then
	state[MODIFIER_STATE_COMMAND_RESTRICTED] = true
end
if self.isInvun then
	state[MODIFIER_STATE_INVULNERABLE] = true
	state[MODIFIER_STATE_NO_HEALTH_BAR] = true
end
return state
end

function modifier_generic_arc:UpdateHorizontalMotion( me, dt )
if self.fix_duration and self:GetElapsedTime()>=self.duration then return end

local pos = me:GetOrigin() + self.direction * self.speed * dt 

self.distance_pas = self.distance_pas + self.speed*dt

if self.distance and (self.distance - self.distance_pas) < 250 and self.end_anim then 
	self.parent:StartGesture(self.end_anim)
	self.end_anim = nil
end

me:SetOrigin( pos )
end


function modifier_generic_arc:UpdateVerticalMotion( me, dt )
if self.fix_duration and self:GetElapsedTime()>=self.duration then return end

local pos = me:GetOrigin()
local time = self:GetElapsedTime()
local height = pos.z
local speed = self:GetVerticalSpeed( time )

pos.z = height + speed * dt

me:SetOrigin( pos )
if not self.fix_duration then
	local ground = GetGroundHeight( pos, me ) + self.end_offset
	if pos.z <= ground then
		pos.z = ground
		me:SetOrigin( pos )
		self:Destroy()
	end
end

end


function modifier_generic_arc:OnHorizontalMotionInterrupted()
self.interrupted = true
self:Destroy()
end

function modifier_generic_arc:OnVerticalMotionInterrupted()
self.interrupted = true
self:Destroy()
end

function modifier_generic_arc:SetJumpParameters( kv )
if not IsServer() then return end

if kv.effect then 
	self.parent:GenericParticle(kv.effect, self)
end

self.end_anim = nil
if kv.end_anim then 
	self.end_anim = kv.end_anim
end

self.distance_pas = 0
self.fix_end = true
self.fix_duration = true
self.fix_height = true
if kv.fix_end then
	self.fix_end = kv.fix_end==1
end
if kv.fix_duration then
	self.fix_duration = kv.fix_duration==1
end
if kv.fix_height then
	self.fix_height = kv.fix_height==1
end
self.isStun = kv.isStun==1
self.isRestricted = kv.isRestricted==1
self.isInvun = kv.isInvun==1
self.isForward = kv.isForward==1
self.activity = kv.activity or 0
self:SetStackCount( self.activity )

if kv.target_x and kv.target_y then
	local origin = self.parent:GetOrigin()
	local dir = Vector( kv.target_x, kv.target_y, 0 ) - origin
	dir.z = 0
	dir = dir:Normalized()
	self.direction = dir
end

if kv.dir_x and kv.dir_y then
	self.direction = Vector( kv.dir_x, kv.dir_y, 0 ):Normalized()
end
if not self.direction then
	self.direction = self.parent:GetForwardVector()
end

if kv.isBkb == 1 then
	self.bkb_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {})
end

self.duration = kv.duration
self.distance = kv.distance

self.speed = kv.speed
if not self.duration then
	self.duration = self.distance/self.speed
end
if not self.distance then
	self.speed = self.speed or 0
	self.distance = self.speed*self.duration
end
if not self.speed then
	self.distance = self.distance or 0
	self.speed = self.distance/self.duration
end


self.height = kv.height or 0
self.start_offset = kv.start_offset or 0
self.end_offset = kv.end_offset or 0


local abs = self.parent:GetAbsOrigin()
abs.z = abs.z + self.start_offset
--self.parent:SetOrigin(abs)

local pos_start = self.parent:GetOrigin()
local pos_end = pos_start + self.direction * self.distance
local height_start = GetGroundHeight( pos_start, self.parent ) + self.start_offset
local height_end = GetGroundHeight( pos_end, self.parent ) + self.end_offset
local height_max
if not self.fix_height then
	self.height = math.min( self.height, self.distance/4 )
end

if self.fix_end then
	height_end = height_start
	height_max = height_start + self.height
else
	local tempmin, tempmax = height_start, height_end
	if tempmin>tempmax then
		tempmin,tempmax = tempmax, tempmin
	end
	local delta = (tempmax-tempmin)*2/3
	height_max = tempmin + delta + self.height
end

if not self.fix_duration then
	self:SetDuration( -1, false )
else
	self:SetDuration( self.duration, true )
end

self:InitVerticalArc( height_start, height_max, height_end, self.duration )
end

function modifier_generic_arc:Jump()
if self.distance>0 then
	if not self:ApplyHorizontalMotionController() then
		self.interrupted = true
		self:Destroy()
	end
end

if self.height>0 then
	if not self:ApplyVerticalMotionController() then
		self.interrupted = true
		self:Destroy()
	end
end

end

function modifier_generic_arc:InitVerticalArc( height_start, height_max, height_end, duration )
local height_end = height_end - height_start
local height_max = height_max - height_start

if height_max<height_end then
	height_max = height_end+0.01
end

if height_max<=0 then
	height_max = 0.01
end

local duration_end = ( 1 + math.sqrt( 1 - height_end/height_max ) )/2
self.const1 = 4*height_max*duration_end/duration
self.const2 = 4*height_max*duration_end*duration_end/(duration*duration)

end

function modifier_generic_arc:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_generic_arc:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end

function modifier_generic_arc:SetEndCallback( func )
	self.endCallback = func
end
