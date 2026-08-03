--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


modifier_ultimate_templar_assassin_phantom = class({})

local PHANTOM_TARGET_CACHE = {}

function modifier_ultimate_templar_assassin_phantom:IsHidden()
	return true
end
function modifier_ultimate_templar_assassin_phantom:IsPurgable()
	return false
end
function modifier_ultimate_templar_assassin_phantom:IsPurgeException()
	return false
end

local function get_owner_forward(owner)
	local forward = owner:GetForwardVector()
	forward.z = 0
	if forward:Length2D() <= 0.01 then
		return Vector(1, 0, 0)
	end

	return forward:Normalized()
end

local function get_anchor_position(owner, side, unit)
	local forward = get_owner_forward(owner)
	local right = Vector(-forward.y, forward.x, 0)
	local origin = owner:GetAbsOrigin() - forward * 60 + right * side * 90
	return GetGroundPosition(origin, unit)
end

function modifier_ultimate_templar_assassin_phantom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
	}
end

function modifier_ultimate_templar_assassin_phantom:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end

function modifier_ultimate_templar_assassin_phantom:StatusEffectPriority()
	return 20
end

function modifier_ultimate_templar_assassin_phantom:GetStatusEffectName()
	return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_ultimate_templar_assassin_phantom:OnCreated()
	self.parent = self:GetParent()
	self.owner = self:GetCaster()
	self.side = self.parent.levelup_templar_assassin_side or 1
	self.target_slot = self.side < 0 and 1 or 2
	self.current_target_entindex = nil
	self.next_attack_order_time = 0
	if not IsServer() then
		return
	end
	self:ApplyHorizontalMotionController()
	self:StartIntervalThink(0.1)
end

function modifier_ultimate_templar_assassin_phantom:UpdateHorizontalMotion(me, dt)
	local owner = self.owner
	if not IsValid(me, owner) or not me:IsAlive() then
		return
	end
	local anchor_position = get_anchor_position(owner, self.side, me)
	me:SetOrigin(anchor_position)
end

function modifier_ultimate_templar_assassin_phantom:OnIntervalThink()
	local parent = self.parent
	local owner = self.owner
	if not IsValid(parent, owner) or not parent:IsAlive() then
		return
	end
	self:ApplyHorizontalMotionController()

	local now = GameRules:GetGameTime()

	--parent:FaceTowards(anchor_position + get_owner_forward(owner) * 200)

	local target = self:GetAttackTarget(now)
	if IsValid(target) then
		if self.current_target_entindex ~= target:entindex() or now >= self.next_attack_order_time then
			self.current_target_entindex = target:entindex()
			self.next_attack_order_time = now + 0.2
			ExecuteOrderFromTable({
				UnitIndex = parent:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				TargetIndex = target:entindex(),
				Queue = false,
			})
		end
		return
	end

	if self.current_target_entindex ~= nil then
		self.current_target_entindex = nil
		self.next_attack_order_time = 0
		ExecuteOrderFromTable({
			UnitIndex = parent:entindex(),
			OrderType = DOTA_UNIT_ORDER_STOP,
			Queue = false,
		})
	end
end

function modifier_ultimate_templar_assassin_phantom:GetCachedTargetEntindexes(now)
	local owner = self.owner
	local parent = self.parent
	if not IsValid(owner, parent) then
		return nil
	end

	local owner_entindex = owner:entindex()
	local current_set_id = parent.levelup_templar_assassin_set_id
	local cache = PHANTOM_TARGET_CACHE[owner_entindex]
	if cache and cache.set_id == current_set_id and cache.next_refresh_time > now then
		return cache.entindexes
	end

	local search_radius = (parent:Script_GetAttackRange() or 0) + 90
	local enemies = FindUnitsInRadius(
		owner:GetTeamNumber(),
		owner:GetAbsOrigin(),
		nil,
		search_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_CLOSEST,
		false
	)

	local entindexes = {}
	for _, enemy in ipairs(enemies or {}) do
		if IsValid(enemy) and enemy:IsAlive() then
			table.insert(entindexes, enemy:entindex())
		end
	end

	PHANTOM_TARGET_CACHE[owner_entindex] = {
		set_id = current_set_id,
		next_refresh_time = now + 0.2,
		entindexes = entindexes,
	}

	return entindexes
end

function modifier_ultimate_templar_assassin_phantom:GetAttackTarget(now)
	local parent = self.parent
	local entindexes = self:GetCachedTargetEntindexes(now)
	if not entindexes or #entindexes <= 0 then
		return nil
	end

	local attack_range = parent:Script_GetAttackRange() or 0
	local preferred_order = { self.target_slot, 1, 2 }
	local checked = {}

	for _, slot in ipairs(preferred_order) do
		if not checked[slot] then
			checked[slot] = true
			local entindex = entindexes[slot]
			if entindex then
				local target = EntIndexToHScript(entindex)
				if
					IsValid(target)
					and target:IsAlive()
					and (target:GetAbsOrigin() - parent:GetAbsOrigin()):Length2D() <= attack_range + 25
				then
					return target
				end
			end
		end
	end

	for slot, entindex in ipairs(entindexes) do
		if not checked[slot] then
			local target = EntIndexToHScript(entindex)
			if
				IsValid(target)
				and target:IsAlive()
				and (target:GetAbsOrigin() - parent:GetAbsOrigin()):Length2D() <= attack_range + 25
			then
				return target
			end
		end
	end

	return nil
end

function modifier_ultimate_templar_assassin_phantom:GetModifierAttackRangeBonus()
	return self.parent.levelup_templar_assassin_attack_range_bonus or 0
end

function modifier_ultimate_templar_assassin_phantom:GetModifierAttackSpeedPercentage()
	return self.parent.levelup_templar_assassin_attack_speed_pct or 0
end