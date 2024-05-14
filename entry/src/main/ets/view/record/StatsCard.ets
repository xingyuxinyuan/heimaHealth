import BreakpointType from '../../common/bean/BreanpointType'
import BreakpointConstants from '../../common/constants/BreakpointConstants'
import DateUtil from '../../common/Utils/DateUtil'
import RecordService from '../../service/RecordService'
import RecordVO from '../../viewmodel/RecordVO'
import StatsInfo from '../../viewmodel/StatsInfo'
import CalorieStats from './CalorieStats'
import DatePickDialog from './DatePickDialog'
import NutrientStats from './NutrientStats'

@Component
export default struct StatsCard {
  //watch监控
  @Consume @Watch('handleRecordsChange') records: RecordVO[]
  //空数组
  @State statsInfo: StatsInfo = new StatsInfo()
  //处理记录变更,热量计算
  handleRecordsChange() {
    //计算统计信息
    this.statsInfo = RecordService.calculateStatsInfo(this.records)
  }
  //监控日期
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  //监控宽度断点
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM
  controller: CustomDialogController = new CustomDialogController({
    builder: DatePickDialog({ selectedDate: new Date(this.selectedDate) })
  })

  build() {
    Column() {
      //日期信息
      Row() {
        Text(DateUtil.formatDate(this.selectedDate))
          .fontColor(Color.Black)
      }
      .padding(8)
      .onClick(() => {
        this.controller.open()
      })
      //统计信息
      Swiper() {
        //热量统计
        CalorieStats({ intake: this.statsInfo.intake, expend: this.statsInfo.expend })
        //营养素
        NutrientStats({ carbon: this.statsInfo.carbon, protein: this.statsInfo.protein, fat: this.statsInfo.fat })
      }
      .indicator(new BreakpointType({
        sm: true,
        md: true,
        lg: false
      }).getValue(this.currentBreakpoint))
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(18)
      .indicatorStyle({ selectedColor: Color.Green })
      .displayCount(new BreakpointType({
        sm: 1,
        md: 1,
        lg: 2
      }).getValue(this.currentBreakpoint))
    }
    .width('94%')
    .backgroundColor($r('app.color.Start_title_bgc'))
    .borderRadius(18)
  }
}

