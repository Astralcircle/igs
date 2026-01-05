--[[-------------------------------------------------------------------------
	Через этот файл невозможно повсеместно изменить скин.
	Да и вообще, все в говно на самом деле, но мне лень уже делать все правильно.
	Это куча геммора, который, скорее всего, никому не нужен
---------------------------------------------------------------------------]]

IGS.S = IGS.S or {}

IGS.S.COLORS = {
	FRAME_HEADER        = classicbox.enums.color_base, -- Фон верхушки фреймов в т.ч. пополнения счета и т.д. https://img.qweqwe.ovh/1491950958825.png
	ACTIVITY_BG         = classicbox.enums.color_base, -- Фон в каждой вкладке (основной) https://img.qweqwe.ovh/1509370647204.png
	TAB_BAR             = classicbox.enums.color_base, -- Фон таб бара https://img.qweqwe.ovh/1509370669492.png

	PASSIVE_SELECTIONS  = classicbox.enums.color_scoreboard, -- Фон панели тегов, цвет кнопки с балансом, верхушки таблиц, не выделенные кнопки https://img.qweqwe.ovh/1509370720597.png
	INNER_SELECTIONS    = classicbox.enums.color_scoreboard, -- Фон иконок на плашках, фон панелек последних покупок... https://img.qweqwe.ovh/1509370766148.png

	SOFT_LINE           = Color(255,122,0), -- Линия между секциями, типа "Информация" и "Описание" в инфе об итеме
	HARD_LINE           = color_black, -- Обводки панелей

	HIGHLIGHTING        = Color(255,122,0),   -- Обводка кнопок, цвет текста не активной кнопки
	HIGHLIGHT_INACTIVE  = Color(160,160,160), -- Цвет иконки неактивной кнопки таббара, мигающая иконка на фрейме помощи https://img.qweqwe.ovh/1509371884592.png

	TEXT_HARD           = color_white,       -- Заголовки, выделяющиеся тексты https://img.qweqwe.ovh/1509372019687.png
	TEXT_SOFT           = Color(200,200,200), -- Описания, значения чего-то
	TEXT_ON_HIGHLIGHT   = color_white, -- Цвет текста на выделенных кнопках

	LOG_SUCCESS         = Color(76,217,100),  -- В логах пополнения цвет успешных операций
	LOG_ERROR           = Color(220,30,70),   -- В логах пополнения цвет ошибок
	LOG_NORMAL          = color_white,       -- В логах пополнения обычные записи

	ICON                = color_white, -- цвет иконок на плашечках
}

IGS.col = IGS.S.COLORS
local rndx = classicbox.rndx

-- https://img.qweqwe.ovh/1486557631077.png
IGS.S.Panel = function(s,w,h,lL,tL,rL,bL)
	rndx.Draw(0, 0, 0, w, h, IGS.col.PASSIVE_SELECTIONS) -- bg

	surface.SetDrawColor(IGS.col.HARD_LINE) -- outline

	if lL then surface.DrawLine(0,0,0,h) end -- left line
	if tL then surface.DrawLine(0,0,w,0) end -- top line
	if rL then surface.DrawLine(w,0,w,h) end -- right line
	if bL then surface.DrawLine(0,h - 1,w,h - 1) end -- bottom line
end

-- https://img.qweqwe.ovh/1486557676799.png
IGS.S.RoundedPanel = function(s,w,h)
	rndx.Draw(4, 0, 0, w, h, IGS.col.INNER_SELECTIONS)
	rndx.DrawOutlined(4, 0, 0, w, h, IGS.col.HARD_LINE, 1)

	return true
end

-- igs\vgui\igs_frame.lua
IGS.S.Frame = function(s,w,h)
	rndx.Draw(0, 0, 0, w, h, IGS.col.ACTIVITY_BG) -- bg

	-- /header
	local th = s:GetTitleHeight()
	rndx.Draw(0, 0, 0, w, th, IGS.col.FRAME_HEADER)
	surface.SetDrawColor(IGS.col.HARD_LINE)
	surface.DrawLine(0,th - 1,w,th - 1)
	-- \header
end

-- igs\vgui\igs_table.lua
IGS.S.TablePanel = function(s,w,h)
	if s.header_tall then
		IGS.S.Panel(s,w,s.header_tall) -- header
	end
end

-- igs_table, igs_frame
IGS.S.Outline = function(s,w,h)
	surface.SetDrawColor(IGS.col.HARD_LINE)

	-- https://img.qweqwe.ovh/1486830692390.png
	surface.DrawLine(0,h,0,0)
	surface.DrawLine(0,0,w,0)
	surface.DrawLine(w - 1,0,w - 1,h)
	surface.DrawLine(w,h - 1,0,h - 1)
end
