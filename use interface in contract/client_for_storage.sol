
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "storage_int.sol";

contract client_for_storage{

    uint public sample1; 
    uint sample2;



    function renderHelloWorld () public pure returns (string) {
        return 'helloWorld';
    }

    function renderHelloWorld_1 () public pure returns (string) {
        tvm.accept();
        return 'helloWorld';
    }

    function store(storage_int current_storage, uint val) public pure{
            current_storage.store_uint(val);
    }
 
}
