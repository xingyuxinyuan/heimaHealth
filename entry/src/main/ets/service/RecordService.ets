//业务层逻辑处理
import DateUtil from '../common/Utils/DateUtil'
import ItemModel from '../model/ItemModel'
import RecordModel from '../model/RecordModel'
import { RecordTypeEnum, RecordTypes } from '../model/RecordTypeModel'
import GroupInfo from '../viewmodel/GroupInfo'
import RecordType from '../viewmodel/RecordType'
import RecordVO from '../viewmodel/RecordVO'
import StatsInfo from '../viewmodel/StatsInfo'

class RecordService {
  //增
  //typeId类型id, itemId项目id, amount数量ID, createTime时间信息
  insert(typeId: number, itemId: number, amount: number): Promise<number> {
    // 1.获取时间
    let createTime = (AppStorage.Get('selectedDate') || DateUtil.beginTimeOfDay(new Date())) as number
    // 2.新增
    return RecordModel.insert({ typeId, itemId, amount, createTime })
  }
  //删
  deleteById(id: number) {
    return RecordModel.deleteById(id)
  }
  //查
  async queryRecordByDate(data: number): Promise<RecordVO[]> {
    //查询数据库的RecordPO
    let rps = await RecordModel.listByDate(data)
    //将RecordPO转RecordVO
    return rps.map(rp => {
      //2.0获取RecordVO基本属性,实际是PO
      let rv = { id: rp.id, typeId: rp.typeId, amount: rp.amount } as RecordVO
      //2.2查询记录项
      rv.recordItem = ItemModel.getById(rp.itemId, rp.typeId !== RecordTypeEnum.WORKOUT)
      //2.3计算热量
      rv.calorie = rp.amount * rv.recordItem.calorie
      //返回
      return rv
    })
  }
  //计算统计信息
  calculateStatsInfo(records: RecordVO[]): StatsInfo {
    //准备结果
    let info: StatsInfo = new StatsInfo()
    if (!records || records.length <= 0) {
      return info
    }
    //2.计算结果
    records.forEach(rec => {
      if (rec.typeId === RecordTypeEnum.WORKOUT) {
        //运动累加消耗
        info.expend += rec.calorie /*卡路里总数*/
      } else {
        //食物
        info.intake += rec.calorie
        info.carbon += rec.recordItem.carbon
        info.protein += rec.recordItem.protein
        info.fat += rec.recordItem.fat
      }
    })
    //3.返回
    return info
  }
  //计算群组信息
  calculateGroupInfo(records: RecordVO[]): GroupInfo<RecordType, RecordVO>[] {
    // 1.创建空的记录类型分组
    let groups = RecordTypes.map(recordType => new GroupInfo(recordType, []))
    if (!records || records.length <= 0) {
      return groups
    }
    // 2.遍历所有饮食记录，
    records.forEach(record => {
      // 2.1.把每个记录存入其对应类型的分组中
      groups[record.typeId].items.push(record)
      // 2.2.计算该组的总热量
      groups[record.typeId].calorie += record.calorie
    })
    return groups
  }
  //typeId, itemId, amount
}

let recordSercice: RecordService = new RecordService()

export default recordSercice as RecordService