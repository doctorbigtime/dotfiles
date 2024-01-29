" Vim syntax file
" Language:	C++ special highlighting for misc C++ classes
" Maintainer:	Sebastien F.
" Last Change:	2017/11/22


syn keyword cppVplatNamespace vhl vpl common

syn keyword cppVplatMacro     VPL_LOG_ERROR VPL_LOG_INFO VPL_LOG_WARNING

syn keyword cppVplatType      CXmlNode
syn keyword cppVplatType      ExchIdxT
syn keyword cppVplatType      StrategyStates

syn keyword cppVplatType      IExecution
syn keyword cppVplatType      IPosition
syn keyword cppVplatType      IUtils
syn keyword cppVplatType      IOrderUpdate
syn keyword cppVplatType      IMarketDataUpdate
syn keyword cppVplatType      ITimerCallback
syn keyword cppVplatType      VPStratLauncher
syn keyword cppVplatType      Sides
syn keyword cppVplatType      CString
syn keyword cppVplatType      CPrice
syn keyword cppVplatType      CTimeSpec
syn keyword cppVplatType      CDate
syn keyword cppVplatType      CDateTime
syn keyword cppVplatType      CSystem
syn keyword cppVplatType      UInt64
syn keyword cppVplatType      Int64
syn keyword cppVplatType      UInt32
syn keyword cppVplatType      Int32
syn keyword cppVplatType      InstIdxT
syn keyword cppVplatType      IvTradeOrderMsg 
syn keyword cppVplatType      IvTradeAmendOrderAcceptMsg
syn keyword cppVplatType      IvTradeAmendOrderRejectMsg 
syn keyword cppVplatType      IvTradeBustedFillMsg 
syn keyword cppVplatType      IvTradeCancelOrderAcceptMsg 
syn keyword cppVplatType      IvTradeCancelOrderRejectMsg 
syn keyword cppVplatType      IvTradeFillFullMsg 
syn keyword cppVplatType      IvTradeFillPartialMsg 
syn keyword cppVplatType      IvTradeNewOrderAcceptMsg 
syn keyword cppVplatType      IvTradeNewOrderRejectMsg 
syn keyword cppVplatType      IvTradeOrderLapseMsg 
syn keyword cppVplatType      IvTradeOrderOutMsg 
syn keyword cppVplatType      IvTradeOrderRefreshMsg 
syn keyword cppVplatType      IvTradeMassCancelOrderAcceptMsg 
syn keyword cppVplatType      IvTradeMassCancelOrderRejectMsg 
syn keyword cppVplatType      IvRefData
syn keyword cppVplatType      ISystemUpdate

syn keyword cppVplatType      IvFiniteDepthBook
syn keyword cppVplatType      IvFiniteDepthBookMsg
syn keyword cppVplatType      IvBookOrderUpdateMsg 

syn keyword cppVplatType      TradeOrderRequest 

syn keyword cppVplatType      MultiBookBuilder
syn keyword cppVplatType      IvBookGroup
syn keyword cppVplatType      CvBookConfig
syn keyword cppVplatType      VHL_UNIVERSE_MANAGER
syn keyword cppVplatType      VHL_PROCESS_MANAGER

" Market data
syn keyword cppVplatType      IvBookAdapterChannelStateMsg 
syn keyword cppVplatType      IvBookEndOfReplayMsg 
syn keyword cppVplatType      IvBookMultiMsg
syn keyword cppVplatType      IvBookTradeMsg
syn keyword cppVplatType      IvBookSecurityStatusMsg
syn keyword cppVplatType      IvBookLevelsUpdatedMsg
syn keyword cppVplatType      IvBookFiniteDepthMsg
syn keyword cppVplatType      IvBookAuctionInfoMsg
syn keyword cppVplatType      IvBookStatisticMsg

syn keyword cppVplatType      TimeInfo
syn keyword cppVplatType      MDBookInfoMsg
syn keyword cppVplatType      MDSecurityStatusMsg
syn keyword cppVplatType      MDTradeMsg
syn keyword cppVplatType      MDAddOrderMsg
syn keyword cppVplatType      MDDeleteOrderMsg
syn keyword cppVplatType      MDAmendOrderMsg
syn keyword cppVplatType      MDLevelByIndexMsg
syn keyword cppVplatType      MDFeedStatusMsg
syn keyword cppVplatType      MDReplayEndMsg
syn keyword cppVplatType      MDExecuteOrderMsg
syn keyword cppVplatType      MDAuctionMsg
syn keyword cppVplatType      MDStatisticMsg
syn keyword cppVplatType      MDLevelByPriceMsg
syn keyword cppVplatType      MDBookInfoMsgWithQuote

syn keyword cppVplatType      EventBasedMarketDataLock
syn keyword cppVplatType      EventBasedMarketDataUnlock
syn keyword cppVplatType      EventBasedMarketDataAddOrder
syn keyword cppVplatType      EventBasedMarketDataModifyOrder
syn keyword cppVplatType      EventBasedMarketDataReplaceOrder
syn keyword cppVplatType      EventBasedMarketDataModifyQPreserveOrder
syn keyword cppVplatType      EventBasedMarketDataDeleteOrder
syn keyword cppVplatType      EventBasedMarketDataExecuteOrder
syn keyword cppVplatType      EventBasedMarketDataTrade
syn keyword cppVplatType      EventBasedMarketDataClearBids
syn keyword cppVplatType      EventBasedMarketDataClearAsks
syn keyword cppVplatType      EventBasedMarketDataLevelByPriceAdd
syn keyword cppVplatType      EventBasedMarketDataLevelByPriceModify
syn keyword cppVplatType      EventBasedMarketDataLevelByPriceDelete
syn keyword cppVplatType      EventBasedMarketDataLevelByIndexAdd
syn keyword cppVplatType      EventBasedMarketDataLevelByIndexModify
syn keyword cppVplatType      EventBasedMarketDataLevelByIndexDelete
syn keyword cppVplatType      EventBasedMarketDataStatistic
syn keyword cppVplatType      EventBasedMarketDataSecurityStatus
syn keyword cppVplatType      EventBasedMarketDataFeedStatus

