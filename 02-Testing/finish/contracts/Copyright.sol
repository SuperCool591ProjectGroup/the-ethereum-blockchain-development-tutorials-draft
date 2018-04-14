pragma solidity ^0.4.4;

contract Copyright {
  Song[] public songs;
  // address[] public users;
  // assume one song only has one copyright holder for now
  mapping(uint => Song) songInfo;
  mapping(address => UserStatus) userInfo;
  // mapping(uint => uint) priceInfo;
  // mapping(uint => address[]) authorization;
  // mapping(address => Song[]) purchasedSongs;
  // mapping(address => Song[]) uploadedSongs;

  struct ShareHolder {
    address add;
    float share;
  }

  struct UserStatus {
    bool registered;
    uint[] purchasedSongs;
    uint[] uploadedSongs;
  }

  struct Song {
    uint ID;
    string name;
    ShareHolder[] shareHolders;
    uint price;
    address[] licenseHolders;
  }

  //TODO: check duplicate
  function userRegister() public {
    // users.push(msg.sender);
    userInfo[msg.sender].registered = true;
  }

  // function checkUsers() public constant returns (address[]) {
  // 	return users;
  // }

  function registerCopyright(string name, uint price, address[] holders, uint[] shares) public {
    require(checkUserExists(msg.sender));
    require(shares.length == holders.length);
    require(checkShareSum(shares));
    // songs.push(song);
    // priceInfo[song] = price;
    // holderInfo[song].add = msg.sender;
    // holderInfo[song].share = 1;
    for(uint i = 0; i < shares.length; i++) {
      songInfo[shareHolders][i].add = holders[i];
      songInfo[shareHolders][i].share = shares[i];
    }

  }

  function checkShareSum(uint[] list) public constant returns (bool) {
    uint sum = 0;
    for(uint i = 0; i < list.length; i++) {
      sum += list[i];
    }
    return sum == 100;

  }

  function checkUserExists(address user) public constant returns (bool) {
    return userInfo[user].registered;
  }

  function checkSongPrice(uint songID) public constant returns (uint) {
    return songInfo[songID].price;
  }

  function buyLicense(uint songID) public payable {
  	require(checkUserExists(msg.sender));
  	uint price = songInfo[songID].price;
  	// Check that the amount paid is >= the price
  	// the ether is paid to the smart contract first through payable function
  	assert(msg.value >= price);
  	// authorization[song].push(msg.sender);
  	// pay the coopyright holder
    userInfo[msg.sender].purchasedSongs.push(songID);
    songInfo[songID].licenseHolders.push(msg.sender);
  	payRoyalty(song, msg.value);
  }

  // function getLicenseInfo

  function payRoyalty(uint songID, uint amount) {
    ShareHolder[] holders = songInfo[songID].shareHolders;
    for(int i = 0; i < holders.length; i++) {
      ShareHolder holder = holders[i];
      holder.add.transfer(amount * holder.share / 100);

    }
  	// holderInfo[song].add.transfer(amount);
  }

  function getMyBalance() public constant returns (uint) {
  	return msg.sender.balance;
  }

}
