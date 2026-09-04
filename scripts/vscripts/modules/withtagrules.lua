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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local g_tagRuleSourceSeq = 0
--- Tag 规则处理器混入工厂：为任意类注入“TagModifierRule 生命周期托管”能力。
--
-- @returns 增强后的类，包含 Tag 规则的统一增删能力
function ____exports.WithTagRules(self, Base)
	local WithTagRulesMixin = __TS__Class()
	WithTagRulesMixin.name = "WithTagRulesMixin"
	__TS__ClassExtends(WithTagRulesMixin, Base)
	function WithTagRulesMixin.prototype.____constructor(self, ...)
		Base.prototype.____constructor(self, ...)
		self._tagRules = {}
		self._tagRulesInitSeq = 0
		self._managedTagRuleEntities = __TS__New(Set)
		self._tagRuleSourceId = nil
	end
	function WithTagRulesMixin.prototype.GetTagModifierRules(self)
		return nil
	end
	function WithTagRulesMixin.prototype.GetAddTagRulesEntity(self)
		return {}
	end
	function WithTagRulesMixin.prototype.InitializeTagRules(self)
		local ____self_0, ____tagRulesInitSeq_1 = self, "_tagRulesInitSeq"
		local ____self__tagRulesInitSeq_2 = ____self_0[____tagRulesInitSeq_1] + 1
		____self_0[____tagRulesInitSeq_1] = ____self__tagRulesInitSeq_2
		local initSeq = ____self__tagRulesInitSeq_2
		if not IsServer() then
			return
		end
		if self:IsRemoved() then
			return
		end
		self._tagRules = { unpack(self:GetTagModifierRules() or {}) }
		local entities = self:GetAddTagRulesEntity()
		if not entities or #entities == 0 then
			return
		end
		local tryApply
		tryApply = function(____, attempt)
			if initSeq ~= self._tagRulesInitSeq then
				return
			end
			if self:IsRemoved() then
				return
			end
			local hasPending = false
			if not MyGameTagManager then
				hasPending = true
			else
				for ____, entity in ipairs(entities) do
					do
						if not IsValidAlive(nil, entity) then
							goto __continue14
						end
						local inited = entity.__attributes_inited__ == true
						if not inited then
							hasPending = true
							goto __continue14
						end
						self:AddManagedTagRuleEntity(entity)
					end
					::__continue14::
				end
			end
			if not hasPending then
				return
			end
			if attempt < 3 then
				SysTimers:CreateTimer(FrameTime(), function()
					return tryApply(nil, attempt + 1)
				end)
				return
			end
			if not MyGameTagManager then
				return
			end
			for ____, entity in ipairs(entities) do
				do
					if not IsValidAlive(nil, entity) then
						goto __continue22
					end
					self:AddManagedTagRuleEntity(entity)
				end
				::__continue22::
			end
		end
		tryApply(nil, 0)
	end
	function WithTagRulesMixin.prototype.RefreshTagRules(self)
		if not IsServer() then
			return
		end
		if self:IsRemoved() then
			return
		end
		if not MyGameTagManager then
			return
		end
		self._tagRules = { unpack(self:GetTagModifierRules() or {}) }
		self._managedTagRuleEntities:forEach(function(____, entIndex)
			local entity = EntIndexToHScript(entIndex)
			if not IsValid(nil, entity) then
				return
			end
			MyGameTagManager:SetUnitSourceRules(entity, self:GetTagRuleSourceId(), self._tagRules)
		end)
	end
	function WithTagRulesMixin.prototype.CleanupTagRules(self)
		self._tagRulesInitSeq = self._tagRulesInitSeq + 1
		if not IsServer() then
			return
		end
		if not MyGameTagManager then
			return
		end
		local sourceId = self:GetTagRuleSourceId()
		self._managedTagRuleEntities:forEach(function(____, entIndex)
			local entity = EntIndexToHScript(entIndex)
			if not IsValid(nil, entity) then
				return
			end
			MyGameTagManager:RemoveUnitSourceRules(entity, sourceId)
		end)
		self._managedTagRuleEntities:clear()
		self._tagRules = {}
	end
	function WithTagRulesMixin.prototype.AddManagedTagRuleEntity(self, entity)
		if not IsServer() then
			return
		end
		if not IsValid(nil, entity) then
			return
		end
		if not MyGameTagManager then
			return
		end
		local entIndex = entity:GetEntityIndex()
		if self._managedTagRuleEntities:has(entIndex) then
			MyGameTagManager:SetUnitSourceRules(entity, self:GetTagRuleSourceId(), self._tagRules)
			return
		end
		self._managedTagRuleEntities:add(entIndex)
		MyGameTagManager:SetUnitSourceRules(entity, self:GetTagRuleSourceId(), self._tagRules)
	end
	function WithTagRulesMixin.prototype.RemoveManagedTagRuleEntity(self, entity)
		if not IsServer() then
			return
		end
		if not IsValid(nil, entity) then
			return
		end
		if not MyGameTagManager then
			return
		end
		local entIndex = entity:GetEntityIndex()
		if not self._managedTagRuleEntities:has(entIndex) then
			return
		end
		MyGameTagManager:RemoveUnitSourceRules(entity, self:GetTagRuleSourceId())
		self._managedTagRuleEntities:delete(entIndex)
	end
	function WithTagRulesMixin.prototype.GetTagRuleSourceId(self)
		if self._tagRuleSourceId then
			return self._tagRuleSourceId
		end
		local ____opt_3 = self.GetName
		local name = ____opt_3 and ____opt_3(self) or "tag_rule_source"
		local entIndexFn = self.entindex
		local ____entIndexFn_5
		if entIndexFn then
			____entIndexFn_5 = tonumber(entIndexFn(self))
		else
			____entIndexFn_5 = 0
		end
		local entIndex = ____entIndexFn_5
		if entIndex > 0 then
			self._tagRuleSourceId = (name .. "@") .. tostring(entIndex)
			return self._tagRuleSourceId
		end
		g_tagRuleSourceSeq = g_tagRuleSourceSeq + 1
		self._tagRuleSourceId = (name .. "@seq_") .. tostring(g_tagRuleSourceSeq)
		return self._tagRuleSourceId
	end
	return WithTagRulesMixin
end
return ____exports