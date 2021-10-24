
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract Wallet {

    struct Token{
        string card_name;
        bool rare;
        uint8 zone;
        uint8 damage;
        bool support;
        uint price;
    }

    Token[] public tokensArr;

    mapping (uint => uint) token_owner;

    function create_token(string card_name, bool rare,
    uint8 zone, uint8 damage, bool support ) public checkOwnerAndAccept{
        for (Token i : tokensArr){
            require(i.card_name.byteLength() == card_name.byteLength(), 104); 
        }
        if (support==true && damage!=0){
            revert(105);
        }
        else{
            tokensArr.push(Token(card_name, rare, zone, damage, support, 10000));
            uint key_number = tokensArr.length - 1; 
            token_owner[key_number] = msg.pubkey();
        }
    }

    function set_price(uint price, string card_name) public checkOwnerAndAccept{
        bool flag = false;
        uint16 count;
        for (Token i : tokensArr){
            if (i.card_name == card_name){
                require(token_owner[count] == msg.pubkey(), 111);
                tokensArr[count].price = price;
                flag = true;
                break;
        }
            count += 1;           
        }
        require(flag == true, 110, "This card doesn't exist");

    }

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }


    modifier checkOwnerAndAccept {

        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}


    function sendTrancfer_comission_by_recipient(address dest, 
    uint128 value, bool bounce) public pure checkOwnerAndAccept {
        dest.transfer(value, bounce, 0);
    }

    function sendTrancfer_comission_by_owner(address dest, 
    uint128 value, bool bounce) public pure checkOwnerAndAccept {
        dest.transfer(value, bounce, 1);
    }

    function send_all_resources(address dest) public pure checkOwnerAndAccept{
        dest.transfer(0, false, 160);
    }

    
}