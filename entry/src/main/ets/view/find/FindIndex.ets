import router from '@ohos.router'
import SwiperComponent from './SwiperComponent'

@Preview
@Component
export default struct FindIndex {
  build() {
    Column() {
      //标题
      this.Header()
      SwiperComponent()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f2f2f2')
    .padding(30)
  }

  @Builder Header() {
    Row() {
      Text('返回').width(50).height(30).onClick(() => {
        router.replaceUrl({
          url: "pages/Index"
        },
          router.RouterMode.Single,
          err => {
            if (err) {
              console.log(`路由失败${err.code}errMsg：${err.message}`)
            }
          })
      })
      Text('find')
      Text('菜单').width(50).height(30)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

