drop proc p_sctj
go
create proc p_sctj @qrq datetime,
                   @zrq datetime
as
--生产统计 (@qrq 开始日期+'00:00:00' @zrq 结果日期+'23:59:59')
declare @kds int, @kdms int, @qgdh varchar(50), @zgdh varchar(50) --开单数,总开单枚数,第一个工单号,最后一个工单号
declare @cds int  --撤单数
declare @pks int, @pkms int, @pkyz int, @pkch int  --普卡数,普卡枚数,普卡用纸个数,普卡消耗纸数
declare @xks int, @xkms int,@xkyz int, @xkch int   --信卡数,信卡枚数,信卡用纸个数,信卡消耗纸数
declare @hks int, @hkms int,@hkyz int, @hkch int   --贺卡数,贺卡枚数,贺卡用纸个数,贺卡消耗纸数
declare @hkfs int, @hkfms int,@hkfyz int, @hkfch int  --贺卡封数,贺卡封枚数,贺卡封用纸个数,贺卡封消耗纸数
declare @dkbk int  --对开版块数
declare @skbk int  --4开版块数
declare @yzbs int, @yzbms int,@yzbpks int, @yzbpkms int, @yzbxks int, @yzbxkms int, @yzbhks int, @yzbhkms int, @yzbhkfs int, @yzbhkfms int
--已制版数,已制版枚数,已制版普卡数,已制版普卡枚数,已制版普卡用纸个数,已制版信卡数,已制版信卡枚数,已制版贺卡数,已制版贺卡枚数,已制版贺卡封数,已制版贺卡封枚数
declare @yyss int, @yysms int,@yyspks int, @yyspkms int, @yysxks int, @yysxkms int, @yyshks int, @yyshkms int, @yyshkfs int, @yyshkfms int
--已印刷数,已印刷枚数,已印刷普卡数,已印刷普卡枚数,已印刷普卡用纸个数,已印刷信卡数,已印刷信卡枚数,已印刷贺卡数,已印刷贺卡枚数,已印刷贺卡封数,已印刷贺卡封枚数
declare @yzds int, @yzdms int,@yzdpks int, @yzdpkms int, @yzdxks int, @yzdxkms int, @yzdhks int, @yzdhkms int, @yzdhkfs int, @yzdhkfms int
--已装订数,已装订枚数,已装订普卡数,已装订普卡枚数,已装订普卡用纸个数,已装订信卡数,已装订信卡枚数,已装订贺卡数,已装订贺卡枚数,已装订贺卡封数,已装订贺卡封枚数


select F_iID,F_sGdh,F_iJfqs,F_iJfs,F_iProductTypeID,F_sSbks,F_iSczt,F_iZl,F_tiCXBZ,F_sSbk into #workid from BI_WorkOrder where F_dKdrq >= @qrq and F_dKdrq <= @zrq 

select @kds=Count(F_iID),@kdms=IsNull(Sum(F_iZl),0) from #workid where  F_tiCXBZ=0

select Top 1 @qgdh=IsNull(F_sGdh,'') from #workid order by F_iID
select Top 1 @zgdh=IsNull(F_sGdh,'') from #workid order by F_iID desc
select @qgdh = IsNull(@qgdh,'')
select @zgdh = IsNull(@zgdh,'')

select @cds=Count(F_iID) from #workid where  F_tiCXBZ=1

select @pks=Count(F_iID),@pkms=IsNull(Sum(F_iZl),0),@pkyz=IsNull(Sum(F_iJfqs),0),@pkch=IsNull(Sum(F_iJfs),0) from #workid where F_iProductTypeID = 1 and F_tiCXBZ=0
select @xks=Count(F_iID),@xkms=IsNull(Sum(F_iZl),0),@xkyz=IsNull(Sum(F_iJfqs),0),@xkch=IsNull(Sum(F_iJfs),0) from #workid where F_iProductTypeID = 2 and F_tiCXBZ=0
select @hks=Count(F_iID),@hkms=IsNull(Sum(F_iZl),0),@hkyz=IsNull(Sum(F_iJfqs),0),@hkch=IsNull(Sum(F_iJfs),0) from #workid where F_iProductTypeID = 5 and F_tiCXBZ=0
select @hkfs=Count(F_iID),@hkfms=IsNull(Sum(F_iZl),0),@hkfyz=IsNull(Sum(F_iJfqs),0),@hkfch=IsNull(Sum(F_iJfs),0) from #workid where F_iProductTypeID in (3,4) and F_tiCXBZ=0
Select @dkbk=IsNull(Sum(CONVERT(int,F_sSbk)),0) from #workid where F_sSbks = '对' and F_tiCXBZ=0
Select @skbk=IsNull(Sum(CONVERT(int,F_sSbk)),0) from #workid where F_sSbks = '4' and F_tiCXBZ=0
--已制版
select a.F_iID,a.F_iProductTypeID,a.F_sSbks,a.F_iSczt,a.F_iZl,F_tiCXBZ into #workyzb from BI_WorkOrder a,DO_ProductDate_Log b where a.F_iID=b.F_iWorkID and F_dYzbrq >= @qrq and F_dYzbrq <= @zrq 

