import router from '@ohos.router'
import MeInfo from '../../viewmodel/MeInfo'
  
const MeList: MeInfo[] = [
  new MeInfo(0, '观看历史', $r('app.media.ic_walk'), "pages/LoginPage"),
  new MeInfo(1, '我的收藏', $r('app.media.ic_walk'), "pages/Register"),
  new MeInfo(2, '我的下载', $r('app.media.ic_walk'), "pages/LoginPage"),
  new MeInfo(3, '上传视频', $r('app.media.ic_walk'), "pages/LoginPage"),
  new MeInfo(4, '意见反馈', $r('app.media.ic_walk'), "pages/LoginPage"),
  new MeInfo(5, '观看历史', $r('app.media.ic_walk'), "pages/LoginPage"),
  new MeInfo(6, '设置', $r('app.media.ic_walk'), "pages/LoginPage")
]


@Component
export default struct Melist {
  build() {
    Column() {
      List() {
        ForEach(
          MeList,
          (item: MeInfo, index) => {
            ListItem() {
              Row() {
                Text(`${item.id.toString()} .`)
                Text(item.name)
                Blank()
                Image(item.picture).width(20).height(20)
              }
              .onClick(() => {
                router.pushUrl({
                  url: item.location
                },
                  //单实例模式
                  router.RouterMode.Single,
                  err => {
                    if (err) {
                      console.log(`路由失败${err.code}errMsg：${err.message}`)
                    }
                  })
              })
              .padding({ left: 10, right: 10 })
              .width('100%')
              .backgroundColor(Color.White)
              .borderRadius(10)
              .height(50)
            }
          })
      }
    }
    .padding({ top: 10 })
    .width('100%')
  }
}