pragma solidity ^0.4.25;
//角色库（管理所有角色地址）
// 1. 实现增加角色地址
// 2. 移除角色地址
// 3. 判断角色地址是否被授权
library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }

    function add(①, address account) internal {
        require(!③, "Roles: account already has role");
        role.④ = true;
    }

    function remove(①, address account) ② {
        require(③, "Roles: account does not have role");
        role.④ = false;
    }

    function has(①, address account) ② returns (bool) {
        require(③, "Roles: account is the zero address");
        return role.④;
    }
}
