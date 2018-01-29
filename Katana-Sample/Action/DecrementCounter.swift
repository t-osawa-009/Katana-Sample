import Katana

struct DecrementCounter: Action {
    func updatedState(currentState: State) -> State {
        guard var state = currentState as? CounterState else { fatalError("wrong state type") }
        state.counter -= 1
        return state
    }
}
