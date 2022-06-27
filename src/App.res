%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

type todo = {
  title: string,
  isDone: bool,
}
type state = {
  todoList: array<todo>,
  inputValue: string,
}

let initialState: state = {
  todoList: [],
  inputValue: "",
}

type actions = AddTodo | ClearTodos | InputChanged(string) | MarkDone(int)

let reducer = (state, action) => {
  switch action {
  | AddTodo => {
      // {...state,
      // inputValue: "",
      //for spreading array, use []
      // todoList: [...state.todoList, too]}
      //Arrays can't use the `...` spread currently. Please use `concat` or other Array helpers.
      // All the fields are already explicitly listed in this record. You can remove the `...` spread.
      // [] for array, {} for object,
      // as title, isDone is an object keep between {} ,
      // and as entire thing is an single array []
      ...state,
      inputValue: "",
      todoList: state.todoList->Js.Array2.concat([
        {
          title: state.inputValue,
          isDone: false,
        },
      ]),
    }
  | ClearTodos => {
      ...state,
      todoList: [],
    }
  | InputChanged(newValue) => {
      ...state,
      inputValue: newValue,
    }
  | MarkDone(idx) => {
    ...state,
      todoList:  state.todoList->Belt.Array.mapWithIndex((id,ele) => {
          if id == idx{
            {
            ...ele,
            isDone: !ele.isDone,
            }
             //returning new todo object as every function returns something
          }
          else
          {
            ele
            //returning just todo object as every function returns something
          }
        })
      ,
  }
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)
  let handleInput = e => {
    let inputVal = ReactEvent.Form.target(e)["value"]
    dispatch(InputChanged(inputVal))
  }
  let handleAdd = _ => {
    dispatch(AddTodo)
  }
  let handleRemove = _ => {
    dispatch(ClearTodos)
  }
  <div className="App">
    <h1> {"TODO"->React.string} </h1>
    <input value=state.inputValue type_="text" onChange={handleInput} />
    <button onClick={handleAdd}> {"Add Todo"->React.string} </button>
    <button onClick={handleRemove}> {"Clear all Todo"->React.string} </button>
    // {state.todoList
    // ->Belt.Array.map(ele =>
    //   <div style={ReactDOM.Style.make(~background="steelblue",~color="white", ~padding="1 rem", ~margin="1rem 0",~fontSize="1.5rem",())}>
    //     {ele.title->React.string}
    //   </div>
    // )
    // ->React.array}
    //todolist is an array of todos
    // todos is an record
    // {state.todoList->Belt.Array.map(ele => ele.title->Js.Json.stringify->React.string)}
    {state.todoList
    ->Belt.Array.mapWithIndex((idx,ele) =>
      <div 
      onClick={_ => dispatch(MarkDone(idx))}
      key={ele.title} style={ReactDOM.Style.make(~background= {ele.isDone ?  "green" : "steelblue"}
      ,~textDecoration = {ele.isDone ? "line-through": "intial"}
      ,~color="white", ~padding="1 rem", ~margin="1rem 0",~fontSize="1.5rem",())}>
        {ele.title->React.string}
      </div>
    )
    ->React.array}
    // for records access with me.age
    // for objects access with me["age"]
  </div>
}
