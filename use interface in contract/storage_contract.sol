
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "storage_int.sol";

contract storage_contract is storage_int{
    
    uint public storage_value;

    function store_uint(uint value) public override{
        
        storage_value = value;

    }   
}
