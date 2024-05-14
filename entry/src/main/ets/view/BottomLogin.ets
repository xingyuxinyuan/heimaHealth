@Component
export default struct BottomLoginView {
  build() {
    Column() {
      Row() {
        Blank()
        Divider().width(100).color($r('app.color.shadow_color'))
        Text('第三方登录')
          .margin({ left: $r('app.float.float10'), right: $r('app.float.float10') })
          .fontSize(16)
        Divider().width(100).color($r('app.color.shadow_color'))
        Blank()
      }.width('100%')

      Row() {
        Image($r('app.media.qq')).width(60).height(60).borderRadius(35) //圆角
          .onClick(() => {

          })
        Image($r('app.media.wechat')).width(60).height(60).borderRadius(35)
          .onClick(() => {

          })
      }.width('100%').justifyContent(FlexAlign.SpaceEvenly)
    }
  }
}