pragma solidity >=0.4.22 <0.5.0;
pragma experimental ABIEncoderV2;

import "./Table.sol";

//食品信息管理合约
// 1.	保存食品基本信息:时间戳(流转过程中),用户名(流转过程中),用户地址信息(流转过程中),食品质量(流转过程中),食物名称,当前用户名称,质量,状态.
// 2.	对食品基本信息进行初始化
// 3.	实现两个方法:中间商添加食品信息;超市添加食品信息
// 4.	实现显示食品信息的方法

contract FoodInfoItem{
    //①保存食品流转过程中各个阶段的时间戳
    //②保存食品流转过程各个阶段的用户名
    //③保存食品流转过程各个阶段的用户地址信息（和用户一一对应）
    //④保存食品流转过程中各个阶段的质量
    //⑤食品名称
    //⑥当前用户名称
    //⑦质量（0=优质 1=合格 2=不合格）
    //⑧状态（0:生产 1:分销 2:出售）
    //⑨初始化owner

  constructor (string name, string traceName, uint8 quality, address producer) public {
        _timestamp.push(now);
        _traceName.push(traceName);
        _traceAddress.push(producer);
        _traceQuality.push(quality);
        _name = name;
        _currentTraceName = traceName;
        _quality = quality;
        _status = 0;
        _owner = msg.sender;
    }

    function addTraceInfoByDistributor( ①, uint8 quality) public returns(bool) {
        require(_status == 0 , "status must be producing");
        //② 参数判定：只有合约部署者才可以调用该方法
        _timestamp.push(now);
        _traceName.push(traceName);
        _currentTraceName = traceName;
        //③
        //④
        _traceQuality.push(_quality);
        _status = 1;
        return true;


        // int code = 0;
        // Table table = tf.openTable(TABLE_NAME);
        // Entry entry = table.newEntry();
        // entry.set("timestamp", now);
        // entry.set("traceName", traceName);
        // entry.set("currentTraceName", traceName)
        // entry.set("distributor", distributor);
        // entry.set("quality", quality);
        // entry.set("status", 1)
        // Condition condition = table.newCondition();
        // int256 count = table.update(traceName, entry, condition);
        // if(count != 1) {
        //     // 失败? 无权限或者其他错误?
        //     code = 0;
        //     return code;
        // }
        // return count;
    }

    function addTraceInfoByRetailer( ①, uint8 quality) public returns(bool) {
        require(_status == 1 , "status must be distributing");
        //② 参数判定：只有合约部署者才可以调用该方法
        _timestamp.push(now);
        _traceName.push(traceName);
        _currentTraceName = traceName;
        //③
        //④
        _traceQuality.push(_quality);
        _status = 2;
        return true;
    }

    function getTraceInfo() public constant returns(uint[], string[], address[], uint8[]) {
        return(_timestamp, _traceName, _traceAddress, _traceQuality);
    }

    function getFood() public constant returns(uint, string, string, string, address, uint8) {
        return(_timestamp[0], _traceName[0], _name, _currentTraceName, _traceAddress[0], _quality);
    }

}
