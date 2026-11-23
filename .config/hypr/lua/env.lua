-- Время в 24 часах, язык при этом остаётся английским.
--
-- Формат часов приложения берут из LC_TIME, а не из своих настроек: en_US
-- означает «12 часов и AM/PM», и Telegram, календари и всё остальное
-- показывали 12:02 AM вместо 00:02. Отдельная переменная, а не смена LANG:
-- меняем ровно формат времени, не трогая язык интерфейса.
hl.env("LC_TIME", "en_GB.UTF-8")

-- Курсор: Bibata Modern Classic — чёрный, без обводки и теней, ровно под
-- тёмную оболочку. Имя темы нужно и в переменных (их читают Xwayland и
-- программы на GTK/Qt), и в самом Hyprland — он рисует курсор сам.
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GDK_SCALE", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Батарея: Hyprland открывает только Intel iGPU, чтобы NVIDIA не просыпалась
-- и спала в D3cold. Игры/тяжёлые программы — через prime-run. Внешний монитор
-- в HDMI на NVIDIA (HDMI-A-3) так работать не будет — закомментируй строку.
-- Путь через симлинк: в by-path есть ':', а это разделитель списка.
-- Переключатель: `gpumode nvidia` / `gpumode intel` (fish), затем перелогиниться.
-- Без зарядки NVIDIA не открывается даже в режиме nvidia: вход на батарее
-- всегда даёт только iGPU.
local hypr = os.getenv("HOME") .. "/.config/hypr/"
local function on_ac()
    local a = io.open("/sys/class/power_supply/AC/online", "r")
    if not a then return true end
    local v = a:read("*l")
    a:close()
    return v == "1"
end
local f = io.open(hypr .. "nvidia-mode", "r")
if f then f:close() end
if f and on_ac() then
    hl.env("AQ_DRM_DEVICES", hypr .. "intel-igpu:" .. hypr .. "nvidia-dgpu")
else
    hl.env("AQ_DRM_DEVICES", hypr .. "intel-igpu")
end
