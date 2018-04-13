pragma solidity ^0.4.4;

contract Copyright {
  string[] public songs;
  address[] public users;
  // assume one song only has one copyright holder for now
  mapping(string => ShareHolder) holderInfo;
  mapping(string => uint) priceInfo;
  mapping(string => address[]) authorization;

  struct ShareHolder {
    address add;
    uint share;
  }

  function userRegister() public {
    users.push(msg.sender);
  }

  function checkUsers() public constant returns (address[]) {
  	return users;
  }

  function registerCopyright(string song, uint price) public {
    require(checkUserExists(msg.sender));
    songs.push(song);
    priceInfo[song] = price;
    holderInfo[song].add = msg.sender;
    holderInfo[song].share = 1;
  }

  function checkUserExists(address user) public constant returns (bool) {
    for(uint i = 0; i < users.length; i++) {
      if(users[i] == user)
        return true;
    }
    return false;
  }

  function checkSongPrice(string song) public constant returns (uint) {
    return priceInfo[song];
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
  	holderInfo[song].add.transfer(amount);
  }

  function getMyBalance() public constant returns (uint) {
  	return msg.sender.balance;
  }

}
