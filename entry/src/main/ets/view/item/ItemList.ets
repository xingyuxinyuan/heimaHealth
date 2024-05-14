import ItemModel from '../../model/ItemModel'
import GroupInfo from '../../viewmodel/GroupInfo'
import RecordItem from '../../viewmodel/RecordItem'
import ItemCategory from '../../viewmodel/ItemCategory'

@Extend(Text) function graytext() {
  .fontSize(14)
  .fontColor(Color.Gray)
}

@Component
export default struct ItemList {
  showPanel: (item: RecordItem) => void
  @Prop isFood: boolean

  build() {
    Tabs() {
      TabContent() {
        this.TabContentBuilder(ItemModel.list(this.isFood))
      }
      .tabBar('全部')

      ForEach(
        ItemModel.listItemGroupByCategory(this.isFood),
        (group: GroupInfo<ItemCategory, RecordItem>) => {
          TabContent() {
            //tab内容
            this.TabContentBuilder(group.items)
          }
          //tab名
          .tabBar(group.type.name)
        })

    }
    .width('94%')
    .height('100%')
    .barMode(BarMode.Scrollable)
  }
  //全部数据方法
  @Builder TabContentBuilder(items: RecordItem[]) {
    List({ space: 10 }) {
      ForEach(
        items, //哪个数组
        (item: RecordItem) => {
          ListItem() {
            Row({ space: 6 }) {
              Image(item.image).width(50)
              Column({ space: 4 }) {
                Text(item.name).fontWeight(500)
                Text(`${item.calorie}千卡/${item.unit}`).graytext()
              }

              Blank()
              Image($r('app.media.ic_public_add_norm_filled'))
                .width(18)
                .fillColor(Color.Green)
            }
            .width('100%')
            .padding(6)
          }
          .onClick(() => {
            this.showPanel(item)
          })
        })
    }
    .width('100%')
    .height('100%')
  }
}