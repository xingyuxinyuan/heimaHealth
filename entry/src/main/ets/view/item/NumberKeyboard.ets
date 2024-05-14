@Component
export default struct NumberKeyboard {
  private numbers: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.']
  @Link amount: number
  @Link value: string
  //自定义样式
  @Styles keyBoxStyles(){
    .backgroundColor(Color.White)
    .height(60)
    .borderRadius(8)
  }

  build() {
    Column() {
      Grid() {
        ForEach(
          this.numbers,
          (num: string) => {
            GridItem() {
              Text(num).fontSize(20).fontWeight(900)
            }
            //自定义样式
            .keyBoxStyles()
            .onClick(() => {
              this.clickNumber(num)
            })
          })
        GridItem() {
          Text('删除').fontSize(20).fontWeight(900)
        }
        .keyBoxStyles()
        .onClick(() => {
          this.clickDelete()
        })
      }
      .width('100%')
      .height(280)
      //行布局
      .columnsTemplate('1fr 1fr 1fr')
      //不透明度
      .opacity(0.8)
      //键盘列间距
      .columnsGap(8)
      //键盘行间距
      .rowsGap(8)
      .margin({ top: 10 })
    }
    .width('100%')
    .height(350)
    .margin(10)
    .backgroundImage($r('app.media.Image'))
    .backgroundImageSize({ width: '100%', height: '100%' })
  }
  //新增
  clickNumber(num: string) {
    //1.拼接
    let val = this.value + num
    //2.获取小数点的脚标
    let firstIndex = val.indexOf('.')
    let lastIndex = val.lastIndexOf('.')
    //3.非法输入
    if (firstIndex !== lastIndex || (lastIndex != -1 && lastIndex < val.length - 2)) {
      return
    }
    //转数字
    let amount = this.parsefloat(val)
    //数量判断
    if (amount >= 999.9) {
      this.amount = 999.9,
      this.value = '999'
    } else {
      this.amount = amount,
      this.value = val
    }
  }
  //删除
  clickDelete() {
    if (this.value.length <= 0) {
      this.value = '',
      this.amount = 0
      return
    } else {
      this.value = this.value.substring(0, this.value.length - 1) //保留0-x
      this.amount = this.parsefloat(this.value)
    }
  }

  parsefloat(str: string) {
    if (!str) {
      return 0
    }
    if (str.endsWith('.')) {
      str = str.substring(0, str.length - 1)
    }
    return parseFloat(str)
  }
}