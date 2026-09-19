--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
// Native Panorama controller for the debug tool.
//
// The control-panel shell + categories + buttons are declared statically in
// debug_tool/layout.xml; this script wires their behaviour by id/class and builds the
// data-driven windows (ability/item/hero pickers, unit info).
//
// Everything lives inside one IIFE so top-level names stay function-scoped and do not
// collide with the shared global scope of the other src/panorama scripts.
//
// Dropped vs the original React bundle: IconPicker (its gallery only copied JSX strings,
// meaningless without React), per-category column re-layout, window drag & resize, the
// keybind/settings system, and all nettable config that backed them. The layout docking
// direction is now a runtime-only toggle (no persistence).
(() => {
    "use strict";
    var _a, _b;
    const DEFAULT_ICON_SIZE = "32px";
    let refreshFutureRoundsPanel;
    // ---- server events -------------------------------------------------------
    function fireEvent(command, arg = "") {
        const local = Players.GetLocalPlayer();
        if (local === -1 || Players.IsSpectator(local) || Players.IsLocalPlayerLiveSpectating()) {
            return;
        }
        GameEvents.SendCustomGameEventToServer("debug_tool_command", {
            command,
            player_id: local,
            unit: Players.GetLocalPlayerPortraitUnit(),
            position: GameUI.GetCameraLookAtPosition(),
            arg,
        });
    }
    function toggleSelection(pickerName) {
        const pickers = $.GetContextPanel().FindChildrenWithClassTraverse("SelectionContainer");
        for (const picker of pickers) {
            if (picker.id === pickerName) {
                picker.ToggleClass("Show");
            }
            else if (!picker.BHasClass("LockWindow")) {
                picker.SetHasClass("Show", false);
            }
        }
    }
    // ---- tooltip helper ------------------------------------------------------
    function attachTooltip(panel, tooltip, position) {
        if (!tooltip) {
            return;
        }
        if (position) {
            panel.style.tooltipPosition = position;
        }
        panel.SetPanelEvent("onmouseover", () => $.DispatchEvent("DOTAShowTextTooltip", panel, tooltip));
        panel.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip", panel));
    }
    function createIcon(parent, attr, width) {
        var _a;
        const image = $.CreatePanel("Image", parent, "");
        image.AddClass("RR_Icon");
        image.SetImage(attr.src);
        image.style.width = (_a = width !== null && width !== void 0 ? width : attr.width) !== null && _a !== void 0 ? _a : DEFAULT_ICON_SIZE;
        if (attr.height) {
            image.style.height = attr.height;
        }
        return image;
    }
    function createIconButton(parent, buildIcon, opts = {}) {
        const button = $.CreatePanel("Button", parent, "");
        button.AddClass("RR_IconButton");
        if (opts.className) {
            for (const c of opts.className.split(" ")) {
                if (c)
                    button.AddClass(c);
            }
        }
        if (opts.width)
            button.style.width = opts.width;
        if (opts.verticalAlign)
            button.style.verticalAlign = opts.verticalAlign;
        buildIcon(button);
        attachTooltip(button, opts.tooltip, opts.tooltipPosition);
        if (opts.onactivate) {
            button.SetPanelEvent("onactivate", () => opts.onactivate(button));
        }
        return button;
    }
    // ---- portaled option menu (layout docking switcher) ----------------------
    let hudRoot = $.GetContextPanel();
    while (hudRoot.GetParent() != null) {
        hudRoot = hudRoot.GetParent();
    }
    for (const stale of hudRoot.FindChildrenWithClassTraverse("RR_DropDownMenu")) {
        stale.DeleteAsync(-1);
    }
    function attachMenu(button, items, onSelect) {
        const menu = $.CreatePanel("Panel", hudRoot, "");
        menu.AddClass("RR_DropDownMenu");
        menu.visible = false;
        const toggleMenu = (state) => {
            const pos = button.GetPositionWithinWindow();
            menu.SetPositionInPixels(pos.x / menu.actualuiscale_x, (pos.y + button.actuallayoutheight + 2) / button.actualuiscale_y, 0);
            menu.visible = state === undefined ? !menu.visible : state;
            menu.SetHasClass("RR_DropDownMenuShow", menu.visible);
            if (menu.visible) {
                menu.SetFocus();
            }
        };
        for (const item of items) {
            const menuItem = $.CreatePanel("Button", menu, "");
            menuItem.AddClass("RR_DropDownMenuItem");
            const label = $.CreatePanel("Label", menuItem, item.id);
            label.text = item.text;
            menuItem.SetPanelEvent("onactivate", () => {
                onSelect(item.id);
                toggleMenu(false);
            });
            menuItem.SetPanelEvent("onblur", () => toggleMenu(false));
        }
        button.SetPanelEvent("onactivate", () => toggleMenu());
    }
    function sanitizeValue(value, valueType, allowNegative = false) {
        const raw = String(value !== null && value !== void 0 ? value : "");
        if (valueType === "text") {
            return raw;
        }
        const negative = allowNegative && raw.trim().startsWith("-");
        let normalized = raw.replace(/,/g, ".").replace(/-/g, "").replace(/[^0-9.]/g, "");
        if (valueType === "int") {
            normalized = normalized.replace(/\./g, "");
        }
        else if (valueType === "float") {
            const dot = normalized.indexOf(".");
            if (dot !== -1) {
                normalized = normalized.slice(0, dot + 1) + normalized.slice(dot + 1).replace(/\./g, "");
            }
        }
        return `${negative ? "-" : ""}${normalized}`;
    }
    function wireTextEntry(button) {
        const eventName = button.id;
        const valueType = button.BHasClass("ValueInt") ? "int" : button.BHasClass("ValueFloat") ? "float" : "text";
        const allowNegative = button.BHasClass("AllowNegative");
        const entry = button.FindChildTraverse("DemoTextEntry");
        if (!entry) {
            return;
        }
        const submit = () => {
            const sanitized = sanitizeValue(entry.text, valueType, allowNegative);
            if (entry.text !== sanitized) {
                entry.text = sanitized;
            }
            fireEvent(eventName, sanitized);
            $.DispatchEvent("DropInputFocus", entry);
        };
        button.SetPanelEvent("onactivate", submit);
        entry.SetPanelEvent("oninputsubmit", submit);
        entry.SetPanelEvent("ontextentrychange", () => {
            const sanitized = sanitizeValue(entry.text, valueType, allowNegative);
            if (entry.text !== sanitized) {
                entry.text = sanitized;
            }
        });
    }
    function wireControlPanelButtons() {
        const controlPanel = $("#RR_DebugToolControlPanel");
        for (const el of controlPanel.FindChildrenWithClassTraverse("FireEvent")) {
            const id = el.id;
            if (el.BHasClass("DemoToggle")) {
                const toggle = el;
                el.SetPanelEvent("onactivate", () => fireEvent(id, toggle.IsSelected() ? "1" : "0"));
            }
            else {
                el.SetPanelEvent("onactivate", () => fireEvent(id));
            }
        }
        for (const el of controlPanel.FindChildrenWithClassTraverse("ToggleSelection")) {
            const id = el.id;
            el.SetPanelEvent("onactivate", () => toggleSelection(id));
        }
        for (const el of controlPanel.FindChildrenWithClassTraverse("DemoTextEntry")) {
            wireTextEntry(el);
        }
        const futureRoundsButton = $("#FutureRounds");
        if (futureRoundsButton) {
            futureRoundsButton.SetPanelEvent("onactivate", () => {
                toggleSelection("FutureRounds");
                fireEvent("GetFutureRounds");
                refreshFutureRoundsPanel === null || refreshFutureRoundsPanel === void 0 ? void 0 : refreshFutureRoundsPanel();
                $.Schedule(0.1, () => refreshFutureRoundsPanel === null || refreshFutureRoundsPanel === void 0 ? void 0 : refreshFutureRoundsPanel());
            });
        }
    }
    function wireControlPanelChrome() {
        const controlPanel = $("#RR_DebugToolControlPanel");
        const expandArrow = $("#dbg_ExpandArrow");
        let minimized = true;
        let direction = "left";
        const applyDirection = () => {
            controlPanel.SetHasClass("Minimized", minimized);
            controlPanel.SetHasClass("DirectionLeft", direction === "left");
            controlPanel.SetHasClass("DirectionRight", direction === "right");
            controlPanel.SetHasClass("DirectionTop", direction === "top");
        };
        const updateExpandArrow = () => {
            const rotate = minimized ? (direction === "top" ? 90 : 0) : direction === "top" ? 270 : 180;
            expandArrow.style.preTransformRotate2d = rotate + "deg";
        };
        $("#ExpandButton").SetPanelEvent("onactivate", () => {
            minimized = !minimized;
            applyDirection();
            updateExpandArrow();
        });
        attachTooltip($("#dbg_LayoutSwitch"), $.Localize("#HUD_Debug_SwitchLayoutName"));
        attachTooltip($("#dbg_Refresh"), $.Localize("#HUD_Debug_ReloadDataName"));
        $("#dbg_Refresh").SetPanelEvent("onactivate", () => GameEvents.SendEventClientSide("custom_refresh_order", { name: "RefreshContainer" }));
        attachMenu($("#dbg_LayoutSwitch"), [
            { id: "left", text: $.Localize("#HUD_Debug_SwitchLayoutNameLeft") },
            { id: "top", text: $.Localize("#HUD_Debug_SwitchLayoutNameTop") },
            { id: "right", text: $.Localize("#HUD_Debug_SwitchLayoutNameRight") },
        ], (dir) => {
            direction = dir;
            applyDirection();
            updateExpandArrow();
        });
        applyDirection();
        updateExpandArrow();
    }
    // Returns #SelectionList into which picker content should be appended.
    function createSelectContainer(parent, opts) {
        var _a, _b;
        let rawMode = false;
        const container = $.CreatePanel("Panel", parent, opts.eventName);
        container.AddClass("RR_Panel");
        container.AddClass("SelectionContainer");
        container.hittest = true;
        container.style.width = (_a = opts.width) !== null && _a !== void 0 ? _a : "864px";
        container.style.height = (_b = opts.height) !== null && _b !== void 0 ? _b : "620px";
        const picker = $.CreatePanel("Panel", container, "SelectionPicker");
        const header = $.CreatePanel("Panel", picker, "SelectionPickerHeader");
        const title = $.CreatePanel("Label", header, "SelectionTitle");
        title.text = opts.title;
        $.CreatePanel("Panel", header, "").AddClass("FillWidth");
        if (opts.hasFilter !== false) {
            const search = $.CreatePanel("Panel", header, "SelectionSearch");
            search.AddClass("SearchBox");
            const entry = $.CreatePanel("TextEntry", search, "SelectionSearchTextEntry");
            entry.style.borderLeftWidth = "1px";
            entry.SetPanelEvent("oninputsubmit", () => { var _a; return (_a = opts.onSearch) === null || _a === void 0 ? void 0 : _a.call(opts, entry.text); });
            entry.SetPanelEvent("ontextentrychange", () => {
                var _a;
                if (entry.text === "") {
                    (_a = opts.onSearch) === null || _a === void 0 ? void 0 : _a.call(opts, "");
                }
            });
        }
        if (opts.hasRawMode !== false) {
            const codeLabel = $.CreatePanel("Panel", header, "");
            codeLabel.AddClass("RR_Panel");
            codeLabel.AddClass("CodeModeLabel");
            codeLabel.style.height = "28px";
            codeLabel.style.verticalAlign = "center";
            attachTooltip(codeLabel, $.Localize("#HUD_Debug_ShowEncodingName"), "top");
            const toggle = $.CreatePanel("TextButton", codeLabel, "");
            toggle.style.fontSize = "20px";
            toggle.style.width = "27px";
            toggle.style.height = "27px";
            toggle.style.marginTop = "2px";
            toggle.text = "Aa";
            toggle.SetPanelEvent("onactivate", () => {
                var _a;
                rawMode = !rawMode;
                toggle.text = rawMode ? "#" : "Aa";
                (_a = opts.onChangeRawMode) === null || _a === void 0 ? void 0 : _a.call(opts, rawMode);
            });
        }
        if (opts.hasLock !== false) {
            let lock = false;
            const lockBtn = createIconButton(header, (btn) => createIcon(btn, { src: "s2r://panorama/images/profile/icon_locked_psd.vtex" }), {
                width: "26px",
                className: "LockIconButton Unlock",
                tooltip: $.Localize("#HUD_Debug_LockWindowName"),
                tooltipPosition: "top",
            });
            lockBtn.SetPanelEvent("onactivate", () => {
                lock = !lock;
                container.SetHasClass("LockWindow", lock);
                lockBtn.SetHasClass("Unlock", !lock);
            });
        }
        createIconButton(header, (btn) => createIcon(btn, { src: "s2r://panorama/images/control_icons/x_close_png.vtex" }), {
            width: "28px",
            tooltip: $.Localize("#HUD_Debug_CloseWindowName"),
            tooltipPosition: "top",
            onactivate: () => toggleSelection(opts.eventName),
        });
        return $.CreatePanel("Panel", picker, "SelectionList");
    }
    function matchesFilter(name, filterWord, localizedPrefix) {
        if (filterWord === "") {
            return true;
        }
        const re = new RegExp(filterWord, "gim");
        return name.search(re) !== -1 || $.Localize(localizedPrefix + name).search(re) !== -1;
    }
    function createAbilityLikePicker(parent, opts, kind) {
        let filterWord = "";
        let rawMode = false;
        const list = createSelectContainer(parent, {
            eventName: opts.eventName,
            title: opts.title,
            onSearch: (text) => {
                filterWord = text;
                rebuild();
            },
            onChangeRawMode: (value) => {
                rawMode = value;
                rebuild();
            },
        });
        const grid = $.CreatePanel("Panel", list, "");
        grid.AddClass("RR_Panel");
        grid.AddClass("RR_DebugTool_AbilityPicker");
        grid.style.flowChildren = "right-wrap";
        grid.style.width = "100%";
        grid.style.overflow = "squish scroll";
        const rebuild = () => {
            grid.RemoveAndDeleteChildren();
            for (const name of opts.names) {
                if (!matchesFilter(name, filterWord, "#DOTA_Tooltip_ability_")) {
                    continue;
                }
                const item = $.CreatePanel("Button", grid, "");
                item.AddClass("RR_Button");
                item.AddClass("RR_DebugTool_AbilityPickerItem");
                item.style.flowChildren = "down";
                if (kind === "ability") {
                    item.style.width = "64px";
                    const image = $.CreatePanel("DOTAAbilityImage", item, "");
                    image.abilityname = name;
                    image.showtooltip = true;
                }
                else {
                    const image = $.CreatePanel("DOTAItemImage", item, "");
                    image.itemname = name;
                    image.showtooltip = true;
                }
                const label = $.CreatePanel("Label", item, "");
                label.AddClass("RR_DebugTool_AbilityPickerItemName");
                label.text = rawMode ? name : $.Localize("#DOTA_Tooltip_ability_" + name);
                item.SetPanelEvent("onactivate", () => fireEvent(opts.eventName, name));
            }
        };
        rebuild();
    }
    function createHeroPicker(parent, opts) {
        let rawMode = false;
        let filterWord = "";
        const list = createSelectContainer(parent, {
            eventName: opts.eventName,
            title: opts.title,
            onSearch: (text) => {
                filterWord = text;
                rebuild();
            },
            onChangeRawMode: (value) => {
                rawMode = value;
                rebuild();
            },
        });
        const grid = $.CreatePanel("Panel", list, "");
        grid.AddClass("RR_Panel");
        grid.AddClass("RR_DebugTool_AbilityPicker");
        grid.style.flowChildren = "right-wrap";
        grid.style.width = "100%";
        grid.style.overflow = "squish scroll";
        const rebuild = () => {
            grid.RemoveAndDeleteChildren();
            for (const name of opts.names) {
                if (!matchesFilter(name, filterWord, "#")) {
                    continue;
                }
                const item = $.CreatePanel("Button", grid, "");
                item.AddClass("RR_Button");
                item.AddClass("RR_DebugTool_AbilityPickerItem");
                item.style.flowChildren = "down";
                const image = $.CreatePanel("DOTAHeroImage", item, "HeroPickerCardImage");
                image.heroname = name;
                image.heroimagestyle = "portrait";
                image.SetScaling("stretch-to-fit-x-preserve-aspect");
                const label = $.CreatePanel("Label", item, "");
                label.AddClass("RR_DebugTool_AbilityPickerItemName");
                label.text = rawMode ? name : $.Localize("#" + name);
                item.SetPanelEvent("onactivate", () => fireEvent(opts.eventName, name));
            }
        };
        rebuild();
    }
    // ---- ShowUnitInfo ---------------------------------------------------------
    function createUnitInfo(parent) {
        const list = createSelectContainer(parent, {
            eventName: "ShowUnitInfo",
            title: $.Localize("#HUD_DebugUnit_PanelName"),
            width: "480px",
            height: "620px",
            hasRawMode: false,
            hasFilter: false,
        });
        const body = $.CreatePanel("Panel", list, "");
        body.AddClass("RR_Panel");
        body.style.flowChildren = "down";
        const nameLabel = $.CreatePanel("Label", body, "");
        const posLabel = $.CreatePanel("Label", body, "");
        const dirLabel = $.CreatePanel("Label", body, "");
        const hpLabel = $.CreatePanel("Label", body, "");
        const manaLabel = $.CreatePanel("Label", body, "");
        const modLabel = $.CreatePanel("Label", body, "");
        modLabel.text = "Modifier：";
        const buffsContainer = $.CreatePanel("Panel", body, "");
        buffsContainer.style.flowChildren = "down";
        const vecStr = (v) => (v ? `${Float(v[0])}, ${Float(v[1])}, ${Float(v[2])}` : "");
        const tick = () => {
            const unit = Players.GetLocalPlayerPortraitUnit();
            nameLabel.text = $.Localize("#HUD_DebugUnit_UnitName") + "：" + `(${unit})` + Entities.GetUnitName(unit);
            posLabel.text = $.Localize("#HUD_DebugUnit_PositionName") + "：" + vecStr(Entities.GetAbsOrigin(unit));
            dirLabel.text = $.Localize("#HUD_DebugUnit_DirectionName") + "：" + vecStr(Entities.GetForward(unit));
            hpLabel.text = $.Localize("#HUD_DebugUnit_HealthName") + "：" + Entities.GetHealth(unit) + "/" + Entities.GetMaxHealth(unit);
            manaLabel.text = $.Localize("#HUD_DebugUnit_ManaName") + "：" + Entities.GetMana(unit) + "/" + Entities.GetMaxMana(unit);
            buffsContainer.RemoveAndDeleteChildren();
            const count = Entities.GetNumBuffs(unit);
            for (let i = 0; i < count; i++) {
                const label = $.CreatePanel("Label", buffsContainer, "");
                label.text = "\t\t" + Buffs.GetName(unit, Entities.GetBuff(unit, i));
            }
            $.Schedule(Game.GetGameFrameTime(), tick);
        };
        tick();
    }
    function localizeToken(token) {
        if (!token) {
            return "";
        }
        const localized = $.Localize(token);
        return localized === token ? token.replace(/^#/, "") : localized;
    }
    function createFutureRounds(parent) {
        const list = createSelectContainer(parent, {
            eventName: "FutureRounds",
            title: $.Localize("#HUD_FutureRounds_Title"),
            width: "640px",
            height: "720px",
            hasRawMode: false,
            hasFilter: false,
        });
        const body = $.CreatePanel("Panel", list, "");
        body.AddClass("RR_Panel");
        body.AddClass("RR_DebugTool_FutureRounds");
        body.style.flowChildren = "down";
        body.style.width = "100%";
        body.style.overflow = "squish scroll";
        const readChunkEntries = (chunk) => {
            var _a;
            const entries = (_a = chunk === null || chunk === void 0 ? void 0 : chunk.entries) !== null && _a !== void 0 ? _a : {};
            return Object.keys(entries)
                .sort((left, right) => Number(left) - Number(right))
                .map((key) => entries[key])
                .filter((entry) => entry != null);
        };
        const render = (entries) => {
            var _a, _b, _c;
            body.RemoveAndDeleteChildren();
            entries.sort((left, right) => { var _a, _b; return Number((_a = left.number) !== null && _a !== void 0 ? _a : 0) - Number((_b = right.number) !== null && _b !== void 0 ? _b : 0); });
            for (const entry of entries) {
                if (!entry) {
                    continue;
                }
                const row = $.CreatePanel("Button", body, "");
                row.AddClass("RR_DebugTool_FutureRoundItem");
                row.SetPanelEvent("onactivate", () => fireEvent("JumpToRound", String(entry.number)));
                const header = $.CreatePanel("Panel", row, "");
                header.AddClass("RR_DebugTool_FutureRoundHeader");
                const title = $.CreatePanel("Label", header, "");
                title.AddClass("RR_DebugTool_FutureRoundTitle");
                title.text = `${entry.number}. ${localizeToken(entry.name)}`;
                const count = $.CreatePanel("Label", header, "");
                count.AddClass("RR_DebugTool_FutureRoundCount");
                count.text = String((_a = entry.count) !== null && _a !== void 0 ? _a : 0);
                const creatures = $.CreatePanel("Panel", row, "");
                creatures.AddClass("RR_DebugTool_FutureRoundCreatures");
                const creatureList = (_b = entry.creatures) !== null && _b !== void 0 ? _b : {};
                const creatureKeys = Object.keys(creatureList).sort((left, right) => Number(left) - Number(right));
                for (const creatureKey of creatureKeys) {
                    const creature = creatureList[creatureKey];
                    if (!creature) {
                        continue;
                    }
                    const label = $.CreatePanel("Label", creatures, "");
                    label.AddClass("RR_DebugTool_FutureRoundCreature");
                    const unitName = localizeToken("#" + creature.name);
                    label.text = `${unitName} x${(_c = creature.count) !== null && _c !== void 0 ? _c : 0}`;
                }
            }
        };
        const renderFromNetTables = () => {
            var _a;
            const meta = CustomNetTables.GetTableValue("rounds", "debug_future_rounds_meta");
            const chunkCount = Number((_a = meta === null || meta === void 0 ? void 0 : meta.chunk_count) !== null && _a !== void 0 ? _a : 5);
            const entries = [];
            for (let chunkIndex = 1; chunkIndex <= chunkCount; chunkIndex++) {
                const chunk = CustomNetTables.GetTableValue("rounds", `debug_future_rounds_${chunkIndex}`);
                entries.push(...readChunkEntries(chunk));
            }
            render(entries);
        };
        refreshFutureRoundsPanel = renderFromNetTables;
        CustomNetTables.SubscribeNetTableListener("rounds", (_tableName, key) => {
            const keyName = String(key);
            if (keyName === "debug_future_rounds_meta" || keyName.indexOf("debug_future_rounds_") === 0) {
                renderFromNetTables();
            }
        });
        renderFromNetTables();
    }
    // ---- data lists ----------------------------------------------------------
    function getNeutralItemList() {
        const items = [];
        const pool = GameUI.CustomUIConfig().NeutralItemsPool;
        for (const level in pool) {
            const info = pool[level];
            if (info && info.items) {
                for (const itemName in info.items) {
                    if (itemName !== "") {
                        items.push(itemName);
                    }
                }
            }
        }
        return items;
    }
    function getAbilityList() {
        const abilities = [];
        const pool = GameUI.CustomUIConfig().AbilitiesPool;
        for (const hero in pool) {
            if (pool[hero] != null) {
                for (const i in pool[hero]) {
                    if (!Number.isNaN(Number(i))) {
                        abilities.push(pool[hero][i]);
                    }
                }
            }
        }
        return abilities;
    }
    // ---- init ----------------------------------------------------------------
    function buildWindows() {
        const host = $("#RR_DebugTool");
        createAbilityLikePicker(host, { eventName: "AddAbility", title: $.Localize("#HUD_AddAbility"), names: getAbilityList() }, "ability");
        createAbilityLikePicker(host, { eventName: "AddNeutralItem", title: $.Localize("#HUD_AddNeutralItem"), names: getNeutralItemList() }, "item");
        createHeroPicker(host, { eventName: "ReplaceHero", title: $.Localize("#HUD_ReplaceHero"), names: Object.keys(GameUI.CustomUIConfig().HeroListKv) });
        createUnitInfo(host);
        createFutureRounds(host);
    }
    const admins = CustomNetTables.GetTableValue("admin", "admins");
    const steamid = String((_b = (_a = Game.GetPlayerInfo(Game.GetLocalPlayerID())) === null || _a === void 0 ? void 0 : _a.player_steamid) !== null && _b !== void 0 ? _b : "0");
    const steamId32 = Number(steamid.substr(3)) - 61197960265728;
    const authorized = (admins && Object.values(admins).includes(steamId32)) || Game.GetConvarInt("sv_cheats") === 1;
    if (!authorized) {
        $("#RR_DebugTool").visible = false;
    }
    else {
        if (!Game.IsInToolsMode()) {
            $("#dbg_CategoryOther").visible = false;
        }
        buildWindows();
        wireControlPanelButtons();
        wireControlPanelChrome();
    }
})();