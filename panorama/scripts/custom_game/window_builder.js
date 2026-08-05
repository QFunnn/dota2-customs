--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


(function () {
    "use strict";

    const SLICE_ROOT = "s2r://panorama/images/custom_game/ui_slices";
    const themes = {};

    const DEFAULT_THEME = {
        name: "obsidian",
        padding: 96,
        tileSize: 96,
        textures: {
            corners: {
                tl: `${SLICE_ROOT}/obsidian/left-top_png.vtex`,
                tr: `${SLICE_ROOT}/obsidian/right-top_png.vtex`,
                bl: `${SLICE_ROOT}/obsidian/left-bottom_png.vtex`,
                br: `${SLICE_ROOT}/obsidian/right-bottom_png.vtex`
            },
            borders: {
                top: `${SLICE_ROOT}/obsidian/top-center_png.vtex`,
                bottom: `${SLICE_ROOT}/obsidian/bottom-center_png.vtex`,
                left: `${SLICE_ROOT}/obsidian/left-center_png.vtex`,
                right: `${SLICE_ROOT}/obsidian/right-center_png.vtex`
            },
            background: `${SLICE_ROOT}/obsidian/bg_png.vtex`
        }
    };

    registerTheme(DEFAULT_THEME.name, DEFAULT_THEME);

    function registerTheme(name, config) {
        themes[name] = {
            padding: config.padding ?? DEFAULT_THEME.padding,
            tileSize: config.tileSize ?? DEFAULT_THEME.tileSize,
            textures: {
                corners: Object.assign({}, DEFAULT_THEME.textures.corners, config.textures?.corners),
                borders: Object.assign({}, DEFAULT_THEME.textures.borders, config.textures?.borders),
                background: config.textures?.background ?? DEFAULT_THEME.textures.background
            }
        };
    }

    function create(parent, themeName, size = {}) {
        if (!parent) {
            $.Msg("[WindowBuilder] parent panel is required");
            return null;
        }

        const theme = themes[themeName] || themes[DEFAULT_THEME.name];
        const padding = size.padding ?? theme.padding;
        const width = size.width ?? 640;
        const height = size.height ?? 420;

        const root = $.CreatePanel("Panel", parent, size.id || "");
        root.AddClass("window-frame");
        root.hittest = false;
        root.style.width = `${width}px`;
        root.style.height = `${height}px`;
        root.style.horizontalAlign = "center";
        root.style.verticalAlign = "center";

        const overlay = $.CreatePanel("Panel", root, "");
        overlay.style.width = "100%";
        overlay.style.height = "100%";
        overlay.hittest = false;

        const content = $.CreatePanel("Panel", root, size.contentId || "");
        content.AddClass("window-frame__content");
        content.style.width = "100%";
        content.style.height = "100%";
        content.style.padding = `${padding}px`;

        buildSlices(overlay, theme, padding);

        return {
            root,
            content,
            padding,
            setSize: (w, h) => {
                root.style.width = `${w}px`;
                root.style.height = `${h}px`;
            },
            destroy: () => root?.DeleteAsync(0)
        };
    }

    function buildSlices(container, theme, padding) {
        const tile = theme.tileSize;

        createCorner(container, "left", "top", theme.textures.corners.tl, tile);
        createCorner(container, "right", "top", theme.textures.corners.tr, tile);
        createCorner(container, "left", "bottom", theme.textures.corners.bl, tile);
        createCorner(container, "right", "bottom", theme.textures.corners.br, tile);

        createBorder(container, {
            orientation: "horizontal",
            texture: theme.textures.borders.top,
            height: tile,
            marginLeft: padding,
            marginRight: padding,
            verticalAlign: "top"
        });

        createBorder(container, {
            orientation: "horizontal",
            texture: theme.textures.borders.bottom,
            height: tile,
            marginLeft: padding,
            marginRight: padding,
            verticalAlign: "bottom"
        });

        createBorder(container, {
            orientation: "vertical",
            texture: theme.textures.borders.left,
            width: tile,
            marginTop: padding,
            marginBottom: padding,
            horizontalAlign: "left"
        });

        createBorder(container, {
            orientation: "vertical",
            texture: theme.textures.borders.right,
            width: tile,
            marginTop: padding,
            marginBottom: padding,
            horizontalAlign: "right"
        });

        const bg = $.CreatePanel("Panel", container, "");
        bg.AddClass("window-frame__bg");
        bg.style.marginTop = `${padding}px`;
        bg.style.marginBottom = `${padding}px`;
        bg.style.marginLeft = `${padding}px`;
        bg.style.marginRight = `${padding}px`;
        bg.style.backgroundImage = `url("${theme.textures.background}")`;
        bg.style.backgroundRepeat = "repeat";
        bg.style.backgroundSize = `${tile * 2}px ${tile * 2}px`;
        bg.style.opacity = "1.0";
        bg.hittest = false;
    }

    function createCorner(parent, horizontal, vertical, texture, size) {
        const corner = $.CreatePanel("Panel", parent, "");
        corner.AddClass("window-frame__corner");
        corner.style.width = `${size}px`;
        corner.style.height = `${size}px`;
        corner.style.horizontalAlign = horizontal;
        corner.style.verticalAlign = vertical;
        corner.style.backgroundImage = `url("${texture}")`;
        corner.style.backgroundRepeat = "no-repeat";
        corner.style.backgroundSize = `${size}px ${size}px`;
        corner.hittest = false;
        return corner;
    }

    function createBorder(parent, data) {
        const border = $.CreatePanel("Panel", parent, "");
        border.AddClass(`window-frame__border window-frame__border--${data.orientation}`);
        border.style.backgroundImage = `url("${data.texture}")`;
        border.style.backgroundRepeat = data.orientation === "horizontal" ? "repeat-x" : "repeat-y";
        border.style.backgroundSize = data.orientation === "horizontal"
            ? `${data.height * 2}px ${data.height}px`
            : `${data.width}px ${data.width * 2}px`;
        border.style.horizontalAlign = data.horizontalAlign || "center";
        border.style.verticalAlign = data.verticalAlign || "center";

        if (data.orientation === "horizontal") {
            border.style.height = `${data.height}px`;
            border.style.marginLeft = `${data.marginLeft || 0}px`;
            border.style.marginRight = `${data.marginRight || 0}px`;
            border.style.width = "100%";
        } else {
            border.style.width = `${data.width}px`;
            border.style.marginTop = `${data.marginTop || 0}px`;
            border.style.marginBottom = `${data.marginBottom || 0}px`;
            border.style.height = "100%";
        }

        border.hittest = false;
        return border;
    }

    const WindowBuilder = {
        registerTheme,
        create,
        getTheme: (name) => themes[name] || themes[DEFAULT_THEME.name]
    };

    GameUI.CustomUIConfig().WindowBuilder = WindowBuilder;
})();