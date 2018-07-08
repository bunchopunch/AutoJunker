
-- Button Callbacks, they are here because I want them to stay local


ESO_Dialogs["AutoJunker_ERROR"] = {
	title = {
		text = "<<1>> ERROR",
	},
	mainText = {
		text = "<<1>>",
		align = TEXT_ALIGN_CENTER,
	},
	buttons = {
		[1] = {
			text = "Ok",
		},
	},
}
ESO_Dialogs["AutoJunker_CONFIRM_SELL_JUNK"] = {
	title = {
		text = "<<1>>",
	},
	mainText = {
		text = "<<1>>",
		align = TEXT_ALIGN_CENTER,
	},
	buttons = {
		[1] = {
			text = "YES",
			callback = function(dialog) AutoJunker.SellJunk() end,
		},
		[2] = {
			text = "NO",
		},
	},
}
ESO_Dialogs["AutoJunker_CONFIRM_SELL_FENCE"] = {
	title = {
		text = "<<1>>",
	},
	mainText = {
		text = "<<1>>",
		align = TEXT_ALIGN_CENTER,
	},
	buttons = {
		[1] = {
			text = "YES",
			callback = function(dialog) AutoJunker.SellFenceItems() end,
		},
		[2] = {
			text = "NO",
		},
	},
}
ESO_Dialogs["AutoJunker_CONFIRM_DESTROY_0VALUE"] = {
	title = {
		text = "<<1>>",
	},
	mainText = {
		text = "<<1>> <<2>>?",
		align = TEXT_ALIGN_CENTER,
	},
	buttons = {
		[1] = {
			text = "Yes",
			callback = function(dialog) AutoJunker.DestroyItem(dialog.data[1], dialog.data[2]) end,
		},
		[2] = {
			text = "No",
		},
	},
}
------------------------------------------------------------------------------------------------------------------
-- Create the parent loot window 																				--
------------------------------------------------------------------------------------------------------------------
function AutoJunker.ShowErrorDialog(_sErrorType, _sErrorMessage)
	ZO_Dialogs_ShowDialog("AutoJunker_ERROR", nil, {titleParams={_sErrorType}, mainTextParams={_sErrorMessage}})
end
