#!/system/bin/sh
#Jevons@OnLineRD.DeviceService, 2013/10/23 add this file for properties


#OPPO_TARGET_DEVICE

#  hw_pcb_version:10、11、12、13
#  hw_rf_version：
#	11,		//WCDMA_GSM_
#	12,		//WCDMA_GSM_LTE_	
#	13,		//WCDMA_GSM_LTE_
#	21,		//WCDMA_GSM_CDMA_	
#	22,		//WCDMA_GSM_
#	23,		//WCDMA_GSM_
#	31,		//TD_GSM	
#	32,		//TD_GSM_LTE	
#	33,		//TDD_FDD_TD_W_GSM		

######################################################################
#    Copied from 8974 self-init.c
#    int NETWORK_MODE_WCDMA_PREF = 0; //GSM/WCDMA (WCDMA preferred) 
#    int NETWORK_MODE_GSM_ONLY = 1; //GSM only 
#    int NETWORK_MODE_WCDMA_ONLY = 2; //WCDMA only 
#    int NETWORK_MODE_GSM_UMTS = 3; //GSM/WCDMA (auto mode, according to PRL)
#                                   //         AVAILABLE Application Settings menu
#    int NETWORK_MODE_CDMA = 4; //CDMA and EvDo (auto mode, according to PRL)
#                               //             AVAILABLE Application Settings menu
#    int NETWORK_MODE_CDMA_NO_EVDO = 5; //CDMA only 
#    int NETWORK_MODE_EVDO_NO_CDMA = 6; //EvDo only 
#    int NETWORK_MODE_GLOBAL = 7; //GSM/WCDMA, CDMA, and EvDo (auto mode, according to PRL)
#                                 //           AVAILABLE Application Settings menu
#    int NETWORK_MODE_LTE_CDMA_EVDO = 8; //LTE, CDMA and EvDo 
#    int NETWORK_MODE_LTE_GSM_WCDMA = 9; //LTE, GSM/WCDMA 
#    int NETWORK_MODE_LTE_CMDA_EVDO_GSM_WCDMA = 10; //LTE, CDMA, EvDo, GSM/WCDMA 
#    int NETWORK_MODE_LTE_ONLY = 11; //LTE Only mode. 
#    int NETWORK_MODE_LTE_WCDMA = 12; //LTE/WCDMA 
#    int NETWORK_MODE_TD_SCDMA_ONLY = 13; //TD-SCDMA only 
#    int NETWORK_MODE_TD_SCDMA_WCDMA = 14; //TD-SCDMA and WCDMA 
#    int NETWORK_MODE_TD_SCDMA_LTE = 15; //TD-SCDMA and LTE 
#    int NETWORK_MODE_TD_SCDMA_GSM = 16; //TD-SCDMA and GSM 
#    int NETWORK_MODE_TD_SCDMA_GSM_LTE = 17; //TD-SCDMA,GSM and LTE 
#    int NETWORK_MODE_TD_SCDMA_GSM_WCDMA = 18; //TD-SCDMA, GSM/WCDMA 
#    int NETWORK_MODE_TD_SCDMA_WCDMA_LTE = 19; //TD-SCDMA, WCDMA and LTE 
#    int NETWORK_MODE_TD_SCDMA_GSM_WCDMA_LTE = 20; //TD-SCDMA, GSM/WCDMA and LTE 
#    int NETWORK_MODE_TD_SCDMA_CDMA_EVDO_GSM_WCDMA = 21; //TD-SCDMA,EvDo,CDMA,GSM/WCDMA
#    int NETWORK_MODE_TD_SCDMA_LTE_CDMA_EVDO_GSM_WCDMA = 22; //TD-SCDMA/LTE/GSM/WCDMA, CDMA, and
#                                                            //   EvDo 
######################################################################

#pcb_version=`cat sys/devices/system/soc/soc0/hw_pcb_version`
#rf_version=`cat sys/devices/system/soc/soc0/hw_rf_version`

#ifdef VENDOR_EDIT
#BaoZhu.Yu@Prd.CommApp.Mms, 2014/03/19, Add for 14033, 14017, 14013, 14027.
modem_type=`cat /proc/oppoVersion/modemType`        #区分不同modem制式
operator_name=`cat /proc/oppoVersion/operatorName`  #区分内销,外销等不同运营商,内销 移动：2，联通：3，电信：4
pcb_version=`cat /proc/oppoVersion/pcbVersion`      #区分不同pcb阶段
prj_version=`cat /proc/oppoVersion/prjVersion`      #区分不同项目
reserved_version=`cat /proc/oppoVersion/reserved`   #预留位

setprop ro.modem_type $modem_type
setprop ro.operator_name $operator_name
setprop ro.prj_version $prj_version
setprop ro.reserved_version $reserved_version
#endif /* VENDOR_EDIT */

setprop ro.pcb_version $pcb_version

OPPO_TARGET_DEVICE=`getprop ro.product.model`
#BaoZhu.Yu@Mobile.Network.RF, Move  "ro.rf_version","ro.telephony.default_network" to /android/vendor/oppo/oppo_config/MSM_XXX/oppo_buildinfo.sh
if   [ $prj_version = "14045" ] ; then
    phone_type="R8207"
