@Component
export default struct Promotion {
  build() {
    Stack() {
      Column() {
        Row() {
          Text('免广告特权')
          Blank()
          Text('暂未享受免广告特权')
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('90%')
        .margin({ top: 20 })

        Row() {
          Text(`已经推广${2}人`).fontColor(Color.White)
          Blank()
          Column({ space: 10 }) {
            Row() {
              Button('分享推广').fontColor(Color.White)
            }
            .justifyContent(FlexAlign.End).width('60%')

            Row() {
              Text('推广可的终身免广告特权>').fontSize(10).fontColor(Color.White)
            }
            .justifyContent(FlexAlign.End).width('60%')
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(15)
        .margin({ top: 20, bottom: 20 })
        .backgroundColor('#ff573f')
        .width('95%')
        .borderRadius(10)
      }
      .opacity(0.9)
      .width('100%')
      .backgroundColor(Color.White).borderRadius(10)
    }
    .borderRadius(10)
    .width('95%')
    .padding({ top: 20 })
  }
}