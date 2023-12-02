use starknet::{storage, ContractAddress};

// Starknet enjoyer
// Debbie Road OG
// Greeting buidler
// rust maxi

#[starknet::interface]
trait IGreetingContract<TContractState> {
    fn set_greeting(ref self: TContractState, greeting: felt252);
    fn get_greeting(self: @TContractState) -> felt252;
    fn last_greeter(self: @TContractState) -> ContractAddress;
}

#[starknet::contract]
mod greeting {
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    #[storage]
    struct Storage {
        greeting: felt252,
        last_greeter: ContractAddress,
        owner: ContractAddress,
    }

    #[constructor]
    fn constructor(ref self: ContractState, init_owner: ContractAddress, init_greeting: felt252) {
        self.owner.write(init_owner);
        self.greeting.write(init_greeting);
    }
    #[external(v0)]
    impl Greeting of super::IGreetingContract<ContractState> {
        fn set_greeting(ref self: ContractState, greeting: felt252) {
            self.greeting.write(greeting);
            self.last_greeter.write(get_caller_address());
        }

        fn get_greeting(self: @ContractState) -> felt252 {
            self.greeting.read()
        }

        fn last_greeter(self: @ContractState) -> ContractAddress {
            self.last_greeter.read()
        }
    }
}
