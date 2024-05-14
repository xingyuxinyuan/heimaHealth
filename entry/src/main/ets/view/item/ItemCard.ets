import RecordItem from '../../viewmodel/RecordItem'

@Component
export default struct ItemCard {
  @Prop amaunt: number
  @Link item: RecordItem

  build() {
    Column({ space: 8 }) {
      Image(this.item.image).width(125)
      Row() {
        Text(this.item.name).fontWeight(700)
      }
      .padding({ top: 5, bottom: 5, left: 12, right: 12 })
      .backgroundColor(Color.Orange)

      Divider().width('94%').opacity(0.6)
      Row({ space: 8 }) {
        this.NutrientInfo({ label: '热量(千卡)', value: this.item.calorie })
        if (this.item.id < 10000) {
          this.NutrientInfo({ label: '碳水(克)', value: this.item.carbon })
          this.NutrientInfo({ label: '蛋白质(克)', value: this.item.protein })
          this.NutrientInfo({ label: '脂肪(克)', value: this.item.fat })
        }
      }

      Divider().width('94%').opacity(0.6)
      Row() {
        Column({ space: 2 }) {
          Text(this.amaunt.toFixed(1))
            .fontSize(50).fontColor(Color.Green).fontWeight(600)
          Divider().opacity(0.6).color(Color.Green)

        }
        .width(150)

        Text(this.item.unit).fontColor(Color.Grey).fontWeight(600)
      }
    }
  }

  @Builder NutrientInfo($$: {
    label: string,
    value: number
  }) {
    Column({ space: 8 }) {
      Text($$.label).fontSize(14).fontColor(Color.Gray)
      Text(($$.value * this.amaunt).toFixed(1)).fontSize(18).fontWeight(700)
    }
  }
}