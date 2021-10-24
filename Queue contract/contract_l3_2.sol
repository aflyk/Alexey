
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
должны быть доступны опции:
- добавить задачу (должен в сопоставление заполняться 
последовательный целочисленный ключ)
- получить количество открытых задач (возвращает число)
- получить список задач
- получить описание задачи по ключу
- удалить задачу по ключу
- отметить задачу как выполненную по ключу
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract contract_l3_2 {

    uint8 public count;
 
    struct  task{
        string task_name;
        uint32 timestamp;
        bool done;
    }

    mapping (uint8=>task) public id_task;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

    }

    modifier checkOwnerAndAccept {
		
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

    function add_task(string task_user) public checkOwnerAndAccept{
        id_task[count] = task(task_user, now, false);
        count += 1;
    }

    function open_task() public returns(uint8){
        uint8 count_open_task;
        for ((uint8 val,):id_task){
            if (id_task[val].done==false){
                count_open_task += 1;
            }
        }
        return count_open_task;
    }

    function list_of_task() public checkOwnerAndAccept returns(string[]){
        string [] list_all_task;
        for ((, task val):id_task){
            list_all_task.push(val.task_name);
        }
        return list_all_task;
    }

    function descripte_task(uint8 key) public returns(string){
        return id_task[key].task_name;
    }

    function done_task(uint8 key) public checkOwnerAndAccept{
        id_task[key].done = true;
    }

    function del_task(uint key) public checkOwnerAndAccept{
        mapping (uint8=>task) new_id_task;
        for ((uint8 val,):id_task){
            if (val != key){
                if (val < key){
                    new_id_task[val]=id_task[val];
                }
                else{
                    new_id_task[val-1] = id_task[val];
                }
            }
        }
        id_task = new_id_task;
    }
}
