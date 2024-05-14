//弹窗
@CustomDialog
export default struct DatePickDialog {
  controller: CustomDialogController
  selectedDate: Date = new Date()
  //日期时间
  build() {
    Column({ space: 12 }) {
      DatePicker({
        start: new Date('2020-01-01'),
        end: new Date(),
        selected: this.selectedDate
      })
        .onChange((value: DatePickerResult) => {
          this.selectedDate.setFullYear(value.year, value.month, value.day)
        })
      //下方按钮
      Row({ space: 12 }) {
        Button('取消').width(120).backgroundColor(Color.Gray)
          .onClick(() => {
            this.controller.close()
          })
        Button('确定').width(120).backgroundColor(Color.Green)
          .onClick(() => {
            //1.保存日期
            AppStorage.SetOrCreate('selectedDate', this.selectedDate.getTime())
            this.controller.close()
          })
      }
      .padding(10)
    }
  }
}