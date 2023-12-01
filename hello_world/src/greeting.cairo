use starknet::ContractAddress;

#[starknet::interface]
trait IGreetingContract<TContractState> {
    fn set_greeting(ref self: TContractState, greeting: felt252);
    fn get_greeting(ref self: TContractState) -> felt252;
    fn last_greeter(ref self: TContractState) -> ContractAddress;
}

#[starknet::contract]
mod Greeting {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        greeting: felt252,
        last_greeter: ContractAddress,
    }

    impl Greeting of super::IGreetingContract<ContractState> {
        fn set_greeting(ref self: ContractState, greeting: felt252) {
            self.greeting.write(greeting);
            self.last_greeter.write(get_caller_address());
        }

        fn get_greeting(ref self: ContractState) -> felt252 {
            self.greeting.read()
        }

        fn last_greeter(ref self: ContractState) -> ContractAddress {
            self.last_greeter.read()
        }
    }
}
