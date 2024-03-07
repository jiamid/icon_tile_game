import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class SqlConfig {
  /// 数据库名字
  static String dbname = "tile_zoo.db";

  /// 数据库表版本
  static int dbVersion = 1;

  /// 创建表通用语句
  static String creatTable = 'CREATE TABLE IF NOT EXISTS';

  /// 主键 递增
  static String primaryKeyAuto =
      'INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE';

  /// 不为null
  static String sqlNoNull = 'NOT NULL';

  /// text
  static String sqlText = 'TEXT';

  /// big int
  static String sqlBigInt = 'BIGINT(20)';

  /// int
  static String sqlInt = 'INT(11)';

  /// 列表数据表名字
  static String transactionRecordsTable = 'transaction_records';
}

class TransactionRecordsTableModel {
  static String key = 'id';
  static String title = 'title';
  static String goodsType = 'goodsType';
  static String goodsAmount = 'goodsAmount';
  static String spendType = 'spendType';
  static String spendAmount = 'spendAmount';
  static String createdAt = 'createdAt';
}

class NewTransactionRecordModel {
  String title = '';
  int goodsType = 0;
  int goodsAmount = 0;
  int spendType = 0;
  String spendAmount = '0';
}

class NormalCreateTables {
  static final String createTransactionRecordsTable = '''
       ${SqlConfig.creatTable} ${SqlConfig.transactionRecordsTable} (
       ${TransactionRecordsTableModel.key} ${SqlConfig.primaryKeyAuto},
       ${TransactionRecordsTableModel.title} ${SqlConfig.sqlText} ${SqlConfig.sqlNoNull} ,
       ${TransactionRecordsTableModel.goodsType} ${SqlConfig.sqlInt} ${SqlConfig.sqlNoNull} ,
       ${TransactionRecordsTableModel.spendType} ${SqlConfig.sqlInt} ${SqlConfig.sqlNoNull},
       ${TransactionRecordsTableModel.goodsAmount} ${SqlConfig.sqlInt} ${SqlConfig.sqlNoNull},
       ${TransactionRecordsTableModel.spendAmount} ${SqlConfig.sqlText} ${SqlConfig.sqlNoNull},
       ${TransactionRecordsTableModel.createdAt} ${SqlConfig.sqlBigInt} ${SqlConfig.sqlNoNull} DEFAULT 0
       );
       ''';

  /// 获取所有的表
  Map<String, String> getAllTables() {
    Map<String, String> map = <String, String>{};
    map['transactionRecordsTable'] = createTransactionRecordsTable;
    return map;
  }
}

class DBManager {
  static final DBManager _instance = DBManager._internal();

  factory DBManager() => _instance;

  static Database? _database;

