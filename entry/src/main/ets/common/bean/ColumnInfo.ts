export interface ColumnInfo {
  name: string //实体字段名
  columnName: string //数据库字段名
  type: ColumnType //数据库字段类型
}

export enum ColumnType {
  LONG,
  DOUBLE,
  STRING,
  BLOB
}