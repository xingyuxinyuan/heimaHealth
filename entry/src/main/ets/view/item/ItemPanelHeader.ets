import DateUtil from '../../common/Utils/DateUtil'

@Component
export default struct ItemPanelHeader {
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())

  build() {
    Row() {
      Text(DateUtil.formatDate(this.selectedDate))
        .fontSize(18).fontWeight(600)
      Image($r('app.media.ic_public_delete_filled')).width(20)
    }
    .justifyContent(FlexAlign.Center)
    .width('94%')
  }
}