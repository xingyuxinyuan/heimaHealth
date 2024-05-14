import ItemCategory from '../viewmodel/ItemCategory'

enum FoodCategoryEnum {
  //主食
  STAPLE,
  //蔬果
  FRUIT,
  //肉蛋奶
  MEAT,
  //坚果
  NUT,
  //其他
  OTHER,
}
//食物类型数组
let FoodCategories: ItemCategory[] = [
  new ItemCategory(0, '主食'),
  new ItemCategory(1, '蔬果'),
  new ItemCategory(2, '肉蛋奶'),
  new ItemCategory(3, '坚果'),
  new ItemCategory(4, '其他')]
//运动类型枚举
enum WorkoutCategoryEnum {
  //走路
  WALKING,
  //跑步
  RUNNING,
  //骑行
  RIDING,
  //跳操
  AEROBICS,
  //游泳
  SWIMMING,
  //打球
  BALLGAME,
  //力量训练
  STRENGTH
}

let WorkoutCategories: ItemCategory[] = [
  new ItemCategory(0, '走路'),
  new ItemCategory(1, '跑步'),
  new ItemCategory(2, '骑行'),
  new ItemCategory(3, '跳操'),
  new ItemCategory(4, '游泳'),
  new ItemCategory(5, '打球'),
  new ItemCategory(6, '力量训练'),]

export { FoodCategoryEnum, FoodCategories, WorkoutCategoryEnum, WorkoutCategories }