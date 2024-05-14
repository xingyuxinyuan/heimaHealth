import DateUtil from '../../common/Utils/DateUtil'
import RecordService from '../../service/RecordService'
import RecordVO from '../../viewmodel/RecordVO'
import RecordList from './Recordlist'
import SearchHeader from './SearchHeader'
import StatsCard from './StatsCard'

@Component
export default struct RecordIndex {
  @Watch('aboutToAppear')
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  @Watch('handlePageshow')
  @Prop isPageShow: boolean
  @Provide records: RecordVO[] = []

  handlePageshow() {
    if (this.isPageShow) {
      this.aboutToAppear()
    }
  }

  async aboutToAppear() {
    this.records = await RecordService.queryRecordByDate(this.selectedDate)
  }

  build() {
    Column() {
      //1.搜索框
      SearchHeader()
      //2.轮播卡片
      StatsCard()
      //3.记录列表
      RecordList()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
  }
}