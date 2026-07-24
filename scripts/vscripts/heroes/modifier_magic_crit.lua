--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--暴击处理器
modifier_magic_crit = class({})

if MAGIC_CRIT_RECORDS == nil then
	_G.MAGIC_CRIT_RECORDS = {}
end

function modifier_magic_crit:IsHidden() return true end
function modifier_magic_crit:IsDebuff() return false end
function modifier_magic_crit:IsPurgable() return false end
function modifier_magic_crit:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_magic_crit:RemoveOnDeath() return false end
function modifier_magic_crit:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end
function modifier_magic_crit:OnCreated()
	if IsServer() then
		self:SetStackCount(1)
	end
end
function modifier_magic_crit:OnRefresh()
	if IsServer() then
		self:IncrementStackCount()
	end
end
function modifier_magic_crit:OnStackCountChanged(iStackCount)
	if IsServer() then
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end
function modifier_magic_crit:GetModifierTotalDamageOutgoing_Percentage(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = params.inflictor
	if IsServer() then
		if params.damage_type == DAMAGE_TYPE_MAGICAL and IsValid(hParent) and IsValid(hTarget) and hTarget:IsAlive() and not hParent:HasModifier("modifier_item_aeon_disk_lua_buff") then
			local bShouldActive = true
			if hAbility ~= nil then
				local AbilityName = hAbility:GetAbilityName()
				if PERCENTAGE_ABILITIES and PERCENTAGE_ABILITIES[AbilityName] or (AbilityName == "enigma_black_hole" and hParent:HasScepter()) or (AbilityName == "witch_doctor_voodoo_restoration" and hParent:HasTalent("special_bonus_unique_witch_doctor_2")) then
					bShouldActive = false
				else
					bShouldActive = true
				end
			else
				bShouldActive = true
			end
			if bShouldActive then
				local MagicCritResult = GetCustomModifierProps(hParent, "MODIFIER_PROPERTY_MAGICAL_CRIT_DAMAGE", params, CUSTOM_MODIFIER_PROPS_CAL_TYPE_MAX)
				if MagicCritResult then
					local value = MagicCritResult.value
					local buff = MagicCritResult.buff

					if value > 0 then
						local tParams = params
						params.crit_buff = buff
						FireCustomEvent("MODIFIER_EVENT_ON_MAGICAL_CRIT", tParams, hParent, buff)
						hTarget:AddNewModifier(hParent, hAbility, "modifier_magic_crit_msg", { duration = FrameTime(), record = params.record })
						table.insert(MAGIC_CRIT_RECORDS, params.record)
						return math.max(0, value - 100)
					end
				end
			end
		end
	end
end
---------------------------
modifier_magic_crit_msg = class({})

function modifier_magic_crit_msg:IsHidden() return true end
function modifier_magic_crit_msg:IsDebuff() return true end
function modifier_magic_crit_msg:IsPurgable() return false end
function modifier_magic_crit_msg:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_magic_crit_msg:RemoveOnDeath() return false end
function modifier_magic_crit_msg:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function modifier_magic_crit_msg:OnCreated(params)
	if IsServer() then
		self.records = {}
		table.insert(self.records, params.record)
	end
end
function modifier_magic_crit_msg:OnRefresh(params)
	if IsServer() then
		table.insert(self.records, params.record)
	end
end
function modifier_magic_crit_msg:GetModifierIncomingDamage_Percentage(params)
	local hParent = self:GetParent()
	if IsServer() then
		for i = #self.records, 1, -1 do
			if self.records[i] == params.record then
				local number_length = math.floor(math.log(math.floor(params.damage), 10) + 1)
				local particleID = ParticleManager:CreateParticle("particles/msg_fx/msg_crit.vpcf", PATTACH_OVERHEAD_FOLLOW, hParent)
				ParticleManager:SetParticleControl(particleID, 1, Vector(0, math.floor(params.damage), 4))
				ParticleManager:SetParticleControl(particleID, 2, Vector(1, number_length + 1, 0))
				ParticleManager:SetParticleControl(particleID, 3, Vector(0, 191, 255))
				ParticleManager:ReleaseParticleIndex(particleID)
				table.remove(self.records, i)
			end
		end
	end
end