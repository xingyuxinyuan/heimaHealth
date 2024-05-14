import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import Promotion from './Promotion'

@Extend(Text) function textstyle() {
  .fontWeight(400)
  .fontSize(20)
}

@Component
export default struct Head_information {
  build() {
    Column() {
      Row() {
        Image($r('app.media.wechat'))
          .width(100)
          .height(100)
          .onClick(() => {
            router.pushUrl({
              url: "pages/LoginPage"
            },
              //但实例模式
              router.RouterMode.Single,
              err => {
                if (err) {
                  promptAction.showToast({ message: '跳转失败' }) //options(`路由失败${err.code}errMsg：${err.message}`)
                }
              })
          })

        Column({ space: 10 }) {
          Row() {
            Text('星语心愿')
              .textstyle()
          }

          Row() {
            Text('ID:1234560')
              .textstyle()
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding(10)
      }
      .padding({ top: 20, left: 20 })
      .width('100%')
      .height(100)
      //分享卡片
      Promotion()
    }
    .width('100%')
    .height(300)
    .backgroundImage($r('app.media.Image'))
    .backgroundImageSize({ width: '100%', height: '100%' })
  }
}