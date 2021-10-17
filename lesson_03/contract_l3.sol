
/**
 3. Написать смартконтракты.
3.1. "Очередь в магазине"
Хранилище данных - массив строк (Где строки имена людей, 
которые встают в очередь). Должны быть доступны опции:
встать в очередь (переданное имя встает в конец очереди - 
в конец массива) вызвать следующего (первый из очереди 
уходит - нулевой элемент массива пропадает)
3.2. "Список задач"
Структура (см лекцию по типам данных)
- название дела
- время добавления (см helloWorld)
- флаг выполненности дела (bool)
Структуру размещаем в сопоставление int8 => 
struct (см лекцию по типам данных)

 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// This is class that describes you smart contract.
contract contract_l3 {
    // Contract can have an instance variables.
    // In this example instance variable `timestamp` is used to store the time of `constructor` or `touch`
    // function call

    string[] public queue; 
    // Contract can have a `constructor` – function that will be called when contract will be deployed to the blockchain.
    // In this example constructor adds current time to the instance variable.
    // All contracts need call tvm.accept(); for succeeded deploy
    constructor() public {
        // Check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and
        // message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        // The current smart contract agrees to buy some gas to finish the
        // current transaction. This actions required to process external
        // messages, which bring no value (henceno gas) with themselves.
        tvm.accept();


    }

    modifier checkOwnerAndAccept {
		
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

    function go_to_queue(string name) public checkOwnerAndAccept{
        queue.push(name);
    }
    
    function next_in_queue() public checkOwnerAndAccept {
        string[] queue1;
        uint count;
        for (string val: queue){
            if (count!=0){
            queue1.push(val);
            }
            count += 1;
        }
        queue = queue1;
    }
        
    
}
