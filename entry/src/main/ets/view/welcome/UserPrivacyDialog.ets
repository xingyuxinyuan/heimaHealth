@CustomDialog
export default struct UserPrivacyDialog {
  controller: CustomDialogController
  //同意
  confirm: () => void
  //取消
  cancel: () => void

  build() {
    Column({ space: 10 }) {
      //1.
      Text('欢迎使用星语心愿').fontSize(20).fontWeight(700)
      //2.
      Text('春节...是中国新一年的开始')
      Text('祝你在新的一年将如温暖的洋流般稳步向前,诸事顺利')
      //3.
      Row({ space: 10 }) {
        Button('同意')
          .onClick((event: ClickEvent) => {
            //同意方法
            this.confirm()
            //关闭窗口
            this.controller.close()
          })
          .width(150)
          .backgroundColor($r('app.color.primary_color'))
        Button('拒绝')
          .onClick((event: ClickEvent) => {
            //拒绝方法
            this.cancel()
            //关闭窗口
            this.controller.close()
          })
          .width(150).backgroundColor($r('app.color.lightest_primary_color'))
          .fontColor($r('app.color.lightest_gray_color'))
      }
    }
    .width('100%')
    .padding(10)
  }
}