elif [ $prj_version = "15009" ] ; then
	if  [ $operator_name = "2" ] ; then
        phone_type="A51t"
	elif [ $operator_name = "4" ] ; then
        phone_type="A51c"
	elif [ $operator_name = "8" ] ; then
        phone_type="15008"
	fi
elif [ $prj_version = "15018" ] ; then
	if [ $operator_name = "4" ] ; then
        phone_type="R7plusc"
	elif [ $operator_name = "8" ] ; then
        phone_type="R7plus"
	fi
else
    phone_type="R8207"
fi

date_ymd=`getprop ro.build.date.ymd`
product_brand=`getprop ro.product.brand`

#ifdef VENDOR_EDIT
#yangguofu@EXP.SysFramework.build,2015/04/22,add for resize 15069 2G RAM heap 
if [ $OPPO_TARGET_DEVICE = "A51f" ] ; then
   setprop dalvik.vm.heapgrowthlimit  256m
   setprop dalvik.vm.heapsize         512m
fi
#endif /* VENDOR_EDIT */

#ifdef VENDOR_EDIT
#wangjimin@EXP.SysFramework.build,add for Singapore Taiwan operator,20141022
#Qiang.shao@EXP.SysFramework.build,add for DZ, 20150213
#Qiang.shao@EXP.SysFramework.build,add for AU OPTUS, 20150520
#Qiang.shao@EXP.SysFramework.build,add for operator dynamic clientid, 20150520
#  Value      Operator
#  00000000   EX
#  00000001   SINGTEL
#  00000010   STARHUB
#  00000011   M1
#  00000100   CHT
#  00000101   FET
#  00000110   TWM
#  00000111   VBO
#  00001000   VN (region)
#  00001001   TWOP    all Taiwan Operators
#  00001010   DZ
#  00001011   OPTUS

#no need use the property in MX build,because it compile independently
mx_or_us=`getprop persist.sys.oppo.region`

if [ $mx_or_us = "MX" ] ; then
    setprop persist.sys.oppo.region MX
    setprop ro.com.google.clientidbase android-oppo
    setprop ro.com.google.clientidbase.ms android-americamovil-{country}
    setprop ro.com.google.clientidbase.yt android-oppo
    setprop ro.com.google.clientidbase.am android-americamovil-{country}
    setprop ro.com.google.clientidbase.gmm android-oppo
else
    exp_operator=`cat /data/opponvitems/6853`

    #Qiang.shao@EXP.SysFramework.build,add for get first 8bits flag, 20150610
    exp_operator=${exp_operator:0:8}
    #Junren_Jie@EXP.sysframework,2015/07/01,Support Full Disk Ecryption.
    if [ -f /cache/opponvitems/6853 ]; then
        exp_operator=`cat /cache/opponvitems/6853`
        exp_operator=${exp_operator:0:8}
        rm -rf /cache/opponvitems
    fi

    setprop ro.com.google.clientidbase android-oppo
    if [ $exp_operator = "00000001" ] ; then
       setprop ro.oppo.operator SINGTEL
       setprop persist.sys.oppo.region SG
       #display_id=`getprop ro.build.display.id`
       #display_id_op=$display_id"_SINGTEL"
       #setprop ro.build.display.id $display_id_op
    elif [ $exp_operator = "00000010" ] ; then
       setprop ro.oppo.operator STARHUB
       setprop persist.sys.oppo.region SG
       #display_id=`getprop ro.build.display.id`
       #display_id_op=$display_id"_STARHUB"
       #setprop ro.build.display.id $display_id_op
    elif [ $exp_operator = "00000011" ] ; then
       setprop ro.oppo.operator M1
       setprop persist.sys.oppo.region SG
    elif [ $exp_operator = "00000100" ] ; then
       setprop ro.oppo.operator CHT
       setprop persist.sys.oppo.region TW
       #display_id=`getprop ro.build.display.id`
       #display_id_op=$display_id"_STARHUB"
       #setprop ro.build.display.id $display_id_op
    elif [ $exp_operator = "00000101" ] ; then
       setprop ro.oppo.operator FET
       setprop persist.sys.oppo.region TW
    elif [ $exp_operator = "00000110" ] ; then
       setprop ro.oppo.operator TWM
       setprop persist.sys.oppo.region TW
    elif [ $exp_operator = "00000111" ] ; then
       setprop ro.oppo.operator VBO
       setprop persist.sys.oppo.region TW
    #no need set VN, just delete wechat by EngineerMode,20150205
    #elif [ $exp_operator = "00001000" ] ; then
    #   setprop persist.sys.oppo.region VN
    elif [ $exp_operator = "00001001" ] ; then
       setprop ro.oppo.operator TWOP
       setprop persist.sys.oppo.region TW
    elif [ $exp_operator = "00001010" ] ; then
       setprop ro.oppo.specialdemand DZ
    elif [ $exp_operator = "00001011" ] ; then
       setprop ro.oppo.operator OPTUS
       setprop persist.sys.oppo.region AU
       setprop ro.com.google.clientidbase.ms android-optus-au
       setprop ro.com.google.clientidbase.yt android-oppo
       setprop ro.com.google.clientidbase.am android-optus-au
       setprop ro.com.google.clientidbase.gmm android-oppo
    fi
fi
#endif /* VENDOR_EDIT */
