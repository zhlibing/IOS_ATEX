//
//  UrlDefine.h
//  SSKJ
//
//  Created by James on 2018/6/14.
//  Copyright © 2018年 James. All rights reserved.
//


//master@ngelpartners.com
//Gkgkgk88     证书密码 123456    Buildid    com.Lionbit.www


#define SUCCESSED 200

#define KSocketLongNofication @"KSocketLongNofication"


#define 正式


#define ProductBaseServer  @"https://dev.atex.kim"

#define ImageBaseServer  @"http://atex001.oss-cn-hongkong.aliyuncs.com"

#define MarketSocketUrl @"wss://dev.atex.kim/ws"









/************************************ 登录、注册、忘记密码、获取验证码 ****************************/

/* 用户注册 ATEX*/
#define BI_Register_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/register"]

/* 用户是否注册 ATEX*/
#define BI_CheckRegister_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/check"]



/* 用户登录 ATEX*/
#define BI_Login_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/login"]


/* 登录成功 */
#define BI_LoginSuccess_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/loginMsg"]


/* 获取短信验证码 ATEX*/
#define BI_GetSmsCode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/sendSms"]


/* 获取邮箱验证码 ATEX*/
#define BI_GetEmailCode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/sendEmail"]

#define BI_getUserBingInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/getUserBingInfo"]

//注册验证验证码接口
#define BI_RegisterVerification_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/registerVerification"]

//忘记密码app验证码验证
#define BI_editPswdVerification_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/editPswdVerification"]

/* 校验验证码 */
#define BI_CheckCode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/checkCode"]

/* 忘记密码 ATEX*/
#define BI_ForgetPWD_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/forgetPassword"]


/* 协议 ATEX*/
#define BI_Protocol_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/software/systemAgree"]




/************************************ 资讯 ****************************/


/* 交易指南 平台咨询 头部图片  ATEX*/
#define JBWallet_NewsHeader_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/software/slides"]



/****************************** 首页  ****************************************/


/* 自选币列表*/
#define JBWallet_CustomList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/getSeltCode"]

/* 自选币状态*/
#define JBWallet_CustomStatus_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/editSeltCode"]

/* 系统公告 ATEX*/
#define JBWallet_NoticeList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/software/systemPosts"]

/* 平台咨询 ATEX*/
#define JBWallet_ZixunList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/software/news"]

// 公告详情
#define JBWallet_NoticeDetail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/contentNoticeDetail"]

/* 版本公告 */
#define BI_CheckVersion_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/software/softwareUpdate"]

/*退出登录*/
#define BI_Logout_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/logout"]


/* 帮助中心 */
#define BI_HelpCenter_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/indexContent"]


/****************************** 个人中心  ****************************************/

/* 支付方式列表 */

#define BI_Paylist_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/payList"]



/********************************* 法币  *******************************************/

// 法币交易大厅
#define BI_FBHall_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/lawCoinTrading"]

// 法币下单判断(判断支付方式是否匹配)
#define BI_FBIsCanDeal_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/sellConfirm"]

// 法币下单
#define BI_FBConfirmDeal_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/lawCoinDeal"]

// 法币取消订单
#define BI_FBCancleOrder_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/cancelLawCoinRecord"]

// 买家确认付款 卖家确认收款(放币)
#define BI_FBDealConfirm_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/sellBuyConfirme"]


// 法币订单列表、订单明细
#define BI_FBOrderList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/selBuySellInfo"]

// 订单详情
#define BI_FBorderDetail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/orderDetail"]

// 法币发布订单
#define BI_FBPublishSell_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/addBill"]

// 法币取消发布单
#define BI_FBPublishCancle_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/cancelLawCoinDealBill"]

// 法币订单申诉
#define BI_FBOrderAppeal_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/appealLawCoinRecord"]

// 申请成为商家
#define BI_FBBusinessApply_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/applyShop"]


// 法币发布记录
#define BI_FBPublishRecord_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/sellBuyRecord"]


// 法币发布数量限制
#define BI_FBLimmitInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/fbMinNum"]

// 大厅参考价
#define BI_FBShowPrice_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/showPrice"]


/********************************* 币币 *******************************************/

// 币币k线 ATEX
#define BI_BBKline_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/ticket"]

// 成交数据 ATEX
#define BI_BBKTransaction_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/RealTimeDeal"]

// 币币下单
#define BI_BBConfirmBuy_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/coincoin/addBill"]

// 币币订单列表
#define BI_BBOrderList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/coincoin/selCoinCoinByHistory"]

