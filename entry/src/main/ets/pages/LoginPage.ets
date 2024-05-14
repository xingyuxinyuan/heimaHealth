import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import BottomLogin from '../view/BottomLogin'

@Entry
@Component
struct LoginPage {
  @State email: string = ''
  @State password: string = ''

  build() {
    Column() {
      Image($r('app.media.banner'))
        .width('100%')
        .height('30%')
      Column({ space: 20 }) {
        Text($r('app.string.title_login_label'))
          .fontSize(26)
          .fontColor($r('app.color.text_label'))
          .fontWeight(FontWeight.Bold)
          .padding({ top: 20 })
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
          Text('登录').fontSize(18).fontColor(Color.White)
        }.height(50).width('100%')
        .onClick(() => {
          if (this.email == ' ') {
            promptAction.showToast({ message: '请输入账号' }) //options
            return
          }
          if (this.password == ' ') {
            promptAction.showToast({ message: '请输入密码' }) //options
            return
          }
        })

        Row() {
          Text('注册账号')
            .onClick(() => {
              router.pushUrl({
                url: "pages/Register"
              },
                router.RouterMode.Single,
                err => {
                  if (err) {
                    console.log(`路由失败${err.code}errMsg：${err.message}`)
                  }
                })
            })
          Blank()
          Text('忘记密码')
        }.width('100%')
        .padding({ right: 10, left: 10 }) //外边距
      }
      .padding({ left: $r('app.float.float10'), right: $r('app.float.float10') })
      .backgroundColor(Color.White)
      .width('90%')
      .height('40%')
      .borderRadius(18) //圆角
      .margin({ top: $r('app.float.float20') })
      //阴影
      .shadow({
        radius: $r('app.float.float10'),
        color: $r('app.color.shadow_color'),
      })

      Blank()
      BottomLogin()
      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.bg_color'))
  }
}