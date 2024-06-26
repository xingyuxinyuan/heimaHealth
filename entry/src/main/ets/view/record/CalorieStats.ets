@Component
export default struct CalorieStats {
  @Prop intake: number
  @Prop expend: number
  recommend: number = 1920

  remainCalorie() {
    return this.recommend - this.intake + this.expend
  }

  build() {
    Row({ space: 6 }) {
      // 1.饮食摄入
      this.StatsBuilder({ label: '饮食摄入', value: this.intake })
      // 2.还可以吃
      Stack() {
        // 2.1.进度条
        Progress({
          value: this.intake,
          total: this.recommend,
          type: ProgressType.Ring
        })
          .width(120)
          .style({ strokeWidth: 10 }) //圆圈宽度
          .color($r('app.color.primary_color'))
        // 2.2.统计数据
        this.StatsBuilder({ label: '还可以吃', value: this.remainCalorie(), tips: `推荐${this.recommend}` })
      }
      // 3.运动消耗
      this.StatsBuilder({ label: '运动消耗', value: this.expend })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder StatsBuilder($$: {
    label: string,
    value: number,
    tips?: string
  }) {
    Column({ space: 6 }) {
      Text($$.label)
        .fontColor(Color.Black)
        .fontWeight(600)
      Text($$.value.toFixed(0))
        .fontSize(20)
        .fontWeight(700)
      if ($$.tips) {
        Text($$.tips)
          .fontSize(12)
          .fontColor(Color.Gray)
      }
    }
  }
}