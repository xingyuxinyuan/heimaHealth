import router from '@ohos.router'
import { RecordTypeEnum, RecordTypes } from '../model/RecordTypeModel'
import RecordService from '../service/RecordService'
import ItemCard from '../view/item/ItemCard'
import ItemList from '../view/item/ItemList'
import ItemPanelHeader from '../view/item/ItemPanelHeader'
import NumberKeyboard from '../view/item/NumberKeyboard'
import RecordItem from '../viewmodel/RecordItem'
import RecordType from '../viewmodel/RecordType'

@Entry
@Component
export default struct ItemIndex {
  @State showPanel: boolean = false
  @State amaunt: number = 0
  @State value: string = ''
  //单窗信息记录
  @State item: RecordItem = null

  @State type: RecordType = RecordTypes[0]
  @State isFood: boolean = true

  onPanelShow(item: RecordItem) {
    this.amaunt = 0
    this.value = ' '
    //赋值
    this.item = item
    //弹窗控制
    this.showPanel = true
  }
  //页面展示-自定义组件的生命周期
  onPageShow() {
    // 1.获取跳转时的参数
    let params: any = router.getParams()
    // 2.获取点击的饮食记录类型
    this.type = params.type
    this.isFood = this.type.id !== RecordTypeEnum.WORKOUT
  }

  build() {
    Column() {
      //头部导航
      this.Header()
      //2.列表
      ItemList({ showPanel: this.onPanelShow.bind(this), isFood: this.isFood })
        .layoutWeight(1)
      //3.底部列表
      Panel(this.showPanel) {
        //1.顶部日期
        ItemPanelHeader().margin({ top: 20 })
        //2.记录项卡片
        if (this.item) {
          ItemCard({ amaunt: this.amaunt, item: $item })
        }
        //3.键盘
        NumberKeyboard({ amount: $amaunt, value: $value })
        //按钮
        this.PanelButton()
      }
      //弹窗展示位置
      .mode(PanelMode.Full)
      .dragBar(false)
      .height('100%')
    }

    .height('100%')
    .width('100%')
  }

  @Builder PanelButton() {
    Row({ space: 10 }) {
      Button('关闭')
        .width(100)
        .type(ButtonType.Normal)
        .borderRadius(6)
        .onClick(() => {
          this.showPanel = false
        })
      Button('提交')
        .width(100)
        .type(ButtonType.Normal)
        .borderRadius(6)
        .onClick(() => {
          //持久化保存
          RecordService.insert(this.type.id, this.item.id, this.amaunt)
            .then(() => {
              // 2.关闭弹窗
              this.showPanel = false
            })
        })
    }
  }

  @Builder Header() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(24)
        .onClick(() => router.back())
      Blank()
      Text(this.type.name).fontSize(18).fontWeight(18)
    }
    .width('94%')
    .height(32)
  }
}