syn keyword cppVplatType      IvBookMsgProcessorNew
syn keyword cppVplatType      Decimal
syn keyword cppVplatType      FeedType
syn keyword cppVplatType      FeedStatus

syn keyword cppVplatType      CvTradeAmendOrderRequestMsg
syn keyword cppVplatType      CvRefDataBase
syn keyword cppVplatType      CvTradeCancelOrderRequestMsg
syn keyword cppVplatType      CvTradeCancelOrderAcceptMsg
syn keyword cppVplatType      CvTradeNewOrderRequestMsg
syn keyword cppVplatType      CvTradeNewOrderAcceptMsg
syn keyword cppVplatType      CvTradeFillPartialMsg
syn keyword cppVplatType      CvTradeFillFullMsg
syn keyword cppVplatType      CvTradeAmendOrderRequestMsg
syn keyword cppVplatType      CvTradeAmendOrderAcceptMsg

syn keyword cppVplatConst     eSide_Undefined
syn keyword cppVplatConst     eSide_Buy
syn keyword cppVplatConst     eSide_Sell
syn keyword cppVplatConst     eSide_Bid
syn keyword cppVplatConst     eSide_Ask

syn keyword cppVplatConst     eStatisticType_Bid
syn keyword cppVplatConst     eStatisticType_Offer
syn keyword cppVplatConst     eStatisticType_LastTrade
syn keyword cppVplatConst     eStatisticType_OpeningPrice
syn keyword cppVplatConst     eStatisticType_SettlementPrice
syn keyword cppVplatConst     eStatisticType_TradingSessionHighPrice
syn keyword cppVplatConst     eStatisticType_TradingSessionLowPrice
syn keyword cppVplatConst     eStatisticType_TradeVolume
syn keyword cppVplatConst     eStatisticType_OpenInterest
syn keyword cppVplatConst     eStatisticType_Bid
syn keyword cppVplatConst     eStatisticType_Offer
syn keyword cppVplatConst     eStatisticType_EmptyBook
syn keyword cppVplatConst     eStatisticType_SessionHighBid
syn keyword cppVplatConst     eStatisticType_SessionLowOffer
syn keyword cppVplatConst     eStatisticType_Undefined

syn keyword cppVplatConst     eImpliedType_Non_Implied
syn keyword cppVplatConst     eImpliedType_Implied

syn keyword cppVplatConst     eTradeType_Summary
syn keyword cppVplatConst     eTradeType_Agg
syn keyword cppVplatConst     eTradeType_Resting
syn keyword cppVplatConst     eTradeType_Undefined
syn keyword cppVplatConst     eTradeType_ConventionalTrade
syn keyword cppVplatConst     eTradeType_NonPrintable
syn keyword cppVplatConst     eTradeType_NonPrintableOffBook
syn keyword cppVplatConst     eTradeType_OffBook
syn keyword cppVplatConst     eTradeType_EarlyOpeningAuction
syn keyword cppVplatConst     eTradeType_OpeningAuction
syn keyword cppVplatConst     eTradeType_ReopeningAuction
syn keyword cppVplatConst     eTradeType_ClosingAuction

syn keyword cppVplatConst     eUpdateAction_New
syn keyword cppVplatConst     eUpdateAction_Change
syn keyword cppVplatConst     eUpdateAction_Delete

syn keyword cppVplatConst     eUpdateAction_Delete

syn keyword cppVplatConst     eSecurityStatus_Undefined
syn keyword cppVplatConst     eSecurityStatus_TradingHalt
syn keyword cppVplatConst     eSecurityStatus_Closed
syn keyword cppVplatConst     eSecurityStatus_PriceIndication
syn keyword cppVplatConst     eSecurityStatus_ReadyToTrade
syn keyword cppVplatConst     eSecurityStatus_Halted
syn keyword cppVplatConst     eSecurityStatus_ShortSellRegulationEffective
syn keyword cppVplatConst     eSecurityStatus_NotAvailableForTrading
syn keyword cppVplatConst     eSecurityStatus_Paused
syn keyword cppVplatConst     eSecurityStatus_UnknownOrInvalid
syn keyword cppVplatConst     eSecurityStatus_PreOpen
syn keyword cppVplatConst     eSecurityStatus_PreCross
syn keyword cppVplatConst     eSecurityStatus_Cross
syn keyword cppVplatConst     eSecurityStatus_NoCancel
syn keyword cppVplatConst     eSecurityStatus_Continuous
syn keyword cppVplatConst     eSecurityStatus_QuotationOnly

syn keyword cppVplatConst     eFeedStatus_Undefined
syn keyword cppVplatConst     eFeedStatus_Caution
syn keyword cppVplatConst     eFeedStatus_Down
syn keyword cppVplatConst     eFeedStatus_Up

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppVplatNamespace  Constant
  HiLink cppVplatMacro      Constant
  HiLink cppVplatType       Typedef
  HiLink cppVplatConst      Constant
  HiLink cppVplatFunction   Function
  delcommand HiLink
endif