  DBManager._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, SqlConfig.dbname);

    return await openDatabase(
      path,
      version: SqlConfig.dbVersion,
      onOpen: (db) async {
        /// 所有的sql语句
        Map<String, String> allTableSqls = NormalCreateTables().getAllTables();

        /// 创建新表
        for (var sql in allTableSqls.keys) {
          if (kDebugMode) {
            print('Create $sql');
          }
          await db.execute(allTableSqls[sql]!);
        }
      },
      onCreate: (db, version) async {},
    );
  }

  Future<List<Map>> getAllTransactionRecords() async {
    List<Map> maps = await _database!.query(SqlConfig.transactionRecordsTable,
        orderBy: '${TransactionRecordsTableModel.key} DESC');
    return maps;
  }

  Future<bool> delOneTransactionRecords(int id) async {
    try {
      await _database!.delete(SqlConfig.transactionRecordsTable,
          where: '${TransactionRecordsTableModel.key} = $id');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delTransactionRecordsOver({int limit = 100}) async {
    try {
      await _database!.delete(SqlConfig.transactionRecordsTable,
          where: '''${TransactionRecordsTableModel.key} NOT IN (
          SELECT ${TransactionRecordsTableModel.key}
          FROM (
          SELECT ${TransactionRecordsTableModel.key}
          FROM ${SqlConfig.transactionRecordsTable}
          ORDER BY ${TransactionRecordsTableModel.key} DESC
          LIMIT $limit
      ) AS subquery )''');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> addOneTransactionRecord(NewTransactionRecordModel newOne) async {
    try {
      int newId = await _database!.insert(SqlConfig.transactionRecordsTable, {
        TransactionRecordsTableModel.title: newOne.title,
        TransactionRecordsTableModel.goodsType: newOne.goodsType,
        TransactionRecordsTableModel.goodsAmount: newOne.goodsAmount,
        TransactionRecordsTableModel.spendType: newOne.spendType,
        TransactionRecordsTableModel.spendAmount: newOne.spendAmount,
        TransactionRecordsTableModel.createdAt:
            DateTime.now().millisecondsSinceEpoch,
      });
      // await delTransactionRecordsOver(limit: 100);
      return newId;
    } catch (e) {
      return 0;
    }
  }

  /// sql助手查找列表(不分页)
  /// @tableName:表名
  /// @selects 查询的字段数组,也就是你想要等到的数据字段集合
  /// @wheres 条件，如：'uid=? and fuid=?'
  /// @whereArgs 参数数组
  Future<List<Map>> queryListByHelper({
    required String tableName,
    required List<String> selects,
    required String whereStr,
    required List whereArgs,
  }) async {
    List<Map> maps = await _database!.query(
      tableName,
      columns: selects,
      where: whereStr,
      whereArgs: whereArgs,
    );
    return maps;
  }

  /// sql 分页查询
  /// SqlUtils sqlUtils = SqlUtils();
  /// await sqlUtils.open();
  /// List list = await sqlUtils.queryListforpageHelper(
  /// ['uid'], 查询返回的数据字段
  /// 'uid = ?', 查询字段
  /// [1], 对应的查询条件
  /// page, 当前页数
  /// 10, 每页个数
  /// orderBy: "createTime DESC" 根据对应字段进行排序 DESC 从大到小排序 ---降序排列 ASC 从小到大排序 -- 升序排列
  ///
  /// );
  Future<List<Map>> queryListForPageHelper({
    required String tableName,
    required List<String> selects,
    required String whereStr,
    required List whereArgs,
    required int page,
    required int size,
    String? orderBy,
  }) async {
    List<Map> maps = await _database!.query(
      tableName,
      columns: selects,
      where: whereStr,
      whereArgs: whereArgs,
      limit: size,
      offset: (page - 1) * size,
      orderBy: orderBy,
    );
    return maps;
  }

  /// sql原生查找列表
  /// eg:
  /// SqlUtils sqlUtils = SqlUtils();
  /// await sqlUtils.open();
  /// await sqlUtils.queryList(
  /// "select * from ${SqlConfig.list} where ${uid} = '$userId'"
  /// );
  Future<List<Map>> queryList({
    required String sql,
  }) async {
    return await _database!.rawQuery(sql);
  }

  /// sql原生插入
  /// eg:
  /// SqlUtils sqlUtils = SqlUtils();
  /// await sqlUtils.open();
  /// await sqlUtils.insert('INSERT INTO List(name, value) VALUES(?, ?)',['name', 'name']);
  Future<int> insert({
    required String sql,
    required List paramters,
  }) async {
    return await _database!.rawInsert(
      sql,
      paramters,
    );
  }

  ///sql助手插入 @tableName:表名 @paramters：参数map
  /// eg:
  /// SqlUtils sqlUtils = SqlUtils();
  /// await sqlUtils.open();
  /// await sqlUtils.insertByHelper(SqlConfig.list, {"uid":uid,"name":name});
  Future<int> insertByHelper({
    required String tableName,
    required Map<String, dynamic> paramters,
  }) async {
    return await _database!.insert(
      tableName,
      paramters,
    );
  }

  ///sql原生修改
  Future<int> update({
    required String sql,
    required List paramters,
  }) async {
//样例：dbUtil.update('UPDATE relation SET fuid = ?, type = ? WHERE uid = ?', [1,2,3]);
    return await _database!.rawUpdate(
      sql,
      paramters,
    );
  }

  /// sql助手更新数据
  Future<int> updateByHelper({
    /// 表名
    required String tableName,

    /// 需要修改的数据
    required Map<String, Object?> setArgs,

    /// 根据条件，获取需要修改数据
    required String whereStr,

    /// 条件
    required List whereArgs,
  }) async {
    return await _database!.update(
      tableName,
      setArgs,
      where: whereStr,
      whereArgs: whereArgs,
    );
  }

  ///sql原生删除
  Future<int> delete({
    required String sql,
    required List parameters,
  }) async {
    //样例：await dbUtil.delete('DELETE FROM relation WHERE uid = ? and fuid = ?', [123,234]);
    return await _database!.rawDelete(
      sql,
      parameters,
    );
  }

  ///sql助手删除 刪除全部whereStr和whereArgs传null
  Future<int> deleteByHelper({
    required String tableName,
    required String whereStr,
    required List whereArgs,
  }) async {
    return await _database!.delete(
      tableName,
      where: whereStr,
      whereArgs: whereArgs,
    );
  }
}

// final db = await MyDatabase().database;
// await db.insert(
// 'users',
// {'name': 'John'},
// conflictAlgorithm: ConflictAlgorithm.replace,
// );

// final db = await MyDatabase().database;
// final List<Map<String, dynamic>> users = await db.query('users');

// final db = await MyDatabase().database;
// await db.update(
// 'users',
// {'name': 'Mary'},
// where: 'id = ?',
// whereArgs: [1],
// );

// final db = await MyDatabase().database;
// await db.delete(
// 'users',
// where: 'id = ?',
// whereArgs: [1],
// );