// 币币委托列表
#define BI_BBEntrustList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/coincoin/selCoinCoin"]

// 币币撤销委托单
#define BI_BBEntrustCancle_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/coincoin/cancelBill"]

// 币币交易对查询
#define BI_BBConiList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/coincoin/stockPair"]


// 币币订单详情
#define BI_BBOrderDetail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/coincoin/successDealInfo"]

// 币币简介 ATEX
#define BI_BBCoinInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/getProInfo"]

// 币币深度 ATEX
#define BI_BBCoinDeep_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/getDepth"]

// 币币盘口 ATEX
#define BI_BBCoinPankou_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/getDepth"]



#pragma mark - 我的


//联系方式
#define Mine_AboutUS_URL  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/touchMe"]

//开启谷歌身份验证
#define  BI_GoogleAuth_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/googleAuth/genSecret"]

//绑定谷歌身份验证
#define  BI_GoogleAuthVerify_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/googleAuth/verify"]

//解除谷歌绑定
#define  BI_CancleGoogleAuthVerify_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/googleAuth/relieveGoolgeAuth"]

//登录谷歌验证
#define  BI_GoginGoogleAuthVerify_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/googleAuth/loginGoogleAuth"]



//开启器谷歌验证
#define    Loin_openGoogleAuth_Url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/googleAuth/openGoolgeAuth"]
//关闭谷歌验证
#define    Loin_closeGoogleAuth_Url  [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/googleAuth/closeGoolgeAuth"]

//!< 设置资金密码 ATEX
#define BI_SetPswd_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/createPaymentPassword"]

//!< 修改资金密码 ATEX
#define BI_UpdatePswd_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/resetPaymentPassword"]

//!< 添加支付方式
#define BI_AddPayWay_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/addPayWay"]

//!< 修改支付方式
#define BI_UpdatePayWay_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/updatePayType"]

//!< 上传图片
#define BI_Upload_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/upload/file"]
//!< 留言反馈
#define BI_FeedBack_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/contentMessage"]

//!< 用户签到
//#define BI_UserSign_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/userSign"]

//!< 绑定手机号或邮箱
#define BI_BindTelOrEmail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/bindTelOrEmail"]
//!< 修改手机号或邮箱
#define BI_UpdataTelOrEmail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/updataTelOrEmail"]

//!< 设置交易密码
#define BI_UpdateTradePswd_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/updateTradePswd"]


//!< 拥金明细
//#define BI_CommissionInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/concess/detail/search"]

//!< 实名认证 （身份认证）
//#define BI_BaseAuth_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/baseAuth"]
//!< 高级认证 （身份认证）
//#define BI_AdvancedAuth_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/inspectAuth"]


/* 个人中心-个人信息  ATEX */
#define BI_UserInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/details"]



//!< 申请商家
#define BI_ApplyShop_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/applyShop"]

//!< 申请商家保证金
#define BI_ApplyShopBaozhengjin_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/applyShopPro"]


//!< 解除商家
#define BI_InspectAuth_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/relieveShop"]


//!< 启用和关闭支付方式
#define BI_SwitchPayWay_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/lawCoin/updatePayWay"]

//!< 联系我们 ATEX
#define BI_TouchMe_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/software/content"]

//!< 隐私政策
#define BI_Privacy_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/privacy"]


//!< 我的客户 ATEX
#define BI_MyCuMstom_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/recommends"]

//佣金明细
#define URL_YongJinDetail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/commissionInfo"]

//!< 资费说明
#define BI_FeeInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/feeInfo"]

//!< 服务协议
#define BI_Service_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/service"]
//!< 关于我们
#define BI_Ours_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/ours"]

//!< 交易规则
#define BI_Rule_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/dealRule"]

//!< 关于反洗钱
#define BI_FanXiQian_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/money"]
//法律声明
#define BI_FaLv_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/falv"]
#define BI_Question_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/question"]

//!< 推广二维码 ATEX
#define BI_Qrcode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/registerLink"]

//!< 佣金明细
//#define BI_ConcessionInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/concessionInfo"]


//!< 兑换记录
#define BI_ChangeRecord_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/changeRecord"]

//!< 个人资产（持有资产）
#define BI_CaptialFund_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/captialFund"]
//!< 兑换币种查询
#define BI_GetExchange_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/getExchange"]


//!< 资产兑换
#define BI_PropertyChange_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/propertyChange"]

//!< 公告详情
#define BI_NoticeDetail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/contentNoticeDetail"]

