import promptAction from '@ohos.promptAction';
import router from '@ohos.router';


@Entry
@Component
export default struct RegisterView {
  @State email: string = ' '
  @State password: string = ' '
  @State user: string = ' '

  build() {
    Column() {
      Image($r('app.media.banner'))
        .width('100%')
        .height('30%')
      Column() {
        Text('注册')
          .fontSize(26)
          .fontColor($r('app.color.text_label'))
          .fontWeight(FontWeight.Bold)
          .padding({ top: 20 })
        TextInput({ placeholder: '请输入账户名称' })
          .height(50)
          .width('100%')
          .type(InputType.Email)
          .caretColor($r('app.color.shadow_color'))
          .onChange((value) => {
            this.user = value
          })
        TextInput({ placeholder: '请输入账号' })
          .height(50)
          .width('100%')
          .type(InputType.Email)
          .caretColor($r('app.color.shadow_color'))
          .onChange((value) => {
            this.email = value
          })
        TextInput({ placeholder: '请输入密码' })
          .height(50)
          .width('100%')
          .type(InputType.Email)
          .caretColor($r('app.color.shadow_color'))
          .type(InputType.Password)
          .onChange((value) => {
            this.password = value
          })
        Button() {
          Text('注册').fontSize(18).fontColor(Color.White)
        }.height(50).width('100%')
        .onClick(() => {
          if (this.email == '' && this.password == '' && this.user == '') {
            promptAction.showToast({ message: '注册失败' })
          }
        })

        Row() {
          Text($r('app.string.Sign_in_now'))
            .onClick(() => {
              router.back()
            })
          Blank()
          Text('忘记密码')
        }.width('100%')
        .padding({ right: 10, left: 10 }) //外边距
      }
      .padding({ left: $r('app.float.float10'), right: $r('app.float.float10') })
      .backgroundColor(Color.White)
      .width('90%')
      .height('50%')
      .borderRadius(18) //圆角
      .margin({ top: $r('app.float.float20') })
      .shadow({
        radius: $r('app.float.float10'),
        color: $r('app.color.shadow_color'),
      })
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.bg_color'))
  }
}