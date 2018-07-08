
local LII = LibStub:GetLibrary("LibItemInfo-1.0")

local colorYellow 		= "|cFFFF00" 	-- yellow 
local colorGreen 		= "|c00FF00" 	-- green
local colorRed 			= "|cFF0000" 	-- Red

--------------------------------------------------------------------
--  Process Item --
-- Determines if the itemType is handled by the addon before processing it to see if it is junk --
--------------------------------------------------------------------
--[[
local function ShouldProcessItem(_iBagId, _iSlotId)
	local isHandled, reason = AutoJunker.IsAHandledItemType(_iBagId, _iSlotId)
	
	AutoJunker.DebugWin:AddText(sJunkReason)
	if isHandled then return true end
	
	return false
end
--]]
----------------------------------------------------------
--  On Slot Update (called from: SlotUpdate(), called from EVENT_INVENTORY_SINGLE_SLOT_UPDATE) --
-- Main code to make calls to see if an item is Junk, set the item to junk (or not) and calls --
-- print chat messages. --
----------------------------------------------------------
function AutoJunker.OnSlotUpdate(_iBagId, _iSlotId) 
	if not AutoJunker.SavedVariables["JUNKMODE"] then return end
	
	local bIsItemJunk, sJunkReason = AutoJunker.IsItemJunk(_iBagId, _iSlotId)
	
	SetItemIsJunk(_iBagId, _iSlotId, bIsItemJunk)
	AutoJunker.PrintChatMessages(_iBagId,  _iSlotId, bIsItemJunk)
	AutoJunker.DebugWin:AddText(sJunkReason)
	
	if bIsItemJunk then
		AutoJunker.DestroyCheck(_iBagId, _iSlotId)
		return true
	end
	return false
end

-----------------------------------------------------------------
-- When using the consolidate area loot you still get gold updates for each body. We temporarily hold the amount for a few ms until the message is printed. So all of the gold can be added up.
----------------------------------------------------------------
function AutoJunker.OnMoneyLooted(_iGoldAmount, _Reason) 
	if _iGoldAmount > 0 then
		-- If the gold holder is empty then we need to start a new (delayed) print gold message --
		if AutoJunker.GoldGainHold == 0 then
			zo_callLater(function() 
				AutoJunker.PrintGoldMessage(_Reason, true) 
				AutoJunker.GoldGainHold = 0
				end, 300)
		end
		-- Put the gold into a temporary holder so we can add it up --
		AutoJunker.GoldGainHold = AutoJunker.GoldGainHold + _iGoldAmount
	elseif _iGoldAmount < 0 then
		-- If the gold holder is empty then we need to start a new (delayed) print gold message --
		if AutoJunker.GoldLostHold == 0 then
			zo_callLater(function() 
				AutoJunker.PrintGoldMessage(_Reason, false) 
				AutoJunker.GoldLostHold = 0
				end, 300)
		end
		-- Put the gold into a temporary holder so we can add it up --
		AutoJunker.GoldLostHold = AutoJunker.GoldLostHold + _iGoldAmount
	end
end


