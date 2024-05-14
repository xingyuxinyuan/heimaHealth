import common from '@ohos.app.ability.common'
import router from '@ohos.router'
import PreferenceUtil from '../common/Utils/PreferenceUtil'
import UserPrivacyDialog from '../view/welcome/UserPrivacyDialog'

@Extend(Text) function opacityblacktext(opacity: number, fontSize: number = 10) {
  .fontSize(fontSize)
  .opacity(opacity)
  .fontColor(Color.Black)
}

const pref_key = 'UserPrivacyKey'

@Entry
@Component
struct WelcomePage {
  context = getContext(this) as common.UIAbilityContext
  controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confirm: () => this.onConfirm(),
      cancel: () => this.exitApp()
    })
  })
  //aboutToAppear函数在创建自定义组件的新实例后，
  // 在执行其build()函数之前执行。允许在aboutToAppear函数中改变状态变量，更改将在后续执行build()函数中生效。
  async aboutToAppear() {
    //加载用户首选项
    let isagree = await PreferenceUtil.getPreferenceValue(pref_key, false)
    if (isagree) {
      this.jumpToIndex()
    } else {
      this.controller.open()
    }
  }

  jumpToIndex() {
    router.replaceUrl({
      url: "pages/Index"
    },
      router.RouterMode.Single,
      err => {
        if (err) {
          console.log(`路由失败${err.code}errMsg：${err.message}`)
        }
      })
  }
  //打开弹窗
  onConfirm() {
    //1.Preference
    PreferenceUtil.putPreferenceValue(pref_key, true)
    //路由跳转
    this.jumpToIndex()
  }
  //退出应用
  exitApp() {
    //终结应用
    this.context.terminateSelf()
  }

  build() {
    Column() {
      //中央slogan
      Row() {
        Image($r('app.media.home_slogan')).width(150).height(150)
      }
      .layoutWeight(1)
      //logo

      //文字描述
      Column({ space: 10 }) {
        Row() {
          Text('星语心愿支持').opacityblacktext(0.8, 12)
          Text('IPv6')
            //线宽
            .opacityblacktext(0.8)
            .fontColor(Color.Black)
            .border({ style: BorderStyle.Solid, width: 1, color: Color.Black, radius: 16 })
            .padding({ left: 5, right: 5 })
          Text('网络').opacityblacktext(0.8, 12)
        }

        Text('“若知是梦何须醒，不比真如一相会”')
          .opacityblacktext(0.8, 12)
        Text('版本号：1.0.0')
          .opacityblacktext(0.8, 14)
      }
      .margin({ bottom: 35 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.welcome_page_color'))
  }
}