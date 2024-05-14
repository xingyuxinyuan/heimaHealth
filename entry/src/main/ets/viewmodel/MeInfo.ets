/**
 * 记录项类型
 */
export default class MeCategory {
  /**
   * 类型id
   */
  id: number
  /**
   * 类型名称
   */
  name: ResourceStr
  /**
   * 图片
   */
  picture: ResourceStr
  /**
   * 跳转地址
   */
  location: string

  constructor(id: number, name: ResourceStr, picture: ResourceStr, location: string) {
    this.id = id
    this.name = name
    this.picture = picture
    this.location = location
  }
}