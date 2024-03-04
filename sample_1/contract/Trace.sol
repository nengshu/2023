pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;
import "./FoodInfoItem.sol";
import "./Distributor.sol";
import "./Producer.sol";
import "./Retailer.sol";
import "./Table.sol";

//食品溯源合约（负责具体食品溯源信息的生成）
//  1.实现生产食品的方法(新建食品信息)
//  2.实现食品分销过程中增加溯源信息的接口
//  3.实现食品出售过程中增加溯源信息的接口
//  4.实现获取食品溯源信息接口

contract Trace is Producer, Distributor, Retailer{

        mapping (uint256 => address)  foods;//食品溯源id到具体食品溯源合约的映射表
        uint[]  foodList;

        //构造函数
        constructor(address producer, address distributor, address retailer)
	public Producer(producer)
	Distributor(distributor)
	Retailer(retailer){

        }
        //生成食品溯源信息接口
        //只有Producer能调用
        //name 食品名称
        //traceNumber 食品溯源id
        //traceName 当前用户名称
	//quality 当前食品质量
        function newFood(①, string traceName, uint8 quality)
	public ② returns(③)
        {
            //④ 条件判定：traceNumber 已经存在
            //⑤
            //⑥
            //⑦
            //⑧

            // int count = 0;
            // Table table = tf.openTable(TABLE_NAME);
            // if(!name.empty() && !traceNumber.empty() && !traceName.empty()){
            //     Entry entry = table.newEntry();
            //     entry.set("name", name);
            //     entry.set("traceName", traceName);
            //     count = table.insert(traceNumber, entry);
            // }
            // return count;
        }

        //食品分销过程中增加溯源信息的接口
        //只有Distributor能调用
        //traceNumber 食品溯源id
        //traceName 当前用户名称
        //quality 当前食品质量
        function addTraceInfoByDistributor(①, uint8 quality)
	public ② returns(bool) {
            //③ 条件判定：traceNumber不存在
            return FoodInfoItem(foods[traceNumber]).④;
        }

        //食品出售过程中增加溯源信息的接口
        //只有Retailer能调用
        //traceNumber 食品溯源id
        //traceName 当前用户名称
        //quality 当前食品质量
        function addTraceInfoByRetailer(①, uint8 quality)
	public ② returns(bool) {
            require(③, "traceNumber does not exist");
            return FoodInfoItem(foods[traceNumber]).④;
        }

        //获取食品溯源信息接口
        //string[] 保存食品流转过程中各个阶段的相关信息
        //address[] 保存食品流转过程各个阶段的用户地址信息（和用户一一对应）
        //uint8[] 保存食品流转过程中各个阶段的状态变化
        function getTraceInfo(uint256 traceNumber) public constant returns(uint[], string[], address[], uint8[]) {
            require(foods[traceNumber] != address(0), "traceNumber does not exist");
            return FoodInfoItem(foods[traceNumber]).getTraceInfo();
        }

        function getFood(uint256 traceNumber) public constant returns(uint, string, string, string, address, uint8) {
            require(foods[traceNumber] != address(0), "traceNumber does not exist");
            return FoodInfoItem(foods[traceNumber]).getFood();
        }

        function getAllFood() public constant returns (uint[]) {
            return foodList;
        }
}
