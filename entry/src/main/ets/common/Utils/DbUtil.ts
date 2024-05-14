import common from '@ohos.app.ability.common';
import relationalStore from '@ohos.data.relationalStore';
import { ColumnInfo, ColumnType } from '../bean/ColumnInfo';
import Logger from './Logger';

const DB_FILENAME: string = 'HeiMaHealthy.db'

class DbUtil {
  rdbStore: relationalStore.RdbStore
  //初始化数据库对象
  initDB(context: common.UIAbilityContext): Promise<void> {
    //配置文件
    let config: relationalStore.StoreConfig = {
      //库名
      name: DB_FILENAME,
      //安全级别
      securityLevel: relationalStore.SecurityLevel.S1
    }
    //返回结果
    return new Promise<void>((resolve, reject) => {
      relationalStore.getRdbStore(context, config)
        .then(rdbStore => {
          this.rdbStore = rdbStore
          Logger.debug('rdbStore初始化完成')
          resolve()
        })
        .catch(reason => {
          Logger.debug('rdbStore初始化异常', JSON.stringify(reason))
          reject(reason)
        })
    })
  }
  //创建数据库对象
  createTable(createSQL: string): Promise<void> {
    return new Promise((resolve, reject) => {
      this.rdbStore.executeSql(createSQL)
        .then(() => {
          Logger.debug('建表成功', createSQL)
          resolve()
        })
        .catch(err => {
          Logger.error('建表失败' + err.message, JSON.stringify(err))
          reject(err)
        })
    })
  }
  //新增
  insert(tableName: string, object: any, columns: ColumnInfo[]): Promise<number> {
    return new Promise((resolve, reject) => {
      let value = this.buildValueBucket(object, columns)
      //构建新增数据
      this.rdbStore.insert(tableName, value, (err, id) => {
        if (err) {
          Logger.error('新增失败：', JSON.stringify(err)) //对象转字符串
          reject(err)
        } else {
          Logger.debug('新增成功：', id.toString())
          resolve(id)
        }
      })
    })
  }
  //删除
  delete(predicates: relationalStore.RdbPredicates): Promise<number> {
    return new Promise((resolve, reject) => {
      //构建新增数据
      this.rdbStore.delete(predicates, (err, rows) => {
        if (err) {
          Logger.error('删除失败：', JSON.stringify(err)) //对象转字符串
          reject(err)
        } else {
          Logger.debug('删除成功：', rows.toString())
          resolve(rows)
        }
      })
    })
  }
  //更新
  update(tableName: string, id: number, object: any, columns: ColumnInfo[]) {
    return new Promise((resolve, reject) => {
      //增加的信息
      let value = this.buildValueBucket(object, columns)
      //判断表名
      let predicates = new relationalStore.RdbPredicates(tableName)
      //匹配信息
      predicates.equalTo('id', id)
      //更新
      this.rdbStore.update(value, predicates, (err, data) => {
        if (err) {
          Logger.error('更新失败：', JSON.stringify(err)) //对象转字符串
          reject(err)
        } else {
          Logger.debug('更新成功：', data.toString())
          resolve(data)
        }
      })
    })
  }
  //查询
  queryForList<T>(predicates: relationalStore.RdbPredicates, columns: ColumnInfo[]): Promise<T[]> {
    return new Promise((resolve, reject) => {
      //构建新增数据
      this.rdbStore.query(predicates, columns.map(info => info.columnName), (err, result) => {
        if (err) {
          Logger.error('查询失败：', JSON.stringify(err)) //对象转字符串
          reject(err)
        } else {
          Logger.debug('查询成功：', result.rowCount.toString())
          resolve(this.parseResultSet(result, columns)) //返回的结果集ResultSet
        }
      })
    })
  }
  //处理返回结果集
  parseResultSet<T>(result: relationalStore.ResultSet, columns: ColumnInfo[]): T[] {
    //声明最终返回的结果
    let arr = []
    //判断是否有结果
    if (result.rowCount <= 0) {
      return arr
    }
    //处理结果
    while (!result.isAtLastRow) {
      // 3.1.去下一行
      result.goToNextRow()
      // 3.2.解析这行数据，转为对象
      //声明最终返回的结果
      let obj = {}
      columns.forEach(info => {
        let val = null;
        switch (info.type) {
          case ColumnType.LONG:
            val = result.getLong(result.getColumnIndex(info.columnName))
            break
          case ColumnType.DOUBLE:
            val = result.getDouble(result.getColumnIndex(info.columnName))
            break
          case ColumnType.STRING:
            val = result.getString(result.getColumnIndex(info.columnName))
            break
          case ColumnType.BLOB:
            val = result.getBlob(result.getColumnIndex(info.columnName))
            break
        }
        obj[info.name] = val
        Logger.debug('查询到数据：', JSON.stringify(obj))
      })
      arr.push(obj)
    }
    return arr
  }
  //自定义函数obj为实体，column为表名
  buildValueBucket(object: any, columns: ColumnInfo[]): relationalStore.ValuesBucket {
    let value = {}
    columns.forEach(info => {
      let val = object[info.name]
      if (typeof val !== 'undefined') {
        value[info.columnName] = val
      }
    })
    return value
  }
}


let dbUtil: DbUtil = new DbUtil();

export default dbUtil as DbUtil