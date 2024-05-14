import mediaquery from '@ohos.mediaquery'
import BreakpointConstants from '../constants/BreakpointConstants'

export default class BreakpointSystem {
  /*
   * 中等屏幕设备的 Breakpoints 标记.
   *static readonly BREAKPOINT_SM: string = 'sm';
   *static readonly BREAKPOINT_MD: string = 'md';
   *static readonly BREAKPOINT_LG: string = 'lg';
   * //--------------------------------------------------------------------------------
   * 当前设备的 breakpoints 存储key
   *static readonly CURRENT_BREAKPOINT: string = 'currentBreakpoint';
   * 小屏幕设备宽度范围.
   *static readonly RANGE_SM: string = '(320vp<=width<600vp)';
   * 中屏幕设备宽度范围.
   *static readonly RANGE_MD: string = '(600vp<=width<840vp)';
   * 大屏幕设备宽度范围.
   *static readonly RANGE_LG: string = '(840vp<=width)';
   * */
  //MediaQueryListener媒体查询监听器
  private smListener: mediaquery.MediaQueryListener = mediaquery.matchMediaSync(BreakpointConstants.RANGE_SM)
  private mdListener: mediaquery.MediaQueryListener = mediaquery.matchMediaSync(BreakpointConstants.RANGE_MD)
  private lgListener: mediaquery.MediaQueryListener = mediaquery.matchMediaSync(BreakpointConstants.RANGE_LG)

  smListenerCallback(result: mediaquery.MediaQueryResult) {
    if (result.matches) {
      this.updataCurrentBreakpoint(BreakpointConstants.BREAKPOINT_SM)
    }
  }
  //matches比赛,匹配
  mdListenerCallback(result: mediaquery.MediaQueryResult) {
    if (result.matches) {
      this.updataCurrentBreakpoint(BreakpointConstants.BREAKPOINT_MD)
    }
  }

  lgListenerCallback(result: mediaquery.MediaQueryResult) {
    if (result.matches) {
      this.updataCurrentBreakpoint(BreakpointConstants.BREAKPOINT_LG)
      //static readonly BREAKPOINT_LG: string = 'lg'
    }
  }
  //static readonly CURRENT_BREAKPOINT: string = 'currentBreakpoint';
  updataCurrentBreakpoint(breakpoint: string) {
    AppStorage.SetOrCreate(BreakpointConstants.CURRENT_BREAKPOINT, breakpoint)
  }
  //register登记表
  register() {
    this.smListener.on('change', this.smListenerCallback.bind(this))
    this.mdListener.on('change', this.mdListenerCallback.bind(this))
    this.lgListener.on('change', this.lgListenerCallback.bind(this))
  }

  unregister() {
    this.smListener.off('change', this.smListenerCallback.bind(this))
    this.mdListener.off('change', this.mdListenerCallback.bind(this))
    this.lgListener.off('change', this.lgListenerCallback.bind(this))
  }
}

