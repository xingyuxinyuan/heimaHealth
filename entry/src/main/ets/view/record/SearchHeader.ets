@Component
export default struct SearchHeader {
  build() {
    //1.
    Row({ space: 8 }) {
      Search({
        placeholder: '搜索'
      })
        .textFont({ size: 18 })
        .layoutWeight(1)
      Badge({ count: 1, position: BadgePosition.RightTop, style: { fontSize: 15 } }) {
        Image($r('app.media.message'))
          .width(25)
      }
    }
    .width('95%')
  }
}