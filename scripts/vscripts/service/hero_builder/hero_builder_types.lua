--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@meta
-- Кастомные поля, навешиваемые на entity-хендлы кодом hero_builder.
-- Файл только для типов (LuaLS): в рантайме не подключается.

---@class CDOTA_BaseNPC_Hero
---@field swapUiSecret string секрет для верификации переупорядочивания абилок из UI
---@field teamSwapUiSecret string секрет для верификации командного свапа абилок
---@field swappingItemIndex integer|nil entindex предмета, инициировавшего командный свап
---@field originalAttackCapability integer исходный тип атаки (для восстановления в FixAttackCapability)
---@field elfWolfSpawned boolean у Lycan-героя уже заспавнен доп. волк (npc_dota_elf_wolf)
---@field isInited boolean герой инициализирован hero_builder'ом

---@class CDOTABaseAbility
---@field isScepterAbility boolean абилка выдана аганимом (удаляется при потере скипетра)
---@field removalTimer string|nil id таймера отложенного удаления абилки
---@field placeholderIndex integer|nil слот-позиция (1-based) для empty_-заглушек