select @yzbs=count(F_iID),@yzbms=IsNull(Sum(F_iZl),0) from #workyzb where F_iSczt=1 and F_tiCXBZ=0
select @yzbpks=Count(F_iID),@yzbpkms=IsNull(Sum(F_iZl),0) from #workyzb where F_iProductTypeID = 1 and F_iSczt=1 and F_tiCXBZ=0
select @yzbxks=Count(F_iID),@yzbxkms=IsNull(Sum(F_iZl),0) from #workyzb where F_iProductTypeID = 2 and F_iSczt=1 and F_tiCXBZ=0 
select @yzbhks=Count(F_iID),@yzbhkms=IsNull(Sum(F_iZl),0) from #workyzb where F_iProductTypeID = 5 and F_iSczt=1 and F_tiCXBZ=0
select @yzbhkfs=Count(F_iID),@yzbhkfms=IsNull(Sum(F_iZl),0) from #workyzb where F_iProductTypeID in (3,4) and F_iSczt=1 and F_tiCXBZ=0
--已印刷

select a.F_iID,a.F_iProductTypeID,a.F_sSbks,a.F_iSczt,a.F_iZl,F_tiCXBZ into #workyys from BI_WorkOrder a,DO_ProductDate_Log b where a.F_iID=b.F_iWorkID and F_dYysrq >= @qrq and F_dYysrq <= @zrq 

select @yyss=count(F_iID),@yysms=IsNull(Sum(F_iZl),0) from #workyys where F_iSczt=2 and F_tiCXBZ=0
select @yyspks=Count(F_iID),@yyspkms=IsNull(Sum(F_iZl),0) from #workyys where F_iProductTypeID = 1 and F_iSczt=2 and F_tiCXBZ=0
select @yysxks=Count(F_iID),@yysxkms=IsNull(Sum(F_iZl),0) from #workyys where F_iProductTypeID = 2 and F_iSczt=2 and F_tiCXBZ=0 
select @yyshks=Count(F_iID),@yyshkms=IsNull(Sum(F_iZl),0) from #workyys where F_iProductTypeID = 5 and F_iSczt=2 and F_tiCXBZ=0
select @yyshkfs=Count(F_iID),@yyshkfms=IsNull(Sum(F_iZl),0) from #workyys where F_iProductTypeID in (3,4) and F_iSczt=2 and F_tiCXBZ=0
--已装订
select a.F_iID,a.F_iProductTypeID,a.F_sSbks,a.F_iSczt,a.F_iZl,F_tiCXBZ into #workyzd from BI_WorkOrder a,DO_ProductDate_Log b where a.F_iID=b.F_iWorkID and F_dYzdrq >= @qrq and F_dYzdrq <= @zrq 

select @yzds=count(F_iID),@yzdms=IsNull(Sum(F_iZl),0) from #workyzd where F_iSczt=4 and F_tiCXBZ=0
select @yzdpks=Count(F_iID),@yzdpkms=IsNull(Sum(F_iZl),0) from #workyzd where F_iProductTypeID = 1 and F_iSczt=4 and F_tiCXBZ=0
select @yzdxks=Count(F_iID),@yzdxkms=IsNull(Sum(F_iZl),0) from #workyzd where F_iProductTypeID = 2 and F_iSczt=4 and F_tiCXBZ=0
select @yzdhks=Count(F_iID),@yzdhkms=IsNull(Sum(IsNull(F_iZl,0)),0) from #workyzd where F_iProductTypeID = 5 and F_iSczt=4 and F_tiCXBZ=0
select @yzdhkfs=Count(F_iID),@yzdhkfms=IsNull(Sum(F_iZl),0) from #workyzd where F_iProductTypeID in (3,4) and F_iSczt=4 and F_tiCXBZ=0

select 
  @kds KDS, @kdms KDMS, @qgdh QGDH, @zgdh ZGDH,
  @cds CDS,
  @pks PKS, @pkms PKMS,@pkyz PKYZ, @pkch PKCH,
  @xks XKS, @xkms XKMS,@xkyz XKYZ, @xkch XKCH,
  @hks HKS, @hkms HKMS,@hkyz HKYZ, @hkch HKCH,
  @hkfs HKFS, @hkfms HKFMS,@hkfyz HKFYZ, @hkfch HKFCH,
  @dkbk DKBK,
  @skbk SKBK,
  @yzbs YZBS, @yzbms YZBMS, @yzbpks YZBPKS, @yzbpkms YZBPKMS, @yzbxks YZBXKS, @yzbxkms YZBXKMS, @yzbhks YZBHKS, @yzbhkms YZBHKMS, @yzbhkfs YZBHKFS, @yzbhkfms YZBHKFMS,
  @yyss YYSS, @yysms YYSMS,@yyspks YYSPKS, @yyspkms YYSPKMS, @yysxks YYSXKS, @yysxkms YYSXKMS, @yyshks YYSHKS, @yyshkms YYSHKMS, @yyshkfs YYSHKFS, @yyshkfms YYSHKFMS,
  @yzds YZDS, @yzdms YZDMS,@yzdpks YZDPKS, @yzdpkms YZDPKMS, @yzdxks YZDXKS, @yzdxkms YZDXKMS, @yzdhks YZDHKS, @yzdhkms YZDHKMS, @yzdhkfs YZDHKFS, @yzdhkfms YZDHKFMS


GO
