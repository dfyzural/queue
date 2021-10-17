pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {

    string[] public str_array;

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

	// Function add 
	function add(string name) public checkOwnerAndAccept {
        require(name != "", 103);
        str_array.push(name);
		
	}

   	// Function next
	function next() public checkOwnerAndAccept returns (string){
        require(str_array.length>0, 104);

        string s=str_array[0];
        string[] new_array;
        
        for (uint i = 1; i<str_array.length; i++){
            new_array.push(str_array[i]);
        }

        str_array = new_array;
        return s;
	}
}