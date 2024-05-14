import BreakpointSystem from '../common/Utils/BreakpointSystem'
import RecordIndex from '../view/record/RecordIndex'
import BreakpointConstants from '../common/constants/BreakpointConstants'
import BreakpointType from '../common/bean/BreanpointType'
import FindIndex from '../view/find/FindIndex'
import MeIndex from './MeIndex'

@Entry
@Component
struct Index {
  private BreakpointSystem: BreakpointSystem = new BreakpointSystem()
  @State current: number = 0
  //static readonly BREAKPOINT_SM: string = 'sm';
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM
  @State isPageshow: boolean = false

  onPageShow() {
    this.isPageshow = true
  }

  onPageHide() {
    this.isPageshow = false
  }
  //启动钩子
  aboutToAppear() {
    this.BreakpointSystem.register()
  }
  //释放钩子
  aboutToDisappear() {
    this.BreakpointSystem.unregister()
  }

  @Builder tabBarBuilder(title: ResourceStr, image: ResourceStr, index: number) {

    Column({ space: 5 }) {
      Image(image)
        .width(25)
        .fillColor(this.current === index ? ' ' : Color.Gray)
      Text(title)
        .fontSize(14)
    }
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs({ barPosition: BreakpointConstants.bar_position.getValue(this.currentBreakpoint) }) {
      TabContent() {
        RecordIndex({ isPageShow: this.isPageshow })
      }
      .tabBar(this.tabBarBuilder('记录', $r("app.media.index_tabbar"), 0))

      TabContent() {
        FindIndex()
      }
      .tabBar(this.tabBarBuilder('记录', $r("app.media.find_tabbar"), 1))

      TabContent() {
        MeIndex()
      }
      .tabBar(this.tabBarBuilder('我的', $r("app.media.my_tabbar"), 2))
    }
    .width('100%')
    .height('100%')
    .onChange((index) => this.current = index)
    //横向排布
    .vertical(new BreakpointType({
      sm: false,
      md: true,
      lg: true
    }).getValue(this.currentBreakpoint))
  }
}


