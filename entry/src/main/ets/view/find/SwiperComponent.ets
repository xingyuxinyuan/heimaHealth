@Preview
@Component
export default struct SwiperComponent {
  build() {
    Column() {
      Swiper() {
        ForEach(CirculationPicture,
          (item: SwiperDate, index) => {
            Stack() {
              Image(item.pic_url).objectFit(ImageFit.Cover).width('100%').width('100%').borderRadius(8)
              Column() {
                Text(item.name).fontColor(Color.Black).fontSize(30).fontWeight(FontWeight.Medium)
                Image($r('app.media.milk')).width(40).height(40).margin({ top: 15 })
                Row() {
                  Text(item.singer).fontColor(Color.Black).fontSize(25).margin({ top: 8 })
                }
                .justifyContent(FlexAlign.End)
                .width('80%')
              }
              .width('100%').alignItems(HorizontalAlign.Start).margin({ left: 25, top: 50 })
            }
          })
      }
      .loop(true)
      .autoPlay(true)
      .interval(7000)
      .vertical(true)
      .width('100%')
    }
  }
}

export class SwiperDate {
  pic_url: ResourceStr
  name: string
  singer: string

  constructor(pic_url: ResourceStr, name: string, singer: string) {
    this.pic_url = pic_url
    this.name = name
    this.singer = singer
  }
}

const CirculationPicture: SwiperDate[] = [
  new SwiperDate($r('app.media.banner'), '1', '星语心愿'),
  new SwiperDate($r('app.media.banner'), '2', '千与千寻'),
  new SwiperDate($r('app.media.banner'), '3', '一闪一闪亮星星'),
  new SwiperDate($r('app.media.banner'), '4', '与此同时'),
  new SwiperDate($r('app.media.banner'), '5', '阿巴阿巴')
]
