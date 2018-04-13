progma solidity 0.4.20

contract Copyright {
	string[] public songs;
	address[] public users;
	// assume one song only has one copyright holder for now
	mapping(string => ShareHolder[]) public holderInfo;
	mapping(string => uint) public priceInfo;
	mapping(string => address[]) public authorization;

	struct ShareHolder {
		address add;
		uint share;
	}

	// constructor
	function Copyright() {

	}

	function userRegister() {
		users.push(msg.sender);
	}

	function registerCopyright(string song, uint price) public {
		require(checkUserExists(msg.sender));
		songs.push(song);
		priceInfo[song] = price;
		ShareHolder[song].add = msg.sender;
		ShareHolder[song].share = 1;
		authorization[song] = address[]
	}

	function checkUserExists(address user) public constant returns(bool) {
		for(uint i = 0; i < users.length; i++) {
			if(users[i] == user)
				return true;
		}
		return false;
	}

	function buyLicense(string song) public payable {
		require(checkUserExists(msg.sender));
		uint price = priceInfo[song];
		// Check that the amount paid is >= the price
		// the ether is paid to the smart contract first through payable function
		assert(msg.value >= price);
		authorization[song].push(msg.sender);
		// pay the coopyright holder
		payRoyalty(song, msg.value);
	}

	function payRoyalty(string song, uint amount) {
		ShareHolder[song].transfer(amount);
	}

	function getPrice(string song) constant returns (uint) {
		return priceInfo[song];
	}

	function getSongs() constant returns (string[]) {
		return songs;
	}
}

