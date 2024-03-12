pragma solidity >=0.4.22 <0.5.0;
pragma experimental ABIEncoderV2;

import "./Table.sol";

//食品信息管理合约
// 1.	保存食品基本信息:时间戳(流转过程中),用户名(流转过程中),用户地址信息(流转过程中),食品质量(流转过程中),食物名称,当前用户名称,质量,状态.
// 2.	对食品基本信息进行初始化
// 3.	实现两个方法:中间商添加食品信息;超市添加食品信息
// 4.	实现显示食品信息的方法

contract FoodInfoItem{
    uint[] _timestamp;
    string[] _traceName;
    address[] _traceAddress;
    uint8[] _traceQuality;
    string _name;
    string _currentTraceName;
    uint8 _quality;
    uint8 _status;
    address _owner;

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

    function addTraceInfoByDistributor( string traceName,address distributor, uint8 quality) public returns(bool) {
        require(_status == 0 , "status must be producing");
        require(_owner == msg.sender,"only trace contract can invoke");
        //② 参数判定：只有合约部署者才可以调用该方法
        _timestamp.push(now);
        _traceName.push(traceName);
        _currentTraceName = traceName;
        //③
        _traceAddress.push(distributor);
        //④
        _quality = quality;

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

    function addTraceInfoByRetailer(string traceName ,address retailer, uint8 quality) public returns(bool) {
        require(_status == 1 , "status must be distributing");
        require(_owner == msg.sender,"only trace contract can invoke");
        //② 参数判定：只有合约部署者才可以调用该方法
        _timestamp.push(now);
        _traceName.push(traceName);
        _currentTraceName = traceName;
        //③
        //④
        _quality = quality;
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
