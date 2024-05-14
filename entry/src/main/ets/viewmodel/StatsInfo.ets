export default class StatsInfo {
  //当日摄入卡路里
  intake: number = 0
  //当日运动
  expend: number = 0
  //当日摄入碳水
  carbon: number = 0
  //当日摄入蛋白质
  protein: number = 0
  /**
   *  当日摄入脂肪
   */
  fat: number = 0

  constructor(intake: number = 0, expend: number = 0, carbon: number = 0, protein: number = 0, fat: number = 0) {
    this.intake = intake
    this.expend = expend
    this.carbon = carbon
    this.protein = protein
    this.fat = fat
  }
}