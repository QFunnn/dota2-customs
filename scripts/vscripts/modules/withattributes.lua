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
local Map = ____lualib.Map
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local ____exports = {}
--- 属性处理器混入工厂：为任意类注入“属性加成”的统一增删能力。
--
-- @returns 增强后的类，包含属性处理能力
function ____exports.WithAttributes(self, Base)
	local WithAttributesMixin = __TS__Class()
	WithAttributesMixin.name = "WithAttributesMixin"
	__TS__ClassExtends(WithAttributesMixin, Base)
	function WithAttributesMixin.prototype.____constructor(self, ...)
		Base.prototype.____constructor(self, ...)
		self._attributeBonus = nil
		self._initSeq = 0
		self._managedEntities = __TS__New(Set)
		self._opIdsByEntity = __TS__New(Map)
	end
	function WithAttributesMixin.prototype.GetAttributeBonus(self)
		return nil
	end
	function WithAttributesMixin.prototype.InitializeAttributes(self)
		local ____self_0, ____initSeq_1 = self, "_initSeq"
		local ____self__initSeq_2 = ____self_0[____initSeq_1] + 1
		____self_0[____initSeq_1] = ____self__initSeq_2
		local initSeq = ____self__initSeq_2
		if self._managedEntities.size > 0 or self._opIdsByEntity.size > 0 then
			self._managedEntities:forEach(function(____, entIndex)
				local entity = EntIndexToHScript(entIndex)
				if IsValid(nil, entity) then
					self:RemoveAttributesFromEntity(entity)
				end
			end)
		end
		self._managedEntities:clear()
		self._opIdsByEntity:clear()
		self._attributeBonus = self:GetAttributeBonus()
		if not self._attributeBonus then
			return
		end
		local entities = self:GetAddAttributesEntity()
		if not entities or #entities == 0 then
			return
		end
		local tryApply
		tryApply = function(____, attempt)
			if initSeq ~= self._initSeq then
				return
			end
			if self:IsRemoved() then
				return
			end
			if not self._attributeBonus then
				return
			end
			local hasPendingEntity = false
			for ____, entity in ipairs(entities) do
				do
					if not IsValidAlive(nil, entity) then
						goto __continue14
					end
					local inited = entity.__attributes_inited__ == true
					if not inited then
						hasPendingEntity = true
						goto __continue14
					end
					self:AddManagedEntity(entity)
				end
				::__continue14::
			end
			if hasPendingEntity then
				if attempt < 3 then
					SysTimers:CreateTimer(FrameTime(), function()
						return tryApply(nil, attempt + 1)
					end)
				else
					for ____, entity in ipairs(entities) do
						if IsValidAlive(nil, entity) then
							self:AddManagedEntity(entity)
						end
					end
				end
			end
		end
		tryApply(nil, 0)
	end
	function WithAttributesMixin.prototype.RefreshAttributes(self)
		local newBonus = self:GetAttributeBonus()
		self._attributeBonus = newBonus
		self._managedEntities:forEach(function(____, entIndex)
			local entity = EntIndexToHScript(entIndex)
			if IsValid(nil, entity) then
				MyGameAttribute:RunAttributeBatch(entity, function()
					self:RemoveAttributesFromEntity(entity)
					if self._attributeBonus then
						self:ApplyAttributesToEntity(entity)
					end
				end)
			end
		end)
	end
	function WithAttributesMixin.prototype.CleanupAttributes(self)
		SysTimers:CreateTimer(FrameTime(), function()
			self._managedEntities:forEach(function(____, entIndex)
				local entity = EntIndexToHScript(entIndex)
				if IsValid(nil, entity) then
					MyGameAttribute:RunAttributeBatch(entity, function()
						self:RemoveAttributesFromEntity(entity)
					end)
				end
			end)
			self._managedEntities:clear()
			self._opIdsByEntity:clear()
			self._attributeBonus = nil
		end)
	end
	function WithAttributesMixin.prototype.AddManagedEntity(self, entity)
		if not IsValid(nil, entity) then
			return
		end
		if not self._attributeBonus then
			return
		end
		local entIndex = entity:GetEntityIndex()
		if self._managedEntities:has(entIndex) then
			return
		end
		self._managedEntities:add(entIndex)
		MyGameAttribute:RunAttributeBatch(entity, function()
			self:ApplyAttributesToEntity(entity)
		end)
	end
	function WithAttributesMixin.prototype.RemoveManagedEntity(self, entity)
		if not IsValid(nil, entity) then
			return
		end
		local entIndex = entity:GetEntityIndex()
		if not self._managedEntities:has(entIndex) then
			return
		end
		MyGameAttribute:RunAttributeBatch(entity, function()
			self:RemoveAttributesFromEntity(entity)
		end)
		self._managedEntities:delete(entIndex)
	end
	function WithAttributesMixin.prototype.EnsureOpBucket(self, entIndex)
		local bucket = self._opIdsByEntity:get(entIndex)
		if not bucket then
			bucket = {}
			self._opIdsByEntity:set(entIndex, bucket)
		end
		return bucket
	end
	function WithAttributesMixin.prototype.ApplyAttributesToEntity(self, entity)
		if not self._attributeBonus then
			return
		end
		if not IsValid(nil, entity) then
			return
		end
		local entIndex = entity:GetEntityIndex()
		local bucket = self:EnsureOpBucket(entIndex)
		for ____, ____value in ipairs(__TS__ObjectEntries(self._attributeBonus)) do
			local rawKey = ____value[1]
			local rawValue = ____value[2]
			do
				if rawValue == nil or rawValue == nil then
					goto __continue49
				end
				local key = rawKey
				local source = (self:GetName() .. "@") .. tostring(math.floor(GameRules:GetGameTime() * 1000))
				local opId = MyGameAttribute:AddAttribute(entity, key, rawValue, source)
				if opId then
					local ____bucket_3, ____key_4 = bucket, key
					if not ____bucket_3[____key_4] then
						____bucket_3[____key_4] = {}
					end
					local ____bucket_key_6 = bucket[key]
					____bucket_key_6[#____bucket_key_6 + 1] = opId
				end
			end
			::__continue49::
		end
	end
	function WithAttributesMixin.prototype.RemoveAttributesFromEntity(self, entity)
		if not IsValid(nil, entity) then
			return
		end
		local entIndex = entity:GetEntityIndex()
		local bucket = self._opIdsByEntity:get(entIndex)
		if not bucket then
			return
		end
		for ____, ____value in ipairs(__TS__ObjectEntries(bucket)) do
			local rawKey = ____value[1]
			local opIds = ____value[2]
			do
				if not opIds or #opIds == 0 then
					goto __continue56
				end
				local key = rawKey
				for ____, opId in ipairs(opIds) do
					MyGameAttribute:RemoveAttribute(entity, key, opId)
				end
			end
			::__continue56::
		end
		self._opIdsByEntity:delete(entIndex)
	end
	return WithAttributesMixin
end
return ____exports