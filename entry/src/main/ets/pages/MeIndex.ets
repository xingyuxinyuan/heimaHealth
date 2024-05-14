import MeInfo from '../viewmodel/MeInfo'
import Head_information from '../view/Me/Head_information'
import Melist from '../view/Me/MeList'

@Preview
@Component
export default struct MeIndex {
  build() {
    Column() {
      //头部信息
      Head_information()
      //列表部分
      Melist()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f2f2f2')
  }
}


