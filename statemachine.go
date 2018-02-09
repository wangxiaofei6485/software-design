// statemachine
package main

/*
	实现基于映射表的状态机
*/
import (
	"fmt"
	"sync"
)

//state
const (
	TESTING_STATE = iota
	OPENING_STATE
	CLOSING_STATE
	RUNNING_STATE
	STOPPING_STATE
)

//action
const (
	TEST_ACTION = iota
	OPEN_ACTION
	CLOSE_ACTION
	RUN_ACTION
	STOP_ACTION
)

//将整数转换为字符串打印出来
var statemap = []string{
	"TESTING_STATE",
	"OPENING_STATE",
	"CLOSING_STATE",
	"RUNNING_STATE",
	"STOPPING_STATE",
}
var actionmap = []string{
	"TEST_ACTION",
	"OPEN_ACTION",
	"CLOSE_ACTION",
	"RUN_ACTION",
	"STOP_ACTION",
}

type Table struct {
	CurState  int
	Action    int
	NextState int
}

type StateMachine struct {
	CurState int
	StateMap map[int]map[int]int
	mutex    sync.Mutex
}

func (machine *StateMachine) init(table []Table) {
	machine.StateMap = make(map[int]map[int]int) //创建大表

	//建立映射表
	for _, item := range table {
		fmt.Println(item.CurState, item.Action, item.NextState)
		var tmp map[int]int
		if _, exist := machine.StateMap[item.CurState]; !exist {
			//			tmp = make(map[int]int)
			machine.StateMap[item.CurState] = make(map[int]int)
		}
		if machine.StateMap[item.CurState] == nil {
			fmt.Println("machine.StateMap[item.CurState] is nil")
		}
		tmp = machine.StateMap[item.CurState]

		tmp[item.Action] = item.NextState
	}
	machine.CurState = CLOSING_STATE
	//	fmt.Println("init func:", machine.StateMap)

}

func (machine *StateMachine) start(action int) {
	tmp, exist := machine.StateMap[machine.CurState]
	if !exist {
		fmt.Println("state not existed")
		return
	}
	fmt.Println("CurState=", machine.CurState, "action=", action, tmp)
	machine.mutex.Lock()
	state, exist := tmp[action]
	machine.mutex.Unlock()
	if !exist {
		fmt.Println("action not existed")
		return
	}
	machine.mutex.Lock()
	machine.CurState = state
	machine.mutex.Unlock()
}

func main() {
	//	fmt.Println("Hello World!")
	//状态机映射表
	stateTable := []Table{
		{OPENING_STATE, CLOSE_ACTION, CLOSING_STATE},
		{OPENING_STATE, OPEN_ACTION, OPENING_STATE},

		{CLOSING_STATE, CLOSE_ACTION, CLOSING_STATE},
		{CLOSING_STATE, OPEN_ACTION, OPENING_STATE},
		{CLOSING_STATE, RUN_ACTION, RUNNING_STATE},

		{RUNNING_STATE, RUN_ACTION, RUNNING_STATE},
		{RUNNING_STATE, STOP_ACTION, STOPPING_STATE},

		{STOPPING_STATE, STOP_ACTION, STOPPING_STATE},
		{STOPPING_STATE, RUN_ACTION, RUNNING_STATE},
		{STOPPING_STATE, OPEN_ACTION, OPENING_STATE},
	}

	fmt.Println(stateTable)
	fmt.Println("len=", len(stateTable))

	for i, tmp := range stateTable {
		//fmt.Println(tmp.CurState, tmp.Action, tmp.NextState)
		fmt.Println(i, statemap[tmp.CurState], actionmap[tmp.Action], statemap[tmp.NextState])
	}

	machine := &StateMachine{}
	fmt.Println("len2=", len(machine.StateMap))
	machine.init(stateTable)
	machine.start(OPEN_ACTION)
	fmt.Println(machine.CurState, " ", statemap[machine.CurState])
	machine.start(RUN_ACTION)
	fmt.Println(machine.CurState, " ", statemap[machine.CurState])
}
