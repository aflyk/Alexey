/*
 Написать смарт-контракт и задеплоить его локально. Суть контракта:
контракт должен хранить произведение чисел. Изначально 
инициализирован единицей. Иметь функцию "умножить".  
Функция очевидно должна умножать сохраненное число на 
переданный в нее параметр. Дополнительным моментом является то, 
что функция должна умножать только на числа от 1 до 10 включительно. 
В противном случае прерывать выполнение. Используем require
*/
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Multiply {

	// State variable storing the sum of arguments that were passed to function 'add',
	uint public mul = 1;

	constructor() public {
		// check that contract's public key is set
		require(tvm.pubkey() != 0, 101);
		// Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	// Modifier that allows to accept some external messages
	modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	// Function that adds its argument to the state variable.
	function times(uint value) public{
        require(value >= 1 , 103);
        require(value <= 10, 104);
        require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
        mul *= value;
	}
}