//!< 充币提币明细
#define BI_GoldEntryAndExit_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/addr/getGoldEntryAndExitList"]

//!< 充币明细 ATEX
#define ATEX_ChargeRecord_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/recharge/index"]

//!< 提币明细 ATEX
#define ATEX_ExtractRecord_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/withdraw/withdrawLog"]


// 资产信息 ATEX
#define Lion_Asset_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/assetInfo"]

// 资产明细（其他） ATEX
#define Lion_AssetDetail_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/userMoneyLog"]



//!< 获取提币地址（充币页面） ATEX
#define BI_RechargeAddr_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/recharge/walletRecharge"]

//!< 提币
#define BI_ConfirmExtract_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/withdraw/applyWithdraw"]


//!< 支持充提币列表
#define BI_ChargeCoinList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/addr/stockCode"]

//!< 撤销提币
#define URL_TiBiRevoke_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/addr/cancelCharge"]

//!< 校验平台用户是否拥有EOS账号
#define LN_FindEosAccount_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/eos/api/findAccount"]
#define LN_CreateEosAccount_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/eos/api/create"]

//!< 提币地址列表 ATEX
#define BI_AddressList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/withdraw/getWithdrawAddress"]

//!< 添加提币地址列表 ATEX
#define BI_AddAddress_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/withdraw/createWithdrawAddress"]


//!< 删除地址 ATEX
#define BI_DeleteAddress_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/withdraw/deleteWithdrawAddress"]

//!< 个人总资产
#define BI_TotalAsset_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/captialFundToltal"]

//!< 提币信息
#define BI_ExtractInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/withdraw/checkBalance"]

//!< 提币信息
//#define BI_ConfirmExtract_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/addr/applyCharge"]

//!< 资产明细 其他
#define BI_AssetDetailOther_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/moneyDetail"]

//!< 可兑换币种列表
#define BI_ConvertCoinList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/getFundList"]

///////////////////////////////////////
#pragma mark - 合约    ---------------------三种合约---------------------
//配置信息 ATEX
#define URL_HEYUE_Setting_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/getProduct"]

//合约信息 ATEX
#define URL_HEYUE_Info_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/statistics"]

//下单 ATEX
#define URL_HEYUE_CreateOrder_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/createOrder"]

//撤单 ATEX
#define URL_HEYUE_RevokeOrder_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/cancellations"]

//平仓 ATEX
#define URL_HEYUE_Done_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/closePosition"]

//一键平仓 ATEX
#define URL_HEYUE_DoneAll_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/allClosePosition"]

//设置止盈止损  ATEX
#define URL_HEYUE_StopPrice_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/setPoit"]

//持仓列表 ATEX
#define URL_HEYUE_DoingList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/transData"]

//历史数据(成交列表) ATEX
#define URL_HEYUE_History_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/orderList"]

//委托列表 ATEX
#define URL_HEYUE_List_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/transData"]

//委托持仓统一列表
#define URL_Userdatas_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/userdatas"]



// 持仓数量
#define URL_HY_ChiCangNum_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/leverDeal/getPositionCount"]

// 合约分享
#define HEYUE_Share_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/contract/shareOrder"]


// 行情列表 ATEX
#define BI_BBCoinList_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/getPro"]


//!< 实名认证 （身份认证） ATEX
#define BI_BaseAuth_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/authentication/advancedCertification"]
//!< 高级认证 （身份认证）
#define BI_AdvancedAuth_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/inspectAuth"]

// 区号
//#define URL_AreaCode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/getAreaCode"]
#define URL_AreaCode_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/listMobilePrefix"]

// 快捷买币ATEX
#define URL_FastPay_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/recharge/onlineRecharge"]

// 快捷买币记录ATEX
#define URL_FastPayRecord_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/recharge/rechargeLog"]


//常见问题

#define URL_Mine_Question_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/question"]

// 推广信息 ATEX
#define ConcessionInfo_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/recommendInfo"]


//获得赠金
#define URL_Mine_GetZengJin [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/give/getMoneys"]

//赠金明细
#define URL_Mine_ZengJinRecord [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/give/pageGive"]
//资产兑换
#define URL_Mine_Convert [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/usermoneyexehange/moneyExehange"]
//资产兑换列表
#define URL_Mine_ConvertRecord [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/usermoneyexehange/pageExehange"]

//获取返佣规则
#define URL_Invite_Rule [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/returnRule"]

//佣金明细 ATEX
#define URL_YongJinRecord_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/api/user/commissionDetails"]

//最小充币数量
#define URL_RechargeNum_URL [NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/getMinInCoin"]



