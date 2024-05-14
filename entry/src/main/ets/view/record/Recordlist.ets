import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import RecordService from '../../service/RecordService'
import GroupInfo from '../../viewmodel/GroupInfo'
import RecordType from '../../viewmodel/RecordType'
import RecordVO from '../../viewmodel/RecordVO'

@Extend(Text) function grayText() {
  .fontSize(14)
  .fontColor(Color.Gray)
}

@Component
export default struct RecordList {
  //附加信息
  @Consume @Watch('handleRecordsChange') records: RecordVO[]
  //类别,附加信息
  @State groups: GroupInfo<RecordType, RecordVO>[] = []
  //查询函数
  handleRecordsChange() {
    this.groups = RecordService.calculateGroupInfo(this.records)
  }

  build() {
    List({ space: 10 }) {
      ForEach(
        this.groups,
        (groups: GroupInfo<RecordType, RecordVO>) => {
          ListItem() {
            Column({ space: 8 }) {
              // 1.分组的标题
              Row({ space: 4 }) {
                Image(groups.type.icon).width(24)
                Text(groups.type.name).fontSize(18).fontWeight(700)
                Text(`建议${groups.type.min}~${groups.type.max}千卡`).grayText()
                Blank()
                Text(groups.calorie.toFixed(0)).fontSize(14).fontColor($r('app.color.primary_color'))
                Text('千卡').grayText()
                Image($r('app.media.ic_public_add_norm_filled'))
                  .width(20)
                  .fillColor($r('app.color.primary_color'))
              }
              .width('100%')
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/ItemIndex',
                  params: { type: groups.type }
                })
              })
              // 2.组内记录列表
              List() {
                ForEach(
                  groups.items,
                  (item: RecordVO, index) => {
                    ListItem() {
                      Row({ space: 6 }) {
                        Image(item.recordItem.image).width(50)
                        Column({ space: 4 }) {
                          Text(item.recordItem.name).fontWeight(500)
                          Text(`${item.amount}${item.recordItem.unit}`).grayText()
                        }

                        Blank()
                        Text(`${item.calorie.toFixed(0)}千卡`).grayText()
                      }
                      .width('100%')
                      .padding(6)
                    }.swipeAction({ end: this.deleteButton(index, item.id) })
                  })
              }
              .width('100%')
            }
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(CommonConstants.DEFAULT_18)
            .padding(12)
          }
        })
    }
    .width(CommonConstants.THOUSANDTH_940)
    .height('100%')
    .margin({ top: 10 })
  }

  @Builder deleteButton(index: number, id: number) {
    Image($r('app.media.ic_public_delete_filled'))
      .width(20)
      .fillColor(Color.Red)
      .margin(5)
      .onClick(() => {
        RecordService.deleteById(id)
          .then(() => {
            this.records.splice(index, 1)
            console.log('testTag', `尝试删除任务，index: ${index}`)
          })
          .catch(error => console.log('testTag', '删除任务失败，id = ', id, JSON.stringify(error)))
      })
  }
}