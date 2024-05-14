import RecordType from '../viewmodel/RecordType'

enum RecordTypeEnum {
  /**
   * 早餐
   */
  BREAKFAST,
  /**
   * 午餐
   */
  LUNCH,
  /**
   * 晚餐
   */
  DINNER,
  /**
   * 加餐
   */
  EXTRA_MEAL,
  /**
   * 运动
   */
  WORKOUT
}


/**
 * 记录类型常量
 */
const RecordTypes: RecordType[] = [
  new RecordType(0, 'breakfast', $r("app.media.ic_breakfast"), 423, 592),
  new RecordType(1, 'lunch', $r("app.media.ic_lunch"), 592, 761),
  new RecordType(2, 'dinner', $r("app.media.ic_dinner"), 423, 592),
  new RecordType(3, 'extra_meal', $r("app.media.ic_extra_m"), 0, 169),
  new RecordType(4, 'workout', $r("app.media.ic_workout")),
]

export { RecordTypes, RecordTypeEnum }