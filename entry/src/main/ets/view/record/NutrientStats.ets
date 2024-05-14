import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct NutrientStats {
  @Prop carbon: number
  @Prop protein: number
  @Prop fat: number
  recommendCarbon: number = 237
  recommendProtein: number = 68
  recommendFat: number = 53

  build() {
    Row({ space: 6 }) {
      this.StatsBuilder({
        label: '碳水化合物',
        value: this.carbon,
        recommend: this.recommendCarbon,
        color: $r('app.color.Start_title_bgc')
      })
      this.StatsBuilder({
        label: '蛋白质',
        value: this.protein,
        recommend: this.recommendProtein,
        color: $r('app.color.lightest_gray_color')
      })
      this.StatsBuilder({
        label: '脂肪',
        value: this.fat,
        recommend: this.recommendFat,
        color: $r('app.color.btn_bg_color')
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder StatsBuilder($$: {
    label: string,
    value: number,
    recommend: number,
    color: ResourceStr
  }) {
    Column({ space: 6 }) {
      Stack() {
        Progress({
          value: $$.value,
          total: $$.recommend,
          type: ProgressType.Ring
        })
          .width(95)
          .style({ strokeWidth: 6 })
          .color($$.color)
        Column({ space: 6 }) {
          Text('摄入推荐')
            .fontSize(12)
            .fontColor($r('app.color.lightest_gray_color'))
          Text(`${$$.value.toFixed(0)}/${$$.recommend.toFixed(0)}`)
            .fontSize(18)
            .fontWeight(6)
        }
      }

      Text(`${$$.label}（克）`)
        .fontSize(12)
        .fontColor($r('app.color.lightest_gray_color'))
    }
  }
}